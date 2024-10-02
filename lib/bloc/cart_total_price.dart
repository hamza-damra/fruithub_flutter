import 'package:flutter_bloc/flutter_bloc.dart';

class totalPriceCubit extends Cubit {
  totalPriceCubit(super.dynamic);

  double myTotalPrice = 0;

  void calcTotalPrice(double price) {
    myTotalPrice += price;

    emit(myTotalPrice);
  }
}
