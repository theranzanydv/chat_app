import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart' show Firebase;

import './screens/chat_screen.dart';
import './screens/login_screen.dart';
import './screens/registration_screen.dart';
import './screens/welcome_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const FlashChat());
}

class FlashChat extends StatelessWidget {
  const FlashChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        textTheme: const TextTheme(
          bodyText1: TextStyle(color: Colors.black87),
          bodyText2: TextStyle(color: Colors.black54),
          subtitle1: TextStyle(color: Colors.black87),
        ),
      ),
      // home: WelcomeScreen(),
      initialRoute: WelcomeScreen.routeName,
      routes: {
        WelcomeScreen.routeName: (context) => WelcomeScreen(),
        LoginScreen.routeName: (context) => const LoginScreen(),
        RegistrationScreen.routeName: (context) => RegistrationScreen(),
        ChatScreen.routeName: (context) => ChatScreen(),
      },
    );
  }
}
