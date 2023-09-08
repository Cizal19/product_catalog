import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:product_catalog/Widgets/MyAppBar.dart';
import 'package:product_catalog/Widgets/MyDrawer.dart';
import 'package:product_catalog/models/Product.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)!.settings.arguments as Product;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: MyAppBar(
        title: product.title.toUpperCase(),
      ),
      // drawer: MyDrawer(),
      body: Column(
        children: [
          CarouselSlider(
              options: CarouselOptions(height: 350.0),
              items: product.images.map<Widget>((image) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                          image: DecorationImage(image: NetworkImage(image))),
                    );
                  },
                );
              }).toList()),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                product.brand.toUpperCase(),
                style: TextStyle(letterSpacing: 2.0, color: Colors.grey[700]),
              ),
              Text(
                product.title.toUpperCase(),
                style: TextStyle(fontSize: 20.0, letterSpacing: 2.0),
              ),
              Text(
                "\$${product.price.toString()}",
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
            product.description,
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
                    product.rating.toString(),
                    style:
                        TextStyle(letterSpacing: 2.0, color: Colors.grey[700]),
                  ),
                ],
              ),
              SizedBox(
                width: 180.0,
              ),
              Text(
                "Stock: ${product.stock.toString()}",
                style: TextStyle(letterSpacing: 2.0),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
