//
//  Heap_Public.h
//  Copyright (c) Heap Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class HeapOptions;

// Makes nonnull annotation default everywhere. We can explicitly annotate with
// nullable if necessary. This makes Swift use non-optional types instead of
// implicitly unwrapped optionals.
NS_ASSUME_NONNULL_BEGIN

/// @name Heap library

/// The Heap API.
@interface Heap : NSObject

/// @name Developer methods

/// Return the version number of the Heap library.
+ (NSString * const)libVersion;

/**
 * Initialize the Heap library.
 *
 * @param envId           the Heap environment ID
 */
+ (void)initialize:(NSString *)envId;

/**
 * Initialize the Heap library.
 *
 * @param envId           the Heap environment ID
 * @param options         initialization options
 */
+ (void)initialize:(NSString *)envId
       withOptions:(HeapOptions *)options;

/**
 * Provides a mechanism for early binding of autocapture event listeners.
 *
 * Heap will perform this action automatically within `[Heap initialize:withOptions:]`, swizzling the required methods
 * per the passed options parameter.  On a typical installation, this should be sufficient to capture all event details.
 *
 * If, however, `[Heap initialize:]` is called late or early events are missing expected properties, it may be beneficial
 * to call this in `application:willFinishLaunchingWithOptions:`.
 * 
 * @param options         The same initialization options that will later be passed to `[Heap initialize:withOptions:]`
 */
+ (void)instrumentAutocaptureWithOptions:(nullable HeapOptions *)options;

/**
 * Start the pairing process to connect to the Event Visualizer.
 *
 * This is equivalent to entering the pairing initiation code, and should not be called in a release version of an app.
 *
 * @see [Event visualizer for iOS apps](https://help.heap.io/heap-administration/data-management/event-visualizer/#tab--ios)
 */
+ (void)startEVPairing;

/**
 * Stop the Event Visualizer pairing process.
 *
 * @see [Event visualizer for iOS apps](https://help.heap.io/heap-administration/data-management/event-visualizer/#tab--ios)
 */
+ (void)stopEVPairing;

/**
 * Stop debug logging.
 */
+ (void)stopDebug;

/**
 * Change the frequency at which data is sent to Heap.
 *
 * The default is 15 seconds. A shorter interval may result in increased power
 * consumption.
 *
 * @param interval     number of seconds between pushing events to Heap
 */
+ (void)changeInterval:(double)interval;


/// Enable or disable tracking
///
/// When tracking is disabled, events are not recorded or sent to Heap servers. This value is not persisted across app launches.
/// The default value is YES
///
///
+ (void)setTrackingEnabled:(BOOL)trackingEnabled;

/// Indicates whether or not tracking is enabled
+ (BOOL)isTrackingEnabled;


/// @name User identities and properties

/// Returns the current session ID if Heap has been initialized and a session is in progress; nil otherwise.
+ (nullable NSString *)sessionId;

/// Returns the Heap-generated user ID of the current user.
+ (NSString * const)userId;

/// Returns the current identity set with `identify:`
/// @see identify:
+ (nullable NSString * const)identity;

/**
 * Attach a unique identifier to a user.
 *
 * If you assign the same identity to a user on a separate device, their past
 * sessions and event activity will be merged into the existing Heap user with
 * that identity.
 *
 * The identity must be no longer than 255 characters.
 *
 * @param identity     case-sensitive string that uniquely identifies a user
 *
 * @see addUserProperties:
 * @see [User identities and properties](https://developers.heap.io/docs/using-identify)
 */
+ (void)identify:(NSString *)identity;

/**
 * Attach custom properties to user profiles.
 *
 * User properties are associated with all of the user's past activity, in
 * addition to their future activity. Custom user properties can be queried in the
 * same fashion as any other user property.
 *
 * Examples include account-level info from your database, A/B test data, or
 * demographic info.
 *
 * Keys and values must be a numbers or strings with fewer than 1024 characters.
 * The string user_id cannot be used as a key in the user properties object.
 *
 * @param properties    key-value pairs to be associated with a user
 *
 * @see identify:
 * @see [User identities and properties](https://developers.heap.io/docs/using-identify)
 */
