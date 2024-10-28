import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:fruitshub/models/product.dart';
import 'package:http/http.dart' as http;

class ProductsManagement {
  Future<http.Response> getAllProducts({
    required String token,
    required String itemsPerPage,
    required String pageNumber,
    required String sortDirection,
    required String sortBy,
  }) async {
    try {
      http.Response response = await http.get(
        Uri.parse(
          'https://fruitappbackendspringbootrestfullapijava.onrender.com/api/v1/products/all?itemsPerPage=$itemsPerPage&currentPage=$pageNumber&sortBy=$sortBy&sortDir=$sortDirection',
        ),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json; charset=UTF-8',
          'accept': 'application/json; charset=UTF-8',
        },
      );

      if (kDebugMode) {
        print(response.body);
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Map<String, dynamic> decodeedResponse = jsonDecode(response.body);
        // Map<String, dynamic> jsonResponse = {
        //   'items': decodeedResponse['items']
        //       .map((json) => Product.fromJson(json as Map<String, dynamic>))
        //       .toList(),
        //   'lastPage': decodeedResponse['lastPage'],
        // };
        // decodeedResponse.clear();
        return response;
      } else {
        throw Exception('فشل تحميل البيانات');
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      throw Exception('حدث خطا غير متوقع يرجي المحاوله مره اخري');
    }
  }

  Future<List<Product>> getFilteredProducts({
    required double min,
    required double max,
    required String token,
  }) async {
    try {
      final response = await http.get(
        Uri.parse(
          'https://fruitappbackendspringbootrestfullapijava.onrender.com/api/v1/products/filtered?minPrice=$max&maxPrice=$min',
        ),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json; charset=UTF-8',
          'accept': 'application/json; charset=UTF-8',
        },
      );
      print(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        if (data.containsKey('items')) {
          List<Product> items = (data['items'] as List)
              .map((json) => Product.fromJson(json as Map<String, dynamic>))
              .toList();
          return items;
        } else {
          throw Exception(
              'Unexpected response format: "items" key is missing.');
        }
      } else {
        throw Exception('فشل تحميل البيانات');
      }
    } catch (e) {
      throw Exception('حدث خطا غير متوقع يرجي المحاوله مره اخري');
    }
  }
}
