import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  Map product = {
    "id": 1,
    "title": "iPhone 9",
    "description": "An apple mobile which is nothing like apple",
    "price": 549,
    "discountPercentage": 12.96,
    "rating": 4.69,
    "stock": 94,
    "brand": "Apple",
    "category": "smartphones",
    "thumbnail": "https://i.dummyjson.com/data/products/1/thumbnail.jpg",
    "images": [
      "https://i.dummyjson.com/data/products/1/1.jpg",
      "https://i.dummyjson.com/data/products/1/2.jpg",
      "https://i.dummyjson.com/data/products/1/3.jpg",
      "https://i.dummyjson.com/data/products/1/4.jpg",
      "https://i.dummyjson.com/data/products/1/thumbnail.jpg"
    ]
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
          title: Text(
            "Product Catalog",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color(0xff46a094),
          iconTheme: IconThemeData(color: Colors.white)),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xff6bbd99),
              ),
              child: Center(
                child: Text(
                  'Categories',
                  style: TextStyle(color: Colors.white, fontSize: 25.0),
                ),
              ),
            ),
            ListTile(
              title: const Text('Category 1'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('Category 2'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(height: 350.0),
            items: [1, 2, 3].map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(product["images"][i]))),
                  );
                },
              );
            }).toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                product["brand"].toUpperCase(),
                style: TextStyle(letterSpacing: 2.0, color: Colors.grey[700]),
              ),
              Text(
                product["title"].toUpperCase(),
                style: TextStyle(fontSize: 20.0, letterSpacing: 2.0),
              ),
              Text(
                "\$${product["price"].toString()}",
                style: TextStyle(
                    fontSize: 20.0,
                    letterSpacing: 2.0,
                    color: Colors.redAccent),
              ),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            product["description"],
            // style: TextStyle(letterSpacing: 2.0),
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            children: [
              SizedBox(
                width: 55.0,
              ),
              Row(
                children: [
                  Icon(Icons.star, color: Colors.yellow),
                  SizedBox(
                    width: 2.0,
                  ),
                  Text(
                    product["rating"].toString(),
                    style:
                        TextStyle(letterSpacing: 2.0, color: Colors.grey[700]),
                  ),
                ],
              ),
              SizedBox(
                width: 180.0,
              ),
              Text(
                "Stock: ${product["stock"].toString()}",
                style: TextStyle(letterSpacing: 2.0),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


// product["images"].map((image) {
//                 return Builder(
//                   builder: (BuildContext context) {
//                     return Container(
//                         width: MediaQuery.of(context).size.width,
//                         margin: EdgeInsets.symmetric(horizontal: 5.0),
//                         decoration:
//                             BoxDecoration(image: DecorationImage(image: image)),
//                         child: Center(
//                           child: Text(
//                             'Product ${product["name"]}',
//                             style: TextStyle(fontSize: 16.0),
//                           ),
//                         ));
//                   },
//                 );
//               }).toList()