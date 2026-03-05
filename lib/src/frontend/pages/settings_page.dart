// ============================================================================
// APLICATIVO: ShadowSync - Gerenciador de Backups
// AUTOR: Eng. Hewerton Bianchi
// DATA: 2024-06-15
// DESCRIÇÃO: Página de configurações do usuário, incluindo nome, avatar, senha de criptografia e opções de backup.
// ============================================================================

// ============================================================================
// IMPORTAÇÕES
// ============================================================================
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import '../../backend/models/user_settings.dart';
import '../../backend/models/telegram_notification_config.dart';
import '../../backend/models/email_notification_config.dart';
import '../../backend/models/email_smtp_preset.dart';
import '../../backend/services/user_settings_service.dart';
import '../../backend/services/telegram_notification_service.dart';
import '../../backend/services/email_notification_service.dart';
import '../../backend/services/locale_service.dart';
import '../../generated/l10n/app_localizations.dart';
import '../theme/shadowsync_theme.dart';

// ============================================================================
// CONFIGURAÇÃO DE TIPOGRAFIA DA PÁGINA DE CONFIGURAÇÕES
// ============================================================================

/// Fonte padrão usada em todos os textos da página
const String kSettingsFontFamily = 'Roboto';

/// Peso da fonte para títulos
const FontWeight kSettingsTitleFontWeight = FontWeight.w600;

/// Peso da fonte para labels
const FontWeight kSettingsLabelFontWeight = FontWeight.w500;

/// Peso da fonte para textos normais
const FontWeight kSettingsNormalFontWeight = FontWeight.normal;

// ============================================================================
// CONFIGURAÇÃO DE TAMANHOS DE FONTE
// ============================================================================

/// Tamanho da fonte do título da página
const double kSettingsTitleFontSize = 18.0;

/// Tamanho da fonte dos labels dos campos
const double kSettingsLabelFontSize = 13.0;

/// Tamanho da fonte dos campos de input
const double kSettingsInputFontSize = 14.0;

/// Tamanho da fonte dos botões
const double kSettingsButtonFontSize = 14.0;

/// Tamanho da fonte das descrições
const double kSettingsDescriptionFontSize = 11.0;

// ============================================================================
// CONFIGURAÇÃO DE DIMENSÕES DA JANELA
// ============================================================================

/// Largura da janela de configurações
const double kSettingsWindowWidth = 650.0;

/// Altura da janela de configurações
const double kSettingsWindowHeight = 700.0;

/// Raio de borda da janela
const double kSettingsWindowBorderRadius = 20.0;

/// Intensidade do blur do backdrop
const double kSettingsBlurSigma = 15.0;

// ============================================================================
// CONFIGURAÇÃO DO AVATAR
// ============================================================================

/// Tamanho do avatar na página de configurações
const double kSettingsAvatarSize = 80.0;

/// Tamanho do ícone de edição do avatar
const double kSettingsAvatarEditIconSize = 24.0;

/// Tamanho do container do ícone de edição
const double kSettingsAvatarEditContainerSize = 32.0;

// ============================================================================
// CONFIGURAÇÃO DOS CAMPOS DE INPUT
// ============================================================================

/// Altura dos campos de input
const double kSettingsInputHeight = 44.0;

/// Raio de borda dos campos de input
const double kSettingsInputBorderRadius = 10.0;

/// Padding horizontal interno dos inputs
const double kSettingsInputHorizontalPadding = 12.0;

// ============================================================================
// CONFIGURAÇÃO DOS BOTÕES
// ============================================================================

/// Altura dos botões
const double kSettingsButtonHeight = 44.0;

/// Raio de borda dos botões
const double kSettingsButtonBorderRadius = 10.0;

// ============================================================================
// ESPAÇAMENTOS
// ============================================================================

/// Padding geral da página
const double kSettingsPagePadding = 24.0;

/// Espaço entre o título e o conteúdo
const double kSettingsTitleToContentSpacing = 20.0;

/// Espaço entre campos
const double kSettingsFieldSpacing = 16.0;

/// Espaço entre label e input
const double kSettingsLabelToInputSpacing = 6.0;

/// Espaço entre o conteúdo e os botões
const double kSettingsContentToButtonsSpacing = 24.0;

// ============================================================================
// WIDGET SETTINGS PAGE
// ============================================================================

class SettingsPage extends StatefulWidget {
  const SettingsPage({
    super.key,
    this.initialUserName,
    this.initialAvatarUrl,
    this.initialEncryptionPassword,
    this.initialUseCustomBackupName,
    this.initialCustomBackupName,
  });

  /// Nome do usuário atual
  final String? initialUserName;

  /// URL do avatar atual
  final String? initialAvatarUrl;

  /// Senha de criptografia atual
  final String? initialEncryptionPassword;

  /// Se deve usar nome personalizado para backup
  final bool? initialUseCustomBackupName;

  /// Nome personalizado para backup
  final String? initialCustomBackupName;

