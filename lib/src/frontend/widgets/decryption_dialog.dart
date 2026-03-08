// ============================================================================
// APLICATIVO: ShadowSync - Gerenciador de Backups
// AUTOR: Eng. Hewerton Bianchi
// DATA: 2024-06-15
// DESCRIÇÃO: Widget dialog para descriptografar arquivos.
// ============================================================================

import 'dart:io';
import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../backend/services/compression_service.dart';
import '../../backend/services/encryption_service.dart';
import '../../generated/l10n/app_localizations.dart';
import '../theme/shadowsync_theme.dart';

// ============================================================================
// CONFIGURAÇÃO DE DIMENSÕES
// ============================================================================

/// Largura do dialog (desktop)
const double kDecryptDialogWidth = 520.0;

/// Breakpoint para mobile
const double kDecryptMobileBreakpoint = 600.0;

/// Padding interno do dialog
const double kDecryptDialogPadding = 24.0;

/// Padding interno do dialog (mobile)
const double kDecryptDialogPaddingMobile = 16.0;

/// Raio de borda do dialog
const double kDecryptDialogBorderRadius = 20.0;

/// Raio de borda dos botões
const double kDecryptButtonBorderRadius = 10.0;

/// Altura dos botões de seleção
const double kDecryptSelectButtonHeight = 56.0;

/// Altura da barra de progresso
const double kDecryptProgressHeight = 8.0;

// ============================================================================
// WIDGET PRINCIPAL
// ============================================================================

/// Dialog para descriptografar arquivos criptografados pelo ShadowSync.
class DecryptionDialog extends StatefulWidget {
  const DecryptionDialog({super.key});

  /// Exibe o dialog de descriptografia.
  static Future<void> show(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) => const DecryptionDialog(),
    );
  }

  @override
  State<DecryptionDialog> createState() => _DecryptionDialogState();
}

class _DecryptionDialogState extends State<DecryptionDialog> {
  final EncryptionService _encryptionService = const EncryptionService();
  final CompressionService _compressionService = const CompressionService();
  final TextEditingController _passwordController = TextEditingController();
  
  String? _sourceFilePath;
  String? _destinationPath;
  String? _destinationFileName;
  
