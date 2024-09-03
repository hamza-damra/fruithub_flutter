import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fruitshub/models/product.dart';
import 'package:fruitshub/screens/sub_screens/rating_screen.dart';
import 'package:fruitshub/widgets/product_info.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: const Color(0xffF3F5F7),
        surfaceTintColor: const Color(0xffF3F5F7),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: EdgeInsets.all(screenWidth * 0.02), // Responsive padding
            child: Container(
              width: screenWidth * 0.1,
              height: screenWidth * 0.1,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: screenWidth * 0.07, // Responsive icon size
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        // Ensures scrollability on smaller screens
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                Container(
                  width: screenWidth,
                  height: screenHeight * 0.30,
                  decoration: const BoxDecoration(
                    color: Color(0xffF3F5F7),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(200),
                      bottomRight: Radius.circular(200),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Image.network(
                    product.imageUrl,
                    width: screenWidth * 0.45,
                    height: screenHeight * 0.25,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.02),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: screenWidth * 0.11,
                        height: screenWidth * 0.11,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xffF3F5F7),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.02,
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            child: Container(
                              height: screenHeight * 0.003,
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.04),
                      Text(
                        product.quantity.toString(),
                        style: TextStyle(
                          fontSize: screenWidth * 0.045,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.04),
                      Container(
                        width: screenWidth * 0.11,
                        height: screenWidth * 0.11,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xff1B5E37),
                        ),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: screenWidth * 0.05, // Adjust icon size
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        product.name,
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.w700,
                          color: const Color(0xff0C0D0D),
                          fontSize: screenWidth * 0.045,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            'الكيلو',
                            style: TextStyle(
                              color: const Color(0xffF8C76D),
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Cairo',
                              fontSize: screenWidth * 0.04,
                            ),
                          ),
                          Text(
                            '/',
                            style: TextStyle(
                              color: const Color(0xffF8C76D),
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Cairo',
                              fontSize: screenWidth * 0.04,
                            ),
                          ),
                          Text(
                            'جنية',
                            style: TextStyle(
                              color: const Color(0xffF4A91F),
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Cairo',
                              fontSize: screenWidth * 0.04,
                            ),
                          ),
                          Text(
                            product.price.toString(),
                            style: TextStyle(
                              color: const Color(0xffF4A91F),
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Cairo',
                              fontSize: screenWidth * 0.04,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                right: screenWidth * 0.03,
                top: screenHeight * 0.01,
                bottom: screenHeight * 0.01,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Spacer(flex: 500),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RatingScreen(
                            product: product,
                          ),
                        ),
                      );
                    },
                    child: Text(
                      'المراجعه',
                      style: TextStyle(
                        fontSize: screenWidth * 0.04,
                        color: const Color(0xff1B5E37),
                        fontWeight: FontWeight.w700,
                        decoration: TextDecoration.underline,
                        decorationColor: const Color(0xff1B5E37),
                        decorationThickness: 2.0,
                      ),
                    ),
                  ),
                  const Spacer(flex: 20),
                  Text(
                    '(${product.counterFiveStars + product.counterFourStars + product.counterThreeStars + product.counterTwoStars + product.counterOneStars})',
                    style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      color: const Color(0xff9796A1),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const Spacer(flex: 20),
                  Text(
                    product.totalRating.toString(),
                    style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(flex: 20),
                  SvgPicture.asset(
                    'assets/images/ratingStar.svg',
                    width: screenWidth * 0.05,
                    height: screenWidth * 0.05,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                right: screenWidth * 0.03,
                left: screenWidth * 0.03,
                bottom: screenHeight * 0.02,
              ),
              child: Text(
                product.description,
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: const Color(0xff979899),
                  fontWeight: FontWeight.w400,
                  fontSize: screenWidth * 0.045,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Expanded(
                      child: ProductInfo(
                        image: 'assets/images/organic.svg',
                        title: Text(
                          '100%',
                          style: TextStyle(
                            color: Color(0xff23AA49),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        subTitle: Text(
                          'اوجانيك',
                          style: TextStyle(
                            color: Color(0xff979899),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ProductInfo(
                        image: 'assets/images/calendar.svg',
                        title: Expanded(
                          child: Row(
                            children: [
                              const Text(
                                'اشهر',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: Color(0xff23AA49),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                ' ${product.expiryMonths}',
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                  color: Color(0xff23AA49),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        subTitle: const Text(
                          'الصلاحيه',
                          style: TextStyle(
                            color: Color(0xff979899),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RatingScreen(
                              product: product,
                            ),
                          ),
                        );
                      },
                      child: ProductInfo(
                        image: 'assets/images/reviews.svg',
                        title: Text(
                          '${product.totalRating} (${product.counterFiveStars + product.counterFourStars + product.counterThreeStars + product.counterTwoStars + product.counterOneStars})',
                          style: const TextStyle(
                            color: Color(0xff23AA49),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        subTitle: const Text(
                          'Reviews',
                          style: TextStyle(
                            color: Color(0xff979899),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ProductInfo(
                      image: 'assets/images/cals.svg',
                      title: Row(
                        children: [
                          const Text(
                            'كالوري',
                            style: TextStyle(
                              color: Color(0xff23AA49),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            ' ${product.caloriesPer100Gram}',
                            style: const TextStyle(
                              color: Color(0xff23AA49),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      subTitle: const Row(
                        children: [
                          Text(
                            'جرام',
                            style: TextStyle(
                              color: Color(0xff979899),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            ' 100',
                            style: TextStyle(
                              color: Color(0xff979899),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      Color(0xff1B5E37),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'أضف الي السلة',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 4,
            ),
          ],
        ),
      ),
    );
  }
}
