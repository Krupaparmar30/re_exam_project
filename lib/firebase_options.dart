// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyDZ8alTivGd-QWak2Um9OZayrpdEofLdoU',
    appId: '1:565745036569:web:b4598451652b7ae2e76988',
    messagingSenderId: '565745036569',
    projectId: 'reexamproject',
    authDomain: 'reexamproject.firebaseapp.com',
    storageBucket: 'reexamproject.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBgRDhFl5EZV7Wp_cO-vfETdaErFhu9fQ8',
    appId: '1:565745036569:android:0718d19c40b02db0e76988',
    messagingSenderId: '565745036569',
    projectId: 'reexamproject',
    storageBucket: 'reexamproject.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAJusMeCjqQBDUro92H3NCfI5_ZJTpBZQY',
    appId: '1:565745036569:ios:d0d2b40f6d5be02ee76988',
    messagingSenderId: '565745036569',
    projectId: 'reexamproject',
    storageBucket: 'reexamproject.firebasestorage.app',
    iosBundleId: 'com.example.reExamProject',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAJusMeCjqQBDUro92H3NCfI5_ZJTpBZQY',
    appId: '1:565745036569:ios:d0d2b40f6d5be02ee76988',
    messagingSenderId: '565745036569',
    projectId: 'reexamproject',
    storageBucket: 'reexamproject.firebasestorage.app',
    iosBundleId: 'com.example.reExamProject',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDZ8alTivGd-QWak2Um9OZayrpdEofLdoU',
    appId: '1:565745036569:web:125d2befa715e9cfe76988',
    messagingSenderId: '565745036569',
    projectId: 'reexamproject',
    authDomain: 'reexamproject.firebaseapp.com',
    storageBucket: 'reexamproject.firebasestorage.app',
  );
}
