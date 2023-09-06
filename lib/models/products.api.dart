import 'dart:convert';
import 'package:http/http.dart';
import 'package:product_catalog/models/Product.dart';

class ProductsApi {
  static Future<List<Product>> getProducts() async {
    final res = await get(Uri.parse("https://dummyjson.com/products"));
    final data = jsonDecode(res.body);

    List productList = [];

    for (var i = 0; i < data["products"].length; i++) {
      productList.add(data["products"][i]);
    }

    return Product.productsFromSnapshot(productList);
  }
}
