import 'package:flutter/material.dart';
import 'package:product_catalog/models/Product.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromARGB(251, 255, 255, 255),
      elevation: 4, // Add shadow to the card
      margin: EdgeInsets.all(16), // Add margin around the card
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product.title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                    ElevatedButton.icon(
                        style: ButtonStyle(
                            iconSize: MaterialStatePropertyAll<double>(25.0),
                            iconColor:
                                MaterialStatePropertyAll<Color>(Colors.white),
                            backgroundColor: MaterialStatePropertyAll<Color>(
                                Color(0xff46a094))),
                        onPressed: () {},
                        icon: Icon(
                          Icons.favorite_border,
                          weight: 2.0,
                        ),
                        label: Text(
                          "Like",
                          style: TextStyle(fontSize: 20.0, color: Colors.white),
                        ))
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  '${product.brand}'.toUpperCase(),
                  style: TextStyle(
                    letterSpacing: 2.0,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  '\$${product.price}',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                      color: Colors.redAccent),
                ),
                SizedBox(height: 8),
                Text(
                  '${product.description}',
                  style: TextStyle(
                    letterSpacing: 1.0,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.orange),
                    Text(
                      ' ${product.rating}',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  'In Stock: ${product.stock}',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
