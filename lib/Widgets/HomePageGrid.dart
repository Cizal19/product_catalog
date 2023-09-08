import 'package:flutter/material.dart';
import 'package:product_catalog/models/Product.dart';
import 'package:product_catalog/models/products.api.dart';

class HomePageGrid extends StatefulWidget {
  const HomePageGrid({super.key});

  @override
  State<HomePageGrid> createState() => _HomePageGridState();
}

class _HomePageGridState extends State<HomePageGrid> {
  List<Product> products = [];
  List<Product> gridList = [];
  @override
  void initState() {
    super.initState();
    getGridProducts();
  }

  Future<List<Product>> getGridProducts() async {
    products = await ProductsApi.getProducts();
    // print(products);
    gridList = products.take(10).toList();
    return gridList;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: getGridProducts(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('An error has occurred!'),
          );
        } else if (snapshot.hasData) {
          return GridView.count(
            primary: false,
            padding: const EdgeInsets.all(20),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            // scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            children: gridList.map<Widget>((product) {
              return Builder(
                builder: (BuildContext context) {
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, "/details",
                          arguments: Product(
                              id: product.id,
                              title: product.title,
                              description: product.description,
                              price: product.price,
                              discountPercentage: product.discountPercentage,
                              rating: product.rating,
                              stock: product.stock,
                              brand: product.brand,
                              category: product.category,
                              thumbnail: product.thumbnail,
                              images: product.images));
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