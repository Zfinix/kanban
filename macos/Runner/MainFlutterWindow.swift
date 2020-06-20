import Cocoa
import FlutterMacOS

class MainFlutterWindow: NSWindow {
  override func awakeFromNib() {
    let flutterViewController = FlutterViewController.init()
    var windowFrame = self.frame
    self.titlebarAppearsTransparent = true
    self.minSize = NSSize(width: 1366, height: 768)
    windowFrame.size = NSSize(width: 1366, height: 768)
    self.contentViewController = flutterViewController
    self.setFrame(windowFrame, display: true)
  
    RegisterGeneratedPlugins(registry: flutterViewController)

    super.awakeFromNib()
  }
}
