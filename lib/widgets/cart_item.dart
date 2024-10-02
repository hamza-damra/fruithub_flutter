import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_svg/svg.dart';
import 'package:fruitshub/API/cart_management.dart';
import 'package:fruitshub/auth/helpers/shared_pref_manager.dart';
import 'package:fruitshub/models/cartItem.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class CartItemWidget extends StatefulWidget {
  const CartItemWidget({
    super.key,
    required this.product,
  });

  final Cartitem product;

  @override
  State<CartItemWidget> createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  Widget deleteButtonChlild = SvgPicture.asset(
    'assets/images/trash.svg',
  );

  final cart = CartManagement();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.02,
        vertical: screenHeight * 0.01,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Column with the product info and quantity controls
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product name and delete button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: deleteButtonChlild,
                      onPressed: () async {
                        setState(() {
                          deleteButtonChlild = SizedBox(
                            width: screenWidth * 0.07,
                            height: screenWidth * 0.07,
                            child: const CircularProgressIndicator(
                              color: Color.fromARGB(255, 132, 139, 139),
                            ),
                          );
                        });
                        http.Response response = await cart.deleteFromCart(
                          token: await SharedPrefManager().getData('token'),
                          id: widget.product.productId,
                        );
                        setState(() {
                          deleteButtonChlild = SvgPicture.asset(
                            'assets/images/trash.svg',
                          );
                        });
                        if (response.statusCode == 200 ||
                            response.statusCode == 204) {
                          showTopSnackBar(
                            Overlay.of(context),
                            CustomSnackBar.info(
                              message: "تم حذف ${widget.product.productName}",
                              textAlign: TextAlign.center,
                              textStyle: const TextStyle(
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          );
                        } else {
                          showTopSnackBar(
                            Overlay.of(context),
                            CustomSnackBar.error(
                              message: "فشل حذف ${widget.product.productName}",
                              textAlign: TextAlign.center,
                              textStyle: const TextStyle(
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          );
                        }
                      },
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          widget.product.productName,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: screenHeight * 0.025,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              'كجم',
                              style: TextStyle(
                                color: const Color(0xffF4A91F),
                                fontSize: screenHeight * 0.02,
                              ),
                            ),
                            Text(
                              ' ${widget.product.quantity}',
                              style: TextStyle(
                                color: const Color(0xffF4A91F),
                                fontSize: screenHeight * 0.02,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.01),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          'جنيه ',
                          style: TextStyle(
                            color: const Color(0xffF4A91F),
                            fontWeight: FontWeight.bold,
                            fontSize: screenHeight * 0.025,
                          ),
                        ),
                        Text(
                          (widget.product.price * widget.product.quantity)
                              .toStringAsFixed(2)
                              .toString(),
                          style: TextStyle(
                            color: const Color(0xffF4A91F),
                            fontWeight: FontWeight.bold,
                            fontSize: screenHeight * 0.025,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            if (widget.product.quantity > 1) {
                              setState(() {
                                widget.product.quantity--;
                              });
                              await cart.decreaseProductQuantity(
                                id: widget.product.productId,
                                token:
                                    await SharedPrefManager().getData('token'),
                              );
                            }
                          },
                          child: Container(
                            width: screenWidth * 0.08,
                            height: screenWidth * 0.08,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xffF3F5F7),
                            ),
                            child: Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                child: Container(
                                  height: screenHeight * 0.003,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.04),
                        Text(
                          widget.product.quantity.toString(),
                          style: TextStyle(
                            fontSize: screenWidth * 0.045,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.04),
                        GestureDetector(
                          onTap: () async {
                            setState(() {
                              widget.product.quantity++;
                            });
                            if (widget.product.quantity <
                                widget.product.stockQuantity) {
                              await cart.increaseProductQuantity(
                                id: widget.product.productId,
                                token:
                                    await SharedPrefManager().getData('token'),
                              );
                            } else {
                              showTopSnackBar(
                                Overlay.of(context),
                                const CustomSnackBar.info(
                                  message:
                                      "لا يمكنك تجاوز الكميه المتوفره للمنتج",
                                  textAlign: TextAlign.center,
                                  textStyle: TextStyle(
                                    fontFamily: 'Cairo',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              );
                            }
                          },
                          child: Container(
                            width: screenWidth * 0.08,
                            height: screenWidth * 0.08,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xff1B5E37),
                            ),
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: screenWidth * 0.05,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.01),
                Container(
                  width: double.infinity,
                  height: 1,
                  color: const Color(0xffF1F1F5),
                ),
              ],
            ),
          ),
          SizedBox(width: screenWidth * 0.02),
          // Product image container with dynamic height
          Container(
            width: screenWidth * 0.25,
            color: const Color(0xffF3F5F7),
            child: AspectRatio(
              aspectRatio: 1 / 1, // Ensures the image is square
              child: FancyShimmerImage(
                boxFit: BoxFit.scaleDown,
                imageUrl: widget.product.productImageUrl,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
