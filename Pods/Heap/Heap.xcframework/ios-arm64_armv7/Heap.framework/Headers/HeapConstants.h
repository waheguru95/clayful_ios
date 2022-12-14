//
//  HeapConstants.h
//  LibHeap
//
//  Created by Brian Nickel on 10/15/21.
//  Copyright © 2021 Heap Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NSString *HeapAncestryNodeProperty NS_TYPED_EXTENSIBLE_ENUM;

FOUNDATION_EXPORT HeapAncestryNodeProperty const HeapAncestryNodePropertyAccessibilityIdentifier;
FOUNDATION_EXPORT HeapAncestryNodeProperty const HeapAncestryNodePropertyAccessibilityLabel;
FOUNDATION_EXPORT HeapAncestryNodeProperty const HeapAncestryNodePropertyClass;

typedef NSString *HeapPageviewProperty NS_TYPED_EXTENSIBLE_ENUM;

FOUNDATION_EXPORT HeapPageviewProperty const HeapPageviewPropertyId;
FOUNDATION_EXPORT HeapPageviewProperty const HeapPageviewPropertyAccessibilityIdentifier;
FOUNDATION_EXPORT HeapPageviewProperty const HeapPageviewPropertyAccessibilityLabel;
FOUNDATION_EXPORT HeapPageviewProperty const HeapPageviewPropertyViewController;
FOUNDATION_EXPORT HeapPageviewProperty const HeapPageviewPropertyTitle;
FOUNDATION_EXPORT HeapPageviewProperty const HeapPageviewPropertyTimestamp;

typedef NSString *HeapTouchEventProperty NS_TYPED_EXTENSIBLE_ENUM;

FOUNDATION_EXPORT HeapTouchEventProperty const HeapTouchEventPropertyViewAncestry;
FOUNDATION_EXPORT HeapTouchEventProperty const HeapTouchEventPropertyEventType;
FOUNDATION_EXPORT HeapTouchEventProperty const HeapTouchEventPropertyTargetClass;
FOUNDATION_EXPORT HeapTouchEventProperty const HeapTouchEventPropertyTargetText;
FOUNDATION_EXPORT HeapTouchEventProperty const HeapTouchEventPropertyTargetAccessibilityIdentifier;
FOUNDATION_EXPORT HeapTouchEventProperty const HeapTouchEventPropertyTargetAccessibilityLabel;
FOUNDATION_EXPORT HeapTouchEventProperty const HeapTouchEventPropertyTargetVariable;
FOUNDATION_EXPORT HeapTouchEventProperty const HeapTouchEventPropertyTargetSelector;

typedef NSString *HeapTouchEventType NS_TYPED_EXTENSIBLE_ENUM;

FOUNDATION_EXPORT HeapTouchEventType const HeapTouchEventTypeTouch;
FOUNDATION_EXPORT HeapTouchEventType const HeapTouchEventTypeFieldEdit;
