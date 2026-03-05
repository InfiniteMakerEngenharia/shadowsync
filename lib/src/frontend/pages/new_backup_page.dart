import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../../backend/models/backup_execution_config.dart';
import '../../backend/models/backup_routine.dart';
import '../../backend/models/user_settings.dart';
import '../../backend/services/disk_space_service.dart';
import '../../backend/services/user_settings_service.dart';
import '../../generated/l10n/app_localizations.dart';
import '../theme/shadowsync_theme.dart';

class NewBackupPage extends StatefulWidget {
  const NewBackupPage({super.key});

  @override
  State<NewBackupPage> createState() => _NewBackupPageState();
}

class _NewBackupPageState extends State<NewBackupPage> {
  final _nameController = TextEditingController();
  final _sourceController = TextEditingController();
  final _destinationController = TextEditingController();
  final _retentionController = TextEditingController(text: '20');
  final List<String> _sourcePaths = [];

  int _currentStep = 0;
  ScheduleType _scheduleType = ScheduleType.daily;
  CompressionFormat _compressionFormat = CompressionFormat.zip;
  bool _compressionEnabled = false;
  bool _encryptionEnabled = false;
  bool _isPickingPath = false;
  late DateTime _nextDate;
  late TimeOfDay _nextTime;
  
  /// Intervalo em minutos para backup por intervalo
  int _intervalMinutes = 60;
  
  /// Opções de intervalo pré-definidas em minutos
  static const List<int> _intervalOptions = [1, 5, 10, 15, 30, 60, 120, 240, 480, 720, 1440];

  // Informações de espaço em disco
  final DiskSpaceService _diskSpaceService = const DiskSpaceService();
  int? _sourceSize;
  int? _availableSpace;
  bool _isCalculatingSize = false;

  // Configurações do usuário
  UserSettings? _userSettings;

  @override
  void initState() {
    super.initState();
    // Inicializa com data e hora atuais
    final now = DateTime.now();
    _nextDate = now;
    _nextTime = TimeOfDay(hour: now.hour, minute: now.minute);
    _loadUserSettings();
  }

  Future<void> _loadUserSettings() async {
    final service = await UserSettingsService.getInstance();
    if (mounted) {
      setState(() {
        _userSettings = service.getSettings();
      });
    }
  }

  List<String> get _destinationChips {
    final destination = _destinationController.text.trim();
    if (destination.isEmpty) {
      return const [];
    }
    return [destination];
  }

