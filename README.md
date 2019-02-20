
# react-native-screenshot-detector

Note: this project is designed to work with the newer version of React Native library imports, i.e. React Native >= 0.40.0

## Getting started

`$ npm install react-native-screenshot-detector --save`

`$ react-native link react-native-screenshot-detector`


## Usage

# In JS
```javascript
import * as ScreenshotDetector from 'react-native-screenshot-detector';

// Subscribe callback to screenshots:
this.eventEmitter = ScreenshotDetector.subscribe(function() { ... });

// Unsubscribe later (a good place would be componentWillUnmount)
ScreenshotDetector.unsubscribe(this.eventEmitter);
```
