// SHA 1: BF:CE:6C:53:ED:82:FF:13:57:20:91:E9:DD:A6:36:87:30:F8:41:CA

//Token: ehs5TsCgR5CgdXwWE0-jC9:APA91bETOqscJHODwPv5MvpA2lOCIt22Sg4GTbkHISHO3nERf4l7tFgb1vxcNIadcRmMAT36y429JCRAGPzyaLPKVAcxwbhfVXQ4l5AjEkw40yMHorbs6KfqnXpLx3PxNnn3LSQVDl4p

import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationsService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;
  static final StreamController<String> _messageStream =
      StreamController.broadcast();
  static Stream<String> get messageStream => _messageStream.stream;

  static Future _backgroundHandler(RemoteMessage message) async {
    print('onbackground Handler ${message.data}');
    _messageStream.add(message.data['product'] ?? 'No data');
  }

  static Future _onMessageHandler(RemoteMessage message) async {
    print('onbackground Handler ${message.data}');
    _messageStream.add(message.data['product'] ?? 'No data');
  }

  static Future _onMessageOpenApp(RemoteMessage message) async {
    print('onbackground Handler ${message.data}');
    _messageStream.add(message.data['product'] ?? 'No data');
  }

  static Future initializeApp() async {
    //Push Notifications
    await Firebase.initializeApp();
    token = await FirebaseMessaging.instance.getToken();
    print('Token: $token');

    //Handlers
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);

    //Local Notifications
  }

  static closeStreams() {
    _messageStream.close();
  }
}
