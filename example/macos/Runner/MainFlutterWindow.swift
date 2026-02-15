import Cocoa
import FlutterMacOS

class MainFlutterWindow: NSWindow {
  override func awakeFromNib() {
    let flutterViewController = FlutterViewController()
    let windowFrame = self.frame
    self.contentViewController = flutterViewController
    self.setFrame(windowFrame, display: true)

    // // 1. Hacemos que la barra de título sea transparente y el contenido ocupe todo
    // self.titleVisibility = .hidden
    // self.titlebarAppearsTransparent = true
    // self.styleMask.insert(.fullSizeContentView)

    // // 2. Ocultamos los botones físicos
    // self.standardWindowButton(.closeButton)?.isHidden = true
    // self.standardWindowButton(.miniaturizeButton)?.isHidden = true
    // self.standardWindowButton(.zoomButton)?.isHidden = true

    RegisterGeneratedPlugins(registry: flutterViewController)


    super.awakeFromNib()
  }
}
