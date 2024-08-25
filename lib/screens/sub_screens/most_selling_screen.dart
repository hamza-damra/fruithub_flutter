import 'package:flutter/material.dart';
import 'package:fruitshub/widgets/most_selling_builder.dart';

class MostSellingScreen extends StatelessWidget {
  const MostSellingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        title: const Text(
          'المنتجات الأكثر مبيعًا',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: MostSelling(
        screenHeight: screenHeight,
        screenWidth: screenWidth,
      ),
    );
  }
}
