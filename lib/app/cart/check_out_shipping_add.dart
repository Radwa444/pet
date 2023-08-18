import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_shop/base/checkout_slider.dart';
import 'package:pet_shop/base/color_data.dart';
import 'package:pet_shop/base/constant.dart';
import 'package:pet_shop/base/fetch_pixels.dart';
import 'package:pet_shop/base/get/cart_contr/shipping_add_controller.dart';
import 'package:pet_shop/base/get/home_controller.dart';
import 'package:pet_shop/base/get/storage_controller.dart';
import 'package:pet_shop/base/widget_utils.dart';
import 'package:pet_shop/woocommerce/model/customer.dart';

import '../../base/get/route_key.dart';
import '../../csc_picker/csc_picker.dart';

class CheckOutShippingAdd extends StatefulWidget {
  const CheckOutShippingAdd({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CheckOutShippingAdd();
  }
}

class _CheckOutShippingAdd extends State<CheckOutShippingAdd> {
  backClick(BuildContext context) {
    Constant.backToPrev(context);
  }

  StorageController storageController = Get.find<StorageController>();
  HomeController homeController = Get.find<HomeController>();

  TextEditingController fullNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  TextEditingController add1Controller = TextEditingController();
  TextEditingController add2Controller = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Constant.setupSize(context);

    double margin = FetchPixels.getDefaultHorSpaceFigma(context);

