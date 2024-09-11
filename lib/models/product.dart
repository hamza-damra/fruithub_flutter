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
  final String description;
  final int stockQuantity;
  final int expiryMonths;
  final int caloriesPer100Gram;
  bool isCartExist;

  // rating
  final String?
      myRating; // add (null defult value if user has no rating to product)
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
    required this.expiryMonths,
    required this.caloriesPer100Gram,
    required this.isCartExist,
    required this.myRating,
    required this.counterFiveStars,
    required this.counterFourStars,
    required this.counterThreeStars,
    required this.counterTwoStars,
    required this.counterOneStars,
  });

  factory Product.fromJson(json) {
    return Product(
      id: json['content'],
      categoryId: json['content'],
      name: json['content']['name'],
      price: json['content']['price'],
      imageUrl: json['content']['imageUrl'],
      isfavourite: json['content']['favorite'],
      description: json['content']['description'],
      stockQuantity: json['content']['stockQuantity'],
      expiryMonths: json[
          'content'], /////// don't know if it's date type if string or date time
      caloriesPer100Gram: json['content']['calories'],
      isCartExist: json['content']['inCart'],
      myRating: json['content'], /////// not added to backend yet
      counterFiveStars: json['content']['counterFiveStars'],
      counterFourStars: json['content']['counterFourStars'],
      counterThreeStars: json['content']['counterThreeStars'],
      counterTwoStars: json['content']['counterTwoStars'],
      counterOneStars: json['content']['counterOneStars'],
    );
  }
}