  /// Abre a página de configurações como um diálogo ou tela cheia (mobile)
  static Future<SettingsResult?> show(
    BuildContext context, {
    String? initialUserName,
    String? initialAvatarUrl,
    String? initialEncryptionPassword,
    bool? initialUseCustomBackupName,
    String? initialCustomBackupName,
  }) {
    final isMobile = Platform.isAndroid || Platform.isIOS;
    
    if (isMobile) {
      // Em dispositivos móveis, abre em tela cheia
      return Navigator.of(context).push<SettingsResult>(
        MaterialPageRoute(
          fullscreenDialog: true,
          builder: (context) => SettingsPage(
            initialUserName: initialUserName,
            initialAvatarUrl: initialAvatarUrl,
            initialEncryptionPassword: initialEncryptionPassword,
            initialUseCustomBackupName: initialUseCustomBackupName,
            initialCustomBackupName: initialCustomBackupName,
          ),
        ),
      );
    }
    
    // Em desktop, abre como diálogo
    return showDialog<SettingsResult>(
      context: context,
      barrierColor: Colors.black54,
      builder: (context) => Center(
        child: SizedBox(
          width: kSettingsWindowWidth,
          height: kSettingsWindowHeight,
          child: SettingsPage(
            initialUserName: initialUserName,
            initialAvatarUrl: initialAvatarUrl,
            initialEncryptionPassword: initialEncryptionPassword,
            initialUseCustomBackupName: initialUseCustomBackupName,
            initialCustomBackupName: initialCustomBackupName,
          ),
        ),
      ),
    );
  }

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage>
    with SingleTickerProviderStateMixin {
  late final TextEditingController _userNameController;
  late final TextEditingController _passwordController;
  late final TextEditingController _customBackupNameController;
  late bool _useCustomBackupName;
  late bool _obscurePassword;
  String? _avatarPath;
  bool _isLoading = false;
  UserSettingsService? _settingsService;
  late final LocaleService _localeService;

  // Telegram notification controllers
  late TabController _tabController;
  late final TextEditingController _telegramBotTokenController;
  late final TextEditingController _telegramChatIdController;
  bool _telegramEnabled = false;
  bool _notifyOnSuccess = true;
  bool _notifyOnFailure = true;
  bool _notifyOnStart = false;
  bool _obscureBotToken = true;
  bool _isSendingTestMessage = false;
  TelegramNotificationService? _telegramService;

  // Email notification controllers
  late final TextEditingController _emailSmtpServerController;
  late final TextEditingController _emailSmtpPortController;
  late final TextEditingController _emailSenderController;
  late final TextEditingController _emailPasswordController;
  late final TextEditingController _emailRecipientsController;
  bool _emailEnabled = false;
  bool _emailNotifyOnSuccess = true;
  bool _emailNotifyOnFailure = true;
  bool _emailNotifyOnStart = false;
  bool _emailUseSSL = false;
  bool _emailUseTLS = true;
  bool _obscureEmailPassword = true;
  bool _isSendingTestEmail = false;
  String? _selectedEmailPreset;
  EmailNotificationService? _emailService;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _userNameController = TextEditingController(text: widget.initialUserName ?? '');
    _passwordController = TextEditingController(text: widget.initialEncryptionPassword ?? '');
    _customBackupNameController = TextEditingController(text: widget.initialCustomBackupName ?? '');
    _telegramBotTokenController = TextEditingController();
    _telegramChatIdController = TextEditingController();
    _emailSmtpServerController = TextEditingController();
    _emailSmtpPortController = TextEditingController(text: '587');
    _emailSenderController = TextEditingController();
    _emailPasswordController = TextEditingController();
    _emailRecipientsController = TextEditingController();
    _useCustomBackupName = widget.initialUseCustomBackupName ?? false;
    _obscurePassword = true;
    _avatarPath = widget.initialAvatarUrl;
    // Obtém a instância singleton do LocaleService já inicializada
    _localeService = LocaleService.getInstance();
    _initServices();
  }

