import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruitshub/API/favourite_management.dart';
import 'package:fruitshub/auth/helpers/shared_pref_manager.dart';
import 'package:fruitshub/globals.dart';
import 'package:fruitshub/models/product.dart';
import 'package:http/http.dart' as http;

class FavouriteState {}

class FavouriteInitial extends FavouriteState {}

class FavouriteLoading extends FavouriteState {
  final int id;
  FavouriteLoading({required this.id});
}

class FavouriteDeleteSuccess extends FavouriteState {
  final int id;
  FavouriteDeleteSuccess({required this.id});
}

class FavouriteAddSuccess extends FavouriteState {
  final int id;
  FavouriteAddSuccess({required this.id});
}

class FavouriteError extends FavouriteState {}

class FavouriteCubit extends Cubit<FavouriteState> {
  FavouriteCubit() : super(FavouriteInitial());

  final favouriteManage = FavouriteManagement();

  Future<void> deleteFromFavourite(
      int id, Product product, String? screen) async {
    emit(FavouriteLoading(id: id));
    http.Response response = await favouriteManage.removeFromFavourite(
      productId: id,
      token: await SharedPrefManager().getData('token'),
    );
    if (response.statusCode == 200 || response.statusCode == 204) {
      emit(FavouriteDeleteSuccess(id: id));
      if (screen == 'fav') {
        mostSelling = [];
        favourite = [];
      } else {
        favourite = [];
      }
    } else {
      emit(FavouriteError());
    }
  }

  Future<void> addToFavourite(int id, Product product, String? screen) async {
    emit(FavouriteLoading(id: id));
    http.Response response = await favouriteManage.addToFavourite(
      productId: id,
      token: await SharedPrefManager().getData('token'),
    );
    if (response.statusCode == 200 || response.statusCode == 204) {
      emit(FavouriteAddSuccess(id: id));
      if (screen == 'fav') {
        mostSelling = [];
        favourite = [];
      } else {
        favourite = [];
      }
    } else {
      emit(FavouriteError());
    }
  }
}