  bool _isDecrypting = false;
  double _progress = 0.0;
  String? _statusMessage;
  bool _hasError = false;
  bool _isComplete = false;
  bool _showPassword = false;

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _selectSourceFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        dialogTitle: AppLocalizations.of(context).selectEncryptedFile,
        type: FileType.any,
        allowMultiple: false,
      );

      if (result != null && result.files.isNotEmpty) {
        final filePath = result.files.first.path;
        if (filePath != null) {
          setState(() {
            _sourceFilePath = filePath;
            _statusMessage = null;
            _hasError = false;
            
            // Sugere um nome de destino baseado no arquivo de origem
            final fileName = filePath.split('/').last;
            if (fileName.endsWith('.encrypted')) {
              _destinationFileName = fileName.replaceAll('.encrypted', '');
            } else {
              _destinationFileName = 'decrypted_$fileName';
            }
          });
        }
      }
    } catch (e) {
      setState(() {
        _statusMessage = AppLocalizations.of(context).errorSelectingFile(e.toString());
        _hasError = true;
      });
    }
  }

  Future<void> _selectDestination() async {
    try {
      final directoryPath = await FilePicker.platform.getDirectoryPath(
        dialogTitle: AppLocalizations.of(context).selectDestinationFolderTooltip,
      );

      if (directoryPath != null) {
        setState(() {
          _destinationPath = directoryPath;
          _statusMessage = null;
          _hasError = false;
        });
      }
    } catch (e) {
      setState(() {
        _statusMessage = AppLocalizations.of(context).errorSelectingDestination(e.toString());
        _hasError = true;
      });
    }
  }

  bool get _canExecute {
    return _sourceFilePath != null &&
           _destinationPath != null &&
           _passwordController.text.isNotEmpty &&
           !_isDecrypting;
  }

  Future<void> _executeDecryption() async {
    if (!_canExecute) return;

    setState(() {
      _isDecrypting = true;
      _progress = 0.0;
      _statusMessage = AppLocalizations.of(context).startingDecryption;
      _hasError = false;
      _isComplete = false;
    });

    String? tempZipPath;

    try {
      // Progresso inicial
      setState(() {
        _progress = 0.1;
        _statusMessage = AppLocalizations.of(context).preparingDecryption;
      });

      // Obtém caminho temporário sem usar path_provider (evita objective_c no macOS)
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final tempDirPath = Directory.systemTemp.path;
      tempZipPath = '$tempDirPath/shadowsync_decrypt_$timestamp.zip';

      setState(() {
        _statusMessage = AppLocalizations.of(context).decryptingFile;
        _progress = 0.3;
      });

      // Descriptografa para arquivo ZIP temporário
      await _encryptionService.decryptFile(
        inputFilePath: _sourceFilePath!,
        outputFilePath: tempZipPath,
        passphrase: _passwordController.text,
      );

      setState(() {
        _statusMessage = AppLocalizations.of(context).extractingContent;
        _progress = 0.6;
      });

      // Extrai o conteúdo do ZIP para o destino
      final extractedFiles = await _compressionService.extractArchive(
        archivePath: tempZipPath,
        outputDirectoryPath: _destinationPath!,
      );

      setState(() {
        _progress = 0.9;
        _statusMessage = AppLocalizations.of(context).finalizing;
      });

      // Remove o arquivo ZIP temporário
      final tempFile = File(tempZipPath);
      if (await tempFile.exists()) {
        await tempFile.delete();
      }

      if (mounted) {
        final fileCount = extractedFiles.length;
        setState(() {
          _progress = 1.0;
          _statusMessage = AppLocalizations.of(context).decryptedSuccessfully(fileCount);
          _isComplete = true;
          _isDecrypting = false;
        });
      }
    } catch (e) {
      // Limpa arquivo temporário em caso de erro
      if (tempZipPath != null) {
        final tempFile = File(tempZipPath);
        if (await tempFile.exists()) {
          await tempFile.delete();
        }
      }
      
      if (mounted) {
        setState(() {
          _statusMessage = e.toString().replaceAll('StateError: ', '');
          _hasError = true;
          _isDecrypting = false;
          _progress = 0.0;
        });
      }
    }
  }

  void _reset() {
    setState(() {
      _sourceFilePath = null;
      _destinationPath = null;
      _destinationFileName = null;
      _passwordController.clear();
      _progress = 0.0;
      _statusMessage = null;
      _hasError = false;
      _isComplete = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < kDecryptMobileBreakpoint;
        final padding = isMobile ? kDecryptDialogPaddingMobile : kDecryptDialogPadding;
        
        final dialogContent = ClipRRect(
          borderRadius: isMobile 
              ? BorderRadius.zero 
              : BorderRadius.circular(kDecryptDialogBorderRadius),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
            child: Container(
              width: isMobile ? double.infinity : kDecryptDialogWidth,
              height: isMobile ? double.infinity : null,
              decoration: BoxDecoration(
                color: ShadowSyncColors.secondary.withOpacityFixed(0.95),
                borderRadius: isMobile 
                    ? BorderRadius.zero 
                    : BorderRadius.circular(kDecryptDialogBorderRadius),
                border: isMobile ? null : Border.all(color: ShadowSyncColors.border),
              ),
              child: SafeArea(
                child: Column(
                  mainAxisSize: isMobile ? MainAxisSize.max : MainAxisSize.min,
                  children: [
                    _buildHeader(padding: padding),
                    Flexible(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildContent(padding: padding),
                            if (_statusMessage != null || _isDecrypting) 
                              _buildStatus(padding: padding),
                          ],
                        ),
                      ),
                    ),
                    _buildFooter(padding: padding, isMobile: isMobile),
                  ],
                ),
              ),
            ),
          ),
        );
        
        if (isMobile) {
          return Material(
            color: Colors.transparent,
            child: dialogContent,
          );
        }
        
        return Dialog(
          backgroundColor: Colors.transparent,
          child: dialogContent,
        );
      },
    );
  }

  Widget _buildHeader({required double padding}) {
    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: ShadowSyncColors.border.withOpacityFixed(0.3)),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: ShadowSyncColors.accent.withOpacityFixed(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.lock_open_outlined,
              color: ShadowSyncColors.accent,
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context).decryptFile,
                  style: const TextStyle(
                    color: ShadowSyncColors.text,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  AppLocalizations.of(context).decryptionDescription,
                  style: const TextStyle(
                    color: Colors.white60,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent({required double padding}) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Botão selecionar arquivo de origem
          _buildSelectButton(
            icon: Icons.file_present_outlined,
            label: AppLocalizations.of(context).encryptedFile,
            value: _sourceFilePath != null
                ? _sourceFilePath!.split('/').last
                : AppLocalizations.of(context).selectFileEllipsis,
            onPressed: _isDecrypting ? null : _selectSourceFile,
            isSelected: _sourceFilePath != null,
          ),
          
          const SizedBox(height: 16),
          
          // Botão selecionar destino
          _buildSelectButton(
            icon: Icons.folder_outlined,
            label: AppLocalizations.of(context).destinationFolder,
            value: _destinationPath != null
                ? _destinationPath!.split('/').last
                : AppLocalizations.of(context).selectFolderEllipsis,
            onPressed: _isDecrypting ? null : _selectDestination,
            isSelected: _destinationPath != null,
          ),
          
          const SizedBox(height: 16),
          
          // Nome do arquivo de saída
          if (_destinationFileName != null) ...[
            Text(
              AppLocalizations.of(context).outputFileName,
              style: TextStyle(
                color: ShadowSyncColors.text.withOpacityFixed(0.7),
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: ShadowSyncColors.primaryBackground.withOpacityFixed(0.5),
                borderRadius: BorderRadius.circular(kDecryptButtonBorderRadius),
                border: Border.all(color: ShadowSyncColors.border.withOpacityFixed(0.3)),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.description_outlined,
                    color: ShadowSyncColors.accent,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      _destinationFileName!,
                      style: const TextStyle(
                        color: ShadowSyncColors.text,
                        fontSize: 14,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
          
          // Campo de senha
          Text(
            AppLocalizations.of(context).decryptionPassword,
            style: TextStyle(
              color: ShadowSyncColors.text.withOpacityFixed(0.7),
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _passwordController,
            enabled: !_isDecrypting,
            obscureText: !_showPassword,
            style: const TextStyle(color: ShadowSyncColors.text),
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context).enterEncryptionPassword,
              hintStyle: TextStyle(color: ShadowSyncColors.text.withOpacityFixed(0.3)),
              filled: true,
              fillColor: ShadowSyncColors.primaryBackground.withOpacityFixed(0.5),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(kDecryptButtonBorderRadius),
                borderSide: BorderSide(color: ShadowSyncColors.border.withOpacityFixed(0.3)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(kDecryptButtonBorderRadius),
                borderSide: BorderSide(color: ShadowSyncColors.border.withOpacityFixed(0.3)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(kDecryptButtonBorderRadius),
                borderSide: const BorderSide(color: ShadowSyncColors.accent),
              ),
              prefixIcon: const Icon(
                Icons.key,
                color: ShadowSyncColors.accent,
                size: 20,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _showPassword ? Icons.visibility_off : Icons.visibility,
                  color: ShadowSyncColors.text.withOpacityFixed(0.5),
                  size: 20,
                ),
                onPressed: () {
                  setState(() {
                    _showPassword = !_showPassword;
                  });
                },
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            ),
            onChanged: (_) => setState(() {}),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectButton({
    required IconData icon,
    required String label,
    required String value,
    required VoidCallback? onPressed,
    required bool isSelected,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(kDecryptButtonBorderRadius),
        child: Container(
          height: kDecryptSelectButtonHeight,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: ShadowSyncColors.primaryBackground.withOpacityFixed(0.5),
            borderRadius: BorderRadius.circular(kDecryptButtonBorderRadius),
            border: Border.all(
              color: isSelected
                  ? ShadowSyncColors.accent.withOpacityFixed(0.5)
                  : ShadowSyncColors.border.withOpacityFixed(0.3),
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isSelected
                      ? ShadowSyncColors.accent.withOpacityFixed(0.15)
                      : ShadowSyncColors.border.withOpacityFixed(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: isSelected ? ShadowSyncColors.accent : ShadowSyncColors.text.withOpacityFixed(0.5),
                  size: 22,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                        color: ShadowSyncColors.text.withOpacityFixed(0.6),
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      value,
                      style: TextStyle(
                        color: isSelected
                            ? ShadowSyncColors.text
                            : ShadowSyncColors.text.withOpacityFixed(0.4),
                        fontSize: 14,
                        fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Icon(
                isSelected ? Icons.check_circle : Icons.arrow_forward_ios,
                color: isSelected
                    ? ShadowSyncColors.success
                    : ShadowSyncColors.text.withOpacityFixed(0.3),
                size: isSelected ? 22 : 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatus({required double padding}) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        padding,
        0,
        padding,
        padding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Barra de progresso
          if (_isDecrypting || _isComplete) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(kDecryptProgressHeight / 2),
              child: LinearProgressIndicator(
                value: _progress,
                minHeight: kDecryptProgressHeight,
                backgroundColor: ShadowSyncColors.border.withOpacityFixed(0.3),
                valueColor: AlwaysStoppedAnimation<Color>(
                  _hasError
                      ? Colors.red.shade400
                      : _isComplete
                          ? ShadowSyncColors.success
                          : ShadowSyncColors.accent,
                ),
              ),
            ),
            const SizedBox(height: 12),
            // Percentual
            if (_isDecrypting)
              Text(
                '${(_progress * 100).toStringAsFixed(0)}%',
                style: const TextStyle(
                  color: ShadowSyncColors.accent,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
          ],
          
          // Mensagem de status
          if (_statusMessage != null) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _hasError
                    ? Colors.red.shade400.withOpacityFixed(0.1)
                    : _isComplete
                        ? ShadowSyncColors.success.withOpacityFixed(0.1)
                        : ShadowSyncColors.accent.withOpacityFixed(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: _hasError
                      ? Colors.red.shade400.withOpacityFixed(0.3)
                      : _isComplete
                          ? ShadowSyncColors.success.withOpacityFixed(0.3)
                          : ShadowSyncColors.accent.withOpacityFixed(0.3),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    _hasError
                        ? Icons.error_outline
                        : _isComplete
                            ? Icons.check_circle_outline
                            : Icons.info_outline,
                    color: _hasError
                        ? Colors.red.shade400
                        : _isComplete
                            ? ShadowSyncColors.success
                            : ShadowSyncColors.accent,
                    size: 20,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      _statusMessage!,
                      style: TextStyle(
                        color: _hasError
                            ? Colors.red.shade400
                            : _isComplete
                                ? ShadowSyncColors.success
                                : ShadowSyncColors.text,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildFooter({required double padding, required bool isMobile}) {
    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: ShadowSyncColors.border.withOpacityFixed(0.3)),
        ),
      ),
      child: isMobile
          ? Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Botão Executar ou Novo (primeiro no mobile)
                if (_isComplete)
                  ElevatedButton.icon(
                    onPressed: _reset,
                    icon: const Icon(Icons.refresh, size: 20),
                    label: Text(AppLocalizations.of(context).decryptAnother),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ShadowSyncColors.accent,
                      foregroundColor: ShadowSyncColors.text,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(kDecryptButtonBorderRadius),
                      ),
                    ),
                  )
                else
                  ElevatedButton.icon(
                    onPressed: _canExecute ? _executeDecryption : null,
                    icon: _isDecrypting
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: ShadowSyncColors.text,
                            ),
                          )
                        : const Icon(Icons.play_arrow, size: 20),
                    label: Text(_isDecrypting 
                        ? AppLocalizations.of(context).decrypting 
                        : AppLocalizations.of(context).execute),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _canExecute
                          ? ShadowSyncColors.accent
                          : ShadowSyncColors.border.withOpacityFixed(0.3),
                      foregroundColor: ShadowSyncColors.text,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(kDecryptButtonBorderRadius),
                      ),
                    ),
                  ),
                const SizedBox(height: 12),
                // Botão Fechar
                TextButton(
                  onPressed: _isDecrypting ? null : () => Navigator.of(context).pop(),
                  child: Text(
                    AppLocalizations.of(context).close,
                    style: TextStyle(
                      color: _isDecrypting
                          ? ShadowSyncColors.text.withOpacityFixed(0.3)
                          : ShadowSyncColors.text.withOpacityFixed(0.7),
                    ),
                  ),
                ),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Botão Fechar
                TextButton(
                  onPressed: _isDecrypting ? null : () => Navigator.of(context).pop(),
                  child: Text(
                    AppLocalizations.of(context).close,
                    style: TextStyle(
                      color: _isDecrypting
                          ? ShadowSyncColors.text.withOpacityFixed(0.3)
                          : ShadowSyncColors.text.withOpacityFixed(0.7),
                    ),
                  ),
                ),
                
                const SizedBox(width: 12),
                
                // Botão Executar ou Novo
                if (_isComplete)
                  ElevatedButton.icon(
                    onPressed: _reset,
                    icon: const Icon(Icons.refresh, size: 20),
                    label: Text(AppLocalizations.of(context).decryptAnother),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ShadowSyncColors.accent,
                      foregroundColor: ShadowSyncColors.text,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(kDecryptButtonBorderRadius),
                      ),
                    ),
                  )
                else
                  ElevatedButton.icon(
                    onPressed: _canExecute ? _executeDecryption : null,
                    icon: _isDecrypting
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: ShadowSyncColors.text,
                            ),
                          )
                        : const Icon(Icons.play_arrow, size: 20),
                    label: Text(_isDecrypting 
                        ? AppLocalizations.of(context).decrypting 
                        : AppLocalizations.of(context).execute),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _canExecute
                          ? ShadowSyncColors.accent
                          : ShadowSyncColors.border.withOpacityFixed(0.3),
                      foregroundColor: ShadowSyncColors.text,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(kDecryptButtonBorderRadius),
                      ),
                    ),
                  ),
              ],
            ),
    );
  }
}
