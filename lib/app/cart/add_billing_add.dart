import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_shop/base/color_data.dart';
import 'package:pet_shop/base/constant.dart';
import 'package:pet_shop/base/fetch_pixels.dart';
import 'package:pet_shop/base/get/home_controller.dart';
import 'package:pet_shop/base/get/storage_controller.dart';
import 'package:pet_shop/base/widget_utils.dart';

import '../../base/get/cart_contr/shipping_add_controller.dart';
import '../../csc_picker/csc_picker.dart';
import '../../woocommerce/model/customer.dart';

class AddBillingAddress extends StatefulWidget {
  const AddBillingAddress({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AddBillingAddress();
  }
}

class _AddBillingAddress extends State<AddBillingAddress> {
  backClick(BuildContext context) {
    Constant.backToPrev(context);
  }

  StorageController storageController = Get.find<StorageController>();
  HomeController homeController = Get.find<HomeController>();

  TextEditingController fullNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addLine1Controller = TextEditingController();
  TextEditingController addLine2Controller = TextEditingController();
  TextEditingController numberController = TextEditingController();
  Billing? wooCustomer;
  ShippingAddressController shippingCont =
      Get.find<ShippingAddressController>();

  @override
  void initState() {
    super.initState();
    Constant.getDelayFunction(() {
      wooCustomer = homeController.currentCustomer!.billing;
      if (wooCustomer!.country!.isNotEmpty) {
        shippingCont.changeCountry(wooCustomer!.country ?? "");
      }
      if (wooCustomer!.state!.isNotEmpty) {
        shippingCont.changeState(wooCustomer!.state ?? "");
      }
      if (wooCustomer!.city!.isNotEmpty) {
        shippingCont.changeState(wooCustomer!.city ?? "");
      }
    });
  }

  Widget buildAddField(BuildContext context, double margin, double verMargin) {
    // if (wooCustomer != null) {
    //   fullNameController.text = wooCustomer!.firstName ?? "";
    //   lastNameController.text = wooCustomer!.lastName ?? "";
    //   lastNameController.text = wooCustomer!.lastName ?? "";
    // }

    return ListView(
      children: [
        getDefaultTextFiled(context, "First Name", fullNameController,
            getFontColor(context), (value) {}),
        getDefaultTextFiled(context, "Last Name", lastNameController,
                getFontColor(context), (value) {})
            .marginSymmetric(vertical: verMargin),
        GetBuilder<ShippingAddressController>(
            builder: (controller) {
              return CSCPicker(
                showStates: true,

                disabledDropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20.h)),
                    color: getGreyCardColor(context),
                    border: Border.all(
                        color: getDividerColor(context), width: 1.h)),
                dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20.h)),
                    color: Colors.transparent,
                    border: Border.all(
                        color: getDividerColor(context), width: 1.h)),
                // getButtonDecoration(Colors.transparent,
                // withCorners: true, corner: 20.h,),

