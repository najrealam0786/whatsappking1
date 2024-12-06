import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'LoginScreen.dart';
import 'bottom_navigation_bar.dart';

class AuthCheck extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // If user is logged in
        if (snapshot.hasData) {
          return Bottomnavigationbar();
        } else {
          return LoginScreen();
        }
      },
    );
  }
}
