import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:product_catalog/Widgets/HomePageCarousel.dart';
import 'package:product_catalog/Widgets/MyAppBar.dart';
import 'package:product_catalog/Widgets/MyDrawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: MyAppBar(title: "Product Catalog"),
      drawer: MyDrawer(),
      body: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Featured".toUpperCase(),
              style: TextStyle(
                  color: Colors.grey[700], fontSize: 20.0, letterSpacing: 2.0),
            ),
          ),
          const SizedBox(
            height: 8.0,
          ),
          const HomePageCarousel(),
          const SizedBox(
            height: 8.0,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.star,
                  color: Color(0xffffd700),
                ),
                SizedBox(
                  width: 2.0,
                ),
                Text(
                  "Top Rated".toUpperCase(),
                  style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 20.0,
                      letterSpacing: 2.0),
                ),
              ],
            ),
          ),
          GridView.count(
            primary: false,
            padding: const EdgeInsets.all(20),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            // scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            children: [1, 2, 3, 4, 5, 6].map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(color: Color(0xffc4e8c2)),
                      child: Center(
                        child: Text(
                          'Product $i',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ));
                },
              );
            }).toList(),
          )
        ]),
      ),
    );
  }
}
