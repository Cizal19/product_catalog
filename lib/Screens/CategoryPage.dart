import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:product_catalog/Widgets/MyAppBar.dart';

import 'package:product_catalog/models/Product.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List<Product> categoryProducts = [];

  Future<List<Product>> getCategoryProducts(category) async {
    final res = await get(
        Uri.parse("https://dummyjson.com/products/category/$category"));
    final data = jsonDecode(res.body);

    List categoryProductList = [];

    for (var i = 0; i < data["products"].length; i++) {
      categoryProductList.add(data["products"][i]);
    }

    categoryProducts = Product.productsFromSnapshot(categoryProductList);
    return categoryProducts;
  }

  @override
  Widget build(BuildContext context) {
    final category = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      appBar: MyAppBar(
        title: "$category".toUpperCase(),
        context: context,
      ),
      body: FutureBuilder<List<Product>>(
        future: getCategoryProducts(category),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('An error has occurred!'),
            );
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 4.0, vertical: 1.0),
                    child: Card(
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, "/details",
                              arguments: categoryProducts[index]);
                        },
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Image.network(
                                categoryProducts[index].thumbnail,
                                height: 100.0,
                                width: 100.0,
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: ListTile(
                                title: Text(categoryProducts[index].title),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ));
              },
              itemCount: categoryProducts.length,
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
