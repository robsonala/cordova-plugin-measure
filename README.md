# cordova-plugin-measure

Cordova plugin using ARKit(iOS) to calculate distance of real world objects

Swift original measure project: https://github.com/levantAJ/Measure

## Supported Platforms

- iOS (Requires ARKit support iOS 11.3+)

## Installation
    cordova plugin add https://github.com/robsonala/cordova-plugin-measure

## Methods
- cordova.plugins.measure.start
- cordova.plugins.measure.onMeasureUpdate
- cordova.plugins.measure.onFinish

----

### start
Insert the camera view under the WebView

##### Parameters

| Parameter        | Type       | Description                                |
| ---------------- | ---------- | ------------------------------------------ |
| `allowMultiplePoints`      | `Boolean` | If true allow the user to draw multiple measures |

```js
cordova.plugins.measure.start();

cordova.plugins.measure.start({allowMultiplePoints: true});
```

----

### onMeasureUpdate

Set listener for event from measures

```js
cordova.plugins.measure.onMeasureUpdate((data) => {});

// Example: data = {"10.00cm"}
```

----

### onFinish

Set listener when the view is dismissed

```js
cordova.plugins.measure.onFinish((data) => {});

/*
Examples:

IF allowMultiplePoints == FALSE:
data = "10.00cm"

IF allowMultiplePoints == TRUE:
data = ["10.00cm", "20.14cm", ...]
*/
```

## TODO
Android support