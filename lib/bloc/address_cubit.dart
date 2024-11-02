import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruitshub/API/address_management.dart';
import 'package:fruitshub/auth/helpers/shared_pref_manager.dart';
import 'package:fruitshub/globals.dart';
import 'package:fruitshub/models/address.dart';
import 'package:http/http.dart' as http;

class AddressState {}

class AddressInitial extends AddressState {}

class AddressLoading extends AddressState {}

class AddressAddSuccess extends AddressState {}

class AddressAddError extends AddressState {}

class AddressUpdateSuccess extends AddressState {
  final bool isSetDefult;

  AddressUpdateSuccess(this.isSetDefult);
}

class AddressUpdateError extends AddressState {}

class AddressDeleteSuccess extends AddressState {}

class AddressDeleteError extends AddressState {}

class AddressCubit extends Cubit<AddressState> {
  AddressCubit() : super(AddressInitial());

  Future<void> addNewAddress({required AddressModel newAddress}) async {
    try {
      emit(AddressLoading());
      http.Response response = await AddressManagement().addNewAddress(
        address: newAddress,
        token: await SharedPrefManager().getData('token'),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        address = [];
        emit(AddressAddSuccess());
      } else {
        emit(AddressAddError());
      }
    } on Exception {
      emit(AddressAddError());
    }
  }

  Future<void> updateAddress(
      {required AddressModel newAddress, required bool isSetDefult}) async {
    try {
      emit(AddressLoading());
      http.Response response = await AddressManagement().updateAddress(
        address: newAddress,
        isSetDefult: isSetDefult,
        token: await SharedPrefManager().getData('token'),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        address = [];
        emit(AddressUpdateSuccess(isSetDefult ? true : false));
      } else {
        emit(AddressUpdateError());
      }
    } on Exception {
      emit(AddressUpdateError());
    }
  }

  Future<void> deleteAddress({required int id}) async {
    try {
      emit(AddressLoading());
      http.Response response = await AddressManagement().deleteAddress(
        id: id,
        token: await SharedPrefManager().getData('token'),
      );

      if (response.statusCode == 204 || response.statusCode == 205) {
        address = [];
        emit(AddressDeleteSuccess());
      } else {
        emit(AddressDeleteError());
      }
    } on Exception {
      emit(AddressDeleteError());
    }
  }
}
