import 'dart:convert';
import 'package:fruitshub/models/address.dart';
import 'package:http/http.dart' as http;

class AddressManagement {
  Future<http.Response> deleteAddress({
    required int id,
    required String token,
  }) async {
    try {
      http.Response response = await http.delete(
        Uri.parse(
          'https://fruitappbackendspringbootrestfullapijava.onrender.com/api/v1/addresses/delete-by-id/$id',
        ),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 204 || response.statusCode == 205) {
        return response;
      } else {
        throw Exception('حدث خطا اثناء اضافه عنوان جديد');
      }
    } on Exception {
      throw Exception('حدث خطا غير متوقع يرجي المحاوله مره اخري');
    }
  }

  Future<http.Response> updateAddress({
    required AddressModel address,
    required bool isSetDefult,
    required String token,
  }) async {
    try {
      http.Response response = await http.put(
        Uri.parse(
          'https://fruitappbackendspringbootrestfullapijava.onrender.com/api/v1/addresses/update-by-id/${address.id}',
        ),
        body: jsonEncode(
          {
            "fullName": address.fullName,
            "city": address.city,
            "streetAddress": address.streetAddress,
            "apartmentNumber": address.apartmentNumber,
            "floorNumber": address.floorNumber,
            "phoneNumber": address.phoneNumber,
            "zipCode": address.postalCode,
            "default": isSetDefult ? true : address.isDefault,
          },
        ),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        throw Exception('حدث خطا اثناء اضافه عنوان جديد');
      }
    } on Exception {
      throw Exception('حدث خطا غير متوقع يرجي المحاوله مره اخري');
    }
  }

  Future<http.Response> addNewAddress({
    required AddressModel address,
    required String token,
  }) async {
    try {
      http.Response response = await http.post(
        Uri.parse(
          'https://fruitappbackendspringbootrestfullapijava.onrender.com/api/v1/addresses/create',
        ),
        body: jsonEncode(
          {
            "fullName": address.fullName,
            "city": address.city,
            "streetAddress": address.streetAddress,
            "apartmentNumber": address.apartmentNumber,
            "floorNumber": address.floorNumber,
            "phoneNumber": address.phoneNumber,
            "zipCode": address.postalCode,
            "default": address.isDefault,
          },
        ),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        throw Exception('حدث خطا اثناء اضافه عنوان جديد');
      }
    } on Exception {
      throw Exception('حدث خطا غير متوقع يرجي المحاوله مره اخري');
    }
  }

  Future<List<AddressModel>> getAllAddresses({
    required String token,
  }) async {
    http.Response response = await http.get(
      Uri.parse(
        'https://fruitappbackendspringbootrestfullapijava.onrender.com/api/v1/addresses/user',
      ),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json; charset=UTF-8',
        'accept': 'application/json; charset=UTF-8',
      },
    );

    print(response.body);

    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        List<dynamic> jsonResponse = jsonDecode(response.body)['addresses'];
        List<AddressModel> addresses =
            jsonResponse.map((item) => AddressModel.fromJson(item)).toList();
        jsonResponse.clear();
        return addresses;
      } else {
        throw Exception('حدث خطأ أثناء إضافة عنوان جديد');
      }
    } catch (e) {
      print(e);
      throw Exception('حدث خطأ غير متوقع يرجى المحاولة مرة أخرى');
    }
  }
}
