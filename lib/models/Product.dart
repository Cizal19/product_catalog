class Product {
  late int id;
  late String title;
  late String description;
  late int price;
  late double discountPercentage;
  late double rating;
  late int stock;
  late String brand;
  late String category;
  late String thumbnail;
  late List<String> images;

  Product(
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.discountPercentage,
      required this.rating,
      required this.stock,
      required this.brand,
      required this.category,
      required this.thumbnail,
      required this.images});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json['id'] as int,
        title: json['title'] as String,
        description: json['description'] as String,
        price: json['price'] as int,
        discountPercentage: json['discountPercentage'] as double,
        rating: json['rating'].toDouble() as double,
        stock: json['stock'] as int,
        brand: json['brand'] as String,
        category: json['category'] as String,
        thumbnail: json['thumbnail'] as String,
        images: json['images'].cast<String>());
  }

  static List<Product> productsFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return Product.fromJson(data);
    }).toList();
  }
}
