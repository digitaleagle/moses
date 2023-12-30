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
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAfaCNw8J_Cp49QYND1_UaVDJx4U9aWkbQ',
    appId: '1:1037110160766:web:4133bcd1c620605dd4572f',
    messagingSenderId: '1037110160766',
    projectId: 'moses-d02f2',
    authDomain: 'moses-d02f2.firebaseapp.com',
    storageBucket: 'moses-d02f2.appspot.com',
    measurementId: 'G-C0RR7XL9J4',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCtuz01nC95cqCl5NTqQhGfcpV5SWi2-II',
    appId: '1:1037110160766:android:12ceaa4471d7b35dd4572f',
    messagingSenderId: '1037110160766',
    projectId: 'moses-d02f2',
    storageBucket: 'moses-d02f2.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDAy1X6iWGJbk0jZ3XsoACpgXR3lGGxDIs',
    appId: '1:1037110160766:ios:2553b39308475d13d4572f',
    messagingSenderId: '1037110160766',
    projectId: 'moses-d02f2',
    storageBucket: 'moses-d02f2.appspot.com',
    iosClientId: '1037110160766-r51o0i9vieh8gf7fhtlrhd5u94gdvjrd.apps.googleusercontent.com',
    iosBundleId: 'com.example.moses',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDAy1X6iWGJbk0jZ3XsoACpgXR3lGGxDIs',
    appId: '1:1037110160766:ios:2553b39308475d13d4572f',
    messagingSenderId: '1037110160766',
    projectId: 'moses-d02f2',
    storageBucket: 'moses-d02f2.appspot.com',
    iosClientId: '1037110160766-r51o0i9vieh8gf7fhtlrhd5u94gdvjrd.apps.googleusercontent.com',
    iosBundleId: 'com.example.moses',
  );
}
