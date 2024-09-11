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
        'الفواكه هي مجموعة من الأغذية الطبيعية التي تنمو على الأشجار أو النباتات وتتميز بطعمها الحلو أو الحامض تحتوي الفواكه على العديد من العناصر الغذائية المفيدة لصحة الجسم وتتنوع أشكالها وألوانها من الأحمر والأصفر إلى الأخضر والبنفسجي يمكن تناولها طازجة أو استخدامها في العصائر والحلويات والسلطات',
    price: 20,
    stockQuantity: 45,
    isfavourite: true,
    imageUrl:
        'https://www.fruitsmith.com/pub/media/mageplaza/blog/post/s/e/seedless_fruits.jpg',
    categoryId: 2,
    counterFiveStars: 3,
    counterFourStars: 6,
    counterThreeStars: 7,
    counterTwoStars: 3,
    counterOneStars: 2,
    isCartExist: true,
    caloriesPer100Gram: 50,
    myRating: null,
    expiryMonths: 6,
  ),
  Product(
    id: 1,
    name: 'سلطة فواكه',
    description:
        'سلطة الفواكه هي مزيج من عدة أنواع من الفواكه الطازجة مثل التفاح والموز والعنب والفراولة وغيرها تُقدم عادة كوجبة خفيفة صحية ومنعشة يمكن إضافة العسل أو عصير الليمون لتعزيز الطعم مما يجعلها خيارًا مثاليًا للتحلية أو كوجبة إفطار خفيفة',
    price: 30,
    stockQuantity: 40,
    isfavourite: true,
    imageUrl:
        'https://images.healthshots.com/healthshots/en/uploads/2022/04/17151621/fruit-salad.jpg',
    categoryId: 2,
    counterFiveStars: 3,
    counterFourStars: 6,
    counterThreeStars: 7,
    counterTwoStars: 3,
    counterOneStars: 2,
    isCartExist: false,
    caloriesPer100Gram: 80,
    myRating: null,
    expiryMonths: 6,
  ),
  Product(
    id: 1,
    name: 'مانجا',
    description:
        'المانجا هي فاكهة استوائية شهيرة بطعمها الحلو والعصيري تتميز بلونها المتنوع بين الأخضر والأصفر والأحمر وقوامها الطري الغني بالعناصر الغذائية تُعتبر المانجا مثالية للاستخدام في العصائر والحلويات والسلطات مما يجعلها خيارًا صحيًا ولذيذًا في أي وقت',
    price: 25,
    stockQuantity: 90,
    isfavourite: false,
    imageUrl:
        'https://hips.hearstapps.com/hmg-prod/images/mango-fruit-sugar-1530136260.jpg?crop=1xw:1xh;center,top&resize=640:*',
    categoryId: 2,
    counterFiveStars: 3,
    counterFourStars: 6,
    counterThreeStars: 7,
    counterTwoStars: 3,
    counterOneStars: 2,
    caloriesPer100Gram: 40,
    myRating: 'جيد',
    isCartExist: true,
    expiryMonths: 6,
  ),
  Product(
    id: 1,
    name: 'كريز',
    description:
        'الكريز هو فاكهة صغيرة مستديرة ذات لون أحمر أو أسود لامع، تتميز بطعمها الحلو أو الحامض. يُعتبر الكريز غنيًا بمضادات الأكسدة وفيتامين سي ، مما يجعله مفيدًا لصحة القلب والجسم بشكل عام. يُستخدم الكريز في الحلويات، العصائر، أو يتم تناوله طازجًا كوجبة خفيفة لذيذة ومنعشة',
    price: 40,
    stockQuantity: 70,
    isfavourite: false,
    imageUrl:
        'https://hips.hearstapps.com/hmg-prod/images/cherries-sugar-fruit-1530136329.jpg?crop=1xw:1xh;center,top&resize=640:*',
    categoryId: 2,
    counterFiveStars: 3,
    counterFourStars: 6,
    counterThreeStars: 7,
    counterTwoStars: 3,
    counterOneStars: 2,
    caloriesPer100Gram: 30,
    myRating: 'جيد',
    isCartExist: false,
    expiryMonths: 6,
  ),
];
