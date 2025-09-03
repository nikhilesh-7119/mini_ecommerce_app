import 'package:mini_ecommerce_app/models/rating.dart';

class Product {
  final int id;
  final String title;
  final String description;
  final String category;
  final double price;
  final String image;
  final Rating rating;

  Product( {
    required this.id,
    required this.title,
    required this.price,
    required this.image,
    required this.rating,
    required this.description,
    required this.category,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: (json['id'] as num).toInt(),
        title: (json['title'] as String?)?.trim() ?? '',
        description: (json['description'] as String?)?.trim() ?? '',
        category: (json['category'] as String?)?.trim() ?? '',
        price: (json['price'] as num).toDouble(),
        image: (json['image'] as String?) ?? '',
        rating: Rating.fromJson(json['rating'] as Map<String, dynamic>? ?? {}),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'category': category,
        'price': price,
        'image': image,
        'rating': rating.toJson(),
      };
}