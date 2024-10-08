import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruitshub/API/favourite_management.dart';
import 'package:fruitshub/auth/helpers/shared_pref_manager.dart';
import 'package:fruitshub/globals.dart';
import 'package:fruitshub/models/product.dart';
import 'package:http/http.dart' as http;

class FavouriteState {}

class FavouriteInitial extends FavouriteState {}

class FavouriteLoading extends FavouriteState {}

class FavouriteSuccess extends FavouriteState {}

class FavouriteError extends FavouriteState {}

class FavouriteCubit extends Cubit<FavouriteState> {
  FavouriteCubit() : super(FavouriteInitial());

  Future<void> deleteFromFavourite(int id, Product product) async {
    emit(FavouriteLoading());
    http.Response response = await FavouriteManagement().removeFromFavourite(
      productId: id,
      token: await SharedPrefManager().getData('token'),
    );
    if (response.statusCode == 200 || response.statusCode == 204) {
      emit(FavouriteSuccess());
      mostSelling = [];
      favourite = [];
    } else {
      emit(FavouriteError());
    }
  }
}
