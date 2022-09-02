import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../Widgets/reusable_button.dart';
import '../constants.dart';
import 'chat_screen.dart';

class RegistrationScreen extends StatefulWidget {
  static String routeName = 'registration';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  bool _spinnerState = false;

  bool _error = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: _spinnerState,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag: 'logo',
                child: SizedBox(
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
              const SizedBox(height: 48.0),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  //Do something with the user input.
                  email = value;
                },
                decoration: kRegistrationTextFieldDecoration.copyWith(hintText: 'Enter your email'),
              ),
              const SizedBox(height: 8.0),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  //Do something with the user input.
                  password = value;
                },
                decoration: kRegistrationTextFieldDecoration.copyWith(hintText: 'Enter your Password'),
              ),
              const SizedBox(height: 24.0),
              if (_error) ...[
                const SizedBox(
                  child: Center(
                    child: Text(
                      'Email already in use.',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ),
                const SizedBox(height: 24.0),
              ],
              ReusableButton(
                  buttonText: 'Register',
                  onPressed: () async {
                    setState(() {
                      _spinnerState = true;
                    });
                    try {
                      final newUser = await _auth.createUserWithEmailAndPassword(email: email, password: password);
                      if (newUser != null) {
                        Navigator.pushNamed(context, ChatScreen.routeName);
                      }
                    } catch (e) {
                      setState(() {
                        _error = true;
                      });
                      if (kDebugMode) {
                        print(e);
                      }
                    }
                    setState(() {
                      _spinnerState = false;
                    });
                  },
                  colour: Colors.blueAccent),
            ],
          ),
        ),
      ),
    );
  }
}
