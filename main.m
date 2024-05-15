// Compile with clang -Wl,-sectcreate,__TEXT,__info_plist,Info.plist -framework Cocoa main.m -o testbin
#import <Cocoa/Cocoa.h>
#import <Security/Security.h>
#import <UserNotifications/UserNotifications.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>
@end


@implementation AppDelegate

- (void)application:(NSApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString *tokenString = [[deviceToken description]
                             stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    tokenString = [tokenString stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"Device Token: %@", tokenString);
    // Register the device token with your server
}

- (void)application:(NSApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"Failed to register for remote notifications: %@", error.localizedDescription);
    // Handle the registration failure
    exit(1);
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    NSLog(@"Finished Launching!");
    [[NSApplication sharedApplication] registerForRemoteNotifications];
    NSLog(@"Registered for push notifications");
    // Print the bundle ID
    NSString *bundleID = [[NSBundle mainBundle] bundleIdentifier];
    NSLog(@"App Bundle ID: %@", bundleID);
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
