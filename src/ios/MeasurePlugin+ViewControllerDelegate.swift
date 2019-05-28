extension MeasurePlugin: ViewControllerDelegate {

    func allowMultiple() -> Bool {
        return allowMultiplePoints ?? false;
    }

    func closeView() {
        let data = myViewController.getMeasures();
        var result: CDVPluginResult
        if (!allowMultiple() && data.count > 0) {
            result = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: data[0])
        } else {
            result = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: data)
        }
        
        myViewController.view.removeFromSuperview()
        self.myViewController = nil
        
        result.setKeepCallbackAs(true)
        commandDelegate!.send(result, callbackId: finishListenerCallbackId)
    }

    func onUpdateMeasure(nodeName: String) {
        guard let result = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: nodeName) else { return }
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
