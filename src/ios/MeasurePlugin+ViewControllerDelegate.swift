extension MeasurePlugin: ViewControllerDelegate {

    func allowMultiple() -> Bool {
        return allowMultiplePoints ?? false;
    }

    func closeView() {
        let data = myViewController.getMeasures();

        myViewController.view.removeFromSuperview()
        self.myViewController = nil

        guard let result = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: data) else { return }
        result.setKeepCallbackAs(true)
        commandDelegate!.send(result, callbackId: finishListenerCallbackId)
    }

    func onUpdateMeasure(nodeName: String) {
        let data = ["data": nodeName];
        guard let result = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: data) else { return }
        result.setKeepCallbackAs(true)
        commandDelegate!.send(result, callbackId: measureListenerCallbackId)
    }
    
    @objc func setMeasureListener(_ command: CDVInvokedUrlCommand) {
        measureListenerCallbackId = command.callbackId
    }
    
    @objc func setFinishListener(_ command: CDVInvokedUrlCommand) {
        finishListenerCallbackId = command.callbackId
    }

}