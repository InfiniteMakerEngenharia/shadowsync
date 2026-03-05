// ============================================================================
// APLICATIVO: ShadowSync - Gerenciador de Backups
// AUTOR: Eng. Hewerton Bianchi
// DATA: 2024-06-15
// DESCRIÇÃO: Widget da sidebar lateral do dashboard, contendo avatar, menu de ferramentas e botão de configurações.
// ============================================================================

// ============================================================================
// IMPORTAÇÕES
// ============================================================================
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import '../../generated/l10n/app_localizations.dart';
import '../theme/shadowsync_theme.dart';

// ============================================================================
// CONFIGURAÇÃO DE TIPOGRAFIA DA SIDEBAR
// ============================================================================

/// Fonte padrão usada em todos os textos da sidebar
const String kSidebarFontFamily = 'Roboto';

/// Peso da fonte para títulos/letras de fallback
const FontWeight kSidebarTitleFontWeight = FontWeight.bold;

/// Peso da fonte para itens de menu
const FontWeight kSidebarMenuFontWeight = FontWeight.w500;

// ============================================================================
// CONFIGURAÇÃO DE DIMENSÕES DA SIDEBAR
// ============================================================================

/// Largura total da sidebar
const double kSidebarWidth = 180.0;

/// Margem externa da sidebar (left, top, right, bottom)
const EdgeInsets kSidebarMargin = EdgeInsets.fromLTRB(14, 14, 0, 14);

/// Raio de borda do container da sidebar
const double kSidebarBorderRadius = 20.0;

/// Intensidade do blur do backdrop
const double kSidebarBlurSigma = 12.0;

/// Padding vertical interno
const double kSidebarVerticalPadding = 16.0;

// ============================================================================
// CONFIGURAÇÃO DO AVATAR DO USUÁRIO
// ============================================================================

/// Tamanho do avatar do usuário
const double kSidebarAvatarSize = 80.0;

/// Raio de borda do avatar
const double kSidebarAvatarBorderRadius = 28.0;

/// Largura da borda do avatar
const double kSidebarAvatarBorderWidth = 2.0;

/// Tamanho da fonte do fallback do avatar (iniciais)
const double kSidebarAvatarFallbackFontSize = 20.0;

// ============================================================================
// CONFIGURAÇÃO DO MENU DE FERRAMENTAS
// ============================================================================

/// Tamanho do ícone dos itens de menu
const double kSidebarMenuIconSize = 36.0;

/// Tamanho da fonte dos itens de menu
const double kSidebarMenuFontSize = 11.0;

/// Espaçamento entre ícone e texto do menu
const double kSidebarMenuIconTextSpacing = 6.0;

/// Espaçamento entre itens de menu
const double kSidebarMenuItemSpacing = 12.0;

/// Padding do item de menu
const double kSidebarMenuItemPadding = 12.0;

/// Raio de borda do item de menu
const double kSidebarMenuItemBorderRadius = 12.0;

/// Duração da animação de hover
const Duration kSidebarHoverAnimationDuration = Duration(milliseconds: 200);

// ============================================================================
// CONFIGURAÇÃO UNIFICADA DOS BOTÕES DA SIDEBAR
// ============================================================================

/// Largura unificada de todos os botões da sidebar
const double kSidebarButtonSize = 140.0;

/// Tamanho do ícone de configurações
const double kSidebarSettingsIconSize = 36.0;

/// Raio de borda do botão de configurações
const double kSidebarSettingsButtonBorderRadius = 12.0;

// ============================================================================
// ESPAÇAMENTOS
// ============================================================================

/// Espaço entre o avatar e o menu
const double kSidebarAvatarToMenuSpacing = 20.0;

/// Espaço entre o menu e o botão de configurações
const double kSidebarMenuToSettingsSpacing = 16.0;

// ============================================================================
// WIDGET SIDEBAR
// ============================================================================

class ShadowSyncSidebar extends StatelessWidget {
  const ShadowSyncSidebar({
    super.key,
    this.avatarPath,
    this.userName,
    this.onSettingsPressed,
    this.onVerifyDiskPressed,
    this.onDecryptPressed,
    this.onAboutPressed,
  });

  /// Caminho local da imagem do avatar do usuário (definida nas configurações)
  final String? avatarPath;

  /// Nome do usuário para exibir iniciais no fallback
  final String? userName;

  /// Callback quando o botão de configurações é pressionado
  final VoidCallback? onSettingsPressed;

  /// Callback quando "Verificar Disco" é pressionado
  final VoidCallback? onVerifyDiskPressed;

  /// Callback quando "Descriptografar" é pressionado
  final VoidCallback? onDecryptPressed;

