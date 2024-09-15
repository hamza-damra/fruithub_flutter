import 'package:flutter/material.dart';

class RatingComment extends StatelessWidget {
  const RatingComment({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Expanded(
      child: ListView.builder(
          itemCount: 15,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(200),
                            child: Image.asset(
                              'assets/images/avatar.jpg',
                              width: screenWidth * .15,
                            ),
                          ),
                          Positioned(
                            top: screenWidth * .08,
                            left: screenWidth * .10,
                            child: Container(
                              width: screenWidth * .07,
                              height: screenWidth * .07,
                              decoration: BoxDecoration(
                                color: const Color(0xffFFC529),
                                borderRadius: BorderRadius.circular(7),
                              ),
                              child: Center(
                                child: Text(
                                  '5',
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.043,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                          left: 20,
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Ahmed Amr',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '25/06/2020',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 9),
                  const Text(
                    'ثسخحبنتصثحخهبتكخهستفسخث4هعفاخسعثهلمشلكاكخهشثقتلقفتسفاتخكهسثقتلكثشست',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
