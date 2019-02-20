
import { NativeEventEmitter, NativeModules } from 'react-native';
const { RNScreenshotDetector } = NativeModules;

export const SCREENSHOT_EVENT = 'ScreenshotTaken';

export function subscribe(cb) {
    RNScreenshotDetector.startlistening(() => {});
    const eventEmitter = new NativeEventEmitter(RNScreenshotDetector);
    const subscription = eventEmitter.addListener(SCREENSHOT_EVENT, cb);
    return subscription
}

export function unsubscribe(subscription) {
    subscription.remove();
}