  Future<void> _initServices() async {
    _settingsService = await UserSettingsService.getInstance();
    _telegramService = await TelegramNotificationService.getInstance();
    _emailService = await EmailNotificationService.getInstance();
    if (mounted) {
      final settings = _settingsService!.getSettings();
      final telegramConfig = _telegramService!.getConfig();
      final emailConfig = _emailService!.getConfig();
      setState(() {
        _userNameController.text = settings.userName ?? '';
        _passwordController.text = settings.encryptionPassword ?? '';
        _customBackupNameController.text = settings.customBackupName ?? '';
        _useCustomBackupName = settings.useCustomBackupName;
        _avatarPath = settings.avatarPath;
        
        // Telegram config
        _telegramBotTokenController.text = telegramConfig.botToken ?? '';
        _telegramChatIdController.text = telegramConfig.chatId ?? '';
        _telegramEnabled = telegramConfig.isEnabled;
        _notifyOnSuccess = telegramConfig.notifyOnSuccess;
        _notifyOnFailure = telegramConfig.notifyOnFailure;
        _notifyOnStart = telegramConfig.notifyOnStart;

        // Email config
        _emailSmtpServerController.text = emailConfig.smtpServer ?? '';
        _emailSmtpPortController.text = emailConfig.smtpPort.toString();
        _emailSenderController.text = emailConfig.senderEmail ?? '';
        _emailPasswordController.text = emailConfig.senderPassword ?? '';
        _emailRecipientsController.text = emailConfig.recipientEmails.join(', ');
        _emailEnabled = emailConfig.isEnabled;
        _emailNotifyOnSuccess = emailConfig.notifyOnSuccess;
        _emailNotifyOnFailure = emailConfig.notifyOnFailure;
        _emailNotifyOnStart = emailConfig.notifyOnStart;
        _emailUseSSL = emailConfig.useSSL;
        _emailUseTLS = emailConfig.useTLS;
        _selectedEmailPreset = emailConfig.presetName;
      });
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _userNameController.dispose();
    _passwordController.dispose();
    _customBackupNameController.dispose();
    _telegramBotTokenController.dispose();
    _telegramChatIdController.dispose();
    _emailSmtpServerController.dispose();
    _emailSmtpPortController.dispose();
    _emailSenderController.dispose();
    _emailPasswordController.dispose();
    _emailRecipientsController.dispose();
    super.dispose();
  }

  Future<void> _onSave() async {
    if (_settingsService == null) return;

    setState(() => _isLoading = true);

    try {
      // Salva configurações gerais
      await _settingsService!.saveSettings(
        UserSettings(
          userName: _userNameController.text.trim(),
          avatarPath: _avatarPath,
          encryptionPassword: _passwordController.text,
          useCustomBackupName: _useCustomBackupName,
          customBackupName: _useCustomBackupName ? _customBackupNameController.text.trim() : null,
        ),
      );

      // Salva configurações do Telegram
      if (_telegramService != null) {
        await _telegramService!.saveConfig(
          TelegramNotificationConfig(
            isEnabled: _telegramEnabled,
            botToken: _telegramBotTokenController.text.trim(),
            chatId: _telegramChatIdController.text.trim(),
            notifyOnSuccess: _notifyOnSuccess,
            notifyOnFailure: _notifyOnFailure,
            notifyOnStart: _notifyOnStart,
          ),
        );
      }

      // Salva configurações de Email
      if (_emailService != null) {
        final recipientsList = _emailRecipientsController.text
            .split(RegExp(r'[,;]'))
            .map((e) => e.trim())
            .where((e) => e.isNotEmpty)
            .toList();
        
        await _emailService!.saveConfig(
          EmailNotificationConfig(
            isEnabled: _emailEnabled,
            smtpServer: _emailSmtpServerController.text.trim(),
            smtpPort: int.tryParse(_emailSmtpPortController.text.trim()) ?? 587,
            senderEmail: _emailSenderController.text.trim(),
            senderPassword: _emailPasswordController.text,
            recipientEmails: recipientsList,
            useSSL: _emailUseSSL,
            useTLS: _emailUseTLS,
            notifyOnSuccess: _emailNotifyOnSuccess,
            notifyOnFailure: _emailNotifyOnFailure,
            notifyOnStart: _emailNotifyOnStart,
            presetName: _selectedEmailPreset,
          ),
        );
      }

      if (mounted) {
        final result = SettingsResult(
          userName: _userNameController.text.trim(),
          avatarUrl: _avatarPath,
          encryptionPassword: _passwordController.text,
          useCustomBackupName: _useCustomBackupName,
          customBackupName: _useCustomBackupName ? _customBackupNameController.text.trim() : null,
        );
        Navigator.of(context).pop(result);
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  /// Envia mensagem de teste para Telegram
  Future<void> _onSendTestMessage() async {
    if (_telegramService == null) return;

    final botToken = _telegramBotTokenController.text.trim();
    final chatId = _telegramChatIdController.text.trim();

    if (botToken.isEmpty || chatId.isEmpty) {
      _showSnackBar('Preencha o Bot Token e o Chat ID para enviar teste', isError: true);
      return;
    }

    setState(() => _isSendingTestMessage = true);

    try {
      final result = await _telegramService!.sendTestMessage(
        botToken: botToken,
        chatId: chatId,
      );

      if (mounted) {
        _showSnackBar(
          result.success
              ? 'Mensagem de teste enviada com sucesso!'
              : 'Erro: ${result.message}',
          isError: !result.success,
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSendingTestMessage = false);
      }
    }
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red.shade700 : Colors.green.shade700,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  void _onCancel() {
    Navigator.of(context).pop();
  }

  Future<void> _onSelectAvatar() async {
    if (_settingsService == null) return;

    setState(() => _isLoading = true);

    try {
      final newAvatarPath = await _settingsService!.pickAndSaveAvatar();
      if (newAvatarPath != null && mounted) {
        setState(() => _avatarPath = newAvatarPath);
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Platform.isAndroid || Platform.isIOS;
    
    final content = ClipRRect(
      borderRadius: BorderRadius.circular(isMobile ? 0 : kSettingsWindowBorderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: kSettingsBlurSigma, sigmaY: kSettingsBlurSigma),
        child: Material(
          color: ShadowSyncColors.secondary.withOpacityFixed(0.85),
          borderRadius: BorderRadius.circular(isMobile ? 0 : kSettingsWindowBorderRadius),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(isMobile ? 0 : kSettingsWindowBorderRadius),
              border: isMobile ? null : Border.all(color: ShadowSyncColors.border),
            ),
            padding: EdgeInsets.all(isMobile ? kSettingsPagePadding + 8 : kSettingsPagePadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Título
                Text(
                  'Configurações',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: kSettingsFontFamily,
                    fontSize: isMobile ? kSettingsTitleFontSize + 4 : kSettingsTitleFontSize,
                    fontWeight: kSettingsTitleFontWeight,
                    color: ShadowSyncColors.text,
                  ),
                ),
                const SizedBox(height: kSettingsTitleToContentSpacing),

                // TabBar
                TabBar(
                  controller: _tabController,
                  labelColor: ShadowSyncColors.accent,
                  unselectedLabelColor: ShadowSyncColors.text.withOpacityFixed(0.6),
                  indicatorColor: ShadowSyncColors.accent,
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: ShadowSyncColors.border,
                  labelStyle: TextStyle(
                    fontFamily: kSettingsFontFamily,
                    fontSize: kSettingsLabelFontSize,
                    fontWeight: kSettingsLabelFontWeight,
                  ),
                  unselectedLabelStyle: TextStyle(
                    fontFamily: kSettingsFontFamily,
                    fontSize: kSettingsLabelFontSize,
                  ),
                  tabs: [
                    Tab(text: AppLocalizations.of(context).general, icon: const Icon(Icons.settings, size: 18)),
                    Tab(text: AppLocalizations.of(context).telegramNotifications, icon: const Icon(Icons.telegram, size: 18)),
                    Tab(text: AppLocalizations.of(context).emailNotifications, icon: const Icon(Icons.email_outlined, size: 18)),
                  ],
                ),
                const SizedBox(height: 16),

                // TabBarView com conteúdo
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildGeneralTab(isMobile),
                      _buildTelegramTab(isMobile),
                      _buildEmailTab(isMobile),
                    ],
                  ),
                ),

                const SizedBox(height: kSettingsContentToButtonsSpacing),

                // Botões
                Row(
                  children: [
                    Expanded(
                      child: _SettingsButton(
                        label: AppLocalizations.of(context).cancel,
                        isOutlined: true,
                        onPressed: _onCancel,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _SettingsButton(
                        label: AppLocalizations.of(context).save,
                        onPressed: _onSave,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );

    if (isMobile) {
      return Scaffold(
        backgroundColor: ShadowSyncColors.primaryBackground,
        body: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(0.0, -0.2),
                radius: 1.15,
                colors: [Color(0xFF0F172A), Color(0xFF020617)],
              ),
            ),
            child: content,
          ),
        ),
      );
    }

    return content;
  }

  /// Constrói o conteúdo da aba Geral
  Widget _buildGeneralTab(bool isMobile) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(right: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar
          Center(
            child: _isLoading
                ? SizedBox(
                    width: kSettingsAvatarSize,
                    height: kSettingsAvatarSize,
                    child: CircularProgressIndicator(
                      color: ShadowSyncColors.accent,
                    ),
                  )
                : _AvatarSelector(
                    avatarPath: _avatarPath,
                    userName: _userNameController.text,
                    onTap: _onSelectAvatar,
                  ),
          ),
          const SizedBox(height: kSettingsFieldSpacing),

          // Seletor de Idioma
          ListenableBuilder(
            listenable: _localeService,
            builder: (context, child) {
              return _SettingsField(
                label: AppLocalizations.of(context).language,
                child: _LanguageSelector(
                  currentLocale: _localeService.currentLocale,
                  onLanguageChanged: (locale) {
                    _localeService.setLocale(locale);
                  },
                ),
              );
            },
          ),
          const SizedBox(height: kSettingsFieldSpacing),

          // Nome do usuário
          _SettingsField(
            label: AppLocalizations.of(context).userName,
            child: _SettingsInput(
              controller: _userNameController,
              hintText: AppLocalizations.of(context).enterYourName,
              onChanged: (_) => setState(() {}),
            ),
          ),
          const SizedBox(height: kSettingsFieldSpacing),

          // Senha de criptografia
          _SettingsField(
            label: AppLocalizations.of(context).encryptionPassword,
            description: AppLocalizations.of(context).encryptionPasswordHint,
            child: _SettingsInput(
              controller: _passwordController,
              hintText: AppLocalizations.of(context).enterPassword,
              obscureText: _obscurePassword,
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                  color: ShadowSyncColors.text.withOpacityFixed(0.5),
                  size: 20,
                ),
                onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
              ),
            ),
          ),
          const SizedBox(height: kSettingsFieldSpacing),

          // Opção de nome personalizado
          _SettingsField(
            label: AppLocalizations.of(context).backupFileName,
            child: Column(
              children: [
                _SettingsSwitch(
                  value: _useCustomBackupName,
                  label: AppLocalizations.of(context).useCustomName,
                  onChanged: (value) => setState(() => _useCustomBackupName = value),
                ),
                if (_useCustomBackupName) ...[
                  const SizedBox(height: kSettingsLabelToInputSpacing),
                  _SettingsInput(
                    controller: _customBackupNameController,
                    hintText: 'Nome personalizado',
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Constrói o conteúdo da aba Telegram
  Widget _buildTelegramTab(bool isMobile) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(right: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Switch para habilitar/desabilitar
          _SettingsField(
            label: AppLocalizations.of(context).telegramNotifications,
            description: AppLocalizations.of(context).telegramDescription,
            child: _SettingsSwitch(
              value: _telegramEnabled,
              label: AppLocalizations.of(context).enableNotifications,
              onChanged: (value) => setState(() => _telegramEnabled = value),
            ),
          ),
          const SizedBox(height: kSettingsFieldSpacing),

          // Campos de configuração (apenas se habilitado)
          AnimatedOpacity(
            opacity: _telegramEnabled ? 1.0 : 0.5,
            duration: const Duration(milliseconds: 200),
            child: IgnorePointer(
              ignoring: !_telegramEnabled,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Bot Token
                  _SettingsField(
                    label: AppLocalizations.of(context).botToken,
                    description: AppLocalizations.of(context).botTokenHint,
                    child: _SettingsInput(
                      controller: _telegramBotTokenController,
                      hintText: '123456789:ABCdefGHI...',
                      obscureText: _obscureBotToken,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureBotToken ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                          color: ShadowSyncColors.text.withOpacityFixed(0.5),
                          size: 20,
                        ),
                        onPressed: () => setState(() => _obscureBotToken = !_obscureBotToken),
                      ),
                    ),
                  ),
                  const SizedBox(height: kSettingsFieldSpacing),

                  // Chat ID
                  _SettingsField(
                    label: AppLocalizations.of(context).chatId,
                    description: AppLocalizations.of(context).chatIdHint,
                    child: _SettingsInput(
                      controller: _telegramChatIdController,
                      hintText: AppLocalizations.of(context).chatIdExample,
                    ),
                  ),
                  const SizedBox(height: kSettingsFieldSpacing),

                  // Opções de notificação
                  _SettingsField(
                    label: AppLocalizations.of(context).whenNotify,
                    child: Column(
                      children: [
                        _SettingsSwitch(
                          value: _notifyOnSuccess,
                          label: AppLocalizations.of(context).backupSuccess,
                          onChanged: (value) => setState(() => _notifyOnSuccess = value),
                        ),
                        const SizedBox(height: 8),
                        _SettingsSwitch(
                          value: _notifyOnFailure,
                          label: AppLocalizations.of(context).backupFailed,
                          onChanged: (value) => setState(() => _notifyOnFailure = value),
                        ),
                        const SizedBox(height: 8),
                        _SettingsSwitch(
                          value: _notifyOnStart,
                          label: AppLocalizations.of(context).backupStarted,
                          onChanged: (value) => setState(() => _notifyOnStart = value),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: kSettingsFieldSpacing),

                  // Botão de teste
                  Center(
                    child: SizedBox(
                      width: isMobile ? double.infinity : 200,
                      child: _SettingsButton(
                        label: _isSendingTestMessage ? AppLocalizations.of(context).sending : AppLocalizations.of(context).sendTest,
                        onPressed: _isSendingTestMessage ? () {} : _onSendTestMessage,
                        isOutlined: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Constrói o conteúdo da aba Email
  Widget _buildEmailTab(bool isMobile) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(right: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Switch para habilitar/desabilitar
          _SettingsField(
            label: AppLocalizations.of(context).emailNotifications,
            description: AppLocalizations.of(context).emailDescription,
            child: _SettingsSwitch(
              value: _emailEnabled,
              label: AppLocalizations.of(context).enableNotifications,
              onChanged: (value) => setState(() => _emailEnabled = value),
            ),
          ),
          const SizedBox(height: kSettingsFieldSpacing),

          // Campos de configuração (apenas se habilitado)
          AnimatedOpacity(
            opacity: _emailEnabled ? 1.0 : 0.5,
            duration: const Duration(milliseconds: 200),
            child: IgnorePointer(
              ignoring: !_emailEnabled,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Dropdown de presets
                  _SettingsField(
                    label: AppLocalizations.of(context).emailProvider,
                    description: AppLocalizations.of(context).emailProviderHint,
                    child: Container(
                      height: kSettingsInputHeight,
                      decoration: BoxDecoration(
                        color: ShadowSyncColors.primaryBackground.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(kSettingsInputBorderRadius),
                        border: Border.all(color: ShadowSyncColors.border),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: kSettingsInputHorizontalPadding),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _selectedEmailPreset,
                          hint: Text(
                            AppLocalizations.of(context).selectProvider,
                            style: TextStyle(
                              color: ShadowSyncColors.text.withValues(alpha: 0.5),
                              fontSize: kSettingsInputFontSize,
                            ),
                          ),
                          isExpanded: true,
                          dropdownColor: ShadowSyncColors.secondary,
                          style: TextStyle(
                            color: ShadowSyncColors.text,
                            fontSize: kSettingsInputFontSize,
                            fontFamily: kSettingsFontFamily,
                          ),
                          items: EmailSmtpPreset.presets.map((preset) {
                            return DropdownMenuItem<String>(
                              value: preset.name,
                              child: Text(preset.displayName),
                            );
                          }).toList(),
                          onChanged: (value) {
                            final preset = EmailSmtpPreset.getByName(value);
                            if (preset != null && preset.name != 'custom') {
                              setState(() {
                                _selectedEmailPreset = value;
                                _emailSmtpServerController.text = preset.smtpServer;
                                _emailSmtpPortController.text = preset.port.toString();
                                _emailUseSSL = preset.useSSL;
                                _emailUseTLS = preset.useTLS;
                              });
                            } else {
                              setState(() {
                                _selectedEmailPreset = value;
                              });
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: kSettingsFieldSpacing),

                  // Servidor SMTP
                  _SettingsField(
                    label: AppLocalizations.of(context).smtpServer,
                    description: AppLocalizations.of(context).smtpServerExample,
                    child: _SettingsInput(
                      controller: _emailSmtpServerController,
                      hintText: AppLocalizations.of(context).smtpServerPlaceholder,
                      enabled: _selectedEmailPreset == 'custom' || _selectedEmailPreset == null,
                    ),
                  ),
                  const SizedBox(height: kSettingsFieldSpacing),

                  // Porta SMTP
                  _SettingsField(
                    label: AppLocalizations.of(context).smtpPort,
                    description: AppLocalizations.of(context).smtpPortHint,
                    child: _SettingsInput(
                      controller: _emailSmtpPortController,
                      hintText: AppLocalizations.of(context).smtpPortPlaceholder,
                      keyboardType: TextInputType.number,
                      enabled: _selectedEmailPreset == 'custom' || _selectedEmailPreset == null,
                    ),
                  ),
                  const SizedBox(height: kSettingsFieldSpacing),

                  // Email de origem
                  _SettingsField(
                    label: AppLocalizations.of(context).yourEmail,
                    description: AppLocalizations.of(context).yourEmailHint,
                    child: _SettingsInput(
                      controller: _emailSenderController,
                      hintText: AppLocalizations.of(context).yourEmailPlaceholder,
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  const SizedBox(height: kSettingsFieldSpacing),

                  // Senha / App Password
                  _SettingsField(
                    label: AppLocalizations.of(context).emailPassword,
                    description: AppLocalizations.of(context).emailPasswordHint,
                    child: _SettingsInput(
                      controller: _emailPasswordController,
                      hintText: AppLocalizations.of(context).emailPasswordPlaceholder,
                      obscureText: _obscureEmailPassword,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureEmailPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                          color: ShadowSyncColors.text.withValues(alpha: 0.5),
                          size: 20,
                        ),
                        onPressed: () => setState(() => _obscureEmailPassword = !_obscureEmailPassword),
                      ),
                    ),
                  ),
                  const SizedBox(height: kSettingsFieldSpacing),

                  // Emails de destino
                  _SettingsField(
                    label: AppLocalizations.of(context).destinationEmails,
                    description: AppLocalizations.of(context).destinationEmailsHint,
                    child: _SettingsInput(
                      controller: _emailRecipientsController,
                      hintText: AppLocalizations.of(context).destinationEmailsPlaceholder,
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  const SizedBox(height: kSettingsFieldSpacing),

                  // Opções de segurança
                  _SettingsField(
                    label: AppLocalizations.of(context).security,
                    child: Column(
                      children: [
                        Opacity(
                          opacity: (_selectedEmailPreset == 'custom' || _selectedEmailPreset == null) ? 1.0 : 0.5,
                          child: IgnorePointer(
                            ignoring: !(_selectedEmailPreset == 'custom' || _selectedEmailPreset == null),
                            child: _SettingsSwitch(
                              value: _emailUseTLS,
                              label: AppLocalizations.of(context).useStartTls,
                              onChanged: (value) => setState(() {
                                _emailUseTLS = value;
                                if (value) _emailUseSSL = false;
                              }),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Opacity(
                          opacity: (_selectedEmailPreset == 'custom' || _selectedEmailPreset == null) ? 1.0 : 0.5,
                          child: IgnorePointer(
                            ignoring: !(_selectedEmailPreset == 'custom' || _selectedEmailPreset == null),
                            child: _SettingsSwitch(
                              value: _emailUseSSL,
                              label: AppLocalizations.of(context).useSsl,
                              onChanged: (value) => setState(() {
                                _emailUseSSL = value;
                                if (value) _emailUseTLS = false;
                              }),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: kSettingsFieldSpacing),

                  // Opções de notificação
                  _SettingsField(
                    label: AppLocalizations.of(context).whenNotify,
                    child: Column(
                      children: [
                        _SettingsSwitch(
                          value: _emailNotifyOnSuccess,
                          label: AppLocalizations.of(context).backupSuccess,
                          onChanged: (value) => setState(() => _emailNotifyOnSuccess = value),
                        ),
                        const SizedBox(height: 8),
                        _SettingsSwitch(
                          value: _emailNotifyOnFailure,
                          label: AppLocalizations.of(context).backupFailed,
                          onChanged: (value) => setState(() => _emailNotifyOnFailure = value),
                        ),
                        const SizedBox(height: 8),
                        _SettingsSwitch(
                          value: _emailNotifyOnStart,
                          label: AppLocalizations.of(context).backupStarted,
                          onChanged: (value) => setState(() => _emailNotifyOnStart = value),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: kSettingsFieldSpacing),

                  // Botão de teste
                  Center(
                    child: SizedBox(
                      width: isMobile ? double.infinity : 200,
                      child: _SettingsButton(
                        label: _isSendingTestEmail ? AppLocalizations.of(context).sending : AppLocalizations.of(context).sendTest,
                        onPressed: _isSendingTestEmail ? () {} : _onSendTestEmail,
                        isOutlined: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Envia email de teste para verificar a configuração
  Future<void> _onSendTestEmail() async {
    if (_emailService == null) return;

    final smtpServer = _emailSmtpServerController.text.trim();
    final smtpPort = int.tryParse(_emailSmtpPortController.text.trim()) ?? 587;
    final senderEmail = _emailSenderController.text.trim();
    final senderPassword = _emailPasswordController.text;
    final recipientsText = _emailRecipientsController.text.trim();

    if (smtpServer.isEmpty || senderEmail.isEmpty || senderPassword.isEmpty || recipientsText.isEmpty) {
      _showSnackBar('Preencha todos os campos obrigatórios', isError: true);
      return;
    }

    final recipientsList = recipientsText
        .split(RegExp(r'[,;]'))
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();

    if (recipientsList.isEmpty) {
      _showSnackBar('Insira pelo menos um email de destino', isError: true);
      return;
    }

    setState(() => _isSendingTestEmail = true);

    try {
      final result = await _emailService!.sendTestEmail(
        smtpServer: smtpServer,
        smtpPort: smtpPort,
        senderEmail: senderEmail,
        senderPassword: senderPassword,
        recipientEmails: recipientsList,
        useSSL: _emailUseSSL,
        useTLS: _emailUseTLS,
      );

      if (mounted) {
        _showSnackBar(
          result.success
              ? 'Email de teste enviado com sucesso!'
              : 'Erro: ${result.message}',
          isError: !result.success,
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSendingTestEmail = false);
      }
    }
  }
}

// ============================================================================
// RESULTADO DAS CONFIGURAÇÕES
// ============================================================================

class SettingsResult {
  const SettingsResult({
    required this.userName,
    this.avatarUrl,
    required this.encryptionPassword,
    required this.useCustomBackupName,
    this.customBackupName,
  });

  final String userName;
  final String? avatarUrl;
  final String encryptionPassword;
  final bool useCustomBackupName;
  final String? customBackupName;
}

// ============================================================================
// WIDGET SELETOR DE AVATAR
// ============================================================================

class _AvatarSelector extends StatelessWidget {
  const _AvatarSelector({
    this.avatarPath,
    this.userName,
    this.onTap,
  });

  final String? avatarPath;
  final String? userName;
  final VoidCallback? onTap;

  String _getInitials() {
    if (userName == null || userName!.isEmpty) return 'U';
    final parts = userName!.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
    }
    return parts.first[0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            width: kSettingsAvatarSize,
            height: kSettingsAvatarSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: ShadowSyncColors.accent,
                width: 2,
              ),
            ),
            child: ClipOval(
              child: avatarPath != null && avatarPath!.isNotEmpty
                  ? Image.file(
                      File(avatarPath!),
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => _buildFallback(),
                    )
                  : _buildFallback(),
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: kSettingsAvatarEditContainerSize,
              height: kSettingsAvatarEditContainerSize,
              decoration: BoxDecoration(
                color: ShadowSyncColors.accent,
                shape: BoxShape.circle,
                border: Border.all(
                  color: ShadowSyncColors.secondary,
                  width: 2,
                ),
              ),
              child: Icon(
                Icons.edit,
                color: Colors.white,
                size: kSettingsAvatarEditIconSize - 8,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFallback() {
    return Container(
      color: ShadowSyncColors.primaryBackground,
      alignment: Alignment.center,
      child: Text(
        _getInitials(),
        style: TextStyle(
          fontFamily: kSettingsFontFamily,
          color: ShadowSyncColors.accent,
          fontWeight: kSettingsTitleFontWeight,
          fontSize: 28,
        ),
      ),
    );
  }
}

// ============================================================================
// WIDGET CAMPO DE CONFIGURAÇÃO
// ============================================================================

class _SettingsField extends StatelessWidget {
  const _SettingsField({
    required this.label,
    required this.child,
    this.description,
  });

  final String label;
  final Widget child;
  final String? description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: kSettingsFontFamily,
            fontSize: kSettingsLabelFontSize,
            fontWeight: kSettingsLabelFontWeight,
            color: ShadowSyncColors.text,
          ),
        ),
        if (description != null) ...[
          const SizedBox(height: 2),
          Text(
            description!,
            style: TextStyle(
              fontFamily: kSettingsFontFamily,
              fontSize: kSettingsDescriptionFontSize,
              color: ShadowSyncColors.text.withOpacityFixed(0.6),
            ),
          ),
        ],
        const SizedBox(height: kSettingsLabelToInputSpacing),
        child,
      ],
    );
  }
}

// ============================================================================
// WIDGET INPUT DE CONFIGURAÇÃO
// ============================================================================

class _SettingsInput extends StatelessWidget {
  const _SettingsInput({
    required this.controller,
    this.hintText,
    this.obscureText = false,
    this.suffixIcon,
    this.onChanged,
    this.enabled = true,
    this.keyboardType,
  });

  final TextEditingController controller;
  final String? hintText;
  final bool obscureText;
  final Widget? suffixIcon;
  final ValueChanged<String>? onChanged;
  final bool enabled;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kSettingsInputHeight,
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        onChanged: onChanged,
        enabled: enabled,
        keyboardType: keyboardType,
        style: TextStyle(
          fontFamily: kSettingsFontFamily,
          fontSize: kSettingsInputFontSize,
          color: enabled ? ShadowSyncColors.text : ShadowSyncColors.text.withValues(alpha: 0.5),
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontFamily: kSettingsFontFamily,
            fontSize: kSettingsInputFontSize,
            color: ShadowSyncColors.text.withOpacityFixed(0.4),
          ),
          filled: true,
          fillColor: ShadowSyncColors.primaryBackground.withOpacityFixed(0.5),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: kSettingsInputHorizontalPadding,
            vertical: 0,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(kSettingsInputBorderRadius),
            borderSide: BorderSide(color: ShadowSyncColors.border),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(kSettingsInputBorderRadius),
            borderSide: BorderSide(color: ShadowSyncColors.border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(kSettingsInputBorderRadius),
            borderSide: BorderSide(color: ShadowSyncColors.accent),
          ),
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}

// ============================================================================
// WIDGET SWITCH DE CONFIGURAÇÃO
// ============================================================================

class _SettingsSwitch extends StatelessWidget {
  const _SettingsSwitch({
    required this.value,
    required this.label,
    required this.onChanged,
  });

  final bool value;
  final String label;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontFamily: kSettingsFontFamily,
              fontSize: kSettingsInputFontSize,
              color: ShadowSyncColors.text.withOpacityFixed(0.8),
            ),
          ),
        ),
        Transform.scale(
          scale: 0.8,
          child: Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: ShadowSyncColors.accent,
            activeTrackColor: ShadowSyncColors.accent.withOpacityFixed(0.4),
            inactiveThumbColor: ShadowSyncColors.text.withOpacityFixed(0.6),
            inactiveTrackColor: ShadowSyncColors.text.withOpacityFixed(0.2),
          ),
        ),
      ],
    );
  }
}

// ============================================================================
// WIDGET BOTÃO DE CONFIGURAÇÃO
// ============================================================================

class _SettingsButton extends StatelessWidget {
  const _SettingsButton({
    required this.label,
    required this.onPressed,
    this.isOutlined = false,
  });

  final String label;
  final VoidCallback onPressed;
  final bool isOutlined;

  @override
  Widget build(BuildContext context) {
    if (isOutlined) {
      return SizedBox(
        height: kSettingsButtonHeight,
        child: OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            foregroundColor: ShadowSyncColors.text,
            side: BorderSide(color: ShadowSyncColors.border),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kSettingsButtonBorderRadius),
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontFamily: kSettingsFontFamily,
              fontSize: kSettingsButtonFontSize,
            ),
          ),
        ),
      );
    }

    return SizedBox(
      height: kSettingsButtonHeight,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: ShadowSyncColors.accent,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kSettingsButtonBorderRadius),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: kSettingsFontFamily,
            fontSize: kSettingsButtonFontSize,
            fontWeight: kSettingsLabelFontWeight,
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// LANGUAGE SELECTOR WIDGET
// ============================================================================

/// Widget personalizado para seleção de idioma
class _LanguageSelector extends StatelessWidget {
  const _LanguageSelector({
    required this.currentLocale,
    required this.onLanguageChanged,
  });

  final Locale currentLocale;
  final ValueChanged<Locale> onLanguageChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kSettingsInputHeight,
      decoration: BoxDecoration(
        color: ShadowSyncColors.secondary,
        borderRadius: BorderRadius.circular(kSettingsInputBorderRadius),
        border: Border.all(
          color: ShadowSyncColors.border,
          width: 1,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: kSettingsInputHorizontalPadding),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<Locale>(
          value: currentLocale,
          isExpanded: true,
          dropdownColor: ShadowSyncColors.secondary,
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: ShadowSyncColors.text.withOpacityFixed(0.5),
            size: 20,
          ),
          style: TextStyle(
            fontFamily: kSettingsFontFamily,
            fontSize: kSettingsInputFontSize,
            color: ShadowSyncColors.text,
          ),
          items: LocaleService.selectableLocales.map((locale) {
            return DropdownMenuItem<Locale>(
              value: locale,
              child: Text(
                LocaleService.getLocaleName(locale),
                style: TextStyle(
                  fontFamily: kSettingsFontFamily,
                  fontSize: kSettingsInputFontSize,
                  color: ShadowSyncColors.text,
                ),
              ),
            );
          }).toList(),
          onChanged: (locale) {
            if (locale != null) {
              onLanguageChanged(locale);
            }
          },
        ),
      ),
    );
  }
}
