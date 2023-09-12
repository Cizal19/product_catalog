import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:product_catalog/models/Product.dart';

class CustomSearchDelegate extends SearchDelegate {
  List<Product> searchProducts = [];

  Future<List<Product>> getSearchProducts(query) async {
    final res =
        await get(Uri.parse("https://dummyjson.com/product/search?q=$query"));
    final data = jsonDecode(res.body);

    List searchProductList = [];

    for (var i = 0; i < data["products"].length; i++) {
      searchProductList.add(data["products"][i]);
    }

    searchProducts = Product.productsFromSnapshot(searchProductList);

    // print(searchProducts);
    return searchProducts;
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
        hintColor: Colors.white,
        appBarTheme: AppBarTheme(
          color: Color(0xff46a094),
        ),
        textTheme: TextTheme(
          titleMedium: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
        ));
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(
          Icons.clear,
          color: Colors.white,
        ),
      ),
    ];
  }

  // second overwrite to pop out of search menu
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(
        Icons.keyboard_arrow_left_outlined,
        size: 30.0,
        color: Colors.white,
      ),
    );
  }

  // third overwrite to show query result
  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty)
      return Center(
          child: Text(
        "Please enter a query!",
        style: TextStyle(
          color: Colors.grey[600],
        ),
      ));

    return FutureBuilder<List<Product>>(
      future: getSearchProducts(query),
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
                            arguments: searchProducts[index]);
                      },
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Image.network(
                              searchProducts[index].thumbnail,
                              height: 100.0,
                              width: 100.0,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: ListTile(
                              title: Text(searchProducts[index].title),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ));
            },
            itemCount: searchProducts.length,
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  // last overwrite to show the
  // querying process at the runtime
  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
