import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruitshub/API/cart_management.dart';
import 'package:fruitshub/auth/helpers/shared_pref_manager.dart';
import 'package:fruitshub/globals.dart';
import 'package:http/http.dart' as http;

class CartState {}

class CartInitial extends CartState {}

class CartDeleteLoading extends CartState {
  final int id;

  CartDeleteLoading({required this.id});
}

class CartDeleteSuccess extends CartState {
  final int id;

  CartDeleteSuccess({required this.id});
}

class CartDeleteError extends CartState {}

class CartAddLoading extends CartState {
  final int id;

  CartAddLoading({required this.id});
}

class CartAddSuccess extends CartState {
  final int id;

  CartAddSuccess({required this.id});
}

class CartAddError extends CartState {}

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  Future<void> deleteFromCart(int id, String? isFav) async {
    emit(CartDeleteLoading(id: id));
    http.Response response = await CartManagement().deleteFromCart(
      token: await SharedPrefManager().getData('token'),
      id: id,
    );

    if (response.statusCode == 200 || response.statusCode == 204) {
      emit(CartDeleteSuccess(id: id));
      if (isFav == 'fav') {
        mostSelling = [];
      }
      cart = [];
      favourite = [];
      lastAdded = [];
    } else {
      emit(CartDeleteError());
    }
  }

  Future<void> addToCart(int id, int quantity, String? isFav) async {
    emit(CartAddLoading(id: id));
    http.Response response = await CartManagement().addToCart(
      token: await SharedPrefManager().getData('token'),
      productId: id,
      quantity: quantity,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      emit(CartAddSuccess(id: id));
      if (isFav == 'fav') {
        mostSelling = [];
      }
      cart = [];
      favourite = [];
      lastAdded = [];
    } else {
      emit(CartAddError());
    }
  }
}
