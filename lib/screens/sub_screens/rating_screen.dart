import 'package:flutter/material.dart';
import 'package:fruitshub/models/product.dart';

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
    );
  }
}
