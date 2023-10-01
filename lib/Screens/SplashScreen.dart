import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SpalshScreen extends StatefulWidget {
  const SpalshScreen({Key? key}) : super(key: key);

  @override
  State<SpalshScreen> createState() => SpalshScreenState();
}

class SpalshScreenState extends State<SpalshScreen> {
  static const String KEYLOGIN = "login";
  static const String USERID = "userId";
  @override
  void initState() {
    super.initState();
    whereToGo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xff46a094),
        child: Center(
          child: Image.asset("assets/logo.png"),
        ),
      ),
    );
  }

  void whereToGo() async {
    var sharedPref = await SharedPreferences.getInstance();
    var isLoggedIn = sharedPref.getBool(KEYLOGIN);
    Timer(Duration(seconds: 2), () {
      if (isLoggedIn != null) {
        if (isLoggedIn) {
          Navigator.pushReplacementNamed(context, "/homepage");
        } else {
          Navigator.pushReplacementNamed(context, "/login");
        }
      } else {
        Navigator.pushReplacementNamed(context, "/login");
      }
    });
  }
}
