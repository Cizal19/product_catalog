import 'package:flutter/material.dart';
import 'package:product_catalog/models/Product.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(251, 255, 255, 255),
      elevation: 4, // Add shadow to the card
      margin: const EdgeInsets.all(16), // Add margin around the card
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          product.brand.toUpperCase(),
                          style: TextStyle(
                            letterSpacing: 2.0,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '\$${product.price}',
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,
                              color: Colors.redAccent),
                        ),
                      ],
                    ),
                    ElevatedButton.icon(
                        style: const ButtonStyle(
                            iconSize: MaterialStatePropertyAll<double>(25.0),
                            iconColor:
                                MaterialStatePropertyAll<Color>(Colors.white),
                            backgroundColor: MaterialStatePropertyAll<Color>(
                                Color(0xff46a094))),
                        onPressed: () {},
                        icon: const Icon(
                          Icons.favorite_border,
                          weight: 2.0,
                        ),
                        label: const Text(
                          "Like",
                          style: TextStyle(fontSize: 20.0, color: Colors.white),
                        ))
                  ],
                ),
                const SizedBox(height: 8),
                const SizedBox(height: 8),
                Text(
                  product.description,
                  style: const TextStyle(
                    letterSpacing: 1.0,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.orange),
                    Text(
                      ' ${product.rating}',
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
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
