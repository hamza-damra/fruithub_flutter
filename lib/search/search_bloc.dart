import 'package:flutter_bloc/flutter_bloc.dart';

class Search {}

class SearchDefult extends Search {}

class SearchError extends Search {}

class SearchRequest extends Search {}

class SearchCubit extends Cubit<Search> {
  SearchCubit() : super(SearchDefult());

  void showSearchResult(String status) {
    if (status == 'error') {
      emit(SearchError());
      Future.delayed(const Duration(seconds: 1), () {
        emit(SearchDefult());
      });
    } else if (status == 'search') {
      emit(SearchRequest());
    } else if (status == 'defult') {
      emit(SearchDefult());
    }
  }
}
