class FavoriteModel {
  final String name;
  final String description;
  final String price;
  final String image;
  final String rating;

  FavoriteModel({
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.rating,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'image': image,
      'rating': rating,
    };
  }

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    return FavoriteModel(
      name: json['name'],
      description: json['description'],
      price: json['price'],
      image: json['image'],
      rating: json['rating'],
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is FavoriteModel && runtimeType == other.runtimeType && name == other.name;

  @override
  int get hashCode => name.hashCode;
}
