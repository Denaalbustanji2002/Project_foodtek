class CartModel {
  final String title;
  final double price;
  int count;
  final String? imagePath;

  CartModel({
    required this.title,
    required this.price,
    this.count = 1,
    this.imagePath,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      title: json['title'],
      price: json['price'],
      count: json['count'],
      imagePath: json['imagePath'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'price': price,
      'count': count,
      'imagePath': imagePath,
    };
  }
}
