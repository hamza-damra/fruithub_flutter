import 'dart:convert';
import 'package:fruitshub/models/cartItem.dart';
import 'package:http/http.dart' as http;

class CartManagement {
  Future<http.Response> addToCart({
    required String token,
    required int productId,
    int? quantity,
  }) async {
    try {
      http.Response response = await http.post(
        Uri.parse(
          'https://fruitappbackendspringbootrestfullapijava.onrender.com/api/cart/add',
        ),
        body: jsonEncode({
          "productId": productId,
          "quantity": quantity ??= 1,
        }),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json; charset=UTF-8',
          'accept': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 404) {}
      print(response.body);
      return response;
    } catch (e) {
      throw Exception('حدث خطا غير متوقع يرجي المحاوله مره اخري');
    }
  }

  Future<List<Cartitem>> getCartItems({
    required String token,
  }) async {
    try {
      http.Response response = await http.get(
        Uri.parse(
          'https://fruitappbackendspringbootrestfullapijava.onrender.com/api/cart/get',
        ),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json; charset=UTF-8',
          'accept': 'application/json; charset=UTF-8',
        },
      );
      print(jsonDecode(response.body));

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.body)['items'];

        List<Cartitem> items = jsonResponse
            .map(
              (json) => Cartitem.fromJson(json),
            )
            .toList();
        jsonResponse.clear();
        return items;
      } else {
        throw Exception('فشل تحميل البيانات');
      }
    } catch (e) {
      throw Exception('حدث خطا غير متوقع يرجي المحاوله مره اخري');
    }
  }

  Future<http.Response> deleteFromCart({
    required String token,
    required int id,
  }) async {
    try {
      http.Response response = await http.delete(
        Uri.parse(
          'https://fruitappbackendspringbootrestfullapijava.onrender.com/api/cart/$id',
        ),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      print(response.body);
      return response;
    } catch (e) {
      throw Exception('حدث خطا غير متوقع يرجي المحاوله مره اخري');
    }
  }

  Future<http.Response> increaseProductQuantity({
    required String token,
    required int id,
  }) async {
    try {
      http.Response response = await http.post(
        Uri.parse(
          'https://fruitappbackendspringbootrestfullapijava.onrender.com/api/cart/increase-quantity/$id',
        ),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      return response;
    } catch (e) {
      throw Exception('حدث خطا غير متوقع يرجي المحاوله مره اخري');
    }
  }

  Future<http.Response> decreaseProductQuantity({
    required String token,
    required int id,
  }) async {
    try {
      http.Response response = await http.post(
        Uri.parse(
          'https://fruitappbackendspringbootrestfullapijava.onrender.com/api/cart/decrease-quantity/$id',
        ),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      return response;
    } catch (e) {
      throw Exception('حدث خطا غير متوقع يرجي المحاوله مره اخري');
    }
  }
}
