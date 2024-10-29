import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fruitshub/bloc/address_cubit.dart';
import 'package:fruitshub/models/address.dart';
import 'package:fruitshub/widgets/address_controller.dart';
import 'package:fruitshub/widgets/my_textfield.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class AddressItem extends StatefulWidget {
  const AddressItem({
    super.key,
    required this.address,
  });

  final AddressModel address;

  @override
  State<AddressItem> createState() => _AddressItemState();
}

class _AddressItemState extends State<AddressItem> {
  late TextEditingController fullNameController;
  late TextEditingController cityController;
  late TextEditingController streetController;
  late TextEditingController apartmentController;
  late TextEditingController floorController;
  late TextEditingController postalCodeController;
  late TextEditingController phoneController;
  String? nameErrorText;
  String? cityErrorText;
  String? streetErrorText;
  String? floorNumberErrorText;
  String? apartmentNumberErrorText;
  String? postalCodeErrorText;
  String? phoneErrorText;

  @override
  void initState() {
    super.initState();
    fullNameController = TextEditingController(text: widget.address.fullName);
    cityController = TextEditingController(text: widget.address.city);
    streetController =
        TextEditingController(text: widget.address.streetAddress);
    apartmentController =
        TextEditingController(text: widget.address.apartmentNumber);
    floorController = TextEditingController(text: widget.address.floorNumber);
    postalCodeController =
        TextEditingController(text: widget.address.postalCode);
    phoneController = TextEditingController(text: widget.address.phoneNumber);

    // Update address values when text fields change
    fullNameController.addListener(() {
      widget.address.fullName = fullNameController.text;
    });
    cityController.addListener(() {
      widget.address.city = cityController.text;
    });
    streetController.addListener(() {
      widget.address.streetAddress = streetController.text;
    });
    apartmentController.addListener(() {
      widget.address.apartmentNumber = apartmentController.text;
    });
    floorController.addListener(() {
      widget.address.floorNumber = floorController.text;
    });
    postalCodeController.addListener(() {
      widget.address.postalCode = postalCodeController.text;
    });
    phoneController.addListener(() {
      widget.address.phoneNumber = phoneController.text;
    });
  }

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

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(screenWidth * 0.03),
      decoration: BoxDecoration(
        color: const Color(0xffF3F5F7),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              widget.address.isDefault
                  ? Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.02,
                        vertical: screenWidth * 0.01,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'العنوان الافتراضي',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth * 0.035,
                        ),
                      ),
                    )
                  : const SizedBox(),
              const Spacer(),
              Expanded(
                child: Text(
                  widget.address.fullName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.04,
                  ),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.right,
                ),
              ),
              SizedBox(width: screenWidth * 0.02),
              FaIcon(
                FontAwesomeIcons.userLarge,
                color: Colors.grey,
                size: screenWidth * 0.05,
              ),
            ],
          ),
          SizedBox(height: screenWidth * 0.03),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Text(
                  'المدينة: ${widget.address.city}',
                  style: TextStyle(fontSize: screenWidth * 0.04),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.right,
                ),
              ),
              SizedBox(width: screenWidth * 0.02),
              FaIcon(
                FontAwesomeIcons.city,
                color: Colors.grey,
                size: screenWidth * 0.05,
              ),
            ],
          ),
          SizedBox(height: screenWidth * 0.03),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Text(
                  'العنوان: ${widget.address.streetAddress}, شقة: ${widget.address.apartmentNumber.toString()}, طابق: ${widget.address.floorNumber.toString()}',
                  style: TextStyle(fontSize: screenWidth * 0.04),
                  textAlign: TextAlign.right,
                  softWrap: true,
                ),
              ),
              SizedBox(width: screenWidth * 0.02),
              FaIcon(
                FontAwesomeIcons.house,
                color: Colors.grey,
                size: screenWidth * 0.05,
              ),
            ],
          ),
          SizedBox(height: screenWidth * 0.03),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                widget.address.postalCode,
                style: TextStyle(fontSize: screenWidth * 0.04),
              ),
              Text(
                ' :الرمز البريدي',
                style: TextStyle(fontSize: screenWidth * 0.04),
              ),
              SizedBox(width: screenWidth * 0.02),
              FaIcon(
                FontAwesomeIcons.envelopeOpenText,
                color: Colors.grey,
                size: screenWidth * 0.05,
              ),
            ],
          ),
          SizedBox(height: screenWidth * 0.03),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'رقم الهاتف: ${widget.address.phoneNumber.toString()}',
                style: TextStyle(fontSize: screenWidth * 0.04),
              ),
              SizedBox(width: screenWidth * 0.02),
              FaIcon(
                FontAwesomeIcons.phone,
                color: Colors.grey,
                size: screenWidth * 0.05,
              ),
            ],
          ),
          SizedBox(height: screenWidth * 0.03),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              widget.address.isDefault
                  ? const Spacer(flex: 55)
                  : const Spacer(flex: 6),
              widget.address.isDefault
                  ? const SizedBox()
                  : AddressController(
                      title: ' تحديد كعنوان افتراضي ',
                      onTap: () {
                        BlocProvider.of<AddressCubit>(context).updateAddress(
                          newAddress: widget.address,
                          isSetDefult: true,
                        );
                      },
                    ),
              const Spacer(flex: 1),
              AddressController(
                title: ' ازاله ',
                onTap: () {
                  BlocProvider.of<AddressCubit>(context).deleteAddress(
                    id: widget.address.id,
                  );
                },
              ),
              const Spacer(flex: 1),
              AddressController(
                title: ' تعديل ',
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.white,
                    isScrollControlled: true,
                    builder: (context) {
                      return StatefulBuilder(
                        builder:
                            (BuildContext context, StateSetter setModalState) {
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
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  const Center(
                                    child: Text(
                                      'تعديل العنوان',
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
                                      controller: fullNameController,
                                      showprefixIcon: false,
                                      errorText: nameErrorText,
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
                                      showprefixIcon: false,
                                      align: TextAlign.right,
                                      errorText: streetErrorText,
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
                                      controller: apartmentController,
                                      showprefixIcon: false,
                                      inputType: TextInputType.number,
                                      errorText: apartmentNumberErrorText,
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
                                      controller: floorController,
                                      errorText: floorNumberErrorText,
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
                                      hint: 'الكود البريدي',
                                      controller: postalCodeController,
                                      showprefixIcon: false,
                                      align: TextAlign.right,
                                      errorText: postalCodeErrorText,
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
                                      showprefixIcon: false,
                                      errorText: phoneErrorText,
                                      align: TextAlign.right,
                                      readOnly: false,
                                      inputType: TextInputType.number,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  SizedBox(
                                    width: screenWidth * 0.90,
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        nameErrorText = null;
                                        cityErrorText = null;
                                        streetErrorText = null;
                                        floorNumberErrorText = null;
                                        apartmentNumberErrorText = null;
                                        postalCodeErrorText = null;
                                        phoneErrorText = null;
                                        setModalState(() {});
                                        if (widget.address.fullName.isEmpty ||
                                            widget.address.city.isEmpty ||
                                            widget.address.streetAddress
                                                .isEmpty ||
                                            widget.address.apartmentNumber
                                                .isEmpty ||
                                            widget
                                                .address.phoneNumber.isEmpty ||
                                            widget
                                                .address.floorNumber.isEmpty ||
                                            widget.address.postalCode.isEmpty) {
                                          showSnackBar(
                                            'الرجاء ادخال جميع الحقول المطلوبه',
                                            'error',
                                          );
                                        } else if (fullNameController.text
                                                .trim()
                                                .length <
                                            2) {
                                          nameErrorText =
                                              'الاسم يجب أن يحتوي على حرفين على الأقل';
                                          setModalState(() {});
                                        } else if (cityController.text
                                                .trim()
                                                .length <
                                            2) {
                                          cityErrorText =
                                              'المدينة يجب أن تحتوي على حرفين على الأقل';
                                          setModalState(() {});
                                        } else if (streetController.text
                                                .trim()
                                                .length <
                                            5) {
                                          streetErrorText =
                                              'الشارع يجب أن يحتوي على 5 أحرف على الأقل';
                                          setModalState(() {});
                                        } else if (apartmentController.text
                                            .trim()
                                            .isEmpty) {
                                          apartmentNumberErrorText =
                                              'رقم الشقة يجب أن يحتوي على حرف واحد على الأقل';
                                          setModalState(() {});
                                        } else if (floorController.text
                                            .trim()
                                            .isEmpty) {
                                          floorNumberErrorText =
                                              'رقم الطابق يجب أن يحتوي على حرف واحد على الأقل';
                                          setModalState(() {});
                                        } else if (postalCodeController.text
                                                    .trim()
                                                    .length <
                                                5 ||
                                            postalCodeController.text
                                                    .trim()
                                                    .length >
                                                10) {
                                          postalCodeErrorText =
                                              'الرمز البريدي يجب أن يكون بين 5 و 10 أحرف';
                                          setModalState(() {});
                                        } else if (phoneController.text
                                                    .trim()
                                                    .length <
                                                10 ||
                                            phoneController.text.trim().length >
                                                15) {
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

                                          BlocProvider.of<AddressCubit>(context)
                                              .updateAddress(
                                            newAddress: widget.address,
                                            isSetDefult: false,
                                          );
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xFF1B5E37),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 16),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                      child: const Text(
                                        'تعديل',
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
              ),
            ],
          )
        ],
      ),
    );
  }
}
