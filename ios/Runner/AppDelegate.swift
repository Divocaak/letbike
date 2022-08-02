import UIKit
import Flutter

import google_mobile_ads

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    
    let listTileFactory = ListTileNativeAdFactory()
    FLTGoogleMobileAdsPlugin.registerNativeAdFactory(
        self, factoryId: "listTile", nativeAdFactory: listTileFactory)

    GADMobileAds.sharedInstance().requestConfiguration.testDeviceIdentifiers = [ "0faf99b3cf596954617f26a2639b9681" ]
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
