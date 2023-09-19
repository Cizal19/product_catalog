import 'package:flutter/material.dart';
import 'package:product_catalog/Screens/CategoryPage.dart';
import 'package:product_catalog/Screens/DetailsPage.dart';
import 'package:product_catalog/Screens/HomePage.dart';
import 'package:product_catalog/Screens/LoginPage.dart';
import 'package:product_catalog/Screens/RegisterPage.dart';

void main() {
  runApp(MaterialApp(
    routes: {
      // '/': (context) => const HomePage(),
      '/': (context) => const RegisterPage(),
      '/register': (context) => RegisterPage(),
      '/login': (context) => LoginPage(),
      "/details": (context) => const DetailsPage(),
      "/category": (context) => const CategoryPage(),
    },
  ));
}
