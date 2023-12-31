// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDCXw241kXxsuhCz2ZlKqkH5ltq8M3CSt8',
    appId: '1:1053572601670:android:6429bff6356e81fda27747',
    messagingSenderId: '1053572601670',
    projectId: 'cookmaster-124f5',
    storageBucket: 'cookmaster-124f5.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAnCM5tu8reIfhfZHMyninlsu9tc8C2OwY',
    appId: '1:1053572601670:ios:75bb25de21bc631ba27747',
    messagingSenderId: '1053572601670',
    projectId: 'cookmaster-124f5',
    storageBucket: 'cookmaster-124f5.appspot.com',
    iosClientId:
        '1053572601670-c7vmo279spp8eu7tj7c7rlre0f49nhoi.apps.googleusercontent.com',
    iosBundleId: 'br.com.cookmaster.cookmasterFront',
  );
}
