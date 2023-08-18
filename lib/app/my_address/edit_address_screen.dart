import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_shop/base/fetch_pixels.dart';

import '../../base/color_data.dart';
import '../../base/constant.dart';
import '../../base/widget_utils.dart';
import '../../csc_picker/csc_picker.dart';

class EditAddressScreen extends StatefulWidget {
  bool? isBilling;
  bool? isShipping;

  EditAddressScreen({Key? key, this.isBilling, this.isShipping})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _EditAddressScreen();
  }
}

class _EditAddressScreen extends State<EditAddressScreen> {
  backClick(BuildContext context) {
    Constant.backToPrev(context);
  }

  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  TextEditingController add1Controller = TextEditingController();
  TextEditingController add2Controller = TextEditingController();

  String countryValue = "Kentucky";
  String stateValue = "Manchester";
  String cityValue = "";

  @override
  void initState() {
    super.initState();
    fullNameController.text = "Leslie Alexander";
    emailController.text = "lesliealexander@gmail.com";
    pinCodeController.text = "(704) 555-0127";
    add1Controller.text = "4517 Washington Ave. Manchester, Kentucky 39495";
    add2Controller.text = "";
  }

  @override
  Widget build(BuildContext context) {
    Constant.setupSize(context);
    double horSpace = FetchPixels.getDefaultHorSpaceFigma(context);

    return WillPopScope(
      onWillPop: () async {
        backClick(context);
        return false;
      },
      child: Scaffold(
        backgroundColor: getScaffoldColor(context),
        body: Column(
          children: [
            getDefaultHeader(context, "Edit Address", () {
              backClick(context);
            }, isShowSearch: false),
            Expanded(
              flex: 1,
              child: Container(
                color: getCardColor(context),
                padding: EdgeInsets.symmetric(vertical: 10.h),
                margin: EdgeInsets.symmetric(vertical: 20.h),
                child: ListView(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  children: [
                    20.h.verticalSpace,
                    getCustomFont("Full name", 16, getFontColor(context), 1,
                            fontWeight: FontWeight.w400)
                        .marginSymmetric(horizontal: horSpace),
                    6.h.verticalSpace,
                    getDefaultTextFiled(context, "Enter Full Name",
                        fullNameController, getFontColor(context), (value) {}),
                    20.h.verticalSpace,
                    getCustomFont("Address", 16, getFontColor(context), 1,
                            fontWeight: FontWeight.w400)
                        .marginSymmetric(horizontal: horSpace),
                    6.h.verticalSpace,
                    getDefaultTextFiled(context, "Enter Address",
                        add1Controller, getFontColor(context), (value) {}),
                    20.h.verticalSpace,
                    CSCPicker(
                      showStates: true,
                      currentCountry: countryValue,
                      currentState: stateValue,

                      disabledDropdownDecoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(12.h)),
                          color: Colors.transparent,
                          border: Border.all(color: black20, width: 1.h)),
                      dropdownDecoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(12.h)),
                          color: Colors.transparent,
                          border: Border.all(color: black20, width: 1.h)),
                      // getButtonDecoration(Colors.transparent,
                      // withCorners: true, corner: 20.h,),

                      /// Enable disable city drop down
                      showCities: false,
                      // currentCity: controller.cityValue, ,
                      selectedCountry: countryValue,
                      selectedState: stateValue,
                      selectedCity: "",
                      flagState: CountryFlag.SHOW_IN_DROP_DOWN_ONLY,
                      layout: Layout.vertical,
                      countrySearchPlaceholder: "Select Country",
                      stateSearchPlaceholder: "Select Town",

                      dropdownItemStyle: buildTextStyle(
                          context, getFontColor(context), FontWeight.w400, 16),
                      selectedItemStyle: buildTextStyle(
                          context, getFontColor(context), FontWeight.w400, 16),
                      onCountryChanged: (value) {},
                      onStateChanged: (value) {},
                      onCityChanged: (value) {},
                    ),
                    20.h.verticalSpace,
                    getCustomFont("Email", 16, getFontColor(context), 1,
                            fontWeight: FontWeight.w400)
                        .marginSymmetric(horizontal: horSpace),
                    6.h.verticalSpace,
                    getDefaultTextFiled(context, "Enter email", emailController,
                        getFontColor(context), (value) {},
                        keyboardType: TextInputType.emailAddress),
                    20.h.verticalSpace,
                    getCustomFont("Phone Number", 16, getFontColor(context), 1,
                            fontWeight: FontWeight.w400)
                        .marginSymmetric(horizontal: horSpace),
                    6.h.verticalSpace,
                    getDefaultTextFiled(context, "Enter phone number",
                        pinCodeController, getFontColor(context), (value) {},
                        keyboardType: TextInputType.number),
                  ],
                ),
              ),
            ),
            getButtonFigma(
                context, getAccentColor(context), true, "Save", Colors.white,
                () async {
              backClick(context);
            }, EdgeInsets.symmetric(horizontal: 20.h, vertical: 15.h)),
          ],
        ),
      ),
    );
  }
}
