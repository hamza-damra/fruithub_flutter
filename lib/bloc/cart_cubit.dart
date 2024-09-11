import 'package:flutter_bloc/flutter_bloc.dart';

class cart {}

class cartExist extends cart {}

class notCartExist extends cart {}

class CartCubit extends Cubit<cart> {
  CartCubit(bool isCartExist)
      : super(isCartExist ? cartExist() : notCartExist());

  void cartManagement(bool isCartExist) {
    if (isCartExist) {
      emit(notCartExist());
    } else {
      emit(cartExist());
    }
  }
}
