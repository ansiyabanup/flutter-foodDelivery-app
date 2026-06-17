class Product {
  final int id;
  final String name;
  final double price;
  final String image;
  final bool available;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.available,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['product_id'],
      name: json['name'],
      price: (json['price'] as num).toDouble(),
      image: json['image'],
      available: json['availability'],
    );
  }
}
//wtjo4w5yoqv45iu