import 'package:flutter/material.dart';
import 'package:product_catalog/Screens/CategoryPage.dart';
import 'package:product_catalog/Screens/DetailsPage.dart';
import 'package:product_catalog/Screens/HomePage.dart';
import 'package:product_catalog/Screens/LoginPage.dart';
import 'package:product_catalog/Screens/RegisterPage.dart';
import 'package:product_catalog/Screens/SplashScreen.dart';
import 'package:product_catalog/Screens/UserDetailsPage.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SpalshScreen(),
    routes: {
      '/register': (context) => RegisterPage(),
      '/login': (context) => LoginPage(),
      '/homepage': (context) => const HomePage(),
      "/details": (context) => const DetailsPage(),
      "/category": (context) => const CategoryPage(),
      "/user": (context) => UserDetailsPage()
    },
    theme: ThemeData(
      // primaryTextTheme: TextTheme(bodyMedium: TextStyle(color: Colors.black)),
      textTheme: TextTheme(
          bodyMedium: TextStyle(color: Color(0xff46a094)),
          // bodyMedium: TextStyle(color: Colors.black),
          headlineLarge: TextStyle(
            color: Color(0xff46a094),
            fontWeight: FontWeight.w900,
          )),
      // textButtonTheme: TextButtonThemeData(style: ButtonStyle())
    ),
  ));
}
