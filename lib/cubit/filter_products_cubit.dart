import 'package:flutter_bloc/flutter_bloc.dart';

class Products {}

class IntialProducts extends Products {}

class MostSellingProducts extends Products {}

class FilteredProducts extends Products {}

class ProductsCubit extends Cubit<Products> {
  ProductsCubit() : super(IntialProducts());

  void showProductState({required String state}) {
    if (state == 'most') {
      emit(MostSellingProducts());
    } else {
      emit(FilteredProducts());
    }
  }
}
