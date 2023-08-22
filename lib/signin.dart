import 'package:flutter/material.dart';
import 'package:flutter_create_pod/authService.dart';
import 'package:flutter_create_pod/home.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            TextButton(
              child: Text("sign with google"),
              onPressed: () {
                Googleauth().signInWithGoogle(context, Home());
              },
            ),
            TextButton(
              child: Text("sign with apple"),
              onPressed: () {
                Googleauth().signInWithApple();
              },
            ),
          ],
        ),
      ),
    );
  }
}
