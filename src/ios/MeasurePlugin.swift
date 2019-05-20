import SceneKit

@objc(HWPMeasurePlugin) class MeasurePlugin : CDVPlugin {
    var allowMultiplePoints: Bool!;

    var measureListenerCallbackId: String!
    var finishListenerCallbackId: String!
    
    var myViewController: ViewController!
    
    @objc func addARView(_ command: CDVInvokedUrlCommand) {
        DispatchQueue.global(qos: .utility).async {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let myViewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController else {
                fatalError("ViewController is not set in storyboard")
            }
            self.myViewController = myViewController
            self.myViewController.delegate = self

            DispatchQueue.main.async {
                let options = command.arguments[0] as! NSMutableDictionary
                let multiplePointsEnabled = options.object(forKey: "allowMultiplePoints") as! Bool;

                self.allowMultiplePoints = multiplePointsEnabled

                guard let superview = self.webView.superview else { return }
                superview.insertSubview(self.myViewController.view, aboveSubview: self.webView)
            }
        }
    }
}
