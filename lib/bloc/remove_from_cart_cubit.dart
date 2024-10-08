import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruitshub/API/cart_management.dart';
import 'package:fruitshub/auth/helpers/shared_pref_manager.dart';
import 'package:fruitshub/globals.dart';
import 'package:http/http.dart' as http;

class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartSuccess extends CartState {}

class CartError extends CartState {}

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  Future<void> deleteFromCart(int id) async {
    emit(CartLoading());
    http.Response response = await CartManagement().deleteFromCart(
      token: await SharedPrefManager().getData('token'),
      id: id,
    );
    if (response.statusCode == 200 || response.statusCode == 204) {
      emit(CartSuccess());
      mostSelling = [];
      cart = [];
      favourite = [];
    } else {
      emit(CartError());
    }
  }
}
