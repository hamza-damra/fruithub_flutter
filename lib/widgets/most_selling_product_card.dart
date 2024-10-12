import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruitshub/API/cart_management.dart';
import 'package:fruitshub/API/favourite_management.dart';
import 'package:fruitshub/auth/helpers/shared_pref_manager.dart';
import 'package:fruitshub/bloc/cart_cubit.dart';
import 'package:fruitshub/bloc/remove_from_favourite_cubit.dart';
import 'package:fruitshub/globals.dart';
import 'package:fruitshub/models/product.dart';
import 'package:fruitshub/widgets/cart_container_and_sizedbox.dart';
import 'package:fruitshub/widgets/heart_loader.dart';
import 'package:http/http.dart' as http;
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({
    super.key,
    required this.product,
    this.screen,
  });

  final Product product;
  final String? screen;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  final favouriteManagement = FavouriteManagement();
  final cartManagement = CartManagement();

  late Widget favouriteIcon;
  late Widget cartIcon;

  void _showSnackBar(String message, String snackBarType) {
    if (snackBarType == 'info') {
      showTopSnackBar(
        Overlay.of(context),
        displayDuration: const Duration(milliseconds: 10),
        CustomSnackBar.info(
          message: message,
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
        displayDuration: const Duration(milliseconds: 10),
        CustomSnackBar.error(
          message: message,
          textAlign: TextAlign.center,
          textStyle: const TextStyle(
            fontFamily: 'Cairo',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      );
    }
  }

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
        ? GestureDetector(
            onTap: () {
              _toggleCart();
            },
            child: const CartContainer(
              child: Center(
                child: Icon(
                  Icons.done_rounded,
                  color: Colors.white,
                  size: 22,
                ),
              ),
            ),
          )
        : GestureDetector(
            onTap: () {
              _toggleCart();
            },
            child: const CartContainer(
              child: Center(
                child: Icon(
                  Icons.add_rounded,
                  color: Colors.white,
                  size: 22,
                ),
              ),
            ),
          );
  }

  Future<void> _toggleFavourite() async {
    // heart loading
    setState(() {
      favouriteIcon = IconButton(
        icon: Padding(
          padding: const EdgeInsets.all(4),
          child: SizedBox(
            width: 20,
            height: 20,
            child: HeartLoader(
              isFavorite: widget.product.isfavourite,
            ),
          ),
        ),
        onPressed: null,
      );
    });

    if (widget.product.isfavourite) {
      if (widget.screen == 'fav') {
        BlocProvider.of<FavouriteCubit>(context).deleteFromFavourite(
          widget.product.productId,
          widget.product,
        );
      } else {
        http.Response response =
            await FavouriteManagement().removeFromFavourite(
          productId: widget.product.id,
          token: await SharedPrefManager().getData('token'),
        );
        if (response.statusCode == 200 || response.statusCode == 204) {
          _showSnackBar("تم حذف المنتج من قائمه التمني", 'info');
          widget.product.isfavourite = false;
          favourite = [];
          if (widget.screen == 'fav') {
            mostSelling = [];
          }
        } else {
          _showSnackBar("فشل حذف المنتج من قائمه التمني", 'info');
        }
      }
    } else {
      http.Response response = await favouriteManagement.addToFavourite(
        productId: widget.product.id,
        token: await SharedPrefManager().getData('token'),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        widget.product.isfavourite = true;
        favourite = [];
        if (widget.screen == 'fav') {
          mostSelling = [];
        }
        _showSnackBar("تم اضافه المنتج الي قائمه التمني", 'info');
      } else {
        _showSnackBar("فشل اضافه المنتج الي قائمه التمني", 'error');
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

  Future<void> _toggleCart() async {
    setState(() {
      cartIcon = const CartContainer(
        child: Center(
          child: SizedBox(
            width: 19, // Ensure it fits inside the CartContainer
            height: 19, // Keep it square to maintain circular shape
            child: CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 2.5,
            ),
          ),
        ),
      );
    });

    String token = await SharedPrefManager().getData('token');
    if (widget.product.isCartExist) {
      http.Response response = await cartManagement.deleteFromCart(
        token: token,
        id: widget.screen == 'fav'
            ? widget.product.productId
            : widget.product.id,
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        lastAdded = [];
        widget.product.isCartExist = false;
        cart = [];
        if (widget.screen == 'fav') {
          mostSelling = [];
          cart = [];
        }
        _showSnackBar("تم حذف المنتج من السله", 'info');
      } else {
        _showSnackBar("فشل حذف المنتج من السله", 'error');
      }
    } else {
      http.Response response = await cartManagement.addToCart(
        token: token,
        productId: widget.screen == 'fav'
            ? widget.product.productId
            : widget.product.id,
      );
      print(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        lastAdded = [];
        widget.product.isCartExist = true;
        cart = [];
        if (widget.screen == 'fav') {
          mostSelling = [];
          cart = [];
        }
        _showSnackBar("تم اضافه المنتج الي السله", 'info');
      } else {
        _showSnackBar("فشل اضافه المنتج الي السله", 'error');
      }
    }

    setState(() {
      cartIcon = widget.product.isCartExist
          ? GestureDetector(
              onTap: () {
                _toggleCart();
              },
              child: const CartContainer(
                child: Center(
                  child: Icon(
                    Icons.done_rounded,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
              ),
            )
          : GestureDetector(
              onTap: () {
                _toggleCart();
              },
              child: const CartContainer(
                child: Center(
                  child: Icon(
                    Icons.add_rounded,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
              ),
            );
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: const Color(0xffF3F5F7),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Favourite Icon Section
          widget.screen == 'fav'
              ? Align(
                  alignment: Alignment.centerRight,
                  child: BlocListener<FavouriteCubit, FavouriteState>(
                    listener: (context, state) {
                      if (state is FavouriteSuccess) {
                        showTopSnackBar(
                          Overlay.of(context),
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
                      } else if (state is FavouriteError) {
                        showTopSnackBar(
                          Overlay.of(context),
                          const CustomSnackBar.info(
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
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        favouriteIcon,
                      ],
                    ),
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    favouriteIcon,
                  ],
                ),

          // Image Section
          Expanded(
            child: Center(
              child: FancyShimmerImage(
                errorWidget: Image.asset(
                  'assets/images/image-error-placeHolder.png',
                ),
                imageUrl: widget.product.imageUrl,
                shimmerBaseColor: Colors.grey[300],
                shimmerHighlightColor: Colors.white,
                boxFit: BoxFit.contain,
              ),
            ),
          ),

          // Product Name Section
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerRight,
                  child: Text(
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
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
            ],
          ),

          // Price and Cart Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Cart Section
              BlocBuilder<CartCubit, CartState>(
                builder: (context, state) {
                  return widget.product.isCartExist
                      ? GestureDetector(
                          onTap: () {
                            _toggleCart();
                          },
                          child: cartIcon,
                        )
                      : GestureDetector(
                          onTap: () {
                            _toggleCart();
                          },
                          child: cartIcon,
                        );
                },
              ),

              // Price Display
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