  @override
  void dispose() {
    _nameController.dispose();
    _sourceController.dispose();
    _destinationController.dispose();
    _retentionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        // Oculta o teclado quando o usuário volta (por gesto ou botão)
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: ShadowSyncColors.primaryBackground,
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).newBackup),
          backgroundColor: ShadowSyncColors.secondary,
        ),
      body: Theme(
        data: Theme.of(context).copyWith(
          colorScheme: Theme.of(context).colorScheme.copyWith(
            primary: ShadowSyncColors.accent,
          ),
        ),
        child: Stepper(
          currentStep: _currentStep,
          onStepContinue: _handleStepContinue,
          onStepCancel: _handleStepCancel,
          onStepTapped: (step) => setState(() => _currentStep = step),
          controlsBuilder: (context, details) {
            final isLastStep = _currentStep == 3;
            return Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: details.onStepContinue,
                    child: Text(isLastStep ? AppLocalizations.of(context).saveRoutine : AppLocalizations.of(context).nextStep),
                  ),
                  const SizedBox(width: 10),
                  TextButton(
                    onPressed: details.onStepCancel,
                    child: Text(_currentStep == 0 ? AppLocalizations.of(context).cancel : AppLocalizations.of(context).back),
                  ),
                ],
              ),
            );
          },
          steps: [
            Step(
              isActive: _currentStep >= 0,
              title: Text(AppLocalizations.of(context).basicData),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context).routineName,
                    ),
                  ),
                  const SizedBox(height: 14),
                  _PathInputCard(
                    title: AppLocalizations.of(context).backupSources,
                    subtitle: AppLocalizations.of(context).selectFilesAndFolders,
                    controller: _sourceController,
                    hintText:
                        '/Users/meuuser/Documents;/Users/meuuser/Projetos',
                    maxLines: 1,
                    showTextField: false,
                    chips: _sourcePaths,
                    onRemoveChip: _removeSourcePath,
                    actionArea: PopupMenuButton<String>(
                      enabled: !_isPickingPath,
                      onSelected: (value) {
                        if (value == 'files') {
                          _pickSourceFiles();
                        } else if (value == 'folder') {
                          _pickSourceDirectory();
                        }
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 'files',
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.upload_file_outlined),
                              const SizedBox(width: 12),
                              Text(AppLocalizations.of(context).selectFiles),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: 'folder',
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.folder_open_outlined),
                              const SizedBox(width: 12),
                              Text(AppLocalizations.of(context).selectFolder),
                            ],
                          ),
                        ),
                      ],
                      child: OutlinedButton.icon(
                        onPressed: null,
                        icon: const Icon(Icons.add_circle_outline),
                        label: Text(
                          _isPickingPath
                              ? AppLocalizations.of(context).selecting
                              : AppLocalizations.of(context).addSource,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  _PathInputCard(
                    title: AppLocalizations.of(context).backupDestination,
                    subtitle: AppLocalizations.of(context).destinationDescription,
                    controller: _destinationController,
                    hintText: '/Volumes/Backup/Destino',
                    maxLines: 1,
                    showTextField: false,
                    chips: _destinationChips,
                    onRemoveChip: (_) {
                      setState(() {
                        _destinationController.clear();
                      });
                    },
                    actionArea: Align(
                      alignment: Alignment.centerLeft,
                      child: OutlinedButton.icon(
                        onPressed: _isPickingPath
                            ? null
                            : _pickDestinationDirectory,
                        icon: const Icon(Icons.folder_copy_outlined),
                        label: Text(
                          _isPickingPath
                              ? AppLocalizations.of(context).selecting
                              : AppLocalizations.of(context).selectDestinationFolder,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Step(
              isActive: _currentStep >= 1,
              title: Text(AppLocalizations.of(context).scheduling),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DropdownButtonFormField<ScheduleType>(
                    initialValue: _scheduleType,
                    decoration: InputDecoration(labelText: AppLocalizations.of(context).frequency),
                    items: [
                      DropdownMenuItem(
                        value: ScheduleType.manual,
                        child: Text(AppLocalizations.of(context).scheduleTypeManual),
                      ),
                      DropdownMenuItem(
                        value: ScheduleType.daily,
                        child: Text(AppLocalizations.of(context).scheduleTypeDaily),
                      ),
                      DropdownMenuItem(
                        value: ScheduleType.weekly,
                        child: Text(AppLocalizations.of(context).scheduleTypeWeekly),
                      ),
                      DropdownMenuItem(
                        value: ScheduleType.interval,
                        child: Text(AppLocalizations.of(context).scheduleTypeInterval),
                      ),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => _scheduleType = value);
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  // Controles condicionais baseados no tipo de agendamento
                  _buildScheduleControls(),
                ],
              ),
            ),
            Step(
              isActive: _currentStep >= 2,
              title: Text(AppLocalizations.of(context).processing),
              content: Column(
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(AppLocalizations.of(context).compressBackup),
                    trailing: Transform.scale(
                      scale: 0.85,
                      child: Switch.adaptive(
                        value: _compressionEnabled,
                        onChanged: (value) {
                          setState(() => _compressionEnabled = value);
                        },
                      ),
                    ),
                  ),
                  if (_compressionEnabled)
                    DropdownButtonFormField<CompressionFormat>(
                      initialValue: _compressionFormat,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context).compressionFormat,
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: CompressionFormat.zip,
                          child: Text('ZIP'),
                        ),
                        DropdownMenuItem(
                          value: CompressionFormat.tar,
                          child: Text('TAR'),
                        ),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          setState(() => _compressionFormat = value);
                        }
                      },
                    ),
                  const SizedBox(height: 8),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(AppLocalizations.of(context).encryptBackup),
                    trailing: Transform.scale(
                      scale: 0.85,
                      child: Switch.adaptive(
                        value: _encryptionEnabled,
                        onChanged: (value) {
                          setState(() => _encryptionEnabled = value);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Step(
              isActive: _currentStep >= 3,
              title: Text(AppLocalizations.of(context).review),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SummaryRow(label: AppLocalizations.of(context).backupName, value: _nameController.text.trim()),
                  _SummaryRow(
                    label: AppLocalizations.of(context).backupSource,
                    value: _sourceController.text.trim(),
                  ),
                  _SummaryRow(
                    label: AppLocalizations.of(context).destination,
                    value: _destinationController.text.trim(),
                  ),
                  _SummaryRow(
                    label: AppLocalizations.of(context).scheduling,
                    value:
                        '${_scheduleType.name} • ${_formatDate(_nextDate)} ${_formatTime(_nextTime)}',
                  ),
                  _SummaryRow(
                    label: AppLocalizations.of(context).backupCompression,
                    value: _compressionEnabled
                        ? '${AppLocalizations.of(context).active} (${_compressionFormat.name.toUpperCase()})'
                        : AppLocalizations.of(context).deactivated,
                  ),
                  _SummaryRow(
                    label: AppLocalizations.of(context).backupEncryption,
                    value: _encryptionEnabled 
                        ? AppLocalizations.of(context).encryptionActive 
                        : AppLocalizations.of(context).deactivated,
                  ),
                  const SizedBox(height: 12),
                  const Divider(color: ShadowSyncColors.border),
                  const SizedBox(height: 8),
                  Text(
                    AppLocalizations.of(context).diskSpace,
                    style: const TextStyle(
                      color: ShadowSyncColors.text,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (_isCalculatingSize)
                    Row(
                      children: [
                        const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          AppLocalizations.of(context).calculatingSizes,
                          style: const TextStyle(color: ShadowSyncColors.text),
                        ),
                      ],
                    )
                  else ...[
                    _SummaryRow(
                      label: AppLocalizations.of(context).sourceSize,
                      value: _sourceSize != null
                          ? DiskSpaceService.formatBytes(_sourceSize!)
                          : AppLocalizations.of(context).notAvailable,
                    ),
                    _SummaryRow(
                      label: AppLocalizations.of(context).availableSpace,
                      value: _availableSpace != null
                          ? DiskSpaceService.formatBytes(_availableSpace!)
                          : AppLocalizations.of(context).notAvailable,
                    ),
                    if (_sourceSize != null && _availableSpace != null)
                      _DiskSpaceWarning(
                        sourceSize: _sourceSize!,
                        availableSpace: _availableSpace!,
                      ),
                  ],
                  const SizedBox(height: 12),
                  const Divider(color: ShadowSyncColors.border),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _retentionController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Retenção (quantidade de versões)',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
    );
  }

  /// Constrói os controles de agendamento baseado no tipo selecionado
  Widget _buildScheduleControls() {
    switch (_scheduleType) {
      case ScheduleType.manual:
        // Para backup manual, mostrar apenas uma mensagem informativa
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacityFixed(0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.blue.withOpacityFixed(0.3)),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: Colors.blue.shade300, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  AppLocalizations.of(context).manualExecutionInfo,
                  style: const TextStyle(fontSize: 13),
                ),
              ),
            ],
          ),
        );
      
      case ScheduleType.daily:
        // Para backup diário, mostrar apenas seletor de hora
        return Wrap(
          spacing: 8,
          runSpacing: 8,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(AppLocalizations.of(context).runAt, style: const TextStyle(fontSize: 14)),
            OutlinedButton.icon(
              onPressed: _pickTime,
              icon: const Icon(Icons.schedule),
              label: Text(_formatTime(_nextTime)),
            ),
          ],
        );
      
      case ScheduleType.weekly:
        // Para backup semanal, mostrar seletor de dia e hora
        return Wrap(
          spacing: 8,
          runSpacing: 8,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            OutlinedButton.icon(
              onPressed: _pickDate,
              icon: const Icon(Icons.calendar_month),
              label: Text(_formatDate(_nextDate)),
            ),
            OutlinedButton.icon(
              onPressed: _pickTime,
              icon: const Icon(Icons.schedule),
              label: Text(_formatTime(_nextTime)),
            ),
          ],
        );
      
      case ScheduleType.interval:
        // Para backup por intervalo, mostrar ComboBox com intervalos pré-definidos
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppLocalizations.of(context).runEvery, style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 8),
            DropdownButtonFormField<int>(
              initialValue: _intervalMinutes,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context).interval,
                border: const OutlineInputBorder(),
              ),
              items: _intervalOptions.map((minutes) {
                return DropdownMenuItem<int>(
                  value: minutes,
                  child: Text(_formatInterval(minutes)),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() => _intervalMinutes = value);
                }
              },
            ),
          ],
        );
    }
  }

  /// Formata o intervalo em minutos para exibição amigável
  String _formatInterval(int minutes) {
    if (minutes == 1) {
      return '1 minuto';
    } else if (minutes < 60) {
      return '$minutes minutos';
    } else if (minutes == 60) {
      return '1 hora';
    } else if (minutes < 1440) {
      final hours = minutes ~/ 60;
      return '$hours horas';
    } else {
      final days = minutes ~/ 1440;
      return days == 1 ? '1 dia' : '$days dias';
    }
  }

  Future<void> _pickDate() async {
    final selected = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 3650)),
      initialDate: _nextDate,
    );

    if (selected != null) {
      setState(() => _nextDate = selected);
    }
  }

  Future<void> _pickSourceFiles() async {
    try {
      setState(() => _isPickingPath = true);
      final result = await FilePicker.platform.pickFiles(allowMultiple: true);
      if (result == null) {
        _showInfo('Seleção de arquivos cancelada.');
        return;
      }

      final filePaths = result.files
          .map((file) => file.path)
          .whereType<String>()
          .where((path) => path.trim().isNotEmpty)
          .toList();

      if (filePaths.isEmpty) {
        return;
      }

      for (final path in filePaths) {
        _appendSourcePath(path);
      }

      _showInfo('${filePaths.length} arquivo(s) adicionado(s) à origem.');
    } catch (error) {
      _showError('Falha ao selecionar arquivos: $error');
    } finally {
      if (mounted) {
        setState(() => _isPickingPath = false);
      }
    }
  }

  Future<void> _pickSourceDirectory() async {
    try {
      setState(() => _isPickingPath = true);
      final directoryPath = await FilePicker.platform.getDirectoryPath();
      if (directoryPath == null || directoryPath.trim().isEmpty) {
        _showInfo('Seleção de pasta de origem cancelada.');
        return;
      }

      _appendSourcePath(directoryPath);
      _showInfo('Pasta de origem selecionada.');
    } catch (error) {
      _showError('Falha ao selecionar pasta de origem: $error');
    } finally {
      if (mounted) {
        setState(() => _isPickingPath = false);
      }
    }
  }

  Future<void> _pickDestinationDirectory() async {
    try {
      setState(() => _isPickingPath = true);
      
      // No iOS, usamos o diretório de documentos do app por padrão
      // devido às restrições de sandbox
      if (Platform.isIOS) {
        final docsDir = await getApplicationDocumentsDirectory();
        final backupsDir = '${docsDir.path}/Backups';
        await Directory(backupsDir).create(recursive: true);
        
        setState(() {
          _destinationController.text = backupsDir;
        });
        _showInfo('No iOS, os backups serão salvos em: Documentos/Backups');
        return;
      }
      
      final directoryPath = await FilePicker.platform.getDirectoryPath();
      if (directoryPath == null || directoryPath.trim().isEmpty) {
        _showInfo('Seleção de pasta de destino cancelada.');
        return;
      }

      setState(() {
        _destinationController.text = directoryPath;
      });
      _showInfo('Pasta de destino selecionada.');
    } catch (error) {
      _showError('Falha ao selecionar pasta de destino: $error');
    } finally {
      if (mounted) {
        setState(() => _isPickingPath = false);
      }
    }
  }

  void _appendSourcePath(String path) {
    if (_sourcePaths.contains(path)) {
      return;
    }

    setState(() {
      _sourcePaths.add(path);
      _syncSourceTextFromChips();
    });
  }

  void _removeSourcePath(String path) {
    setState(() {
      _sourcePaths.remove(path);
      _syncSourceTextFromChips();
    });
  }

  void _syncSourceTextFromChips() {
    _sourceController.text = _sourcePaths.join(';');
    _sourceController.selection = TextSelection.fromPosition(
      TextPosition(offset: _sourceController.text.length),
    );
  }

  Future<void> _pickTime() async {
    final selected = await showTimePicker(
      context: context,
      initialTime: _nextTime,
    );

    if (selected != null) {
      setState(() => _nextTime = selected);
    }
  }

  Future<void> _handleStepContinue() async {
    if (_currentStep < 3) {
      if (!_validateCurrentStep()) {
        return;
      }

      // Ao ir para o passo de Revisão (step 3), calcula tamanhos
      if (_currentStep == 2) {
        await _calculateDiskSpaceInfo();
      }

      setState(() => _currentStep += 1);
      return;
    }

    if (!_validateCurrentStep()) {
      return;
    }

    final sources = _sourceController.text
        .split(';')
        .map((item) => item.trim())
        .where((item) => item.isNotEmpty)
        .toList();

    final retentionCount = int.tryParse(_retentionController.text.trim());
    final nextRun = _calculateNextRun();

    // Obtém configurações de nome personalizado do usuário
    final useCustomName = _userSettings?.useCustomBackupName ?? false;
    final customName = _userSettings?.customBackupName;
    
    // Obtém a senha de criptografia das configurações (se criptografia habilitada)
    final encryptionKey = _encryptionEnabled ? _userSettings?.encryptionPassword : null;

    final routine = BackupRoutine(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      name: _nameController.text.trim(),
      sourcePaths: sources,
      destinationPath: _destinationController.text.trim(),
      scheduleType: _scheduleType,
      scheduleValue: _formatScheduleValue(),
      status: _formatStatusLabel(),
      progress: 0,
      type: _encryptionEnabled ? BackupType.encrypted : BackupType.standard,
      isCompleted: false,
      executionConfig: BackupExecutionConfig(
        compressionEnabled: _compressionEnabled,
        compressionFormat: _compressionFormat,
        encryptionEnabled: _encryptionEnabled,
        encryptionKeyRef: encryptionKey,
        retentionCount: retentionCount,
        useCustomBackupName: useCustomName,
        customBackupName: customName,
      ),
      lastRunAt: null,
      nextRunAt: nextRun,
      sourceSize: _sourceSize,
    );

    // Oculta o teclado antes de fechar
    FocusScope.of(context).unfocus();
    
    Navigator.of(context).pop(routine);
  }

  void _handleStepCancel() {
    // Oculta o teclado antes de navegar
    FocusScope.of(context).unfocus();
    
    if (_currentStep == 0) {
      Navigator.of(context).pop();
      return;
    }

    setState(() => _currentStep -= 1);
  }

  bool _validateCurrentStep() {
    if (_currentStep == 0) {
      if (_nameController.text.trim().isEmpty) {
        _showError('Informe o nome da rotina.');
        return false;
      }
      if (_sourceController.text.trim().isEmpty) {
        _showError('Informe ao menos uma origem.');
        return false;
      }
      if (_destinationController.text.trim().isEmpty) {
        _showError('Informe o caminho de destino.');
        return false;
      }
    }

    if (_currentStep == 3) {
      final retention = int.tryParse(_retentionController.text.trim());
      if (retention == null || retention <= 0) {
        _showError('Retenção deve ser um número maior que zero.');
        return false;
      }
      
      // Valida se há senha de criptografia quando a criptografia está habilitada
      if (_encryptionEnabled) {
        final encryptionPassword = _userSettings?.encryptionPassword;
        if (encryptionPassword == null || encryptionPassword.isEmpty) {
          _showError('Configure uma senha de criptografia nas Configurações antes de habilitar a criptografia.');
          return false;
        }
      }
    }

    return true;
  }

  /// Calcula a próxima execução baseada no tipo de agendamento
  DateTime _calculateNextRun() {
    final now = DateTime.now();
    
    switch (_scheduleType) {
      case ScheduleType.manual:
        // Para backup manual, não há próxima execução agendada
        // Retorna null seria ideal, mas o campo é DateTime, então retornamos data/hora atual
        return now;
      
      case ScheduleType.daily:
        // Para backup diário, calcula a próxima ocorrência do horário selecionado
        var scheduled = DateTime(
          now.year,
          now.month,
          now.day,
          _nextTime.hour,
          _nextTime.minute,
        );
        // Se o horário já passou hoje, agenda para amanhã
        if (scheduled.isBefore(now)) {
          scheduled = scheduled.add(const Duration(days: 1));
        }
        return scheduled;
      
      case ScheduleType.weekly:
        // Para backup semanal, usa a data e hora selecionadas
        return DateTime(
          _nextDate.year,
          _nextDate.month,
          _nextDate.day,
          _nextTime.hour,
          _nextTime.minute,
        );
      
      case ScheduleType.interval:
        // Para backup por intervalo, calcula baseado no intervalo selecionado
        return now.add(Duration(minutes: _intervalMinutes));
    }
  }

  String _formatScheduleValue() {
    switch (_scheduleType) {
      case ScheduleType.manual:
        return 'manual';
      case ScheduleType.daily:
        return 'daily:${_formatTime(_nextTime)}';
      case ScheduleType.weekly:
        return 'weekly:${_formatDate(_nextDate)} ${_formatTime(_nextTime)}';
      case ScheduleType.interval:
        return 'interval:$_intervalMinutes';
    }
  }

  String _formatStatusLabel() {
    final l10n = AppLocalizations.of(context);
    switch (_scheduleType) {
      case ScheduleType.daily:
        return l10n.scheduledDaily(_formatTime(_nextTime));
      case ScheduleType.weekly:
        return l10n.scheduledWeekly(_formatDate(_nextDate));
      case ScheduleType.interval:
        return l10n.scheduledInterval(_formatInterval(_intervalMinutes));
      case ScheduleType.manual:
        return l10n.manualExecution;
    }
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year.toString();
    return '$day/$month/$year';
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0xFF7F1D1D),
        content: Text(
          message,
          style: const TextStyle(color: ShadowSyncColors.text),
        ),
      ),
    );
  }

  void _showInfo(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(
          message,
          style: const TextStyle(color: ShadowSyncColors.text),
        ),
        backgroundColor: ShadowSyncColors.secondary,
      ),
    );
  }

  Future<void> _calculateDiskSpaceInfo() async {
    setState(() => _isCalculatingSize = true);

    try {
      // Calcula tamanho total das origens
      final sourceSize = await _diskSpaceService.calculateTotalSize(_sourcePaths);
      
      // Obtém espaço disponível no destino
      final destination = _destinationController.text.trim();
      int? availableSpace;
      if (destination.isNotEmpty) {
        availableSpace = await _diskSpaceService.getAvailableSpace(destination);
      }

      if (mounted) {
        setState(() {
          _sourceSize = sourceSize;
          _availableSpace = availableSpace;
        });
      }
    } catch (_) {
      // Ignora erros, exibe "Não disponível" na UI
    } finally {
      if (mounted) {
        setState(() => _isCalculatingSize = false);
      }
    }
  }
}

