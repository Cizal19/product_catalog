import 'package:flutter/material.dart';
import 'package:product_catalog/models/Product.dart';
import 'package:product_catalog/models/products.api.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  List<Product> products = [];
  @override
  void initState() {
    super.initState();
    getProducts();
  }

  Future<List<Product>> getProducts() async {
    products = await ProductsApi.getProducts();
    // print(products);
    return products;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Product Catalog",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xff46a094),
      ),
      body: FutureBuilder<List<Product>>(
        future: getProducts(),
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
                    child: ListTile(
                      onTap: () {},
                      // title: Text(products[index]["title"]),
                      title: Text(products[index].title),
                    ),
                  ),
                );
              },
              itemCount: products.length,
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
