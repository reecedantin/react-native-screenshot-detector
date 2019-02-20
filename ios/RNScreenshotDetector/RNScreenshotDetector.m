//
//  RNScreenshotDetector.m
//
//  Created by Graham Carling on 1/11/17.
//

#import "RNScreenshotDetector.h"

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

    callback(@[[NSNull null]]);
}

- (void)screenshotDetected:(NSNotification *)notification {
    [self sendEventWithName:@"ScreenshotTaken" body:nil];
}

@end
