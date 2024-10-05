import 'package:flutter/material.dart';
import 'package:fruitshub/API/cart_management.dart';
import 'package:fruitshub/API/favourite_management.dart';
import 'package:fruitshub/auth/helpers/shared_pref_manager.dart';
import 'package:fruitshub/models/product.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:http/http.dart' as http;

class ProductCard extends StatefulWidget {
  const ProductCard({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  final favouriteManagement = FavouriteManagement();
  final cartManagement = CartManagement();

  late Widget favouriteIcon;
  late Widget cartIcon;

  @override
  void initState() {
    super.initState();

    favouriteIcon = widget.product.isfavourite
        ? IconButton(
            icon: const Icon(
              Icons.favorite_rounded,
              color: Colors.red,
              size: 22,
            ),
            onPressed: _toggleFavourite,
          )
        : IconButton(
            icon: const Icon(
              Icons.favorite_border_rounded,
              color: Colors.red,
              size: 22,
            ),
            onPressed: _toggleFavourite,
          );

    cartIcon = widget.product.isCartExist
        ? const Icon(
            Icons.done_rounded,
            color: Colors.white,
            size: 22,
          )
        : const Icon(
            Icons.add_rounded,
            color: Colors.white,
            size: 22,
          );
  }

  Future<void> _toggleFavourite() async {
    setState(() {
      favouriteIcon = const IconButton(
        icon: Padding(
          padding: EdgeInsets.all(4),
          child: SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              color: Colors.red,
            ),
          ),
        ),
        onPressed: null,
      );
    });

    if (widget.product.isfavourite) {
      http.Response response = await favouriteManagement.removeFromFavourite(
        productId: widget.product.id,
        token: await SharedPrefManager().getData('token'),
      );

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 203 ||
          response.statusCode == 204) {
        widget.product.isfavourite = false;
        showTopSnackBar(
          Overlay.of(context),
          displayDuration: const Duration(milliseconds: 1000),
          const CustomSnackBar.info(
            message: "تم حذف المنتج من قائمه التمني",
            textAlign: TextAlign.center,
            textStyle: TextStyle(
              fontFamily: 'Cairo',
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        );
      } else {
        showTopSnackBar(
          Overlay.of(context),
          displayDuration: const Duration(milliseconds: 1000),
          const CustomSnackBar.error(
            message: "فشل حذف المنتج من قائمه التمني",
            textAlign: TextAlign.center,
            textStyle: TextStyle(
              fontFamily: 'Cairo',
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        );
      }
    } else {
      http.Response response = await favouriteManagement.addToFavourite(
        productId: widget.product.id,
        token: await SharedPrefManager().getData('token'),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        widget.product.isfavourite = true;
        showTopSnackBar(
          Overlay.of(context),
          displayDuration: const Duration(milliseconds: 1000),
          const CustomSnackBar.info(
            message: "تم اضافه المنتج الي قائمه التمني",
            textAlign: TextAlign.center,
            textStyle: TextStyle(
              fontFamily: 'Cairo',
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        );
      } else {
        showTopSnackBar(
          Overlay.of(context),
          displayDuration: const Duration(milliseconds: 1000),
          const CustomSnackBar.error(
            message: "فشل اضافه المنتج الي قائمه التمني",
            textAlign: TextAlign.center,
            textStyle: TextStyle(
              fontFamily: 'Cairo',
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        );
      }
    }

    setState(() {
      favouriteIcon = widget.product.isfavourite
          ? IconButton(
              icon: const Icon(
                Icons.favorite_rounded,
                color: Colors.red,
                size: 22,
              ),
              onPressed: _toggleFavourite,
            )
          : IconButton(
              icon: const Icon(
                Icons.favorite_border_rounded,
                color: Colors.red,
                size: 22,
              ),
              onPressed: _toggleFavourite,
            );
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: const Color(0xffF3F5F7),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          favouriteIcon,
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: FancyShimmerImage(
                    imageUrl: widget.product.imageUrl,
                    shimmerBaseColor: Colors.grey[300],
                    shimmerHighlightColor: Colors.white,
                    boxFit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerRight,
              child: Text(
                widget.product.name,
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w700,
                  color: const Color(0xff0C0D0D),
                  fontSize: screenWidth * 0.04,
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                // Cart management logic
                onTap: () async {
                  String token = await SharedPrefManager().getData('token');

                  setState(() {
                    cartIcon = const AspectRatio(
                      aspectRatio: 1 / 1,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2.5,
                        ),
                      ),
                    );
                  });

                  if (widget.product.isCartExist) {
                    http.Response deleteResponse =
                        await cartManagement.deleteFromCart(
                      token: token,
                      id: widget.product.id,
                    );
                    if (deleteResponse.statusCode == 200 ||
                        deleteResponse.statusCode == 201 ||
                        deleteResponse.statusCode == 203 ||
                        deleteResponse.statusCode == 204) {
                      widget.product.isCartExist = false;
                      showTopSnackBar(
                        Overlay.of(context),
                        displayDuration: const Duration(milliseconds: 1000),
                        const CustomSnackBar.info(
                          message: "تم حذف المنتج من السله",
                          textAlign: TextAlign.center,
                          textStyle: TextStyle(
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      );
                    } else {
                      showTopSnackBar(
                        Overlay.of(context),
                        displayDuration: const Duration(milliseconds: 1000),
                        const CustomSnackBar.error(
                          message: 'فشل حذف المنتج من السله',
                          textAlign: TextAlign.center,
                          textStyle: TextStyle(
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      );
                    }
                  } else {
                    http.Response addResponse = await cartManagement.addToCart(
                      token: token,
                      productId: widget.product.id,
                    );
                    if (addResponse.statusCode == 200 ||
                        addResponse.statusCode == 201) {
                      widget.product.isCartExist = true;
                      showTopSnackBar(
                        Overlay.of(context),
                        displayDuration: const Duration(milliseconds: 1000),
                        const CustomSnackBar.info(
                          message: "تم اضافه المنتج الي السله",
                          textAlign: TextAlign.center,
                          textStyle: TextStyle(
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      );
                    } else {
                      showTopSnackBar(
                        Overlay.of(context),
                        displayDuration: const Duration(milliseconds: 1000),
                        const CustomSnackBar.error(
                          message: 'فشل اضافه المنتج الي السله',
                          textAlign: TextAlign.center,
                          textStyle: TextStyle(
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      );
                    }
                  }

                  ////////
                  setState(() {
                    cartIcon = widget.product.isCartExist
                        ? const Icon(
                            Icons.done_rounded,
                            color: Colors.white,
                            size: 22,
                          )
                        : const Icon(
                            Icons.add_rounded,
                            color: Colors.white,
                            size: 22,
                          );
                  });
                },
                child: Container(
                  width: screenWidth * 0.08,
                  height: screenHeight * 0.08,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xff1B5E37),
                  ),
                  child: Center(
                    child: cartIcon,
                  ),
                ),
              ),
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerRight,
                  child: Row(
                    children: [
                      Text(
                        'الكيلو',
                        style: TextStyle(
                          color: const Color(0xffF8C76D),
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Cairo',
                          fontSize: screenWidth * 0.040,
                        ),
                      ),
                      Text(
                        '/',
                        style: TextStyle(
                          color: const Color(0xffF8C76D),
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Cairo',
                          fontSize: screenWidth * 0.040,
                        ),
                      ),
                      Text(
                        'جنية',
                        style: TextStyle(
                          color: const Color(0xffF4A91F),
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Cairo',
                          fontSize: screenWidth * 0.040,
                        ),
                      ),
                      Text(
                        widget.product.price.toString(),
                        style: TextStyle(
                          color: const Color(0xffF4A91F),
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Cairo',
                          fontSize: screenWidth * 0.040,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
