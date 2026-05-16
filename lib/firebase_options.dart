import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return const FirebaseOptions(
        apiKey: 'demo-api-key',
        appId: '1:000000000000:web:atlas-sonoro',
        messagingSenderId: '000000000000',
        projectId: 'atlas-sonoro-demo',
        authDomain: 'atlas-sonoro-demo.firebaseapp.com',
        storageBucket: 'atlas-sonoro-demo.appspot.com',
      );
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      default:
        return android;
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'demo-api-key',
    appId: '1:000000000000:android:atlas-sonoro',
    messagingSenderId: '000000000000',
    projectId: 'atlas-sonoro-demo',
    storageBucket: 'atlas-sonoro-demo.appspot.com',
  );
}
