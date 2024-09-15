import 'package:flutter/material.dart';
import 'package:fruitshub/globals.dart';
import 'package:fruitshub/models/product.dart';
import 'package:fruitshub/widgets/most_selling_builder.dart';

class Searchdelegate extends SearchDelegate {
  List<Product> filter = [];
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.cancel_rounded),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return GestureDetector(
      onTap: () {
        close(context, null);
        filter = [];
      },
      child: const Padding(
        padding: EdgeInsets.all(17),
        child: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: Colors.black,
        ),
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    if (query.isEmpty) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.all(screenWidth * 0.03),
                child: Image.asset(
                  'assets/images/search food.png',
                  width: screenWidth * 0.6,
                  height: screenHeight * 0.25,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            const Text(
              'قم بالبحث عن الطعام الان',
              style: TextStyle(
                fontFamily: 'Cairo',
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    } else {
      filter = myProducts
          .where((product) =>
              product.name.toLowerCase().contains(query.toLowerCase()))
          .toList();

      if (filter.isNotEmpty) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: MostSellingBuilder(
            products: filter,
            showText: false,
          ),
        );
      } else {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(screenWidth * 0.03),
                  child: Image.asset(
                    'assets/images/noResult.png',
                    width: screenWidth * 0.6,
                    height: screenHeight * 0.25,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      query,
                      style: const TextStyle(
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      ' لا يوجد نتائج بحث عن',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }
    }
  }
}
