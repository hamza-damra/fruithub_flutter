class AddressModel {
  final int id;
  String fullName;
  String city;
  String streetAddress;
  String apartmentNumber;
  String floorNumber;
  String phoneNumber;
  String postalCode;
  bool isDefault;

  AddressModel({
    required this.id,
    required this.fullName,
    required this.city,
    required this.streetAddress,
    required this.apartmentNumber,
    required this.floorNumber,
    required this.phoneNumber,
    required this.postalCode,
    required this.isDefault,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'],
      fullName: json['fullName'],
      city: json['city'],
      streetAddress: json['streetAddress'],
      apartmentNumber: json['apartmentNumber'],
      floorNumber: json['floorNumber'],
      phoneNumber: json['phoneNumber'],
      postalCode: json['zipCode'],
      isDefault: json['default'],
    );
  }
}
