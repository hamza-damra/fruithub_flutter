import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruitshub/bloc/filter_products_cubit.dart';
import 'package:fruitshub/globals.dart';
import 'package:fruitshub/screens/sub_screens/details_screen.dart';
import 'package:fruitshub/widgets/most_selling_builder.dart';
import 'package:fruitshub/widgets/my_textfield.dart';
import 'package:fruitshub/widgets/our_product_card.dart';
import 'package:fruitshub/widgets/price_filtered_products.dart';
import 'package:fruitshub/widgets/search.dart';
import 'package:fruitshub/widgets/search_delegate.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  String sort = 'name'; // Default sort order
  String? selectedOption;

  @override
  void initState() {
    BlocProvider.of<ProductsCubit>(context).showProductState(state: 'most');
    super.initState();
  }

  void reBuild() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        centerTitle: true,
        title: const FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            'المنتجات',
            style: TextStyle(
              fontFamily: 'Cairo',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
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
                showTopSnackBar(
                  Overlay.of(context),
                  const CustomSnackBar.info(
                    message: "سيتم توفير الاشعارات قريبا",
                    textAlign: TextAlign.center,
                    textStyle: TextStyle(
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                );
              },
              color: const Color.fromARGB(255, 39, 139, 43),
              iconSize: screenWidth * 0.07,
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
              textScaleFactor: textScaleFactor,
              screenWidth: screenWidth,
              screenHeight: screenHeight,
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
                              groupValue: selectedOption,
                              activeColor: Colors.green.shade600,
                              onChanged: (String? value) {
                                setState(() {
                                  selectedOption = value;
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
                              groupValue: selectedOption,
                              activeColor: Colors.green.shade600,
                              onChanged: (String? value) {
                                setState(() {
                                  selectedOption = value;
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
                              groupValue: selectedOption,
                              activeColor: Colors.green.shade600,
                              onChanged: (String? value) {
                                setState(() {
                                  selectedOption = value;
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
                                    reBuild();
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
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.02),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
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
                                ': تصنيف حسب السعر',
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16, right: 16),
                                    child: MyTextField(
                                      align: TextAlign.center,
                                      hint: '0',
                                      showprefixIcon: false,
                                      inputType: TextInputType.number,
                                      controller: minController,
                                    ),
                                  ),
                                ),
                                const Text(
                                  'الي',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16, right: 16),
                                    child: MyTextField(
                                      align: TextAlign.center,
                                      hint: '0',
                                      showprefixIcon: false,
                                      inputType: TextInputType.number,
                                      controller: maxController,
                                    ),
                                  ),
                                ),
                              ],
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
                                    maxNum = int.parse(maxController.text);
                                    minNum = int.parse(minController.text);
                                    BlocProvider.of<ProductsCubit>(this.context)
                                        .showProductState(state: 'filter');
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
                  child: Container(
                    width: screenWidth * 0.10,
                    height:
                        screenWidth * 0.10, // Square container for the arrow
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.grey.shade300,
                        width: screenWidth * 0.005,
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/images/arrow.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'منتجاتنا',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.w700,
                      fontSize: screenWidth * 0.050,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: screenHeight * 0.15, // 15% of screen height
            child: Padding(
              padding: EdgeInsets.only(
                right: screenWidth * 0.02, // 2% of screen width
              ),
              child: ListView.builder(
                reverse: true,
                itemCount: myProducts.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return DetailsScreen(
                            product: myProducts[index],
                          );
                        },
                      ));
                    },
                    child: OurProductCard(
                      screenWidth: screenWidth,
                      screenHeight: screenHeight,
                      product: myProducts[index],
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.01), // Spacing between elements
          SizedBox(height: screenHeight * 0.01), // Spacing between elements
          SizedBox(height: screenHeight * 0.01), // Spacing between elements

          ///////// cubit issue here
          BlocBuilder<ProductsCubit, Products>(
            builder: (context, state) {
              if (state is MostSellingProducts) {
                return MostSellingBuilder(
                  products: myProducts,
                  showText: true,
                  sorting: sort,
                );
              } else {
                return PriceFilteredProducts(
                  max: maxNum,
                  min: minNum,
                  products: myProducts,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
