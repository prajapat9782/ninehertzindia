import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ninehertzindia/screens/home_screen.dart';
import 'package:ninehertzindia/screens/record_screen.dart';

class AuthController extends ChangeNotifier {
  FirebaseAuth? auth;
  User? user;
  bool isLogin = false;

  Future<void> signIn(context) async {
    log("in Sign In");
    final GoogleSignInAccount? account = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication accountAuth =
        await account!.authentication;
    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: accountAuth.accessToken,
      idToken: accountAuth.idToken,
    );

    final UserCredential userData =
        await auth!.signInWithCredential(credential);
    if (userData.user != null) {
      log("user not null");
      isLogin = true;
      user = userData.user;

      notifyListeners();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MapSample()),
      );
    }
  }
}