class _PathInputCard extends StatelessWidget {
  const _PathInputCard({
    required this.title,
    required this.subtitle,
    required this.controller,
    required this.hintText,
    required this.maxLines,
    required this.actionArea,
    this.showTextField = true,
    this.chips = const [],
    this.onRemoveChip,
  });

  final String title;
  final String subtitle;
  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  final Widget actionArea;
  final bool showTextField;
  final List<String> chips;
  final ValueChanged<String>? onRemoveChip;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacityFixed(0.02),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ShadowSyncColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: ShadowSyncColors.text,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: const TextStyle(
              color: ShadowSyncColors.text,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 10),
          if (showTextField)
            TextField(
              controller: controller,
              minLines: maxLines,
              maxLines: maxLines,
              decoration: InputDecoration(
                hintText: hintText,
                suffixIcon: controller.text.trim().isEmpty
                    ? null
                    : IconButton(
                        onPressed: () {
                          controller.clear();
                        },
                        icon: const Icon(Icons.clear),
                      ),
              ),
            ),
          if (chips.isNotEmpty) ...[
            const SizedBox(height: 10),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: chips
                  .map(
                    (path) => InputChip(
                      label: Text(
                        path,
                        overflow: TextOverflow.ellipsis,
                      ),
                      onDeleted: onRemoveChip == null
                          ? null
                          : () => onRemoveChip!(path),
                    ),
                  )
                  .toList(),
            ),
          ],
          const SizedBox(height: 10),
          actionArea,
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(color: ShadowSyncColors.text),
          children: [
            TextSpan(
              text: '$label: ',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            TextSpan(text: value.isEmpty ? '-' : value),
          ],
        ),
      ),
    );
  }
}

