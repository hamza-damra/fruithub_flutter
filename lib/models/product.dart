class Product {
  final int id;
  final String name;
  final String description;
  final double price;
  final int quantity;
  final String imageUrl;
  final int categoryId;
  final double totalRating;
  final int counterFiveStars;
  final int counterFourStars;
  final int counterThreeStars;
  final int counterTwoStars;
  final int counterOneStars;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.quantity,
    required this.imageUrl,
    required this.categoryId,
    required this.totalRating,
    required this.counterFiveStars,
    required this.counterFourStars,
    required this.counterThreeStars,
    required this.counterTwoStars,
    required this.counterOneStars,
  });
}
