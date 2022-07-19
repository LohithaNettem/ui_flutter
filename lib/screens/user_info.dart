import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ui_flutter/screens/loginscreen.dart';
import 'package:ui_flutter/utils/authentication.dart';

class UserInfoPage extends StatefulWidget {
  const UserInfoPage({Key? key}) : super(key: key);

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  User? user;

  @override
  void initState() {
    user = FirebaseAuth.instance.currentUser;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 8, bottom: 8),
          child: CircleAvatar(
            foregroundImage: NetworkImage(
              user!.photoURL.toString(),
            ),
          ),
        ),
        title: Text(user!.displayName.toString()),
        actions: [
          IconButton(
            onPressed: () {
              Authentication.signOutFromGoogle();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) {
                return const LogInScreen();
              }), (route) => true);
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      floatingActionButton:
          FloatingActionButton(child: const Icon(Icons.add), onPressed: () {}),
      body: const Center(
        child: Text('Hello!'),
      ),
    );
  }
}
