import UIKit
import Flutter
import Firebase
import FirebaseMessaging


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate, MessagingDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

      FirebaseApp.configure()
      //Messaging.messaging().delegate = self
      GeneratedPluginRegistrant.register(with: self)
      TokenPlugin.register(with: registrar(forPlugin: "TokenPlugin")!)
      if #available(iOS 10.0, *) {
          // For iOS 10 display notification (sent via APNS)
          UNUserNotificationCenter.current().delegate = self
          let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
          UNUserNotificationCenter.current().requestAuthorization(
                  options: authOptions,
                  completionHandler: {_, _ in })
      } else {
          let settings: UIUserNotificationSettings =
          UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
          application.registerUserNotificationSettings(settings)
      }
      application.registerForRemoteNotifications()
      return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    override func application(_ application: UIApplication,
      didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {

       Messaging.messaging().apnsToken = deviceToken
       print("Token: \(deviceToken)")
       super.application(application,
       didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
     }
  }
