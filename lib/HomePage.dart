import 'package:flutter/material.dart';
import 'package:product_catalog/models/Product.dart';
import 'package:product_catalog/models/products.api.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List products = [];
  @override
  void initState() {
    super.initState();
    getProducts();
  }

  Future<void> getProducts() async {
    products = await ProductsApi.getProducts();
    print(products);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product List"),
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



// ListView.builder(
//           itemBuilder: (context, index) {
//             return Padding(
//               padding:
//                   const EdgeInsets.symmetric(horizontal: 4.0, vertical: 1.0),
//               child: Card(
//                 child: ListTile(
//                   onTap: () {},
//                   // title: Text(products[index]["title"]),
//                   title: Text(products[index].title),
//                 ),
//               ),
//             );
//           },
//           itemCount: products.length,
//         )




