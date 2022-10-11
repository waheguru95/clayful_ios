//
//  HeapOptions.h
//  Copyright (c) Heap Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol HeapAutocaptureEnrichmentDelegate;

NS_ASSUME_NONNULL_BEGIN

/// @name Heap options library

/// The Heap initialization options API.
@interface HeapOptions : NSObject

/// Start debug logging of Heap activity via NSLog. This should not be called in the release version of an app.
@property (assign) BOOL debug;

/// Disable target text capture.
@property (assign) BOOL disableTextCapture;

/// Disable accessibility label capture.
@property (assign) BOOL disableAccessibilityLabelCapture;

/// Disable view controller title capture.
@property (assign) BOOL disableTitleCapture;

/// Disable ivar capture.
@property (assign) BOOL disableIvarCapture;

/// Don't capture the iOS vendor ID (IDFV).
@property (assign) BOOL disableVendorIdCapture;

/// Don't capture the iOS advertiser ID (IDFA).
@property (assign) BOOL disableAdvertiserIdCapture;

/// Opt-out of telemetry capture.
@property (assign) BOOL disableTelemetryCapture;

/// Disable Heap autocapture when the app has been backgrounded.
@property (assign) BOOL disableAutocaptureWhenBackgrounded;

/// Disable Heap event capture
@property (assign) BOOL disableTracking;

/// Disable Heap autocapture for touches, fieldedits, swipes, gesture recognizers, etc.
@property (assign) BOOL disableTouchAutocapture;

/// Disable Heap event tracking for gesture recognizers.
@property (assign) BOOL enableGestureAutocapture;

/// Disable Heap event tracking of view controllers as pageviews.
@property (assign) BOOL disableViewControllerAutocapture;

/// When set to true, Event Visualizer will capture faster but less accurate screenshots.
/// This should be used if you notice consistent performance issues when connected to Event Visualizer.
/// The default behavior is to capture higher quality screenshots but switch to fast capture if it takes more than
/// 500ms to capture a screenshot.
@property (assign) BOOL useFastEVScreenshotCapture;

/// Limit the size of the hierarchy (of parent view elements) captured for every autocaptured interaction. (Default: 30)
@property (assign) NSInteger hierarchyCaptureLimit;

/// Proxy tracking requests through an alternative base URL.
@property (nonatomic, copy, nullable) NSURL *captureBaseUrl;

/// Proxy Event Visualizer requests through an alternative base URL. Path components are currently ignored and should be omitted.
@property (nonatomic, copy, nullable) NSURL *eventVisualizerWebSocketBaseUrl;

/// Disables the pairing gesture (i.e. pressing the screen with four fingers for five seconds) used to pair a device with the Event Visualizer.
/// @see [Event visualizer for iOS apps](https://help.heap.io/heap-administration/data-management/event-visualizer/#tab--ios)
@property (nonatomic, assign) BOOL disableVisualizerPairingGesture;

@property (nonatomic, weak) id<HeapAutocaptureEnrichmentDelegate> autocaptureEnrichmentDelegate;

@property (nonatomic, assign) BOOL enableAccessibilityPrefetching;

@end

NS_ASSUME_NONNULL_END
