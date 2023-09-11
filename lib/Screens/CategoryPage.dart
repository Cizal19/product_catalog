import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:product_catalog/Widgets/MyAppBar.dart';
import 'package:product_catalog/Widgets/MyDrawer.dart';
import 'package:product_catalog/models/Product.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List<Product> categoryProducts = [];

  // @override
  // void initState() {
  //   super.initState();
  //   getCategoryProducts(category);
  // }

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
      // drawer: MyDrawer(),
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


// Card(
//                     child: ListTile(
//                       onTap: () {},
//                       // title: Text(products[index]["title"]),
//                       title: Text(categoryProducts[index].title),
//                       leading: CircleAvatar(
//                         radius: 70.0,
//                         backgroundImage:
//                             NetworkImage(categoryProducts[index].thumbnail),
//                       ),
//                     ),
//                   ),




// Product(
//                                   id: categoryProducts[index].id,
//                                   title: categoryProducts[index].title,
//                                   description:
//                                       categoryProducts[index].description,
//                                   price: categoryProducts[index].price,
//                                   discountPercentage: categoryProducts[index]
//                                       .discountPercentage,
//                                   rating: categoryProducts[index].rating,
//                                   stock: categoryProducts[index].stock,
//                                   brand: categoryProducts[index].brand,
//                                   category: categoryProducts[index].category,
//                                   thumbnail: categoryProducts[index].thumbnail,
//                                   images: categoryProducts[index].images)