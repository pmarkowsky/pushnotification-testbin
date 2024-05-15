// Compile with clang -Wl,-sectcreate,__TEXT,__info_plist,Info.plist -framework Cocoa main.m -o testbin
#import <Cocoa/Cocoa.h>
#import <Security/Security.h>
#import <UserNotifications/UserNotifications.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>
@end

@implementation AppDelegate

- (NSString *)hexStringFromData:(NSData *)data {
    if (!data || [data length] == 0) {
        return @"";
    }
    
    NSMutableString *hexString = [NSMutableString stringWithCapacity:[data length] * 2];
    const unsigned char *bytes = [data bytes];
    
    for (NSUInteger i = 0; i < [data length]; i++) {
        [hexString appendFormat:@"%02x", bytes[i]];
    }
    
    return hexString;
}

- (void)application:(NSApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString *tokenString = [self hexStringFromData:deviceToken];
    NSLog(@"Device Token: %@", tokenString);
}

- (void)application:(NSApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"Failed to register for remote notifications: %@", error.localizedDescription);
    // Handle the registration failure
    exit(1);
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    NSApplication *app = [NSApplication sharedApplication];
    NSLog(@"Finished Launching!");
    NSLog(@"Notification: %@", aNotification);
    [app registerForRemoteNotifications];
    NSLog(@"Registered for push notifications");
    // Print the bundle ID
    NSString *bundleID = [[NSBundle mainBundle] bundleIdentifier];
    NSLog(@"App Bundle ID: %@", bundleID);
    if (app.registeredForRemoteNotifications) {
        NSLog(@"we think we're registered");
    } else {
        NSLog(@"Not registered");
    }
    /*
    NSLog(@"Remote notifications: %lu", [[NSApplication sharedApplication] enabledRemoteNotificationTypes]);
     */
}

- (void)application:(NSApplication *)application didReceiveRemoteNotification:(NSDictionary<NSString *, id> *)userInfo  {
    NSLog(@"Received Push Notification: %@", userInfo);
    // Handle the push notification
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center
didReceiveNotificationResponse:(UNNotificationResponse *)response
         withCompletionHandler:(void (^)(void))completionHandler {
    // Handle the notification here
    UNNotificationContent *content = response.notification.request.content;
    NSString *body = content.body;
    NSLog(@"Received Push Notification: %@", body);

    completionHandler();
}
@end

int main(int argc, const char *argv[]) {
  @autoreleasepool {
    NSApplication *app = [NSApplication sharedApplication];

    // Setup the delegate to receive the device token and the push notification
    AppDelegate *delegate = [[AppDelegate alloc] init];
    app.delegate = delegate;
    NSLog(@"Starting App");
    [NSApp run];
  }

  return 0;
}