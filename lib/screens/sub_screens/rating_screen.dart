import 'package:flutter/material.dart';
import 'package:fruitshub/models/product.dart';
import 'package:fruitshub/widgets/my_textfield.dart';
import 'package:fruitshub/widgets/rating_comment.dart';
import 'package:rating_summary/rating_summary.dart';

class RatingScreen extends StatefulWidget {
  const RatingScreen({
    super.key,
    required this.product,
    required this.average,
    required this.totalRating,
  });

  final Product product;
  final Widget average;
  final int totalRating;

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  @override
  Widget build(BuildContext context) {
    int counter = (widget.product.counterFiveStars +
        widget.product.counterFourStars +
        widget.product.counterThreeStars +
        widget.product.counterTwoStars +
        widget.product.counterOneStars);

    double average = double.parse(
      (((5 * widget.product.counterFiveStars) +
                  (4 * widget.product.counterFourStars) +
                  (3 * widget.product.counterThreeStars) +
                  (2 * widget.product.counterTwoStars) +
                  (1 * widget.product.counterOneStars)) /
              (widget.product.counterFiveStars +
                  widget.product.counterFourStars +
                  widget.product.counterThreeStars +
                  widget.product.counterTwoStars +
                  widget.product.counterOneStars))
          .toStringAsFixed(1),
    );
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'المراجعه',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MyTextField(
              hint: 'اكتب تعليق',
              showprefixIcon: false,
              align: TextAlign.right,
              suffixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: CircleAvatar(
                  radius: screenWidth * 0.03,
                  backgroundImage: const AssetImage('assets/images/avatar.jpg'),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text(
                  'مراجعه',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  " ${widget.totalRating}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'الملخص',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Center(
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RatingSummary(
                      counter: counter,
                      average: average,
                      showAverage: false,
                      counterFiveStars: widget.product.counterFiveStars,
                      counterFourStars: widget.product.counterFourStars,
                      counterThreeStars: widget.product.counterThreeStars,
                      counterTwoStars: widget.product.counterTwoStars,
                      counterOneStars: widget.product.counterOneStars,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: widget.average,
                ),
              ],
            ),
          ),
          const RatingComment(),
        ],
      ),
    );
  }
}
