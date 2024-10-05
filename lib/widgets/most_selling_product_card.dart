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

  void _showSnackBar(String message, String snackBarType) {
    if (snackBarType == 'info') {
      showTopSnackBar(
        Overlay.of(context),
        displayDuration: const Duration(milliseconds: 1000),
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
        displayDuration: const Duration(milliseconds: 1000),
        CustomSnackBar.error(
          message: message,
          textAlign: TextAlign.center,
          textStyle: const TextStyle(
            fontFamily: 'Cairo',
            fontWeight: FontWeight.bold,
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
        ? Container(
            width: 22,
            height: 22,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xff1B5E37),
            ),
            child: const Center(
              child: Icon(
                Icons.done_rounded,
                color: Colors.white,
                size: 22,
              ),
            ),
          )
        : Container(
            width: 22,
            height: 22,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xff1B5E37),
            ),
            child: const Center(
              child: Icon(
                Icons.add_rounded,
                color: Colors.white,
                size: 22,
              ),
            ),
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

      if (response.statusCode == 200 || response.statusCode == 204) {
        widget.product.isfavourite = false;
        _showSnackBar("تم حذف المنتج من قائمه التمني", 'info');
      } else {
        _showSnackBar("فشل حذف المنتج من قائمه التمني", 'error');
      }
    } else {
      http.Response response = await favouriteManagement.addToFavourite(
        productId: widget.product.id,
        token: await SharedPrefManager().getData('token'),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        widget.product.isfavourite = true;
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
      cartIcon = Container(
        width: 22,
        height: 22,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xff1B5E37),
        ),
        child: const AspectRatio(
          aspectRatio: 1 / 1,
          child: Padding(
            padding: EdgeInsets.all(8.0),
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
        id: widget.product.id,
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        widget.product.isCartExist = false;
        _showSnackBar("تم حذف المنتج من السله", 'info');
      } else {
        _showSnackBar("فشل حذف المنتج من السله", 'error');
      }
    } else {
      http.Response response = await cartManagement.addToCart(
        token: token,
        productId: widget.product.id,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        widget.product.isCartExist = true;
        _showSnackBar("تم اضافه المنتج الي السله", 'info');
      } else {
        _showSnackBar("فشل اضافه المنتج الي السله", 'error');
      }
    }

    setState(() {
      cartIcon = widget.product.isCartExist
          ? Container(
              // screenWidth * 0.08
              width: 22,
              height: 22,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xff1B5E37),
              ),
              child: const Center(
                child: Icon(
                  Icons.done_rounded,
                  color: Colors.white,
                  size: 22,
                ),
              ),
            )
          : Container(
              width: 22,
              height: 22,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xff1B5E37),
              ),
              child: const Center(
                child: Icon(
                  Icons.add_rounded,
                  color: Colors.white,
                  size: 22,
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
          Align(
            alignment: Alignment.centerRight,
            child: favouriteIcon,
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
              // Cart Icon
              IconButton(
                icon: cartIcon,
                onPressed: _toggleCart,
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
