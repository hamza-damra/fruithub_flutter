import 'package:flutter/material.dart';
import 'package:fruitshub/models/product.dart';

Widget? products;

List<Product> mostSellingProducts = [
  Product(
    id: 1,
    name: 'فواكه',
    description: 'fruits description',
    price: 20,
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
    price: 25,
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
    price: 40,
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
