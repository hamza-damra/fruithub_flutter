import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fruitshub/screens/sub_screens/details_screen.dart';
import 'package:fruitshub/widgets/most_selling_builder.dart';
import 'package:fruitshub/widgets/my_textfield.dart';
import 'package:fruitshub/widgets/our_product_card.dart';
import 'package:fruitshub/widgets/price_filtered_products.dart';
import 'package:fruitshub/widgets/search.dart';
import 'package:fruitshub/widgets/search_delegate.dart';

import '../../bloc/cubit/filter_products_cubit.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  String sort = 'name';
  String? selectedOption;
  final TextEditingController start = TextEditingController();
  final TextEditingController end = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ProductsCubit>().loadProducts();
  }

  @override
  void dispose() {
    start.dispose();
    end.dispose();
    super.dispose();
  }

  void showSortOptions(BuildContext context) {
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
                    context.read<ProductsCubit>().loadProducts(sortingOrder: sort);
                    Navigator.pop(context);
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
                    context.read<ProductsCubit>().loadProducts(sortingOrder: sort);
                    Navigator.pop(context);
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
                    context.read<ProductsCubit>().loadProducts(sortingOrder: sort);
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(height: 9),
              ],
            );
          },
        );
      },
    );
  }

  void showPriceFilterOptions(BuildContext context) {
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
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: MyTextField(
                      align: TextAlign.center,
                      hint: '0',
                      showSuffixIcon: false,
                      inputType: TextInputType.number,
                      controller: end,
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
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: MyTextField(
                      align: TextAlign.center,
                      hint: '0',
                      showSuffixIcon: false,
                      inputType: TextInputType.number,
                      controller: start,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 9),
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.90,
                height: 40,
                child: ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                      Color(0xff1B5E37),
                    ),
                  ),
                  onPressed: () {
                    int minPrice = int.parse(start.text);
                    int maxPrice = int.parse(end.text);
                    context.read<ProductsCubit>().filterProductsByPrice(minPrice, maxPrice);
                    Navigator.pop(context);
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
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        centerTitle: true,
        title: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            'المنتجات',
            style: TextStyle(
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w700,
              fontSize: screenWidth * 0.050,
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
      body: BlocBuilder<ProductsCubit, ProductsState>(
        builder: (context, state) {
          if (state is ProductsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductsLoaded) {
            return Column(
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
                    textScaleFactor: MediaQuery.of(context).textScaleFactor,
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                    onTap: () => showSortOptions(context),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(screenWidth * 0.02),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => showPriceFilterOptions(context),
                        child: Container(
                          width: screenWidth * 0.10,
                          height: screenWidth * 0.10, // Square container for the arrow
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
                      itemCount: state.products.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return DetailsScreen(
                                  product: state.products[index],
                                );
                              },
                            ));
                          },
                          child: OurProductCard(
                            screenWidth: screenWidth,
                            screenHeight: screenHeight,
                            product: state.products[index],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.01), // Spacing between elements
                MostSelling(
                  products: state.products,
                  showText: true,
                  sorting: state.sortingOrder,
                ),
              ],
            );
          } else if (state is ProductsFiltered) {
            return PriceFilteredProducts(
              start: state.start,
              end: state.end,
              products: state.products,
            );
          } else if (state is ProductsError) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return const Center(
              child: Text('No products available'),
            );
          }
        },
      ),
    );
  }
}
