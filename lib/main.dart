import 'package:flutter/material.dart';
import 'package:product_catalog/Screens/CategoryPage.dart';
import 'package:product_catalog/Screens/DetailsPage.dart';
import 'package:product_catalog/Screens/HomePage.dart';
import 'package:product_catalog/Screens/LoginPage.dart';
import 'package:product_catalog/Screens/RegisterPage.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    routes: {
      '/register': (context) => RegisterPage(),
      '/': (context) => LoginPage(),
      '/homepage': (context) => const HomePage(),
      "/details": (context) => const DetailsPage(),
      "/category": (context) => const CategoryPage(),
    },
    theme: ThemeData(
      textTheme: TextTheme(
          bodyMedium: TextStyle(color: Color(0xff46a094)),
          headlineLarge: TextStyle(
            color: Color(0xff46a094),
            fontWeight: FontWeight.w900,
          )),
      // textButtonTheme: TextButtonThemeData(style: ButtonStyle())
    ),
  ));
}
