import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruitshub/bloc/cart_cubit.dart';
import 'package:fruitshub/models/product.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

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
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    Icon favouriteIcon = widget.product.isfavourite
        ? Icon(
            Icons.favorite_rounded,
            color: Colors.red,
            size: screenWidth * 0.06,
          )
        : Icon(
            Icons.favorite_border_rounded,
            color: Colors.red,
            size: screenWidth * 0.06,
          );

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
          GestureDetector(
            // Favourite logic
            onTap: () {
              setState(() {
                if (widget.product.isfavourite) {
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
                }
                widget.product.isfavourite = !widget.product.isfavourite;
              });
            },
            child: favouriteIcon,
          ),
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
                onTap: () {
                  this
                      .context
                      .read<CartCubit>()
                      .cartManagement(widget.product.isCartExist);
                  if (widget.product.isCartExist) {
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
                  }
                  widget.product.isCartExist = !widget.product.isCartExist;
                },
                child: Container(
                  width: screenWidth * 0.08,
                  height: screenHeight * 0.08,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xff1B5E37),
                  ),
                  /////// BlocBuilder ///////
                  child: Center(
                    child: BlocBuilder<CartCubit, cart>(
                      builder: (context, state) {
                        if (state is cartExist) {
                          return Icon(
                            Icons.done_rounded,
                            color: Colors.white,
                            size: screenWidth * 0.05,
                          );
                        } else {
                          return Icon(
                            Icons.add_rounded,
                            color: Colors.white,
                            size: screenWidth * 0.05,
                          );
                        }
                      },
                    ),
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
