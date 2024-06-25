/// * The product identifier is an important concept and can have its own type.
typedef ProductID = String;

/// Class representing a product.
class Product {
  const Product({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.price,
    required this.availableQuantity,
    this.avgRating = 0,
    this.numRatings = 0,
  });

  /// Unique product id
  final ProductID id;
  final String imageUrl;
  final String title;
  final String description;
  final double price;
  final int availableQuantity;
  final double avgRating;
  final int numRatings;

  @override
  String toString() {
    return 'Product{id: $id, imageUrl: $imageUrl, title: $title, description: $description, price: $price, availableQuantity: $availableQuantity, avgRating: $avgRating, numRatings: $numRatings}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Product &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          imageUrl == other.imageUrl &&
          title == other.title &&
          description == other.description &&
          price == other.price &&
          availableQuantity == other.availableQuantity &&
          avgRating == other.avgRating &&
          numRatings == other.numRatings;

  @override
  int get hashCode =>
      id.hashCode ^
      imageUrl.hashCode ^
      title.hashCode ^
      description.hashCode ^
      price.hashCode ^
      availableQuantity.hashCode ^
      avgRating.hashCode ^
      numRatings.hashCode;
}
