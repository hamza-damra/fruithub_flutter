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
}
