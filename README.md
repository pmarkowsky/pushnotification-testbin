# What is this?

This is a binary for testing if you can send Apple Push Notifications to a daemon in the background.

# Building

1. Define CODESIGN_ID for code signing
1. Run `make`


# Setting up Push Notifications.
  1. Sign in to the Apple Developer Portal.
  1. In the left nav, click Certificates, IDs & Profiles.
  1.  On the Certificates, IDs & Profiles page, in the left nav, click Identifiers.
  1. View your app's details by clicking its App ID.
  1. On the Capabilities tab, scroll down and check the Push Notifications capability.
  1.  Save your changes.
  1. Create an auth token

# Actually Sending a Push Notification

 1. Use a tool like [https://github.com/sideshow/apns2](https://github.com/sideshow/apns2)
 1. Use Apple's [push notification console](https://developer.apple.com/notifications/push-notifications-console/)

# Resources

* https://support.iterable.com/hc/en-us/articles/115000315806-Setting-up-iOS-Push-Notifications#step-1-enable-push-notifications-in-xcode
