class Products {
  final int id;
  final int categories_id;
  final String name;
  final String description;
  final String image;
  final double price;
  final int quantity;
  final DateTime createAt;
  final DateTime updateAt;
  final DateTime deleteAt;

  const Products({
    required this.id,
    required this.categories_id,
    required this.name,
    required this.description,
    required this.image,
    required this.price,
    required this.quantity,
    required this.createAt,
    required this.updateAt,
    required this.deleteAt,
  });

  factory Products.fromJson(Map<String, dynamic> json) => Products(
        id: json['id'] ?? 0,
        categories_id: json['categories_id'] ?? 0,
        description: json['description'] ?? '',
        name: json['name'] ?? '',
        image: json['image'] ?? '',
        price: json['price'] != null ? json['price'].toDouble() : 0.0,
        quantity: json['quantity'] ?? 0,
        createAt: json['create_at'] != null ? DateTime.parse(json['create_at']) : DateTime.now(),
        updateAt: json['update_at'] != null ? DateTime.parse(json['update_at']) : DateTime.now(),
        deleteAt: json['delete_at'] != null ? DateTime.parse(json['delete_at']) : DateTime.now(),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'categories_id': categories_id,
    'description': description,
    'name': name,
    'image': image,
    'price': price,
    'quantity': quantity,
    'createAt': createAt.toIso8601String(),
    'updateAt': updateAt.toIso8601String(),
    'deleteAt': deleteAt.toIso8601String(),
  };
}