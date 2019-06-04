package com.gj.arcoredraw

import org.apache.cordova.*
import org.json.JSONArray
import org.json.JSONException
import android.util.Log

import android.content.Intent
import android.os.Handler
import org.apache.cordova.PluginResult
import org.apache.cordova.CordovaPlugin
import com.google.ar.core.ArCoreApk

class MeasurePluginCallback {
    companion object {
        var setMeasureListenerCallbackContext: CallbackContext? = null
        var setFinishListenerCallbackContext: CallbackContext? = null

        fun onUpdate(value: String) {
            if (setFinishListenerCallbackContext != null) {
                val pluginResult = PluginResult(PluginResult.Status.OK,value)
                pluginResult.keepCallback = true
                setMeasureListenerCallbackContext?.sendPluginResult(pluginResult)
            }
        }

        fun onFinish(data: Array<String>) {
            if (setFinishListenerCallbackContext != null) {
                val pluginResult = PluginResult(PluginResult.Status.OK, JSONArray(data))
                pluginResult.keepCallback = true
                setFinishListenerCallbackContext?.sendPluginResult(pluginResult)
            }
        }
    }
}

class MeasurePlugin : CordovaPlugin() {

    @Throws(JSONException::class)
    override fun execute(action: String, data: JSONArray, callbackContext: CallbackContext): Boolean {
        var result = true
        Log.e(TAG, "STARTING " + action)
        try {
            if (action == "setMeasureListener") {
                MeasurePluginCallback.setMeasureListenerCallbackContext = callbackContext

                val pluginResult = PluginResult(PluginResult.Status.NO_RESULT)
                pluginResult.keepCallback = true
                callbackContext.sendPluginResult(pluginResult)
            } else if (action == "setFinishListener") {
                MeasurePluginCallback.setFinishListenerCallbackContext = callbackContext

                val pluginResult = PluginResult(PluginResult.Status.NO_RESULT)
                pluginResult.keepCallback = true
                callbackContext.sendPluginResult(pluginResult)
            } else if (action == "addARView") {
                var options = data.getJSONObject(0)
                val allowMultiple = options.getBoolean("allowMultiplePoints")

                var intent = Intent().apply {
                    setClass(cordova.getActivity().getApplicationContext(), MeasurePluginActivity::class.java)
                    putExtra("allowMultiple", false)
                }
                cordova.startActivityForResult(this, intent, 0)
            } else {
                handleError("Invalid action", callbackContext)
                result = false
            }

        } catch (e: Exception) {
            handleException(e, callbackContext)
            result = false
        }

        return result
    }

    /**
     * Handles an error while executing a plugin API method.
     * Calls the registered Javascript plugin error handler callback.
     *
     * @param errorMsg Error message to pass to the JS error handler
     */
    private fun handleError(errorMsg: String, callbackContext: CallbackContext) {
        try {
            Log.e(TAG, errorMsg)
            callbackContext.error(errorMsg)
        } catch (e: Exception) {
            Log.e(TAG, e.toString())
        }

    }

    private fun handleException(exception: Exception, callbackContext: CallbackContext) {
        handleError(exception.toString(), callbackContext)
    }

    companion object {

        protected val TAG = "MeasurePlugin"
    }
}