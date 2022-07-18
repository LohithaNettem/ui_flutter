import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
//import 'package:firebase_core/firebase_core.dart';
//import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ui_flutter/screens/user_info.dart';

class Authentication {
  static Future<FirebaseApp> initializeFirebase({
    required BuildContext context,
  }) async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const UserInfoPage(),
        ),
      );
    }

    return firebaseApp;
  }

  static Future<User?> signInWithGoogle() async {
    User? user;
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) return null;

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(
              credential); //.signInWithCredential(credential);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        log('The account already exists with a different credential.');
      } else if (e.code == 'invalid-credential') {
        log('Error occurred while accessing credentials. Try again.');
      }
    } catch (e) {
      log('Error occurred using Google Sign-In. Try again.');
    }
    return user;
  }

  static Future<void> signOutFromGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      await googleSignIn.signOut();
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      log('Error signing out. Try again.');
    }
  }
}
