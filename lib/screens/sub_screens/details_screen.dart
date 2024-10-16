import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruitshub/bloc/cart_cubit.dart';
import 'package:fruitshub/globals.dart';
import 'package:fruitshub/models/product.dart';
import 'package:fruitshub/screens/sub_screens/rating_screen.dart';
import 'package:fruitshub/widgets/product_info.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({
    super.key,
    required this.product,
    this.screen,
  });

  final Product product;
  final String? screen;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    int totalRating = widget.product.counterFiveStars +
        widget.product.counterFourStars +
        widget.product.counterThreeStars +
        widget.product.counterTwoStars +
        widget.product.counterOneStars;

    double average = totalRating > 0
        ? (widget.product.counterFiveStars * 5 +
                widget.product.counterFourStars * 4 +
                widget.product.counterThreeStars * 3 +
                widget.product.counterTwoStars * 2 +
                widget.product.counterOneStars * 1) /
            totalRating
        : 0;

    String formattedAverage = average.toStringAsFixed(1);

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: const Color(0xffF3F5F7),
        surfaceTintColor: const Color(0xffF3F5F7),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: EdgeInsets.all(screenWidth * 0.02), // Responsive padding
            child: Container(
              width: screenWidth * 0.1,
              height: screenWidth * 0.1,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: screenWidth * 0.07, // Responsive icon size
              ),
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          Stack(
            children: [
              Container(
                width: screenWidth,
                height: screenHeight * 0.30,
                decoration: const BoxDecoration(
                  color: Color(0xffF3F5F7),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(200),
                    bottomRight: Radius.circular(200),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: FancyShimmerImage(
                  errorWidget: ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(35),
                    ),
                    child: Image.asset(
                      'assets/images/image-error-placeHolder.png',
                    ),
                  ),
                  imageUrl: widget.product.imageUrl,
                  width: screenWidth * 0.45,
                  height: screenHeight * 0.25,
                  boxFit: BoxFit.contain,
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.02),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BlocBuilder<CartCubit, CartState>(
                  builder: (context, state) {
                    if (state is CartAddError ||
                        state is CartAddLoading ||
                        !widget.product.isCartExist) {
                      return Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (widget.product.myQuantity > 1) {
                                widget.product.myQuantity--;
                                setState(() {});
                              }
                            },
                            child: Container(
                              width: screenWidth * 0.11,
                              height: screenWidth * 0.11,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xffF3F5F7),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.02,
                                ),
                                child: Container(
                                  alignment: Alignment.center,
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
                            widget.product.myQuantity.toString(),
                            style: TextStyle(
                              fontSize: screenWidth * 0.045,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: screenWidth * 0.04),
                          GestureDetector(
                            onTap: () {
                              if (widget.product.myQuantity <
                                  widget.product.stockQuantity) {
                                widget.product.myQuantity++;
                                setState(() {});
                              } else {
                                showTopSnackBar(
                                  context as OverlayState,
                                  const CustomSnackBar.error(
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
                              width: screenWidth * 0.11,
                              height: screenWidth * 0.11,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xff1B5E37),
                              ),
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                                size: screenWidth * 0.05, // Adjust icon size
                              ),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      widget.product.name,
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w700,
                        color: const Color(0xff0C0D0D),
                        fontSize: screenWidth * 0.045,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          'الكيلو',
                          style: TextStyle(
                            color: const Color(0xffF8C76D),
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Cairo',
                            fontSize: screenWidth * 0.04,
                          ),
                        ),
                        Text(
                          '/',
                          style: TextStyle(
                            color: const Color(0xffF8C76D),
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Cairo',
                            fontSize: screenWidth * 0.04,
                          ),
                        ),
                        Text(
                          'جنية ',
                          style: TextStyle(
                            color: const Color(0xffF4A91F),
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Cairo',
                            fontSize: screenWidth * 0.04,
                          ),
                        ),
                        Text(
                          widget.product.price.toString(),
                          style: TextStyle(
                            color: const Color(0xffF4A91F),
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Cairo',
                            fontSize: screenWidth * 0.04,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'الكميه المتوفره : ${widget.product.stockQuantity.toString()}',
                      style: TextStyle(
                        fontSize: screenWidth * 0.04, // Responsive font size
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cairo',
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 5),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              right: screenWidth * 0.03,
              left: screenWidth * 0.03,
              bottom: screenHeight * 0.02,
            ),
            child: Text(
              widget.product.description,
              textAlign: TextAlign.right,
              style: TextStyle(
                color: const Color(0xff979899),
                fontWeight: FontWeight.w400,
                fontSize: screenWidth * 0.045,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ProductInfo(
                    image: 'assets/images/calendar.svg',
                    title: Row(
                      children: [
                        const Text(
                          'اشهر',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Color(0xff23AA49),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          ' ${getMonthsUntilExpiry(widget.product.expiryMonths.toString())}',
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            color: Color(0xff23AA49),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    subTitle: const Text(
                      'الصلاحيه',
                      style: TextStyle(
                        color: Color(0xff979899),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RatingScreen(
                            product: widget.product,
                            average: Row(
                              children: [
                                Text(
                                  formattedAverage,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const Icon(
                                  Icons.star_outlined,
                                  color: Color(0xffFFC529),
                                  size: 19,
                                ),
                              ],
                            ),
                            totalRating: totalRating,
                          ),
                        ),
                      );
                    },
                    child: ProductInfo(
                      image: 'assets/images/reviews.svg',
                      title: Row(
                        children: [
                          Text(
                            '($totalRating)  $formattedAverage',
                            style: const TextStyle(
                              color: Color(0xff23AA49),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const Icon(
                            Icons.star_outlined,
                            color: Color(0xffFFC529),
                            size: 19,
                          ),
                        ],
                      ),
                      subTitle: const Text(
                        'المراجعات',
                        style: TextStyle(
                          color: Color(0xff979899),
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Expanded(
                  child: ProductInfo(
                    image: 'assets/images/organic.svg',
                    title: Text(
                      '100%',
                      style: TextStyle(
                        color: Color(0xff23AA49),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    subTitle: Text(
                      'اوجانيك',
                      style: TextStyle(
                        color: Color(0xff979899),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ProductInfo(
                    image: 'assets/images/cals.svg',
                    title: Row(
                      children: [
                        const Text(
                          'كالوري',
                          style: TextStyle(
                            color: Color(0xff23AA49),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          ' ${widget.product.caloriesPer100Gram}',
                          style: const TextStyle(
                            color: Color(0xff23AA49),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    subTitle: const Row(
                      children: [
                        Text(
                          'جرام',
                          style: TextStyle(
                            color: Color(0xff979899),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          ' 100',
                          style: TextStyle(
                            color: Color(0xff979899),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
            child: SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      WidgetStateProperty.all<Color>(const Color(0xff1B5E37)),
                ),
                onPressed: () {
                  cart = [];
                  lastAdded = [];
                  favourite = [];
                  if (widget.product.isCartExist) {
                    BlocProvider.of<CartCubit>(context).deleteFromCart(
                      widget.screen == 'fav'
                          ? widget.product.productId
                          : widget.product.id,
                      widget.screen,
                    );
                  } else {
                    BlocProvider.of<CartCubit>(context).addToCart(
                      widget.screen == 'fav'
                          ? widget.product.productId
                          : widget.product.id,
                      widget.product.myQuantity,
                      widget.screen,
                    );
                  }
                },
                child: BlocConsumer<CartCubit, CartState>(
                  listener: (context, state) {
                    if (state is CartDeleteSuccess || state is CartAddSuccess) {
                      setState(() {
                        widget.product.isCartExist =
                            !widget.product.isCartExist;
                      });
                    }

                    if (state is CartDeleteSuccess) {
                      showTopSnackBar(
                        Overlay.of(context),
                        displayDuration: const Duration(milliseconds: 10),
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
                    } else if (state is CartAddSuccess) {
                      showTopSnackBar(
                        Overlay.of(context),
                        displayDuration: const Duration(milliseconds: 10),
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
                    } else if (state is CartDeleteError ||
                        state is CartAddError) {
                      showTopSnackBar(
                        Overlay.of(context),
                        displayDuration: const Duration(milliseconds: 10),
                        CustomSnackBar.error(
                          message: state is CartDeleteError
                              ? "فشل حذف المنتج من السله"
                              : "فشل اضافه المنتج الي السله",
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
                  builder: (context, state) {
                    if (state is CartAddLoading || state is CartDeleteLoading) {
                      return const CircularProgressIndicator(
                        color: Colors.white,
                      );
                    }
                    return Text(
                      widget.product.isCartExist
                          ? 'حذف من السله'
                          : 'اضافه الي السله',
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
        ],
      ),
    );
  }

  int getMonthsUntilExpiry(String expiryDate) {
    DateTime expiry = DateTime.parse(expiryDate);
    DateTime now = DateTime.now();

    // Calculate the months difference
    int months = ((expiry.year - now.year) * 12) + (expiry.month - now.month);

    // If the current day is later than the expiry day in the same month, subtract one month
    if (now.day > expiry.day) {
      months--;
    }

    // Ensure that the number of months is not negative
    return months < 0 ? 0 : months;
  }
}
