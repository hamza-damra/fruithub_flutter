import 'package:flutter/material.dart';
import 'package:fruitshub/widgets/product_card.dart';

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
    return Expanded(
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.04,
          ),
          Expanded(
            child: GridView.builder(
              itemCount: 50,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2 / 2.5,
                mainAxisSpacing: 8,
                crossAxisSpacing: MediaQuery.of(context).size.width * 0.04,
              ),
              itemBuilder: (context, index) {
                return ProductCard(
                  screenWidth: screenWidth,
                  screenHeight: screenHeight,
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
