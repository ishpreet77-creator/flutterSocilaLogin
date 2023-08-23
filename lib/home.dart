import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'Appdefault.dart';
import 'authService.dart';

import 'main.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var name;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getvalue();
  }

  void getvalue() async {
    name = await savestring().displayname();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 100),
        child: Center(
          child: Column(
            children: [
              TextButton(
                child: Text("signOut"),
                onPressed: () {
                  socialLoginAuth().signOut(context, MyApp());
                },
              ),
              Text('User Name== $name'),
            ],
          ),
        ),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}
