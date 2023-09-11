import 'package:flutter/material.dart';
import 'package:product_catalog/Screens/CategoryPage.dart';
import 'package:product_catalog/Screens/DetailsPage.dart';
import 'package:product_catalog/Screens/HomePage.dart';
import 'package:product_catalog/Screens/ProductsPage.dart';

void main() {
  runApp(MaterialApp(
    // home: HomePage(),
    routes: {
      '/': (context) => HomePage(),
      "/details": (context) => DetailsPage(),
      "/category": (context) => CategoryPage(),
    },
  ));
}
