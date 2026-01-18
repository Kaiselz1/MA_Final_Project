class Product {
  int id;
  String name;
<<<<<<< HEAD
  String category;
  double price;
  int stock;
  String image;
  String description;
=======
  String description;
  double price;
  String imageUrl;
  String categoryName;
>>>>>>> new-api

  Product({
    required this.id,
    required this.name,
<<<<<<< HEAD
    required this.category,
    required this.price,
    required this.stock,
    required this.image,
    required this.description,
=======
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.categoryName,
>>>>>>> new-api
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
<<<<<<< HEAD
      category: json['category'],
      price: (json['price'] as num).toDouble(),
      stock: json['stock'],
      image: json['image'],
      description: json['description'],
=======
      description: json['description'],
      price: (json['price']).toDouble(),
      imageUrl: json['image_url'],
      categoryName: json['category_name'],
>>>>>>> new-api
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
<<<<<<< HEAD
      'category': category,
      'price': price,
      'stock': stock,
      'image': image,
      'description': description,
    };
  }
}
=======
      'description': description,
      'price': price,
      'image_url': imageUrl,
      'category_id': categoryName,
    };
  }
}
>>>>>>> new-api
