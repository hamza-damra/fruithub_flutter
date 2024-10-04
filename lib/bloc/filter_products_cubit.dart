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

  // @override
  // MyProducts? fromJson(Map<String, dynamic> json) {
  //   // Check if the 'state' key exists and is of type String
  //   if (json.containsKey('state') && json['state'] is String) {
  //     final String state = json['state'];
  //     if (state == 'mostSelling') {
  //       return MostSellingProducts();
  //     } else if (state == 'filtered') {
  //       return FilteredProducts();
  //     } else if (state == 'initial') {
  //       return InitialProducts();
  //     }
  //   }
  //   // Default to InitialProducts if there's an issue with the JSON
  //   return InitialProducts();
  // }

  // @override
  // Map<String, dynamic>? toJson(MyProducts state) {
  //   if (state is MostSellingProducts) {
  //     return {'state': 'mostSelling'};
  //   } else if (state is FilteredProducts) {
  //     return {'state': 'filtered'};
  //   } else if (state is InitialProducts) {
  //     return {'state': 'initial'};
  //   }
  //   return null;
  // }
}
