import 'package:hydrated_bloc/hydrated_bloc.dart';

class Products {}

class InitialProducts extends Products {}

class MostSellingProducts extends Products {}

class FilteredProducts extends Products {}

class ProductsCubit extends HydratedCubit<Products> {
  ProductsCubit() : super(InitialProducts());

  void showProductState({required String state}) {
    if (state == 'most') {
      emit(MostSellingProducts());
    } else {
      emit(FilteredProducts());
    }
  }

  @override
  Products? fromJson(Map<String, dynamic> json) {
    final String state = json['state'] as String;
    if (state == 'mostSelling') {
      return MostSellingProducts();
    } else if (state == 'filtered') {
      return FilteredProducts();
    }
    return InitialProducts();
  }

  @override
  Map<String, dynamic>? toJson(Products state) {
    if (state is MostSellingProducts) {
      return {'state': 'mostSelling'};
    } else if (state is FilteredProducts) {
      return {'state': 'filtered'};
    }
    return null;
  }
}
