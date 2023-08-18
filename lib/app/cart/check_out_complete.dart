import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:pet_shop/base/checkout_slider.dart';
import 'package:pet_shop/base/color_data.dart';
import 'package:pet_shop/base/constant.dart';
import 'package:pet_shop/base/data_file.dart';
import 'package:pet_shop/base/fetch_pixels.dart';
import 'package:pet_shop/base/get/already_in_cart.dart';
import 'package:pet_shop/base/get/home_controller.dart';
import 'package:pet_shop/base/get/product_data.dart';
import 'package:pet_shop/base/get/route_key.dart';
import 'package:pet_shop/base/get/storage_controller.dart';
import 'package:pet_shop/base/widget_utils.dart';
import '../../base/get/cart_contr/cart_controller.dart';
import '../../csc_picker/csc_picker.dart';
import '../../woocommerce/model/model_shipping_method.dart';
import '../../woocommerce/model/model_tax.dart';
import '../model_ui/model_cart.dart';

class CheckOutComplete extends StatefulWidget {
  const CheckOutComplete({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CheckOutComplete();
  }
}

class _CheckOutComplete extends State<CheckOutComplete> {
  backClick(BuildContext context) {
    Constant.backToPrev(context);
  }

  RxBool isCouponApply = false.obs;
  String inputCoupon = '';
  String finalInputCoupon = '';

  StorageController storageController = Get.find<StorageController>();
  ProductDataController productDataController =
      Get.find<ProductDataController>();
  HomeController homeController = Get.find<HomeController>();
  CartController cartController = Get.find<CartController>();
  AlreadyInCart alreadyInCart = Get.find<AlreadyInCart>();
  Rx<ModelShippingMethod?> selectedShippingMethod = (null).obs;
  List<ModelShippingMethod> shippingMethods = [];
  RxBool shippingMthLoaded = false.obs;

  // Rx<List<ModelShippingMethod?>> shippingMethods = (null as List<ModelShippingMethod?>).obs;

  Rx<ModelTax?> taxModel = (null).obs;

  @override
  void initState() {
    super.initState();
    getShippingMethods();
    getTaxRates();
  }

  getTaxRates() async {
    List<ModelTax> rateList = await homeController.wooCommerce!.getAllTax();
    if (rateList.isNotEmpty) {
      String countrySet = await CSCPickerState().getCountriesCode(
              storageController.selectedShippingAddress!.country) ??
          "";
      print('country-----$countrySet');

      for (int i = 0; i < rateList.length; i++) {
        ModelTax modelTax = rateList[i];
        print("modelTax----${modelTax.country}");
        if (modelTax.country == countrySet) {
          taxModel.value = modelTax;
          return;
        }
      }
    }
  }

  getShippingMethods() async {
    String zoneId = await productDataController.getShippingMethodZoneId(
        homeController.wooCommerce!,
        storageController.selectedShippingAddress!.country);
    shippingMethods =
        await homeController.wooCommerce!.getAllShippingMethods(zoneId);
    print(
        'zoneId-----$zoneId-----${storageController.selectedShippingAddress!.country}');
    shippingMthLoaded.value = true;
  }

  List<ModelCart> cartList = DataFile.getAllCartList();

