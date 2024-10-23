import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruitshub/globals.dart';

class CartTotalPriceState {
  final double totalPrice;

  CartTotalPriceState({required this.totalPrice});
}

class CartTotalPricInitial extends CartTotalPriceState {
  CartTotalPricInitial({required super.totalPrice});
}

class CartTotalPricChange extends CartTotalPriceState {
  CartTotalPricChange({required super.totalPrice});
}

class CartTotalPriceCubit extends Cubit<CartTotalPriceState> {
  double _calculateTotalPrice() {
    double totalPrice = 0;
    for (int i = 0; i < cart.length; i++) {
      totalPrice += cart[i].quantity * cart[i].price;
    }
    return totalPrice;
  }

  CartTotalPriceCubit() : super(CartTotalPricInitial(totalPrice: 0)) {
    updateTotalPrice();
  }

  void updateTotalPrice() {
    double newTotalPrice = _calculateTotalPrice();
    emit(CartTotalPricChange(totalPrice: newTotalPrice));
  }
}
