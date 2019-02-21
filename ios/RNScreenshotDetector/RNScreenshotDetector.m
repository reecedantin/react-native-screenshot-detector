//
//  RNScreenshotDetector.m
//
//  Created by Graham Carling on 1/11/17.
//

#import "RNScreenshotDetector.h"
#import <React/RCTRootView.h>

@implementation RNScreenshotDetector

RCT_EXPORT_MODULE();

- (NSArray<NSString *> *)supportedEvents {
    return @[@"ScreenshotTaken"];
}

RCT_EXPORT_METHOD(startlistening:(RCTResponseSenderBlock)callback)
{
    NSOperationQueue *mainQueue = [NSOperationQueue mainQueue];
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationUserDidTakeScreenshotNotification
                                                      object:nil
                                                       queue:mainQueue
                                                  usingBlock:^(NSNotification *notification) {
                                                      [self screenshotDetected:notification];
                                                  }];

    if (@available(iOS 11.0, *)) {
        [[NSNotificationCenter defaultCenter] addObserverForName:UIScreenCapturedDidChangeNotification
                                                          object:nil
                                                           queue:mainQueue
                                                      usingBlock:^(NSNotification *notification) {
                                                          [self screenshotDetected:notification];
                                                      }];
    } else {
        // Fallback on earlier versions
    }

    if (@available(iOS 11.0, *)) {
        if([UIScreen mainScreen].isCaptured) {
            callback(@[@true]);
        } else {
            callback(@[@false]);
        }
    } else {
        callback(@[[NSNull null]]);
    }
}

- (void)screenshotDetected:(NSNotification *)notification {
    NSString * type;
    if (@available(iOS 11.0, *)) {
        if(notification.name == UIScreenCapturedDidChangeNotification) {
            type = ((UIScreen *)notification.object).isCaptured ? @"start_record" : @"stop_record";
        } else {
            type = @"screenshot";
        }
    } else {
        type = @"screenshot";
    }


    [self sendEventWithName:@"ScreenshotTaken" body:@{@"type": type}];
}

@end
