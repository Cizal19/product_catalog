import 'package:flutter/material.dart';

class CategoryRail extends StatelessWidget {
  const CategoryRail({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 4.0,
      borderOnForeground: true,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: Image.asset(
              "assets/smartphone.png",
              height: 52.0,
            ),
            onPressed: () {
              Navigator.pushNamed(context, "/category",
                  arguments: "smartphones");
            },
          ),
          IconButton(
            icon: Image.asset(
              "assets/laptop.png",
              height: 55.0,
            ),
            onPressed: () {
              Navigator.pushNamed(context, "/category", arguments: "laptops");
            },
          ),
          IconButton(
            icon: Image.asset(
              "assets/perfume.png",
              height: 52.0,
            ),
            onPressed: () {
              Navigator.pushNamed(context, "/category",
                  arguments: "fragrances");
            },
          ),
          IconButton(
            icon: Image.asset(
              "assets/skincare.png",
              height: 52.0,
            ),
            onPressed: () {
              Navigator.pushNamed(context, "/category", arguments: "skincare");
            },
          ),
          IconButton(
            icon: Image.asset(
              "assets/grocery.png",
              height: 52.0,
            ),
            onPressed: () {
              Navigator.pushNamed(context, "/category", arguments: "groceries");
            },
          ),
          IconButton(
            icon: Image.asset(
              "assets/shelf.png",
              height: 52.0,
            ),
            onPressed: () {
              Navigator.pushNamed(context, "/category",
                  arguments: "home-decoration");
            },
          ),
        ],
      ),
    );
  }
}
