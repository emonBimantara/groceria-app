class ProductModel {
  final String id;
  final String title;
  final List<String> imageUrls;
  final String description;
  final String category;
  final double price;

  ProductModel({
    required this.id,
    required this.title,
    required this.imageUrls,
    required this.description,
    required this.price,
    required this.category,
  });

  factory ProductModel.fromFireStore(String id, Map<String, dynamic> data) {
    return ProductModel(
      id: id,
      title: data['title'] ?? 'No Title',
      price: (data['price'] as num?)?.toDouble() ?? 0.0,
      imageUrls: List<String>.from(data['image'] ?? []),
      description: data['description'] ?? 'No Description',
      category: data['category'] ?? 'No category',
    );
  }
}
