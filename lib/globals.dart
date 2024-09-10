import 'package:flutter/material.dart';
import 'package:fruitshub/models/product.dart';

// filter vars
int maxNum = 0;
int minNum = 0;
TextEditingController start = TextEditingController();
TextEditingController end = TextEditingController();

// same list for both الرئيسيه and المنتجات and المنتجات الأكثر مبيعًا screens
List<Product> mostSellingProducts = [
  Product(
    id: 1,
    name: 'فواكه',
    description:
        'مجموعة متنوعة من الفواكه الطازجة والمغذية، مثالية لوجبات خفيفة صحية وتحضير العصائر',
    price: 20,
    stockQuantity: 100,
    isfavourite: true,
    imageUrl:
        'https://www.fruitsmith.com/pub/media/mageplaza/blog/post/s/e/seedless_fruits.jpg',
    categoryId: 2,
    totalRating: 3.5,
    counterFiveStars: 3,
    counterFourStars: 6,
    counterThreeStars: 7,
    counterTwoStars: 3,
    counterOneStars: 2,
    caloriesPer100Gram: 50,
    expiryMonths: 6,
  ),
  Product(
    id: 1,
    name: 'سلطة فواكه',
    description:
        'مزيج لذيذ من الفواكه الطازجة المقطعة، مثالية كوجبة خفيفة منعشة أو تحلية صحية',
    price: 30,
    stockQuantity: 10,
    isfavourite: true,
    imageUrl:
        'https://images.healthshots.com/healthshots/en/uploads/2022/04/17151621/fruit-salad.jpg',
    categoryId: 2,
    totalRating: 3.5,
    counterFiveStars: 3,
    counterFourStars: 6,
    counterThreeStars: 7,
    counterTwoStars: 3,
    counterOneStars: 2,
    caloriesPer100Gram: 80,
    expiryMonths: 6,
  ),
  Product(
    id: 1,
    name: 'مانجا',
    description:
        ' فاكهة استوائية لذيذة ومليئة بالعصارة، مثالية لتناولها طازجة أو لتحضير العصائر والمشروبات',
    price: 25,
    stockQuantity: 95,
    isfavourite: false,
    imageUrl:
        'https://hips.hearstapps.com/hmg-prod/images/mango-fruit-sugar-1530136260.jpg?crop=1xw:1xh;center,top&resize=640:*',
    categoryId: 2,
    totalRating: 3.5,
    counterFiveStars: 3,
    counterFourStars: 6,
    counterThreeStars: 7,
    counterTwoStars: 3,
    counterOneStars: 2,
    caloriesPer100Gram: 40,
    expiryMonths: 6,
  ),
  Product(
    id: 1,
    name: 'كريز',
    description:
        'حبات كريز حلوة وعصيرية، مثالية كوجبة خفيفة منعشة أو لاستخدامها في الحلويات والمشروبات',
    price: 40,
    stockQuantity: 90,
    isfavourite: false,
    imageUrl:
        'https://hips.hearstapps.com/hmg-prod/images/cherries-sugar-fruit-1530136329.jpg?crop=1xw:1xh;center,top&resize=640:*',
    categoryId: 2,
    totalRating: 3.5,
    counterFiveStars: 3,
    counterFourStars: 6,
    counterThreeStars: 7,
    counterTwoStars: 3,
    counterOneStars: 2,
    caloriesPer100Gram: 30,
    expiryMonths: 6,
  ),
];
