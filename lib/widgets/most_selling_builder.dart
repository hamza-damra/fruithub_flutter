import 'package:flutter/material.dart';
import 'package:fruitshub/models/product.dart';
import 'package:fruitshub/screens/sub_screens/details_screen.dart';
import 'package:fruitshub/widgets/most_selling_product_card.dart';

class MostSelling extends StatelessWidget {
  const MostSelling({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
  });

  final double screenWidth;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    List<Product> products = [
      Product(
        id: 1,
        name: 'فواكه',
        description: 'fruits description',
        price: 30,
        quantity: 1,
        imageUrl:
            'https://www.fruitsmith.com/pub/media/mageplaza/blog/post/s/e/seedless_fruits.jpg',
        categoryId: 2,
        totalRating: 3.5,
        counterFiveStars: 3,
        counterFourStars: 6,
        counterThreeStars: 7,
        counterTwoStars: 3,
        counterOneStars: 2,
      ),
      Product(
        id: 1,
        name: 'سلطه فواكه',
        description: 'fruit salad description',
        price: 30,
        quantity: 1,
        imageUrl:
            'https://images.healthshots.com/healthshots/en/uploads/2022/04/17151621/fruit-salad.jpg',
        categoryId: 2,
        totalRating: 3.5,
        counterFiveStars: 3,
        counterFourStars: 6,
        counterThreeStars: 7,
        counterTwoStars: 3,
        counterOneStars: 2,
      ),
      Product(
        id: 1,
        name: 'مانجا',
        description: 'mango description',
        price: 30,
        quantity: 1,
        imageUrl:
            'https://hips.hearstapps.com/hmg-prod/images/mango-fruit-sugar-1530136260.jpg?crop=1xw:1xh;center,top&resize=640:*',
        categoryId: 2,
        totalRating: 3.5,
        counterFiveStars: 3,
        counterFourStars: 6,
        counterThreeStars: 7,
        counterTwoStars: 3,
        counterOneStars: 2,
      ),
      Product(
        id: 1,
        name: 'كريز',
        description: 'Cherries description',
        price: 30,
        quantity: 1,
        imageUrl:
            'https://hips.hearstapps.com/hmg-prod/images/cherries-sugar-fruit-1530136329.jpg?crop=1xw:1xh;center,top&resize=640:*',
        categoryId: 2,
        totalRating: 3.5,
        counterFiveStars: 3,
        counterFourStars: 6,
        counterThreeStars: 7,
        counterTwoStars: 3,
        counterOneStars: 2,
      ),
    ];
    return Expanded(
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.04,
          ),
          Expanded(
            child: GridView.builder(
              itemCount: products.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2 / 2.5,
                mainAxisSpacing: 8,
                crossAxisSpacing: MediaQuery.of(context).size.width * 0.04,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsScreen(
                          product: products[index],
                        ),
                      ),
                    );
                  },
                  child: ProductCard(
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                    product: products[index],
                  ),
                );
              },
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.04,
          ),
        ],
      ),
    );
  }
}