+ (void)addUserProperties:(NSDictionary<NSString *, id> *)properties;

/// @name Custom events

/**
 * Track a custom event.
 *
 * The event name is limited to 1024 characters.
 *
 * @param event        the event name
 *
 * @see track:withProperties:
 * @see [track in Heap documentation](https://developers.heap.io/reference#track)
 */
+ (void)track:(NSString *)event;

/**
 * Track a custom event with properties.
 *
 * The event name is limited to 1024 characters. Keys and values must be a
 * numbers or strings with fewer than 1024 characters.
 *
 * @param event        the event name
 * @param properties   key-value pairs to associate with the event
 *
 * @see track:
 * @see [track in Heap documentation](https://developers.heap.io/reference#track)
 */
+ (void)track:(NSString *)event withProperties:(nullable NSDictionary *)properties;

/**
 * Track an autocaptured framework event.
 *
 * Only supported source types will be processed correctly. Unsupported source
 * types will not be processed as framework events.
 *
 * @param event              the event name
 * @param source             the source name
 * @param sourceProperties   key-value pairs to associate with the framework event
 *
 * @see frameworkTrack:withProperties:withSource:withSourceProperties:
 */
+ (void)frameworkAutocaptureEvent:(NSString *)event
                       withSource:(NSString *)source
             withSourceProperties:(nullable NSDictionary *)sourceProperties;

/**
 * Track a custom event from a framework with properties and framework context.
 *
 * Only supported source types will be processed correctly. Unsupported source
 * types will not be processed as framework events.
 *
 * @param event              the event name
 * @param properties         key-value pairs to associate with the event
 * @param source             the source name
 * @param sourceProperties   key-value pairs to associate with the framework context of the event
 *
 * @see @frameworkAutocaptureEvent:withSource:withSourceProperties:
 */
+ (void)frameworkTrack:(NSString *)event
        withProperties:(nullable NSDictionary *)properties
            withSource:(NSString *)source
  withSourceProperties:(nullable NSDictionary *)sourceProperties;

/// @name Global event properties

/**
 * Specify global key-value pairs to attach to all of a user's subsequent events.
 *
 * These event properties will persist across multiple sessions on the same
 * device and get applied to both auto-captured and custom events. This is
 * useful if you have some persistent state, but you don't want to apply it
 * across all of a user's events with identify.
 *
 * A good example is "Logged In", which changes over the user's lifecycle. You
 * can use addEventProperties to measure how a user's behavior changes when
 * they're logged in vs. when they're logged out.
 *
 * @param properties   key-value pairs to associate with future events
 *
 * @see removeEventProperty:
 * @see clearEventProperties
 */
+ (void)addEventProperties:(NSDictionary<NSString *, id> *)properties;
/**
 * Stops a single event property from getting attached to all subsequent events.
 *
 * @param property     the name of the property remove
 *
 * @see addEventProperties:
 * @see clearEventProperties
 */
+ (void)removeEventProperty:(NSString *)property;

/**
 * Remove all properties added with addEventProperties:.
 *
 * @see addEventProperties:
 * @see removeEventProperty:
 */
+ (void)clearEventProperties;

/// Resets a user's identity to a random anonymous user ID. A new session for an
/// anonymous user will begin when called if the user was previously identified.
/// The method has no effect if the user was previously anonymous when called.
+ (void)resetIdentity;

/// Call this method in UIApplicationDelegate.application(_:open:options:) to launch
/// Event Visualizer with the QR code provided by Heap.
+ (void)handleOpenURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options;

/// Call this method in UISceneDelegate.scene(_,willConnectTo:options:)
/// and `UISceneDelegate.scene(_,openURLContexts:)` in scene-based applications to launch
/// Event Visualizer with the QR code provided by Heap.
+ (void)handleOpenURLContexts:(NSSet<UIOpenURLContext *> *)openURLContexts API_AVAILABLE(ios(13.0));

@end

NS_ASSUME_NONNULL_END
