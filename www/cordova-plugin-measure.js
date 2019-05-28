var exec = require('cordova/exec');
var pluginName = 'MeasurePlugin';

/**
 * Callback listener for Measure changes
 */
exports.onMeasureUpdate = function (success = function(){}, error = function(){}) {
    exec(success, error, pluginName, 'setMeasureListener');
};

/**
 * Callback when the view is dismissed
 */
exports.onFinish = function (success = function(){}, error = function(){}) {
    exec(success, error, pluginName, 'setFinishListener');
};

exports.start = function (options = {allowMultiplePoints: false}) {
    exec(undefined, undefined, pluginName, 'addARView', [options]);
};
