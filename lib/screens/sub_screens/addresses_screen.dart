import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fruitshub/API/address_management.dart';
import 'package:fruitshub/auth/helpers/shared_pref_manager.dart';
import 'package:fruitshub/bloc/address_cubit.dart';
import 'package:fruitshub/globals.dart';
import 'package:fruitshub/models/address.dart';
import 'package:fruitshub/widgets/address_item.dart';
import 'package:fruitshub/widgets/my_textfield.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class AddressesScreen extends StatefulWidget {
  const AddressesScreen({super.key});

  @override
  State<AddressesScreen> createState() => _AddressesScreenState();
}

class _AddressesScreenState extends State<AddressesScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController floorNumberController = TextEditingController();
  TextEditingController apartmentNumberController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  String? nameErrorText;
  String? cityErrorText;
  String? streetErrorText;
  String? floorNumberErrorText;
  String? apartmentNumberErrorText;
  String? postalCodeErrorText;
  String? phoneErrorText;

  bool isDefault = true;
  final addressManagement = AddressManagement();

  void showSnackBar(String message, String snackBarType) {
    if (snackBarType == 'info') {
      showTopSnackBar(
        Overlay.of(context),
        displayDuration: const Duration(milliseconds: 10),
        CustomSnackBar.info(
          message: message,
          textAlign: TextAlign.center,
          textStyle: const TextStyle(
            fontFamily: 'Cairo',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      );
    } else {
      showTopSnackBar(
        Overlay.of(context),
        displayDuration: const Duration(milliseconds: 1000),
        CustomSnackBar.error(
          message: message,
          textAlign: TextAlign.center,
          textStyle: const TextStyle(
            fontFamily: 'Cairo',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      );
    }
  }

  void clearControllers() {
    nameController.clear();
    cityController.clear();
    streetController.clear();
    floorNumberController.clear();
    apartmentNumberController.clear();
    postalCodeController.clear();
    phoneController.clear();
  }

  Future<List<AddressModel>> getAllAddresses() async {
    return await addressManagement.getAllAddresses(
      token: await SharedPrefManager().getData('token'),
    );
  }

  Future<List<AddressModel>> requestData() async {
    if (address.isEmpty) {
      address = await getAllAddresses();
    }
    return address;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'العناوين',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          clearControllers();
          nameErrorText = null;
          cityErrorText = null;
          streetErrorText = null;
          floorNumberErrorText = null;
          apartmentNumberErrorText = null;
          postalCodeErrorText = null;
          phoneErrorText = null;
          showModalBottomSheet(
            context: context,
            backgroundColor: Colors.white,
            isScrollControlled: true,
            builder: (context) {
              return StatefulBuilder(
                builder: (BuildContext context, StateSetter setModalState) {
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 70,
                                height: 4,
                                decoration: BoxDecoration(
                                  color: Colors.grey[400],
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          const Center(
                            child: Text(
                              'اضافه عنوان جديد',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.03,
                            ),
                            child: MyTextField(
                              hint: 'الاسم',
                              errorText: nameErrorText,
                              controller: nameController,
                              showprefixIcon: false,
                              align: TextAlign.right,
                              readOnly: false,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.03,
                            ),
                            child: MyTextField(
                              hint: 'المدينه',
                              controller: cityController,
                              errorText: cityErrorText,
                              showprefixIcon: false,
                              align: TextAlign.right,
                              readOnly: false,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.03,
                            ),
                            child: MyTextField(
                              hint: 'الشارع',
                              controller: streetController,
                              errorText: streetErrorText,
                              showprefixIcon: false,
                              align: TextAlign.right,
                              readOnly: false,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.03,
                            ),
                            child: MyTextField(
                              hint: 'رقم الشقه',
                              controller: apartmentNumberController,
                              errorText: apartmentNumberErrorText,
                              showprefixIcon: false,
                              inputType: TextInputType.number,
                              align: TextAlign.right,
                              readOnly: false,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.03,
                            ),
                            child: MyTextField(
                              hint: 'رقم الدور',
                              controller: floorNumberController,
                              showprefixIcon: false,
                              errorText: floorNumberErrorText,
                              inputType: TextInputType.number,
                              align: TextAlign.right,
                              readOnly: false,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.03,
                            ),
                            child: MyTextField(
                              hint: 'الكود البريدي',
                              controller: postalCodeController,
                              showprefixIcon: false,
                              errorText: postalCodeErrorText,
                              align: TextAlign.right,
                              readOnly: false,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.03,
                            ),
                            child: MyTextField(
                              hint: 'رقم الهاتف',
                              controller: phoneController,
                              errorText: phoneErrorText,
                              showprefixIcon: false,
                              align: TextAlign.right,
                              readOnly: false,
                              inputType: TextInputType.number,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.02,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Text('تعيين كعنوان افتراضي'),
                                Checkbox(
                                  value: isDefault,
                                  activeColor: Colors.green[600],
                                  onChanged: (value) {
                                    setModalState(() {
                                      isDefault = value ?? false;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: screenWidth * 0.90,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (nameController.text.isEmpty ||
                                    cityController.text.isEmpty ||
                                    streetController.text.isEmpty ||
                                    phoneController.text.isEmpty ||
                                    floorNumberController.text.isEmpty ||
                                    apartmentNumberController.text.isEmpty ||
                                    postalCodeController.text.isEmpty) {
                                  showSnackBar(
                                    'الرجاء ادخال جميع الحقول المطلوبه',
                                    'error',
                                  );
                                } else if (nameController.text.trim().length <
                                    2) {
                                  nameErrorText =
                                      'الاسم يجب أن يحتوي على حرفين على الأقل';
                                  setModalState(() {});
                                } else if (cityController.text.trim().length <
                                    2) {
                                  cityErrorText =
                                      'المدينة يجب أن تحتوي على حرفين على الأقل';
                                  setModalState(() {});
                                } else if (streetController.text.trim().length <
                                    5) {
                                  streetErrorText =
                                      'الشارع يجب أن يحتوي على 5 أحرف على الأقل';
                                  setModalState(() {});
                                } else if (apartmentNumberController.text
                                    .trim()
                                    .isEmpty) {
                                  apartmentNumberErrorText =
                                      'رقم الشقة يجب أن يحتوي على حرف واحد على الأقل';
                                  setModalState(() {});
                                } else if (floorNumberController.text
                                    .trim()
                                    .isEmpty) {
                                  floorNumberErrorText =
                                      'رقم الطابق يجب أن يحتوي على حرف واحد على الأقل';
                                  setModalState(() {});
                                } else if (postalCodeController.text
                                            .trim()
                                            .length <
                                        5 ||
                                    postalCodeController.text.trim().length >
                                        10) {
                                  postalCodeErrorText =
                                      'الرمز البريدي يجب أن يكون بين 5 و 10 أحرف';
                                  setModalState(() {});
                                } else if (phoneController.text.trim().length <
                                        10 ||
                                    phoneController.text.trim().length > 15) {
                                  phoneErrorText =
                                      'رقم الهاتف يجب أن يكون بين 10 و 15 حرف';
                                  setModalState(() {});
                                } else {
                                  nameErrorText = null;
                                  cityErrorText = null;
                                  streetErrorText = null;
                                  floorNumberErrorText = null;
                                  apartmentNumberErrorText = null;
                                  postalCodeErrorText = null;
                                  phoneErrorText = null;
                                  setModalState(() {});

                                  // Show loading dialog
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (context) => const Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.black,
                                      ),
                                    ),
                                  );

                                  // Create AddressModel
                                  final address = AddressModel(
                                    id: 0,
                                    fullName: nameController.text,
                                    city: cityController.text,
                                    streetAddress: streetController.text,
                                    apartmentNumber:
                                        apartmentNumberController.text,
                                    floorNumber: floorNumberController.text,
                                    phoneNumber: phoneController.text,
                                    postalCode: postalCodeController.text,
                                    isDefault: isDefault,
                                  );

                                  BlocProvider.of<AddressCubit>(this.context)
                                      .addNewAddress(
                                    newAddress: address,
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF1B5E37),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text(
                                'اضافه عنوان',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
        backgroundColor: Colors.green[100],
        child: Icon(
          Icons.add,
          color: Colors.grey.shade600,
          size: screenWidth * 0.09,
        ),
      ),
      body: BlocConsumer<AddressCubit, AddressState>(
        listener: (context, state) {
          if (state is AddressAddSuccess) {
            Navigator.pop(context);
            Navigator.pop(context);
            showSnackBar(
              'تم اضافه العنوان بنجاح',
              'info',
            );
            clearControllers();
          } else if (state is AddressAddError) {
            Navigator.pop(context);
            showSnackBar(
              'فشل اضافه العنوان. الرجاء المحاوله مره اخرى',
              'error',
            );
          } else if (state is AddressUpdateSuccess) {
            if (state.isSetDefult) {
            } else {
              Navigator.pop(context);
              Navigator.pop(context);
            }
            showSnackBar(
              'تم تعديل العنوان بنجاح',
              'info',
            );
            clearControllers();
          } else if (state is AddressUpdateError) {
            showSnackBar(
              'فشل تعديل العنوان. الرجاء المحاوله مره اخرى',
              'error',
            );
          } else if (state is AddressDeleteSuccess) {
            showSnackBar(
              'تم حذف العنوان بنجاح',
              'info',
            );
            clearControllers();
          } else if (state is AddressDeleteError) {
            showSnackBar(
              'فشل حذف العنوان. الرجاء المحاوله مره اخرى',
              'error',
            );
          }
        },
        builder: (context, state) {
          if (state is AddressLoading) {
            return const SpinKitThreeBounce(
              color: Colors.green,
              size: 50.0,
            );
          }

          return FutureBuilder<List<AddressModel>>(
            future: getAllAddresses(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SpinKitThreeBounce(
                  color: Colors.green,
                  size: 50.0,
                );
              }

              if (snapshot.hasError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/error.png',
                        width: screenHeight * 0.5,
                        height: screenHeight * 0.25,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      Text(
                        '! حدث خطا اثناء تحميل البيانات',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.05,
                        ),
                      ),
                    ],
                  ),
                );
              }

              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/noResult.png',
                        width: screenHeight * 0.5,
                        height: screenHeight * 0.25,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      Text(
                        'لم يتم اضافه عناوين',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.05,
                        ),
                      ),
                    ],
                  ),
                );
              }
              List<AddressModel> myAddresses = snapshot.data!;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ListView.builder(
                  itemCount: myAddresses.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: AddressItem(
                        address: myAddresses[index],
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