  @override
  Widget build(BuildContext context) {
    Constant.setupSize(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {});
    double margin = FetchPixels.getDefaultHorSpaceFigma(context);
    return WillPopScope(
        child: Scaffold(
          backgroundColor: getScaffoldColor(context),
          body: Column(
            children: [
              getDefaultHeader(context, "Check Out", () {
                backClick(context);
              }, isShowSearch: false),
              CheckOutSlider(
                icons: Constant.icons,
                filledIcons: Constant.filledIcon,
                itemSize: 24,
                completeColor: getAccentColor(context),
                currentColor: black40,
                currentPos: 2,
              ).marginSymmetric(horizontal: margin, vertical: margin),
              Expanded(
                flex: 1,
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    Container(
                      color: getCardColor(context),
                      padding: EdgeInsets.all(margin),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildTitleWidget(context, "Shipping Address"),
                          getVerSpace(12.h),
                          getMultilineCustomFont(
                              "1901 Thornridge Cir. Shiloh, Hawaii 81063",
                              14,
                              getFontColor(context),
                              fontWeight: FontWeight.w400),
                        ],
                      ),
                    ),
                    getVerSpace(20.h),
                    Container(
                      color: getCardColor(context),
                      padding: EdgeInsets.all(margin),
                      child: Builder(
                        builder: (context) {
                          // WooPaymentGateway modelPaymentGateway =
                          // storageController.selectedPaymentGateway!;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildTitleWidget(context, "Payment Method"),
                              getVerSpace(12.h),
                              Row(
                                children: [
                                  getSvgImage(context, "paypal.svg", 40),
                                  getHorSpace(12.h),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      getCustomFont("Paypal", 14,
                                          getFontColor(context), 1,
                                          fontWeight: FontWeight.w400),
                                      getVerSpace(6.h),
                                      getCustomFont("XXXX XXXX XXXX 2563", 14,
                                          getFontColor(context), 1,
                                          fontWeight: FontWeight.w400),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    getVerSpace(20.h),
                    Container(
                      padding: EdgeInsets.all(20.h),
                      color: getCardColor(context),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildTitleWidget(context, "Cart Detail"),
                          getVerSpace(20.h),
                          ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              ModelCart cart = cartList[index];
                              return buildMyCartItem(
                                context,
                                cart,
                                112.h,
                                () {},
                                //         () async {
                                //   isCouponApply.value = false;
                                //   controller.coupon.clear();
                                //   controller.clearPromoPrice();
                                //   controller.increaseQuantity(index);
                                // }, () async {
                                //   if (controller
                                //       .cartOtherInfoList[index]
                                //       .quantity! !=
                                //       1) {
                                //     isCouponApply.value = false;
                                //   }
                                //   controller.cartOtherInfoList[index]
                                //       .quantity! >
                                //       1
                                //       ? controller
                                //       .decreaseQuantity(index)
                                //       : controller
                                //       .cartOtherInfoList[index]
                                //       .quantity = 1;
                                //
                                //   // controller.decreaseQuantity(index);
                                // }, () {
                                //   controller.removeItemInfo(controller
                                //       .cartOtherInfoList[index]
                                //       .productName
                                //       .toString());
                                //   controller.coupon.clear();
                                //   controller.clearPromoPrice();
                                //   isCouponApply.value = false;
                                //   if (controller
                                //       .cartOtherInfoList.isEmpty) {
                                //     // Constant.sendToNext(
                                //     //     context, myCartScreenRoute);
                                //   }
                                // }
                              );
                            },
                            itemCount: cartList.length,
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return getDivider(setColor: Colors.grey.shade300)
                                  .marginSymmetric(vertical: 20.h);
                            },
                          )
                        ],
                      ),
                    ),
                    getVerSpace(20.h),
                    Container(
                      color: getCardColor(context),
                      child: GetBuilder<CartController>(
                          init: CartController(),
                          builder: (controller) {
                            return Column(
                              children: [
                                buildSubtotalRow(
                                    context, "Subtotal", "\$80.00"),
                                getDivider(setColor: Colors.grey.shade300)
                                    .marginSymmetric(vertical: 14.h),
                                buildSubtotalRow(context, "Shipping", "Free"),
                                getDivider(setColor: Colors.grey.shade300)
                                    .marginSymmetric(vertical: 14.h),
                                buildSubtotalRow(
                                  context,
                                  "Tax",
                                  "+\$2.00",
                                ),
                                getDivider(setColor: Colors.grey.shade300)
                                    .marginSymmetric(vertical: 14.h),
                                buildSubtotalRow(
                                    context, "Discount", "-\$5.00"),
                                getDivider(setColor: Colors.grey.shade300)
                                    .marginSymmetric(vertical: 14.h),
                                buildTotalRow(
                                  context,
                                  "Total",
                                  "\$77.00",
                                ),
                              ],
                            ).marginSymmetric(
                                horizontal: margin, vertical: 20.h);
                          }),
                    )
                  ],
                ),
              ),
              getButtonFigma(context, getAccentColor(context), true,
                  "Confirm Order", Colors.white, () {
                Constant.sendToNext(context, orderConfirmScreenRoute);
                // Payments.completePaymentProgress(
                //     context,
                //     storageController.selectedPaymentGateway!,
                //         () async {},
                //     homeController.currentCustomer!,
                //     getTotalString(),
                //     getSubTotal(),
                //     cartController.tax,
                //     storageController.selectedShippingRate.value,
                //     cartController.cartOtherInfoList,
                //     storageController.selectedShippingAddress!,
                //         (isPaid) async {
                //       print("Getres--create--order----true");
                //
                //       storageController.selectedShippingAddress!.country =
                //           (await CSCPickerState().getCountriesCode(
                //               storageController
                //                   .selectedShippingAddress!.country)) ??
                //               "";
                //       print(
                //           'country-----${storageController.selectedShippingAddress!.country}');
                //       bool isCreated = await homeController.wooCommerce!
                //           .createOrder(
                //           homeController.currentCustomer!,
                //           cartController.cartItems,
                //           storageController
                //               .selectedPaymentGateway!.methodTitle!,
                //           isPaid,
                //           storageController.selectedShippingAddress!,
                //           cartController.coupon,
                //           cartController.shippingLines);
                //       print('isCreated-------$isCreated');
                //       if (isCreated) {
                //         EasyLoading.dismiss();
                //
                //         // WooGetCreatedOrder? order = productDataController.myOrderList[0];
                //         cartController.clearCart();
                //         alreadyInCart.alreadyInPurchase.value = false;
                //         storageController.currentQuantity.value = 1;
                //
                //         // WidgetsBinding.instance.addPostFrameCallback((_) {
                //         //   showGetDialog(
                //         //       context,
                //         //       "order_confirm.png",
                //         //       "Order Confirm",
                //         //       "Your order has been successfully\ncompleted!",
                //         //       "Ok", () async {
                //         //     backClick(context);
                //         //     Future.delayed(
                //         //       Duration.zero,
                //         //           () {
                //         //         Constant.sendToNext(
                //         //             context, myOrderScreenRoute);
                //         //       },
                //         //     );
                //         //   },
                //         //       dialogHeight: 464,
                //         //       imgHeight: 146,
                //         //       imgWidth: 146,
                //         //       fit: BoxFit.fill,
                //         //       barrierDismissible: false
                //         //
                //         //   );
                //         // });
                //         WidgetsBinding.instance
                //             .addPostFrameCallback((timeStamp) {
                //           Constant.sendToScreen(
                //               OrderConfirmScreen(), context, (value) {});
                //           // Constant.sendToNext(
                //           //     context, orderConfirmScreenRoute);
                //         });
                //       } else {
                //         EasyLoading.showError("Order not created");
                //
                //         Constant.sendToNext(context, homeScreenRoute);
                //       }
                //     });
              }, EdgeInsets.symmetric(horizontal: margin, vertical: 20.h))
            ],
          ),
        ),
        onWillPop: () async {
          backClick(context);
          return true;
        });
  }

  String getTotalString() {
    double totalVals = (isCouponApply.value)
        ? (cartController.cartTotalPriceF(1) -
            cartController.promoPrice +
            double.parse(getTax()))
        : cartController.cartTotalPriceF(1) + double.parse(getTax());

    if (selectedShippingMethod.value != null) {
      totalVals = totalVals +
          double.parse(
              selectedShippingMethod.value!.settings!.cost!.value ?? "0");
    }
    return totalVals.toString();
    // return (isCouponApply.value)
    //     ? (cartController.cartTotalPriceF(1) - cartController.promoPrice)
    //         .toString()
    //     : cartController.cartTotalPriceF(1).toString();
  }

  String getSubTotal() {
    return cartController.cartTotalPriceF(1).toString();
  }

  String getTax() {
    double total = double.parse(getSubTotal());
    double tax = 0;
    double vatTax = 0;
    double shippingTax = 0;
    if (taxModel.value != null) {
      vatTax = (double.parse(taxModel.value!.rate ?? "0"));
    }
    if (taxModel.value != null) {
      tax = (total * vatTax) / 100;
    }
    if (selectedShippingMethod.value != null) {
      shippingTax = double.parse(
              selectedShippingMethod.value!.settings!.cost!.value ?? "0") *
          vatTax /
          100;
    }

    double totalTax = tax;
    if (taxModel.value != null) {
      if (taxModel.value!.shipping!) {
        totalTax = tax + shippingTax;
        return totalTax.toString();
      } else {
        return totalTax.toString();
      }
    } else {
      return totalTax.toString();
    }
  }

  Widget buildTitleWidget(BuildContext context, String title) {
    return getCustomFont(title, 17, getFontColor(context), 1,
        fontWeight: FontWeight.w600);
  }
}
