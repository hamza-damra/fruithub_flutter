import 'dart:convert';

import 'package:fruitshub/models/product.dart';
import 'package:http/http.dart' as http;

class SearchManagement {
  Future<List<Product>> searchProducts(
      {required String token, required String product}) async {
    try {
      http.Response response = await http.get(
        Uri.parse(
          'https://fruitappbackendspringbootrestfullapijava.onrender.com/api/v1/products/search?keyword=$product',
        ),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        List<dynamic> jsonResponse = jsonDecode(response.body);
        List<Product> items = jsonResponse
            .map((json) => Product.fromJson(json as Map<String, dynamic>))
            .toList();
        jsonResponse.clear();
        return items;
      } else {
        throw Exception('فشل تحميل البيانات');
      }
    } on Exception {
      throw Exception('حدث خطا غير متوقع يرجي المحاوله مره اخري');
    }
  }
}
