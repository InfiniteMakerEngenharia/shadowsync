// ============================================================================
// APLICATIVO: ShadowSync - Gerenciador de Backups
// AUTOR: Eng. Hewerton Bianchi
// DATA: 2024-06-15
// DESCRIÇÃO: Tela de splash screen com suporte a animação RIVE.
// ============================================================================

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

import '../../generated/l10n/app_localizations.dart';
import '../theme/shadowsync_theme.dart';

// ============================================================================
// CONFIGURAÇÕES DA SPLASH SCREEN
// ============================================================================

/// Configurações da splash screen.
class SplashScreenConfig {
  const SplashScreenConfig({
    this.riveAssetPath = 'assets/animations/splash.riv',
    this.animationName,
    this.stateMachineName,
    this.minDisplayDuration = const Duration(seconds: 2),
    this.maxDisplayDuration = const Duration(seconds: 5),
    this.fadeOutDuration = const Duration(milliseconds: 500),
  });

  /// Caminho do arquivo .riv na pasta assets.
  final String riveAssetPath;

  /// Nome da animação a ser reproduzida (null = primeira animação).
  final String? animationName;

  /// Nome da state machine (se usar state machine ao invés de animação simples).
  final String? stateMachineName;

  /// Duração mínima de exibição da splash screen.
  final Duration minDisplayDuration;

  /// Duração máxima de exibição (fallback se animação não terminar).
  final Duration maxDisplayDuration;

  /// Duração do fade out ao sair da splash.
  final Duration fadeOutDuration;
}

// ============================================================================
// SPLASH SCREEN PAGE
// ============================================================================

