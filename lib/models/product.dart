class Product {
  final int id;
  final String name;
  final String description;
  final double price;
  final int stockQuantity;
  final String imageUrl;
  final int categoryId;
  final double totalRating;
  final int counterFiveStars;
  final int counterFourStars;
  final int counterThreeStars;
  final int counterTwoStars;
  final int counterOneStars;
  final int expiryMonths;
  final int caloriesPer100Gram;
  bool isfavourite = false;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.stockQuantity,
    required this.isfavourite,
    required this.imageUrl,
    required this.categoryId,
    required this.totalRating,
    required this.counterFiveStars,
    required this.counterFourStars,
    required this.counterThreeStars,
    required this.counterTwoStars,
    required this.counterOneStars,
    required this.expiryMonths,
    required this.caloriesPer100Gram,
  });
}
