import 'package:ecommerce_app1/bootomnav.dart';

import 'package:ecommerce_app1/services/loginorreg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            //use loggd in
            if (snapshot.hasData) {
              return BottomNav();
            } else {
              return LoginOrRegister();
            }
          }),
    );
  }
}

