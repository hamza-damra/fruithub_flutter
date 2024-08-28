import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fruitshub/models/product.dart';
import 'package:fruitshub/widgets/most_selling_builder.dart';
import 'package:fruitshub/widgets/search.dart';
import 'package:fruitshub/widgets/search_delegate.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _selectedOption;
  String sort = 'name'; // Default sort order

  List<Product> products = [
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

  void _sortProducts() {
    if (sort == 'asc') {
      products.sort((a, b) => a.price.compareTo(b.price));
    } else if (sort == 'desc') {
      products.sort((a, b) => b.price.compareTo(a.price));
    } else if (sort == 'name') {
      products.sort((a, b) => a.name.compareTo(b.name));
    }
    setState(() {}); // Trigger rebuild to reflect changes
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen width and height for responsive design
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: screenWidth * 0.02),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '..! صباح الخير',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    color: Colors.grey.shade500,
                    fontWeight: FontWeight.w400,
                    fontSize: 14 * textScaleFactor,
                  ),
                ),
                Text(
                  'أحمد مصطفي',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.bold,
                    fontSize: 16 * textScaleFactor,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.02),
            child: CircleAvatar(
              radius: screenWidth * 0.07, // Responsive radius
              backgroundImage: const AssetImage('assets/images/avatar.jpg'),
            ),
          ),
        ],
        leading: Padding(
          padding: EdgeInsets.only(left: screenWidth * 0.02),
          child: Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 220, 228, 221),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(
                Icons.notifications_none_rounded,
              ),
              onPressed: () {
                Fluttertoast.showToast(
                  msg: "سيتم توفير الاشعارات قريبا",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.TOP,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.cyan[100],
                  textColor: const Color.fromARGB(255, 129, 129, 129),
                  fontSize: 16.0,
                );
              },
              color: const Color.fromARGB(255, 39, 139, 43),
              iconSize: screenWidth * 0.07,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: screenHeight * 0.01), // Responsive spacing
          GestureDetector(
            onTap: () {
              showSearch(
                context: context,
                delegate: Searchdelegate(),
              );
            },
            child: Search(
              screenWidth: screenWidth,
              screenHeight: screenHeight,
              textScaleFactor: textScaleFactor,
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 70,
                                  height: 4,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[400],
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 17),
                            const Padding(
                              padding: EdgeInsets.only(right: 13.0),
                              child: Text(
                                ': ترتيب حسب',
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            RadioListTile<String>(
                              title: const Text(
                                'السعر ( الأقل الي الأعلي )',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              value: 'asc',
                              groupValue: _selectedOption,
                              activeColor: Colors.green.shade600,
                              onChanged: (String? value) {
                                setState(() {
                                  _selectedOption = value;
                                  sort = 'asc';
                                });
                              },
                            ),
                            RadioListTile<String>(
                              title: const Text(
                                'السعر ( الأعلي الي الأقل )',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              value: 'desc',
                              groupValue: _selectedOption,
                              activeColor: Colors.green.shade600,
                              onChanged: (String? value) {
                                setState(() {
                                  _selectedOption = value;
                                  sort = 'desc';
                                });
                              },
                            ),
                            RadioListTile<String>(
                              title: const Text(
                                'الأبجديه',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              value: 'name',
                              groupValue: _selectedOption,
                              activeColor: Colors.green.shade600,
                              onChanged: (String? value) {
                                setState(() {
                                  _selectedOption = value;
                                  sort = 'name';
                                });
                              },
                            ),
                            const SizedBox(height: 9),
                            Center(
                              child: SizedBox(
                                width: screenWidth * 0.90,
                                height: 40,
                                child: ElevatedButton(
                                  style: const ButtonStyle(
                                    backgroundColor: WidgetStatePropertyAll(
                                      Color(0xff1B5E37),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    _sortProducts(); // Call sort function
                                  },
                                  child: const Text(
                                    'تصفيه',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                          ],
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 7),
          MostSelling(
            products: products, // Pass sorted products
            sorting: sort,
            showText: false,
          ),
        ],
      ),
    );
  }
}
