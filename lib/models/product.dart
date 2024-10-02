class Product {
  // category
  final int id;
  final int categoryId;

  // product base info
  final String name;
  final double price;
  final String imageUrl;
  bool isfavourite;

  // product details
  int myQuantity = 1;
  final String description;
  final int stockQuantity;
  int quantityInCart;
  final String expiryMonths;
  final int caloriesPer100Gram;
  bool isCartExist;
  int orderCount;

  // rating
  final int counterFiveStars;
  final int counterFourStars;
  final int counterThreeStars;
  final int counterTwoStars;
  final int counterOneStars;

  Product({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.isfavourite,
    required this.description,
    required this.stockQuantity,
    required this.orderCount,
    required this.quantityInCart,
    required this.expiryMonths,
    required this.caloriesPer100Gram,
    required this.isCartExist,
    required this.counterFiveStars,
    required this.counterFourStars,
    required this.counterThreeStars,
    required this.counterTwoStars,
    required this.counterOneStars,
  });

  // myRating - comments

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      categoryId: json['categoryId'],
      name: json['name'],
      price: json['price'],
      orderCount: json['orderCount'],
      imageUrl: json['imageUrl'],
      isfavourite: json['isFavorite'],
      description: json['description'],
      stockQuantity: json['stockQuantity'],
      quantityInCart: json['quantityInCart'],
      expiryMonths: json['expirationDate'],
      caloriesPer100Gram: json['caloriesPer100Grams'],
      isCartExist: json['isInCart'],
      counterFiveStars: json['counterFiveStars'],
      counterFourStars: json['counterFourStars'],
      counterThreeStars: json['counterThreeStars'],
      counterTwoStars: json['counterTwoStars'],
      counterOneStars: json['counterOneStars'],
    );
  }
}
