// Compile with clang -Wl,-sectcreate,__TEXT,__info_plist,Info.plist -framework Cocoa main.m -o testbin
#import <Cocoa/Cocoa.h>
#import <Security/Security.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>
@end


@implementation AppDelegate
- (void)application:(NSApplication *)application 
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
  NSString *tokenStr = [[NSString alloc] initWithData:deviceToken encoding:NSUTF8StringEncoding];

  NSLog(@"Device Token: %@", tokenStr);
}
@end

int main(int argc, const char *argv[]) {
  @autoreleasepool {
    NSApplication *app = [NSApplication sharedApplication];

    // Setup the delegate to receive the device token and the push notification
    AppDelegate *delegate = [[AppDelegate alloc] init];
    app.delegate = delegate;
    NSLog(@"%@", app);


    // Register for push notifications here.
    [app registerForRemoteNotifications];
    // Start the app's run loop
    [NSApp run];
  }

  return 0;
}
