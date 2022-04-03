// SHA1: BF:CE:6C:53:ED:82:FF:13:57:20:91:E9:DD:A6:36:87:30:F8:41:CA
//Token: fyw-4GQRQ-6Rv0T3IKcRH4:APA91bHa5LDz8SNYOwRyJZI29IpMIA1aMDsxHe7q2NwLezWkHu059lilIlCtCS8crIzuf2KP5-eDGPiS4809nJAA2sxDiMqiMGRmpMRF4ubf20AW1BWMgdzfJYB3pH8YmcYwcwt3pLi9

import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationsService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;
  static StreamController<String> _messageStream =
      new StreamController.broadcast();
  static Stream<String> get messageStream => _messageStream.stream;

  static Future _backgroundHandler(RemoteMessage message) async {
    //print('onbackground Handler ${message.messageId}');
    print(message.data);
    _messageStream.add(message.data['product'] ?? 'No data');
  }

  static Future _onMessageHandler(RemoteMessage message) async {
    //print('_onMessage Handler ${message.messageId}');
    print(message.data);
    _messageStream.add(message.data['product'] ?? 'No data');
  }

  static Future _onMessageOpenApp(RemoteMessage message) async {
    //print('_onMessageOpenApp Handler ${message.messageId}');
    print(message.data);
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
