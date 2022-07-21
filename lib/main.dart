import 'package:flutter/material.dart';
import 'package:universal_io/io.dart' as u;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:user_app/pages/login/view/login.dart';

Future<void> _messageHandler(RemoteMessage message) async {
  print('background message ${message.notification!.body}');
}
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (u.Platform.operatingSystem == "android" ||
      u.Platform.operatingSystem == "ios") {
    await Firebase.initializeApp();
    FirebaseMessaging.onBackgroundMessage(_messageHandler);
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Login(),
    );
  }
}
