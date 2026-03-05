import Cocoa
import FlutterMacOS

class MainFlutterWindow: NSWindow {
  override func awakeFromNib() {
    let flutterViewController = FlutterViewController()
    let windowFrame = self.frame
    self.contentViewController = flutterViewController
    self.setFrame(windowFrame, display: true)

    RegisterGeneratedPlugins(registry: flutterViewController)

    // Desabilita o botão de maximizar (zoom)
    self.standardWindowButton(.zoomButton)?.isEnabled = false

    super.awakeFromNib()
  }
}
