//
//  HeapDelegates.h
//  LibHeap
//
//  Created by Brian Nickel on 10/15/21.
//  Copyright © 2021 Heap Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Heap/HeapConstants.h>

NS_ASSUME_NONNULL_BEGIN

@protocol HeapAutocaptureEnrichmentDelegate <NSObject>

@optional
- (NSDictionary<HeapAncestryNodeProperty, NSString *> *)autocaptureAncestryNodePropertiesForResponder:(UIResponder *)responder;
- (NSDictionary<HeapPageviewProperty, NSString *> *)autocapturePageviewPropertiesForViewController:(UIViewController *)viewController;
- (NSDictionary<HeapTouchEventProperty, NSString *> *)autocaptureTouchEventPropertiesForEventType:(HeapTouchEventType)eventType view:(UIView *)view touch:(nullable UITouch *)touch inControl:(nullable UIControl *)control;

@end

NS_ASSUME_NONNULL_END
