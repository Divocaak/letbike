// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB7dlGzCnoALib8Hp0OKnatFq0s7Fwg37U',
    appId: '1:922511656456:android:45e2508c7dd1ad6fa573bd',
    messagingSenderId: '922511656456',
    projectId: 'letbike-a7457',
    storageBucket: 'letbike-a7457.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDY7LysokXSJhZU45sDkEHS5gJhw-IaDQY',
    appId: '1:922511656456:ios:8a5f7e56741663d0a573bd',
    messagingSenderId: '922511656456',
    projectId: 'letbike-a7457',
    storageBucket: 'letbike-a7457.appspot.com',
    androidClientId: '922511656456-e4i4svr51osmu1v88maq357rjsua8buv.apps.googleusercontent.com',
    iosClientId: '922511656456-da49hug54dkesaog9gi8bfnq36l0pjp3.apps.googleusercontent.com',
    iosBundleId: 'cz.divocak.letbike',
  );
}
