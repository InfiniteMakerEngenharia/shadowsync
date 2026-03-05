import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:system_tray/system_tray.dart';
import 'package:window_manager/window_manager.dart';

class TrayService with WindowListener {
  final SystemTray _systemTray = SystemTray();
  final Menu _menu = Menu();

  bool _listenerSetup = false;
  bool _trayInitialized = false;
  bool _isExiting = false;

  /// Configura o listener de fechar janela para esconder ao invés de sair.
  /// Deve ser chamado ANTES do runApp para garantir comportamento correto.
  Future<void> setupWindowListener() async {
    if (_listenerSetup || !_isDesktopPlatform) {
      return;
    }

    await windowManager.setPreventClose(true);
    windowManager.addListener(this);
    _listenerSetup = true;
  }

  /// Inicializa o ícone e menu da bandeja do sistema.
  /// Pode ser chamado depois que a janela estiver visível.
  Future<void> initializeTray() async {
    if (_trayInitialized || !_isDesktopPlatform) {
      return;
    }

    try {
      final iconPath = _resolveTrayIconPath();

      await _systemTray.initSystemTray(title: '', iconPath: iconPath);

      await _menu.buildFrom([
        MenuItemLabel(
          label: 'Abrir ShadowSync',
          onClicked: (_) async {
            await _showWindow();
          },
        ),
        MenuSeparator(),
        MenuItemLabel(
          label: 'Sair',
          onClicked: (_) async {
            await _exitApp();
          },
        ),
      ]);

      await _systemTray.setContextMenu(_menu);
      _systemTray.registerSystemTrayEventHandler((eventName) async {
        if (eventName == kSystemTrayEventClick ||
            eventName == kSystemTrayEventRightClick) {
          await _showWindow();
        }
      });

      _trayInitialized = true;
    } catch (_) {
      // Tray falhou, mas o listener de fechar ainda funciona
    }
  }

  Future<void> dispose() async {
    if (!_listenerSetup) {
      return;
    }

    windowManager.removeListener(this);
    _listenerSetup = false;
    _trayInitialized = false;
  }

  @override
  Future<void> onWindowClose() async {
    if (_isExiting) {
      await windowManager.destroy();
      return;
    }

    await windowManager.hide();
  }

  Future<void> _showWindow() async {
    await windowManager.show();
    await windowManager.focus();
  }

  Future<void> _exitApp() async {
    _isExiting = true;
    await windowManager.destroy();
  }

  String _resolveTrayIconPath() {
    if (Platform.isWindows) {
      final exeDir = File(Platform.resolvedExecutable).parent.path;
      return p.join(exeDir, 'data', 'flutter_assets', 'assets', 'images', 'tray_icon.png');
    }

    if (Platform.isMacOS) {
      // No macOS compilado, o executável fica em MyApp.app/Contents/MacOS/MyApp
      // Os assets ficam em MyApp.app/Contents/Frameworks/App.framework/Versions/A/Resources/flutter_assets/
      final exeDir = File(Platform.resolvedExecutable).parent.path;
      final contentsDir = Directory(exeDir).parent.path;
      return p.join(
        contentsDir,
        'Frameworks',
        'App.framework',
        'Versions',
        'A',
        'Resources',
        'flutter_assets',
        'assets',
        'images',
        'tray_icon.png',
      );
    }

    // Linux
    final exeDir = File(Platform.resolvedExecutable).parent.path;
    return p.join(exeDir, 'data', 'flutter_assets', 'assets', 'images', 'tray_icon.png');
  }

  bool get _isDesktopPlatform =>
      Platform.isMacOS || Platform.isWindows || Platform.isLinux;
}
