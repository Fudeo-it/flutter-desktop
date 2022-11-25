class Product {
  final int id;
  final String name;
  final String description;
  final String category;
  final int quantity;
  final DateTime createdAt;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.quantity,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['id'] as int,
        name: json['name'] as String,
        description: json['description'] as String,
        category: json['category'] as String,
        quantity: json['quantity'] as int,
        createdAt:
            DateTime.fromMillisecondsSinceEpoch(json['createdAt'] as int),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'category': category,
        'quantity': quantity,
        'createdAt': createdAt.millisecondsSinceEpoch,
      };
}
