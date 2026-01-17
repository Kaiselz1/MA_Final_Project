class Product {
  int id;
  String name;
  String description;
  double price;
  String imageUrl;
  String categoryName;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.categoryName,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: (json['price']).toDouble(),
      imageUrl: json['image_url'],
      categoryName: json['category_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'image_url': imageUrl,
      'category_id': categoryName,
    };
  }
}
