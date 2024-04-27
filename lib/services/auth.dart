import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final userStream = FirebaseAuth.instance.authStateChanges();
  final user = FirebaseAuth.instance.currentUser;

  Future<void> anonLogin() async {
    try {
      await FirebaseAuth.instance.signInAnonymously();
    } on FirebaseAuthException {
      // handle error
    }
  }

  Future<void> signOut() async {
    await GoogleSignIn().disconnect();
    await FirebaseAuth.instance.signOut();
  }

  Future<void> googleLogin(context) async {
    try {
      final googleUser = await GoogleSignIn().signIn();

      if (googleUser == null || !googleUser.email.endsWith("thapar.edu")) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Please Sign in with thapar.edu mail id'),
        ));

        try {
          await GoogleSignIn().disconnect();
        } catch (e) {
          return;
        }
        return;
      }

      final googleAuth = await googleUser.authentication;
      final authCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(authCredential);
    } on FirebaseAuthException catch (e) {
      // handle error
    }
  }
}