/// Tela de splash screen com suporte a animação RIVE.
/// 
/// Exemplo de uso:
/// ```dart
/// SplashScreenPage(
///   config: const SplashScreenConfig(
///     riveAssetPath: 'assets/animations/splash.riv',
///     stateMachineName: 'State Machine 1',
///   ),
///   onComplete: () => Navigator.pushReplacement(
///     context,
///     MaterialPageRoute(builder: (_) => DashboardPage()),
///   ),
/// )
/// ```
class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({
    super.key,
    this.config = const SplashScreenConfig(),
    required this.onComplete,
    this.onInitialize,
  });

  /// Configurações da splash screen.
  final SplashScreenConfig config;

  /// Callback executado quando a splash screen termina.
  final VoidCallback onComplete;

  /// Callback para executar inicializações enquanto a splash é exibida.
  /// Retorna um Future que deve completar antes da transição.
  final Future<void> Function()? onInitialize;

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage>
    with SingleTickerProviderStateMixin {
  // Estado de carregamento do RIVE
  bool _riveAssetExists = false;
  bool _riveChecked = false;

  // Animação de fallback
  late AnimationController _fallbackAnimationController;

  // Controle de tempo
  bool _minDurationCompleted = false;
  bool _initializationCompleted = false;
  bool _isExiting = false;

  // Animação de fade out
  double _opacity = 1.0;

  @override
  void initState() {
    super.initState();

    // Inicializa animação de fallback
    _fallbackAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    // Verifica se o arquivo RIVE existe
    _checkRiveAsset();

    // Inicia timers e inicialização
    _startTimers();
    _runInitialization();
  }

  @override
  void dispose() {
    _fallbackAnimationController.dispose();
    super.dispose();
  }

  // ==========================================================================
  // VERIFICAÇÃO DO ASSET RIVE
  // ==========================================================================

  Future<void> _checkRiveAsset() async {
    try {
      // Tenta carregar o arquivo .riv para verificar se existe
      await rootBundle.load(widget.config.riveAssetPath);
      if (mounted) {
        setState(() {
          _riveAssetExists = true;
          _riveChecked = true;
        });
      }
    } catch (e) {
      // Se falhar ao carregar, usa animação de fallback
      debugPrint('[SplashScreen] Arquivo RIVE não encontrado: ${widget.config.riveAssetPath}');
      debugPrint('[SplashScreen] Usando animação de fallback');
      if (mounted) {
        setState(() {
          _riveAssetExists = false;
          _riveChecked = true;
        });
      }
    }
  }

  // ==========================================================================
  // CONTROLE DE TEMPO
  // ==========================================================================

  void _startTimers() {
    // Timer para duração mínima
    Timer(widget.config.minDisplayDuration, () {
      _minDurationCompleted = true;
      _checkCompletion();
    });

    // Timer para duração máxima (fallback)
    Timer(widget.config.maxDisplayDuration, () {
      if (!_isExiting) {
        _exitSplash();
      }
    });
  }

  Future<void> _runInitialization() async {
    if (widget.onInitialize != null) {
      await widget.onInitialize!();
    }
    _initializationCompleted = true;
    _checkCompletion();
  }

  void _checkCompletion() {
    if (_minDurationCompleted && _initializationCompleted && !_isExiting) {
      _exitSplash();
    }
  }

  void _exitSplash() {
    if (_isExiting) return;
    _isExiting = true;

    // Fade out animation
    setState(() {
      _opacity = 0.0;
    });

    // Aguarda o fade out completar e chama o callback
    Future.delayed(widget.config.fadeOutDuration, () {
      if (mounted) {
        widget.onComplete();
      }
    });
  }

  // ==========================================================================
  // BUILD
  // ==========================================================================

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _opacity,
      duration: widget.config.fadeOutDuration,
      child: Scaffold(
        backgroundColor: ShadowSyncColors.primaryBackground,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Animação RIVE ou fallback
              SizedBox(
                width: 200,
                height: 200,
                child: _buildAnimation(),
              ),

              const SizedBox(height: 32),

              // Nome do app
              Text(
                AppLocalizations.of(context).appTitle,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: ShadowSyncColors.text,
                  letterSpacing: 2,
                ),
              ),

              const SizedBox(height: 8),

              // Subtítulo
              Text(
                AppLocalizations.of(context).appSubtitle,
                style: TextStyle(
                  fontSize: 14,
                  color: ShadowSyncColors.text.withValues(alpha: 0.7),
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimation() {
    // Se RIVE está disponível e o asset existe, usa a animação RIVE
    if (_riveChecked && _riveAssetExists) {
      return RiveWidgetBuilder(
        fileLoader: FileLoader.fromAsset(
          widget.config.riveAssetPath,
          riveFactory: Factory.rive,
        ),
        stateMachineSelector: widget.config.stateMachineName != null
            ? StateMachineNamed(widget.config.stateMachineName!)
            : const StateMachineDefault(),
        artboardSelector: const ArtboardDefault(),
        builder: (context, state) {
          return switch (state) {
            RiveLoading() => _buildFallbackAnimation(),
            RiveFailed() => _buildFallbackAnimation(),
            RiveLoaded(:final controller) => RiveWidget(
                controller: controller,
                fit: Fit.contain,
              ),
          };
        },
      );
    }

    // Animação de fallback (pulso com ícone)
    return _buildFallbackAnimation();
  }

  Widget _buildFallbackAnimation() {
    return AnimatedBuilder(
      listenable: _fallbackAnimationController,
      builder: (context, child) {
        final scale = 1.0 + 0.1 * _fallbackAnimationController.value;
        final opacity = 0.5 + 0.5 * (1 - _fallbackAnimationController.value);

        return Transform.scale(
          scale: scale,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  ShadowSyncColors.accent.withValues(alpha: opacity),
                  ShadowSyncColors.accent.withValues(alpha: 0.0),
                ],
              ),
            ),
            child: Center(
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ShadowSyncColors.secondary,
                  border: Border.all(
                    color: ShadowSyncColors.accent,
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: ShadowSyncColors.accent.withValues(alpha: 0.4),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Image.asset(
                  'assets/images/small_icon.png',
                  width: 48,
                  height: 48,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// ============================================================================
// ANIMATED BUILDER (Helper para animação de fallback)
// ============================================================================

class AnimatedBuilder extends StatelessWidget {
  const AnimatedBuilder({
    super.key,
    required this.listenable,
    required this.builder,
  });

  final Listenable listenable;
  final Widget Function(BuildContext context, Widget? child) builder;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: listenable,
      builder: builder,
    );
  }
}
