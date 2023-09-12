import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:product_catalog/models/Product.dart';
import 'package:product_catalog/models/products.api.dart';

class HomePageCarousel extends StatefulWidget {
  const HomePageCarousel({super.key});

  @override
  State<HomePageCarousel> createState() => _HomePageCarouselState();
}

class _HomePageCarouselState extends State<HomePageCarousel> {
  List<Product> products = [];
  List<Product> carouselList = [];
  @override
  void initState() {
    super.initState();
    getCarouselProducts();
  }

  Future<List<Product>> getCarouselProducts() async {
    products = await ProductsApi.getProducts();
    // print(products);
    carouselList = products.take(5).toList();
    return carouselList;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: getCarouselProducts(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('An error has occurred!'),
          );
        } else if (snapshot.hasData) {
          return CarouselSlider(
            options: CarouselOptions(
              height: 350.0,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 4),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              aspectRatio: 16 / 9,
              viewportFraction: 0.9,
            ),
            items: carouselList.map<Widget>((product) {
              return Builder(
                builder: (BuildContext context) {
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, "/details",
                          arguments: product);
                    },
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(product.thumbnail)))),
                  );
                },
              );
            }).toList(),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
