import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fruitshub/API/favourite_management.dart';
import 'package:fruitshub/auth/helpers/shared_pref_manager.dart';
import 'package:fruitshub/bloc/remove_from_favourite_cubit.dart';
import 'package:fruitshub/globals.dart';
import 'package:fruitshub/models/product.dart';
import 'package:fruitshub/screens/sub_screens/details_screen.dart';
import 'package:fruitshub/widgets/most_selling_product_card.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  Future<List<Product>> getProducts() async {
    return await FavouriteManagement().getFavourites(
      token: await SharedPrefManager().getData('token'),
    );
  }

  Future<List<Product>> requestData() async {
    if (favourite.isEmpty) {
      favourite = await getProducts();
      return favourite;
    } else {
      return favourite;
    }
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
        title: const Text('المفضله'),
        centerTitle: true,
      ),
      body: BlocConsumer<FavouriteCubit, FavouriteState>(
        listener: (context, state) {
          if (state is FavouriteSuccess) {
            showTopSnackBar(
              Overlay.of(context),
              displayDuration: const Duration(milliseconds: 10),
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
              displayDuration: const Duration(milliseconds: 10),
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
        builder: (context, state) {
          if (state is FavouriteInitial ||
              state is FavouriteError ||
              state is FavouriteSuccess) {
            return Expanded(
              child: FutureBuilder<List<Product>>(
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
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/noProducts.png',
                            width: screenHeight * 0.5,
                            height: screenHeight * 0.25,
                            fit: BoxFit.contain,
                          ),
                          Text(
                            'لم يتم اضافه منتجات في المفضله',
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
                    final products = snapshot.data!;
                    return Row(
                      children: [
                        SizedBox(
                          width: screenWidth * 0.04,
                        ),
                        Expanded(
                          child: GridView.builder(
                            itemCount: products.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 2 / 2.5,
                              mainAxisSpacing: 8,
                              crossAxisSpacing: screenWidth * 0.04,
                            ),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailsScreen(
                                        product: products[index],
                                      ),
                                    ),
                                  );
                                },
                                child: ProductCard(
                                  product: products[index],
                                  screen: 'fav',
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          width: screenWidth * 0.04,
                        ),
                      ],
                    );
                  }
                },
              ),
            );
          } else {
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                centerTitle: true,
                backgroundColor: Colors.white,
                surfaceTintColor: Colors.white,
                leading: const SizedBox(),
              ),
              body: const Center(
                child: SpinKitThreeBounce(
                  color: Colors.green,
                  size: 50.0,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
