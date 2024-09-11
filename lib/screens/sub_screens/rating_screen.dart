import 'package:flutter/material.dart';
import 'package:fruitshub/models/product.dart';
import 'package:rating_summary/rating_summary.dart';

class RatingScreen extends StatefulWidget {
  const RatingScreen({
    super.key,
    required this.product,
  });

  final Product product;

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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'المراجعه',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: RatingSummary(
                counter: counter,
                average: average,
                showAverage: true,
                counterFiveStars: widget.product.counterFiveStars,
                counterFourStars: widget.product.counterFourStars,
                counterThreeStars: widget.product.counterThreeStars,
                counterTwoStars: widget.product.counterTwoStars,
                counterOneStars: widget.product.counterOneStars,
              ),
            ),
          )
        ],
      ),
    );
  }
}
