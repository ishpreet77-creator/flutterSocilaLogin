import 'package:flutter/material.dart';
import 'package:flutter_create_pod/main.dart';

import 'authService.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Home"),
        ),
        body: Center(
          child: TextButton(
            child: Text("signOut"),
            onPressed: () {
              Googleauth().signOut(context, MyApp());
            },
          ),
        ));
  }
}
