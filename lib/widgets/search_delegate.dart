import 'package:flutter/material.dart';
import 'package:fruitshub/models/product.dart';
import 'package:fruitshub/widgets/most_selling_builder.dart';

class Searchdelegate extends SearchDelegate {
  List<Product> products = [
    Product(
      id: 1,
      name: 'فواكه',
      description: 'fruits description',
      price: 20,
      stockQuantity: 1,
      isfavourite: true,
      imageUrl:
          'https://www.fruitsmith.com/pub/media/mageplaza/blog/post/s/e/seedless_fruits.jpg',
      categoryId: 2,
      counterFiveStars: 3,
      counterFourStars: 6,
      userQuantity: 1,
      counterThreeStars: 7,
      counterTwoStars: 3,
      counterOneStars: 2,
      isCartExist: true,
      caloriesPer100Gram: 50,
      myRating: null,
      expiryMonths: 6,
    ),
    Product(
      id: 1,
      name: 'سلطه فواكه',
      description: 'fruit salad description',
      price: 30,
      stockQuantity: 1,
      isfavourite: true,
      imageUrl:
          'https://images.healthshots.com/healthshots/en/uploads/2022/04/17151621/fruit-salad.jpg',
      categoryId: 2,
      counterFiveStars: 3,
      counterFourStars: 6,
      counterThreeStars: 7,
      counterTwoStars: 3,
      userQuantity: 1,
      counterOneStars: 2,
      isCartExist: false,
      caloriesPer100Gram: 80,
      myRating: null,
      expiryMonths: 6,
    ),
    Product(
      id: 1,
      name: 'مانجا',
      description: 'mango description',
      price: 25,
      stockQuantity: 1,
      isfavourite: false,
      imageUrl:
          'https://hips.hearstapps.com/hmg-prod/images/mango-fruit-sugar-1530136260.jpg?crop=1xw:1xh;center,top&resize=640:*',
      categoryId: 2,
      counterFiveStars: 3,
      counterFourStars: 6,
      userQuantity: 1,
      counterThreeStars: 7,
      counterTwoStars: 3,
      counterOneStars: 2,
      caloriesPer100Gram: 40,
      myRating: 'جيد',
      isCartExist: true,
      expiryMonths: 6,
    ),
    Product(
      id: 1,
      name: 'كريز',
      description: 'Cherries description',
      price: 40,
      stockQuantity: 1,
      isfavourite: false,
      imageUrl:
          'https://hips.hearstapps.com/hmg-prod/images/cherries-sugar-fruit-1530136329.jpg?crop=1xw:1xh;center,top&resize=640:*',
      categoryId: 2,
      counterFiveStars: 3,
      counterFourStars: 6,
      counterThreeStars: 7,
      userQuantity: 1,
      counterTwoStars: 3,
      counterOneStars: 2,
      caloriesPer100Gram: 30,
      myRating: 'جيد',
      isCartExist: false,
      expiryMonths: 6,
    ),
  ];
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
      filter = products
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
