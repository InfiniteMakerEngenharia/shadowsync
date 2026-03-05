# Animações RIVE

Este diretório contém animações RIVE (.riv) usadas no aplicativo ShadowSync.

## Splash Screen

Para adicionar a animação da splash screen:

1. Crie sua animação no [Rive Editor](https://rive.app/)
2. Exporte o arquivo como `.riv`
3. Salve o arquivo neste diretório com o nome `splash.riv`

### Configuração recomendada

- **Tamanho do Artboard**: 200x200 pixels
- **State Machine**: Use uma state machine chamada `State Machine 1` (padrão)
- **Duração**: A animação deve completar em 2-3 segundos

### Personalização

Você pode alterar as configurações da splash screen em `lib/src/app.dart`:

```dart
SplashScreenPage(
  config: const SplashScreenConfig(
    riveAssetPath: 'assets/animations/splash.riv',
    stateMachineName: 'State Machine 1', // Nome da sua state machine
    minDisplayDuration: Duration(seconds: 2),
    maxDisplayDuration: Duration(seconds: 5),
  ),
  onComplete: _onSplashComplete,
)
```

### Fallback

Se o arquivo `splash.riv` não existir, uma animação de fallback será exibida automaticamente (pulso com ícone de sincronização).
