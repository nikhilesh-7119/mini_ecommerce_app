//model to store all the data for the cart item
class CartItem {
  final int id;
  final String title;
  final double price;
  final String image;
  final String? description;
  final String? category;
  final double? rate;
  final int? count;
  final int quantity;

  CartItem({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
    this.description,
    this.category,
    this.rate,
    this.count,
    required this.quantity,
  });

  double get lineTotal => price * quantity;

  CartItem copyWith({int? quantity}) => CartItem(
    id: id,
    title: title,
    price: price,
    image: image,
    description: description,
    category: category,
    rate: rate,
    count: count,
    quantity: quantity ?? this.quantity,
  );

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
    id: (json['id'] as num).toInt(),
    title: (json['title'] as String?)?.trim() ?? '',
    price: (json['price'] as num).toDouble(),
    image: (json['image'] as String?) ?? '',
    description: json['description'] as String?,
    category: json['category'] as String?,
    rate: (json['rate'] as num?)?.toDouble(),
    count: (json['count'] as num?)?.toInt(),
    quantity: (json['quantity'] as num?)?.toInt() ?? 1,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'price': price,
    'image': image,
    'description': description,
    'category': category,
    'rate': rate,
    'count': count,
    'quantity': quantity,
  };
}
