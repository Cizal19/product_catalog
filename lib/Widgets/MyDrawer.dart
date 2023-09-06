import 'package:flutter/material.dart';
import 'package:product_catalog/models/products.api.dart';

Future<List<String>> getCategories() async {
  List productList = await ProductsApi.getProducts();

  List<String> categories = [];

  for (var product in productList) {
    String category = product.category;
    if (!categories.contains(category)) {
      categories.add(category);
    }
  }
  // print(categories);
  return categories;
}

class MyDrawer extends Drawer {
  MyDrawer({Key? key, Widget? child})
      : super(
            key: key,
            child: ListView(
                // Important: Remove any padding from the ListView.
                padding: EdgeInsets.zero,
                children: [
                  const UserAccountsDrawerHeader(
                    accountName: Text("John Doe"),
                    accountEmail: Text("johndoe@example.com"),
                    decoration: BoxDecoration(
                      color: Color(0xff6bbd99),
                    ),
                    currentAccountPicture: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person),
                    ),
                  ),
                  FutureBuilder<List<String>>(
                    future: getCategories(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(
                            child: Text('No categories available.'));
                      } else {
                        List<String> categories = snapshot.data!;

                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                                title: Text(categories[index].toUpperCase()),
                                onTap: () {});
                          },
                        );
                      }
                    },
                  ),
                ]));
}
