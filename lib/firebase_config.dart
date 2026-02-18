import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class FirebaseConfig {
  static Future<void> initialize() async {
    // Carrega o arquivo .env
    await dotenv.load(fileName: ".env");

    FirebaseOptions? options;

    if (kIsWeb) {
      options = _webOptions();
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      options = _androidOptions();
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      options = _iosOptions();
    }
    // Adicione outras plataformas se necessário (Windows, macOS)

    // Se options for null, o Firebase tentará usar a configuração nativa (google-services.json / GoogleService-Info.plist)
    // Se options for fornecido, usará os dados do .env
    await Firebase.initializeApp(options: options);
  }

  static FirebaseOptions _webOptions() {
    return FirebaseOptions(
      apiKey: dotenv.env['FIREBASE_API_KEY'] ?? '',
      appId: dotenv.env['FIREBASE_APP_ID'] ?? '',
      messagingSenderId: dotenv.env['FIREBASE_MESSAGING_SENDER_ID'] ?? '',
      projectId: dotenv.env['FIREBASE_PROJECT_ID'] ?? '',
      storageBucket: dotenv.env['FIREBASE_STORAGE_BUCKET'],
    );
  }

  static FirebaseOptions _androidOptions() {
    return FirebaseOptions(
      apiKey:
          dotenv.env['FIREBASE_ANDROID_API_KEY'] ??
          dotenv.env['FIREBASE_API_KEY'] ??
          '',
      appId:
          dotenv.env['FIREBASE_ANDROID_APP_ID'] ??
          dotenv.env['FIREBASE_APP_ID'] ??
          '',
      messagingSenderId: dotenv.env['FIREBASE_MESSAGING_SENDER_ID'] ?? '',
      projectId: dotenv.env['FIREBASE_PROJECT_ID'] ?? '',
      storageBucket: dotenv.env['FIREBASE_STORAGE_BUCKET'],
    );
  }

  static FirebaseOptions _iosOptions() {
    return FirebaseOptions(
      apiKey:
          dotenv.env['FIREBASE_IOS_API_KEY'] ??
          dotenv.env['FIREBASE_API_KEY'] ??
          '',
      appId:
          dotenv.env['FIREBASE_IOS_APP_ID'] ??
          dotenv.env['FIREBASE_APP_ID'] ??
          '',
      messagingSenderId: dotenv.env['FIREBASE_MESSAGING_SENDER_ID'] ?? '',
      projectId: dotenv.env['FIREBASE_PROJECT_ID'] ?? '',
      storageBucket: dotenv.env['FIREBASE_STORAGE_BUCKET'],
      iosBundleId: dotenv.env['FIREBASE_IOS_BUNDLE_ID'],
    );
  }
}