    return WillPopScope(
        child: Scaffold(
          backgroundColor: getScaffoldColor(context),
          body: GetBuilder(
            builder: (controller) {
              // Billing? wooCustomer = (homeController.currentCustomer != null)
              //     ? homeController.currentCustomer!.billing
              //     : null;
              // Shipping? shippingAddress =
              //     (homeController.currentCustomer != null)
              //         ? homeController.currentCustomer!.shipping
              //         : null;

              return Column(
                children: [
                  getDefaultHeader(context, "Check Out", () {
                    backClick(context);
                  }, isShowSearch: false),
                  20.h.verticalSpace,
                  CheckOutSlider(
                    icons: Constant.icons,
                    filledIcons: Constant.filledIcon,
                    itemSize: 24,
                    completeColor: getAccentColor(context),
                    currentColor: getFontColor(context),
                    currentPos: 0,
                  ).marginSymmetric(horizontal: margin),
                  20.h.verticalSpace,
                  Expanded(
                    flex: 1,
                    child: ListView(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        children: [
                          buildAddressWidget(
                              EdgeInsets.symmetric(
                                  horizontal: margin, vertical: 10.h),
                              context,
                              "Hawaii ",
                              "1901 Thornridge Cir. Shiloh, Hawaii 81063",
                              "(319) 555-0115",
                              homeController.isBillingAdd.value, () {
                            homeController.isBillingAdd.value = true;
                          }),
                          Container(
                            color: getCardColor(context),
                            child: getDivider(setColor: Colors.grey.shade300)
                                .marginSymmetric(horizontal: 20.h),
                          ),
                          buildAddressWidget(
                              EdgeInsets.symmetric(
                                  horizontal: margin, vertical: 10.h),
                              context,
                              "Kentucky",
                              "4517 Washington Ave. Manchester, Kentucky 39495",
                              "(704) 555-0127",
                              !homeController.isBillingAdd.value, () {
                            homeController.isBillingAdd.value = false;
                          }),
                        ]),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 267.h,
                      margin: EdgeInsets.only(top: 10.h),
                      height: getButtonHeightFigma(),
                      decoration: getButtonDecoration(
                        getGreyCardColor(context),
                        withCorners: true,
                        corner: getButtonCornersFigma(),
                      ),
                      child: InkWell(
                        onTap: () {
                          //   double verMargin = 20.h;
                          //   fullNameController = TextEditingController();
                          //   lastNameController = TextEditingController();
                          //   lastNameController = TextEditingController();
                          //   pinCodeController = TextEditingController();
                          //   add1Controller = TextEditingController();
                          //   add2Controller = TextEditingController();
                          //
                          //   Get.bottomSheet(
                          //     isScrollControlled: true,
                          //     backgroundColor: getCardColor(context),
                          //     ListView(
                          //         shrinkWrap: true,
                          //         children: [
                          //           buildAddField(context, margin, verMargin),
                          //           getButtonFigma(
                          //               context,
                          //               getAccentColor(context),
                          //               true,
                          //               "Save",
                          //               Colors.white, () async {
                          //             print("clciked=--true11");
                          //
                          //             if (fullNameController.text.isNotEmpty &&
                          //                 lastNameController.text.isNotEmpty &&
                          //                 shippingCont.countryValue.isNotEmpty &&
                          //                 shippingCont.stateValue.isNotEmpty &&
                          //                 shippingCont.cityValue.isNotEmpty &&
                          //                 pinCodeController.text.isNotEmpty &&
                          //                 add1Controller.text.isNotEmpty &&
                          //                 add2Controller.text.isNotEmpty) {
                          //               print("clciked=--true");
                          //               Shipping billing = Shipping(
                          //                   firstName: fullNameController.text
                          //                       .toString(),
                          //                   lastName: lastNameController.text
                          //                       .toString(),
                          //                   company: "uetu5ry",
                          //                   country: shippingCont.countryValue,
                          //                   city: shippingCont.cityValue,
                          //                   state: shippingCont.stateValue,
                          //                   address1: add1Controller.text,
                          //                   address2: add2Controller.text,
                          //                   postcode: pinCodeController.text);
                          //               await EasyLoading.show();
                          //
                          //               await homeController.wooCommerce!
                          //                   .updateCustomerShipping(
                          //                   id: homeController
                          //                       .currentCustomer!.id!,
                          //                   // data: {"shipping": [billing].toList().toString()});
                          //                   data: billing);
                          //               homeController.updateCurrentCustomer();
                          //               await EasyLoading.dismiss();
                          //               backClick(context);
                          //             } else {
                          //               print("clciked=--true");
                          //
                          //               showCustomToast("fill all detail");
                          //             }
                          //           },
                          //               EdgeInsets.symmetric(
                          //                   horizontal: margin, vertical: 15.h))
                          //         ]).paddingSymmetric(vertical: margin),
                          //     isDismissible: false,
                          //     shape: RoundedRectangleBorder(
                          //       borderRadius: BorderRadius.vertical(
                          //           top: Radius.circular(30.h)),
                          //     ),
                          //     enableDrag: false,
                          //   );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            getSvgImageWithSize(context, "add.svg", 24.h, 24.h,
                                color: getFontColor(context)),
                            12.h.horizontalSpace,
                            getCustomFont(
                                "Add New Address", 16, getFontColor(context), 1,
                                fontWeight: FontWeight.w600)
                          ],
                        ),
                      ),
                    ),
                  ),
                  getButtonFigma(
                      context, accentColor, true, "Next", Colors.white,
                      () async {
                    // ModelDummySelectedAdd selectedAdd;
                    // if (homeController.isBillingAdd.value) {
                    //   Billing billing =
                    //       homeController.currentCustomer!.billing!;
                    //   selectedAdd = ModelDummySelectedAdd(
                    //       billing.firstName ?? "",
                    //       billing.lastName ?? "",
                    //       billing.company ?? "",
                    //       billing.address1 ?? "",
                    //       billing.address2 ?? "",
                    //       billing.city ?? "",
                    //       billing.state ?? "",
                    //       billing.postcode ?? "",
                    //       billing.country ?? "");
                    // } else {
                    //   Shipping billing =
                    //       homeController.currentCustomer!.shipping!;
                    //   selectedAdd = ModelDummySelectedAdd(
                    //       billing.firstName ?? "",
                    //       billing.lastName ?? "",
                    //       billing.company ?? "",
                    //       billing.address1 ?? "",
                    //       billing.address2 ?? "",
                    //       billing.city ?? "",
                    //       billing.state ?? "",
                    //       billing.postcode ?? "",
                    //       billing.country ?? "");
                    // }
                    //
                    // storageController.selectedShippingAddress = selectedAdd;
                    Constant.sendToNext(context, checkoutScreenRoute);
                  }, EdgeInsets.symmetric(horizontal: margin, vertical: 15.h))
                ],
              );
            },
            init: HomeController(),
          ),
        ),
        onWillPop: () async {
          backClick(context);
          return true;
        });
  }

  Widget buildAddField(BuildContext context, double margin, double verMargin) {
    RxBool useShipping = false.obs;
    String countryValue = "";
    String stateValue = "";
    String cityValue = "";
    return ObxValue(
      (p0) {
        return Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: getCustomFont(
                    "Add New Address",
                    20,
                    getFontColor(context),
                    1,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: getSvgImageWithSize(context, "close.svg", 24.h, 24.h,
                      color: getFontColor(context)),
                )
              ],
            ).marginSymmetric(horizontal: margin),
            getDefaultTextFiled(context, "Full Name*", fullNameController,
                    getFontColor(context), (value) {})
                .marginOnly(top: verMargin),
            getDefaultTextFiled(context, "Last Name*", lastNameController,
                    getFontColor(context), (value) {})
                .marginSymmetric(vertical: verMargin),
            GetBuilder<ShippingAddressController>(
                builder: (controller1) {
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
                    selectedCountry: countryValue,
                    selectedState: stateValue,
                    selectedCity: cityValue,
                    // currentCity:shippingCont.cityValue,
                    // currentState:shippingCont.stateValue,

                    flagState: CountryFlag.SHOW_IN_DROP_DOWN_ONLY,
                    // defaultCountry: DefaultCountry.Bahrain,
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
                    // currentCountry: shippingCont.countryValue,
                    // currentState: shippingCont.stateValue,
                    // currentCity: shippingCont.cityValue,
                    onCountryChanged: (value) {
                      // print("getcountr===$value");
                      // countryValue = "";
                      // stateValue = "";
                      // cityValue = "";
                      // shippingCont.changeCountry(value);
                    },
                    onStateChanged: (value) {
                      // if (value != null) {
                      //   countryValue = "";
                      //   stateValue = "";
                      //   cityValue = "";
                      //   shippingCont.changeState(value);
                      // }
                    },
                    onCityChanged: (value) {
                      // if (value != null) {
                      //   countryValue = "";
                      //   stateValue = "";
                      //   cityValue = "";
                      //   shippingCont.changeCity(value);
                      // }
                    },
                  ).marginSymmetric(horizontal: margin);
                },
                init: ShippingAddressController()),
            getDefaultTextFiled(context, "Pin Code*", pinCodeController,
                    getFontColor(context), (value) {},
                    keyboardType: TextInputType.number)
                .marginSymmetric(vertical: verMargin),
            getDefaultTextFiled(context, "Address Line 1*", add1Controller,
                getFontColor(context), (value) {},
                keyboardType: TextInputType.text),
            getDefaultTextFiled(context, "Address Line 2*", add2Controller,
                    getFontColor(context), (value) {},
                    keyboardType: TextInputType.text)
                .marginSymmetric(vertical: verMargin),
            // getDefaultTextFiled(context, "Email*", emailController,
            //     getFontColor(context), (value) {},
            //     keyboardType: TextInputType.number),
            // getDefaultTextFiled(context, "Phone Number*", numberController,
            //         getFontColor(context), (value) {},
            //         keyboardType: TextInputType.phone)
            //     .marginSymmetric(vertical: verMargin),
            InkWell(
                onTap: () {
                  if (useShipping.isTrue) {
                    useShipping.value = false;
                  } else {
                    useShipping.value = true;
                    Shipping billing =
                        homeController.currentCustomer!.shipping!;
                    fullNameController.text = billing.firstName ?? "";
                    lastNameController.text = billing.lastName ?? "";
                    print("changecountry===${billing.country ?? ""}");
                    countryValue = billing.country ?? "";
                    stateValue = billing.city ?? "";
                    cityValue = billing.state ?? "";
                    // shippingCont.changeCountry(billing.country ?? "");
                    // shippingCont.changeCity(billing.city ?? "");
                    // shippingCont.changeState(billing.state ?? "");
                    pinCodeController.text = billing.postcode ?? "";
                    add1Controller.text = billing.address1 ?? "";
                    add2Controller.text = billing.address2 ?? "";
                    // shippingCont.update();
                  }
                },
                child: Row(
                  children: [
                    getSvgImageWithSize(
                        context,
                        (useShipping.isTrue) ? "check.svg" : "uncheck.svg",
                        24.h,
                        24.h),
                    10.h.horizontalSpace,
                    Expanded(
                      flex: 1,
                      child: getCustomFont("Use as shipping address", 14,
                          getFontColor(context), 1,
                          fontWeight: FontWeight.w400),
                    )
                  ],
                ).marginSymmetric(horizontal: margin)
                // child: ObxValue((p0) {
                //   return Row(
                //     children: [
                //       getSvgImageWithSize(
                //           context,
                //           (useShipping.isTrue) ? "check.svg" : "uncheck.svg",
                //           24.h,
                //           24.h),
                //       10.h.horizontalSpace,
                //       Expanded(
                //         flex: 1,
                //         child: getCustomFont(
                //             "Use as shipping address", 14, getFontColor(context), 1,
                //             fontWeight: FontWeight.w400),
                //       )
                //     ],
                //   ).marginSymmetric(horizontal: margin);
                // }, useShipping)
                ),
          ],
        );
      },
      useShipping,
    );
  }

  Container buildAddressWidget(
      EdgeInsets margin,
      BuildContext context,
      String title,
      String add,
      String mobile,
      bool isSelected,
      Function click) {
    return Container(
      color: getCardColor(context),
      padding: EdgeInsets.all(20.h),
      width: double.infinity,
      child: InkWell(
        onTap: () {
          click();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: getCustomFont(title, 16, getFontColor(context), 1,
                      fontWeight: FontWeight.w600),
                ),
                getSvgImageWithSize(
                  context,
                  (isSelected) ? "selected_radio.svg" : "unselected_radio.svg",
                  24.h,
                  24.h,
                  // color: getAccentColor(context)
                )
              ],
            ),
            getVerSpace(8.h),
            getCustomFont(add, 14, getFontColor(context), 2,
                fontWeight: FontWeight.w400),
            getVerSpace(8.h),
            getCustomFont(mobile, 14, getFontColor(context), 1,
                fontWeight: FontWeight.w400)
          ],
        ),
      ),
      // child: (homeController.currentCustomer!.shipping!=null)?:,
    );
  }

  Row buildTotalRow(BuildContext context, String total) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        getCustomFont(
          "Total",
          22,
          getFontColor(context),
          1,
          fontWeight: FontWeight.w700,
        ),
        getCustomFont(
          total,
          22,
          getFontColor(context),
          1,
          fontWeight: FontWeight.w700,
        ),
      ],
    );
  }
}
