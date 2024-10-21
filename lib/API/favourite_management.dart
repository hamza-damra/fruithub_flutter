import 'dart:convert';

import 'package:fruitshub/models/product.dart';
import 'package:http/http.dart' as http;

class FavouriteManagement {
  Future<http.Response> removeFromFavourite(
      {required String token, required int productId}) async {
    try {
      final http.Response response = await http.delete(
        Uri.parse(
          'https://fruitappbackendspringbootrestfullapijava.onrender.com/api/wishlist/remove?productId=$productId',
        ),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json; charset=UTF-8',
          'accept': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 500) {
        throw Exception(
            'Failed to remove from favourites: HTTP error From server: ${response.statusCode}');
      }

      if (response.statusCode == 400) {
        throw Exception(
            'Failed to remove from favourites: HTTP error $response.statusCode');
      }

      return response;
    } catch (e) {
      throw Exception('Failed to remove from favourites: $e');
    }
  }

  Future<http.Response> addToFavourite(
      {required String token, required int productId}) async {
    try {
      final http.Response response = await http.post(
        Uri.parse(
            'https://fruitappbackendspringbootrestfullapijava.onrender.com/api/wishlist/add?productId=$productId'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 500) {
        throw Exception(
            'Failed to add to favourites: HTTP error From server: ${response.statusCode}');
      }

      if (response.statusCode == 400) {
        throw Exception(
            'Failed to add to favourites: HTTP error ${response.statusCode} and reposnse message: ${response.body}');
      }

      return response;
    } catch (e) {
      throw Exception('Failed to add to favourites: $e');
    }
  }

  Future<List<Product>> getFavourites({
    required String token,
  }) async {
    try {
      http.Response response = await http.get(
        Uri.parse(
          'https://fruitappbackendspringbootrestfullapijava.onrender.com/api/wishlist/user',
        ),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json; charset=UTF-8',
          'accept': 'application/json; charset=UTF-8',
        },
      );

      print(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        List<dynamic> jsonResponse = jsonDecode(response.body)['items'];
        List<Product> items = jsonResponse
            .map((json) => Product.fromJson(json as Map<String, dynamic>))
            .toList();
        return items;
      } else {
        throw Exception('فشل تحميل البيانات');
      }
    } on Exception catch (e) {
      print(e.toString());
      throw Exception('حدث خطا غير متوقع يرجي المحاوله مره اخري');
    }
  }
}
