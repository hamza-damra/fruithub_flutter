import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fruitshub/bloc/cart_cubit.dart';
import 'package:fruitshub/widgets/cart_builder.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          BlocListener<CartCubit, CartState>(
            listenWhen: (previous, current) =>
                current is CartSuccess || current is CartError,
            listener: (context, state) {
              if (state is CartSuccess) {
                showTopSnackBar(
                  Overlay.of(context),
                  const CustomSnackBar.info(
                    message: "تم الحذف بنجاح",
                    textAlign: TextAlign.center,
                    textStyle: TextStyle(
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                );
              } else if (state is CartError) {
                showTopSnackBar(
                  Overlay.of(context),
                  const CustomSnackBar.info(
                    message: "فشل حذف المنتج",
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
          ),
        ],
        child: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            if (state is CartInitial) {
              return const Cart();
            } else if (state is CartLoading) {
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
                body: const Center(
                  child: SpinKitThreeBounce(
                    color: Colors.green,
                    size: 50.0,
                  ),
                ),
              );
            } else if (state is CartSuccess || state is CartError) {
              return const Cart();
            } else {
              return const Center(child: Text('Unexpected state!'));
            }
          },
        ),
      ),
    );
  }
}
