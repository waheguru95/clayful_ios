//
//  UIView+HeapIgnore.h
//  Copyright (c) Heap Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (HeapIgnore)

/// When set, Heap will ignore touch events on this view and its descendents in the view hierarchy..
///
/// @remarks Default value is false. This property is not thread-safe and should only be accessed from the main thread.
@property (nonatomic, assign) IBInspectable BOOL heapIgnore;

/// When set, Heap will redact text in touch events on this element and its descendents in the
/// view hierarchy.
///
/// @remarks Default value is false. This property is not thread-safe and should only be accessed from the main thread.
@property (nonatomic, assign) IBInspectable BOOL heapRedactText;

/// When set, Heap will redact accessibility label in touch events on this element and its descendents in the
/// view hierarchy.
///
/// @remarks Default value is false. This property is not thread-safe and should only be accessed from the main thread.
@property (nonatomic, assign) IBInspectable BOOL heapRedactAccessibilityLabel;

/// When set, Heap will treat all touches inside this view as a touch on the view itself. This can be used to keep inner
/// implementation details and properties out of logged events.
///
/// @remarks Default value is derived from the class's @c heapIgnoreInnerHierarchyDefault property, which iself defaults to
/// false.  This property is not thread-safe and should only be accessed from the main thread.
@property (nonatomic, assign) IBInspectable BOOL heapIgnoreInnerHierarchy;

/// Sets a view class's default value for @c heapIgnoreInnerHierarchy.
///
/// @remarks Default value is false.  When overriding this property, it should return a fixed value.
@property (nonatomic, assign, readonly, class) BOOL heapIgnoreInnerHierarchyDefault;

@end