class _DiskSpaceWarning extends StatelessWidget {
  const _DiskSpaceWarning({
    required this.sourceSize,
    required this.availableSpace,
  });

  final int sourceSize;
  final int availableSpace;

  @override
  Widget build(BuildContext context) {
    final hasEnoughSpace = availableSpace >= sourceSize;
    final marginPercent = ((availableSpace - sourceSize) / availableSpace * 100).clamp(0, 100);
    final l10n = AppLocalizations.of(context);

    if (hasEnoughSpace) {
      return Container(
        margin: const EdgeInsets.only(top: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: ShadowSyncColors.success.withOpacityFixed(0.15),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: ShadowSyncColors.success.withOpacityFixed(0.4)),
        ),
        child: Row(
          children: [
            const Icon(Icons.check_circle, color: ShadowSyncColors.success, size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                l10n.diskSpaceSufficient(marginPercent.toStringAsFixed(0)),
                style: const TextStyle(color: ShadowSyncColors.success, fontSize: 13),
              ),
            ),
          ],
        ),
      );
    }

    final deficit = sourceSize - availableSpace;
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.redAccent.withOpacityFixed(0.15),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.redAccent.withOpacityFixed(0.4)),
      ),
      child: Row(
        children: [
          const Icon(Icons.warning_amber_rounded, color: Colors.redAccent, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              l10n.diskSpaceInsufficient(DiskSpaceService.formatBytes(deficit)),
              style: const TextStyle(color: Colors.redAccent, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}