  /// Callback quando "Sobre" é pressionado
  final VoidCallback? onAboutPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: kSidebarWidth,
      margin: kSidebarMargin,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(kSidebarBorderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: kSidebarBlurSigma, sigmaY: kSidebarBlurSigma),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: ShadowSyncColors.secondary.withOpacityFixed(0.75),
              borderRadius: BorderRadius.circular(kSidebarBorderRadius),
              border: Border.all(color: ShadowSyncColors.border),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: kSidebarVerticalPadding),
              child: Column(
                children: [
                  // Avatar do usuário
                  _UserAvatar(
                    avatarPath: avatarPath,
                    userName: userName,
                  ),
                  SizedBox(height: kSidebarAvatarToMenuSpacing),
                  
                  // Menu de ferramentas
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          _SidebarMenuItem(
                            imagePath: 'assets/images/verificaDisco.png',
                            label: AppLocalizations.of(context).verifyDisk,
                            onPressed: onVerifyDiskPressed,
                          ),
                          SizedBox(height: kSidebarMenuItemSpacing),
                          _SidebarMenuItem(
                            imagePath: 'assets/images/criptografia-de-dados.png',
                            label: AppLocalizations.of(context).decrypt,
                            onPressed: onDecryptPressed,
                          ),
                          SizedBox(height: kSidebarMenuItemSpacing),
                          _SidebarMenuItem(
                            icon: Icons.info_outline,
                            label: AppLocalizations.of(context).about,
                            onPressed: onAboutPressed,
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  SizedBox(height: kSidebarMenuToSettingsSpacing),
                  
                  // Botão de configurações
                  _SettingsButton(onPressed: onSettingsPressed),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// WIDGET AVATAR DO USUÁRIO
// ============================================================================

class _UserAvatar extends StatelessWidget {
  const _UserAvatar({
    this.avatarPath,
    this.userName,
  });

  final String? avatarPath;
  final String? userName;

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
    return Container(
      width: kSidebarAvatarSize,
      height: kSidebarAvatarSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: ShadowSyncColors.accent,
          width: kSidebarAvatarBorderWidth,
        ),
        boxShadow: [
          BoxShadow(
            color: ShadowSyncColors.accent.withOpacityFixed(0.3),
            blurRadius: 12,
            spreadRadius: -2,
          ),
        ],
      ),
      child: ClipOval(
        child: avatarPath != null && avatarPath!.isNotEmpty
            ? Image.file(
                File(avatarPath!),
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => _buildFallback(),
              )
            : _buildFallback(),
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
          fontFamily: kSidebarFontFamily,
          color: ShadowSyncColors.accent,
          fontWeight: kSidebarTitleFontWeight,
          fontSize: kSidebarAvatarFallbackFontSize,
        ),
      ),
    );
  }
}

// ============================================================================
// WIDGET ITEM DE MENU DA SIDEBAR
// ============================================================================

class _SidebarMenuItem extends StatefulWidget {
  const _SidebarMenuItem({
    this.imagePath,
    required this.label,
    this.onPressed,
    this.icon,
  }) : assert(imagePath != null || icon != null, 'Either imagePath or icon must be provided');

  final String? imagePath;
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;

  @override
  State<_SidebarMenuItem> createState() => _SidebarMenuItemState();
}

class _SidebarMenuItemState extends State<_SidebarMenuItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.label,
      preferBelow: false,
      verticalOffset: 40,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.onPressed,
            borderRadius: BorderRadius.circular(kSidebarMenuItemBorderRadius),
            child: AnimatedContainer(
              duration: kSidebarHoverAnimationDuration,
              width: kSidebarButtonSize,
              padding: EdgeInsets.all(kSidebarMenuItemPadding),
              decoration: BoxDecoration(
                color: _isHovered 
                    ? ShadowSyncColors.accent.withOpacityFixed(0.15) 
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(kSidebarMenuItemBorderRadius),
              ),
              child: widget.icon != null
                  ? Icon(
                      widget.icon,
                      size: kSidebarMenuIconSize,
                      color: ShadowSyncColors.accent,
                    )
                  : Image.asset(
                      widget.imagePath!,
                      width: kSidebarMenuIconSize,
                      height: kSidebarMenuIconSize,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// WIDGET BOTÃO DE CONFIGURAÇÕES
// ============================================================================

class _SettingsButton extends StatefulWidget {
  const _SettingsButton({this.onPressed});

  final VoidCallback? onPressed;

  @override
  State<_SettingsButton> createState() => _SettingsButtonState();
}

class _SettingsButtonState extends State<_SettingsButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: AppLocalizations.of(context).settings,
      preferBelow: false,
      verticalOffset: 40,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.onPressed,
            borderRadius: BorderRadius.circular(kSidebarSettingsButtonBorderRadius),
            child: AnimatedContainer(
              duration: kSidebarHoverAnimationDuration,
              width: kSidebarButtonSize,
              padding: EdgeInsets.all(kSidebarMenuItemPadding),
              decoration: BoxDecoration(
                color: _isHovered 
                    ? ShadowSyncColors.accent.withOpacityFixed(0.15) 
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(kSidebarSettingsButtonBorderRadius),
              ),
              child: Image.asset(
                'assets/images/configuracoes.png',
                width: kSidebarSettingsIconSize,
                height: kSidebarSettingsIconSize,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
