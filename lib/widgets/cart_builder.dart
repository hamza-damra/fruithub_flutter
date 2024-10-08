import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fruitshub/API/cart_management.dart';
import 'package:fruitshub/auth/helpers/shared_pref_manager.dart';
import 'package:fruitshub/bloc/remove_from_cart_cubit.dart';
import 'package:fruitshub/globals.dart';
import 'package:fruitshub/models/cartItem.dart';
import 'package:fruitshub/widgets/cart_item.dart';

class Cart extends StatefulWidget {
  const Cart({
    super.key,
  });

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  Future<List<Cartitem>> getProducts() async {
    return await CartManagement().getCartItems(
      token: await SharedPrefManager().getData('token'),
    );
  }

  Future<List<Cartitem>> requestData() async {
    if (cart.isEmpty) {
      cart = await getProducts();
      return cart;
    } else {
      return cart;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'السله',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      body: FutureBuilder(
        future: requestData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SpinKitThreeBounce(
              color: Colors.green,
              size: 50.0,
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/error.png',
                    width: screenHeight * 0.5,
                    height: screenHeight * 0.25,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  Text(
                    '! حدث خطا اثناء تحميل البيانات',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.05,
                    ),
                  ),
                ],
              ),
            );
          } else {
            List<Cartitem> items = snapshot.data ?? [];
            return items.isNotEmpty
                ? ListView.builder(
                    itemCount: items.length + 2,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Column(
                          children: [
                            Container(
                              width: double.infinity,
                              height: MediaQuery.sizeOf(context).height * 0.09,
                              color: const Color(0xffEBF9F1),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'منتجات في سله التسوق',
                                      style: TextStyle(
                                        color: const Color(0xff1B5E37),
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            MediaQuery.sizeOf(context).width *
                                                0.04,
                                      ),
                                    ),
                                    Text(
                                      ' ${items.length} ',
                                      style: TextStyle(
                                        color: const Color(0xff1B5E37),
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            MediaQuery.sizeOf(context).width *
                                                0.04,
                                      ),
                                    ),
                                    Text(
                                      'لديك',
                                      style: TextStyle(
                                        color: const Color(0xff1B5E37),
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            MediaQuery.sizeOf(context).width *
                                                0.04,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 6),
                          ],
                        );
                      }

                      // Show cart items
                      else if (index > 0 && index <= items.length) {
                        return CartItemWidget(
                          childButton: BlocBuilder<CartCubit, CartState>(
                            builder: (context, state) {
                              if (state is CartInitial ||
                                  state is CartSuccess ||
                                  state is CartError) {
                                return SvgPicture.asset(
                                  'assets/images/trash.svg',
                                );
                              } else {
                                return SizedBox(
                                  width: screenWidth * 0.07,
                                  height: screenWidth * 0.07,
                                  child: const CircularProgressIndicator(
                                    color: Color.fromARGB(255, 132, 139, 139),
                                  ),
                                );
                              }
                            },
                          ),
                          product: items[index - 1],
                        );
                      }

                      // Last item is the payment button
                      else if (index == items.length + 1) {
                        return Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            const SizedBox(height: 6),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: SizedBox(
                                width: double.infinity,
                                height: 45,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: WidgetStateProperty.all(
                                      const Color(0xff1B5E37),
                                    ),
                                  ),
                                  onPressed: () {
                                    // Add payment handling logic here
                                  },
                                  child: const Text(
                                    'الدفع',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 6),
                          ],
                        );
                      }
                      return null;
                    },
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Responsive Image
                        Image.asset(
                          'assets/images/noCart.PNG',
                          width: screenHeight *
                              0.5, // Adjust width as 50% of screen width
                          height: screenHeight *
                              0.25, // Adjust height as 25% of screen height
                          fit: BoxFit
                              .contain, // Ensure image fits within the specified dimensions
                        ),

                        SizedBox(
                            height: screenHeight * 0.02), // Responsive height

                        Text(
                          '! السله فارغه',
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.bold,
                            fontSize: screenHeight * 0.03,
                          ),
                        ),
                      ],
                    ),
                  );
          }
        },
      ),
    );
  }
}
