import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruitshub/search/search_bloc.dart';

class Defult extends StatefulWidget {
  Defult({
    super.key,
    required this.query,
  });

  String query;

  @override
  State<Defult> createState() => _DefultState();
}

class _DefultState extends State<Defult> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Column(
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
        SizedBox(height: screenHeight * 0.02),
        ElevatedButton(
          onPressed: () {
            if (widget.query.isEmpty) {
              context.read<SearchCubit>().showSearchResult('error');
              widget.query = '';
            } else {
              context.read<SearchCubit>().showSearchResult('search');
              widget.query = '';
            }
          },
          child: const Text('ابحث الان'),
        ),
      ],
    );
  }
}
