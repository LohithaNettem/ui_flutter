import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ui_flutter/screens/user_info.dart';
import 'package:ui_flutter/utils/authentication.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  void onButtonPressed(BuildContext buildContext) async {
    User? user = await Authentication.signInWithGoogle();
    if (user != null) {
      Navigator.of(buildContext).pushReplacement(MaterialPageRoute(
        builder: (context) => const UserInfoPage(),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: TextButton.icon(
            onPressed: () => onButtonPressed(context),
            style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsets>(
                    const EdgeInsets.only(left: 6, right: 8)),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: const BorderSide(color: Colors.white)))),
            icon: const Icon(Icons.login),
            label: const Text('SignIn with Google'),
          ),
        ),
      ),
    );
  }
}
