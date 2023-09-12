import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:product_catalog/Widgets/MyAppBar.dart';
import 'package:product_catalog/Widgets/ProductCard.dart';
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
        context: context,
      ),
      body: Column(
        children: [
          CarouselSlider(
              options: CarouselOptions(height: 350.0),
              items: product.images.map<Widget>((image) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                          image: DecorationImage(image: NetworkImage(image))),
                    );
                  },
                );
              }).toList()),
          const SizedBox(
            height: 30.0,
          ),
          ProductCard(product: product),
        ],
      ),
    );
  }
}