                /// Enable disable city drop down
                showCities: true,
                // currentCity: controller.cityValue, ,
                // currentCountry: controller.countryValue,
                flagState: CountryFlag.SHOW_IN_DROP_DOWN_ONLY,
                // selectedItemStyle:
                // TextStyle(
                // color: Colors.black,
                // fontSize: 14,
                // fontStyle: FontStyle.italic,
                // fontWeight: FontWeight.bold),
                dropdownItemStyle: buildTextStyle(
                    context,
                    getFontColor(context),
                    FontWeight.w400,
                    getEditFontSizeFigma()),
                selectedItemStyle: buildTextStyle(
                    context,
                    getFontColor(context),
                    FontWeight.w400,
                    getEditFontSizeFigma()),
                // currentState: controller.stateValue,
                onCountryChanged: (value) {
                  controller.changeCountry(value);
                },
                onStateChanged: (value) {
                  if (value != null) {
                    controller.changeState(value);
                  }
                },
                onCityChanged: (value) {
                  if (value != null) {
                    controller.changeCity(value);
                  }
                },
              ).marginSymmetric(horizontal: margin);
            },
            init: ShippingAddressController()),
        getDefaultTextFiled(context, "Pin Code*", pinCodeController,
                getFontColor(context), (value) {},
                keyboardType: TextInputType.number)
            .marginSymmetric(vertical: verMargin),
        getDefaultTextFiled(
          context,
          "Address Line 1 *",
          addLine1Controller,
          getFontColor(context),
          (value) {},
        ),
        getDefaultTextFiled(
          context,
          "Address Line 2 *",
          addLine2Controller,
          getFontColor(context),
          (value) {},
        ).marginSymmetric(vertical: verMargin),
        getDefaultTextFiled(
          context,
          "Email*",
          emailController,
          getFontColor(context),
          (value) {},
        ),
        getDefaultTextFiled(context, "Phone Number*", numberController,
                getFontColor(context), (value) {},
                keyboardType: TextInputType.phone)
            .marginSymmetric(vertical: verMargin),
        Row(
          children: [
            getSvgImageWithSize(context, "check.svg", 24.h, 24.h),
            10.h.horizontalSpace,
            Expanded(
              flex: 1,
              child: getCustomFont(
                  "Use as shipping address", 14, getFontColor(context), 1,
                  fontWeight: FontWeight.w400),
            )
          ],
        ).marginSymmetric(horizontal: margin),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Constant.setupSize(context);

    double margin = FetchPixels.getDefaultHorSpaceFigma(context);
    double verMargin = 20.h;

    return WillPopScope(
        child: Scaffold(
            appBar: getTitleAppBar(context, () {
              backClick(context);
            }, title: "Add Billing Address", isCartAvailable: false),
            body: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: buildAddField(context, margin, verMargin),
                ),
                getButtonFigma(context, getAccentColor(context), true, "Save",
                    Colors.white, () async {
                  if (fullNameController.text.isEmpty) {
                    showCustomToast('Add full name');
                  } else if (lastNameController.text.isEmpty) {
                    showCustomToast('Add last name');
                  } else if (shippingCont.countryValue.isEmpty) {
                    showCustomToast('Add country name');
                  } else if (shippingCont.stateValue.isEmpty) {
                    showCustomToast('Add state');
                  } else if (shippingCont.cityValue.isEmpty) {
                    showCustomToast('Add city');
                  } else if (pinCodeController.text.isEmpty) {
                    showCustomToast('Add valid pin code');
                  } else if (addLine1Controller.text.isEmpty) {
                    showCustomToast('Add valid Address');
                  } else if (addLine2Controller.text.isEmpty) {
                    showCustomToast('Add valid Address');
                  } else if (emailController.text.isEmpty) {
                    showCustomToast('Add valid email');
                  } else if (numberController.text.isEmpty) {
                    showCustomToast('Add valid phone number');
                  } else {
                    Billing billing = Billing(
                        firstName: fullNameController.text.toString(),
                        lastName: lastNameController.text.toString(),
                        email: emailController.text.toString(),
                        phone: numberController.text.toString(),
                        country: shippingCont.countryValue,
                        city: shippingCont.cityValue,
                        state: shippingCont.stateValue,
                        address1: addLine1Controller.text,
                        address2: addLine2Controller.text,
                        postcode: pinCodeController.text);
                    await EasyLoading.show();

                    await homeController.wooCommerce!.updateCustomer(
                        id: homeController.currentCustomer!.id!,
                        data: {"billing": billing.toJson()});
                    // homeController.currentCustomer=getCurrentCustomer;
                    homeController.updateCurrentCustomer();

                    // homeController.updateCurrentCustomer();
                    await EasyLoading.dismiss();
                    Future.delayed(
                      Duration.zero,
                      () {
                        backClick(context);
                      },
                    );
                  }

                  // if (fullNameController.text.isNotEmpty &&
                  //     lastNameController.text.isNotEmpty &&
                  //     shippingCont.countryValue.isNotEmpty &&
                  //     shippingCont.stateValue.isNotEmpty &&
                  //     shippingCont.cityValue.isNotEmpty &&
                  //     pinCodeController.text.isNotEmpty &&
                  //     addLine1Controller.text.isNotEmpty &&
                  //     addLine2Controller.text.isNotEmpty &&
                  //     pinCodeController.text.isNotEmpty &&
                  //     emailController.text.isNotEmpty &&
                  //     numberController.text.isNotEmpty) {
                  //   Billing billing = Billing(
                  //       firstName: fullNameController.text.toString(),
                  //       lastName: lastNameController.text.toString(),
                  //       email: emailController.text.toString(),
                  //       phone: numberController.text.toString(),
                  //       country: shippingCont.countryValue,
                  //       city: shippingCont.cityValue,
                  //       state: shippingCont.stateValue,
                  //       address1: addLine1Controller.text,
                  //       address2: addLine2Controller.text,
                  //       postcode: pinCodeController.text);
                  //   await EasyLoading.show();
                  //
                  //
                  //   await homeController.wooCommerce!.updateCustomer(
                  //       id: homeController.currentCustomer!.id!,
                  //       data: {"billing": billing.toJson()});
                  //   // homeController.currentCustomer=getCurrentCustomer;
                  //   homeController.updateCurrentCustomer();
                  //
                  //   // homeController.updateCurrentCustomer();
                  //   await EasyLoading.dismiss();
                  //   backClick(context);
                  // }
                }, EdgeInsets.symmetric(horizontal: margin, vertical: 15.h))
              ],
            )),
        onWillPop: () async {
          backClick(context);
          return true;
        });
  }
}
