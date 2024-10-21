import 'package:hydrated_bloc/hydrated_bloc.dart';

class MyProducts {}

class InitialProducts extends MyProducts {}

class MostSellingProducts extends MyProducts {}

class FilteredProducts extends MyProducts {}

class ProductsCubit extends Cubit<MyProducts> {
  ProductsCubit() : super(InitialProducts());

  void showProductState({required String myState}) {
    if (myState == 'most') {
      emit(MostSellingProducts());
    } else {
      emit(FilteredProducts());
    }
  }
}
