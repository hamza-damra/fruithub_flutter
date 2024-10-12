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
                current is CartDeleteSuccess || current is CartDeleteError,
            listener: (context, state) {
              if (state is CartDeleteSuccess) {
                showTopSnackBar(
                  Overlay.of(context),
                  displayDuration: const Duration(milliseconds: 10),
                  const CustomSnackBar.info(
                    message: "تم حذف المنتج بنجاح",
                    textAlign: TextAlign.center,
                    textStyle: TextStyle(
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                );
              } else if (state is CartDeleteError) {
                showTopSnackBar(
                  Overlay.of(context),
                  displayDuration: const Duration(milliseconds: 10),
                  const CustomSnackBar.error(
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
            if (state is CartInitial ||
                state is CartDeleteSuccess ||
                state is CartDeleteError) {
              return const Cart();
            } else if (state is CartDeleteLoading) {
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
            } else {
              return const Center(child: Text('Unexpected state!'));
            }
          },
        ),
      ),
    );
  }
}
