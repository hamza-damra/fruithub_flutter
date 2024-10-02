class Cartitem {
  final int id;
  final int productId;
  int quantity;
  final String productName;
  final String productImageUrl;
  final double price;
  int stockQuantity;

  Cartitem({
    required this.id,
    required this.productId,
    required this.quantity,
    required this.productName,
    required this.stockQuantity,
    required this.productImageUrl,
    required this.price,
  });

  factory Cartitem.fromJson(json) {
    return Cartitem(
      id: json['id'],
      productId: json['productId'],
      quantity: json['quantity'],
      stockQuantity: json['stockQuantity'],
      productName: json['productName'],
      productImageUrl: json['productImageUrl'],
      price: json['price'],
    );
  }
}
