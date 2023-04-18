import 'package:flutter/material.dart';
import 'package:notifications/screens/screens.dart';
import 'package:notifications/services/push_notifications_service.dart';

//void main() => runApp(const MyApp());

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PushNotificationsService.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();

//--------------------------------------------------------------
//---------------------- initState -----------------------------
//--------------------------------------------------------------

  @override
  void initState() {
    super.initState();
    PushNotificationsService.messageStream.listen((message) {
      //print('MyApp: $message');

      navigatorKey.currentState?.pushNamed('message', arguments: message);

      final snackBar = SnackBar(content: Text(message));
      messengerKey.currentState?.showSnackBar(snackBar);
    });
  }

//--------------------------------------------------------------
//---------------------- Pantalla ------------------------------
//--------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey, //Navegar
        scaffoldMessengerKey: messengerKey, //Snacks
        title: 'Notifications',
        initialRoute: 'home',
        routes: {
          'home': (_) => const HomeScreen(),
          'message': (_) => const MessageScreen(),
        });
  }
}
