class Product {
  const Product({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.isInStock,
  });

  final String id;
  final String name;
  final String imageUrl;
  final num price;
  final bool isInStock;
}
