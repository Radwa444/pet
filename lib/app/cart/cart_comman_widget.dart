import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_shop/app/model_ui/model_cart.dart';
import 'package:pet_shop/base/data_file.dart';
import 'package:pet_shop/base/get/storage.dart';

import '../../base/color_data.dart';
import '../../base/constant.dart';
import '../../base/get/bottom_selection_controller.dart';
import '../../base/get/cart_contr/cart_controller.dart';
import '../../base/get/route_key.dart';
import '../../base/widget_utils.dart';

class CartCommonWidget extends StatefulWidget {
  const CartCommonWidget({Key? key}) : super(key: key);

  @override
  State<CartCommonWidget> createState() => _CartCommonWidgetState();
}

class _CartCommonWidgetState extends State<CartCommonWidget> {
  String inStock = 'instock';

  Widget emptyCard(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          getSvgImageWithSize(context, "empty_card.svg", 140.h, 140.h,
              fit: BoxFit.fill),
          5.h.verticalSpace,
          getCustomFont("Your cart is empty", 22, getFontColor(context), 1,
                  textAlign: TextAlign.center, fontWeight: FontWeight.w700)
              .marginSymmetric(vertical: 20.h),
          SizedBox(
            width: 174.h,
            child: getButtonFigma(context, Colors.transparent, true,
                "Explore Now", getAccentColor(context), () {
              final controller = Get.find<BottomItemSelectionController>();
              controller.changePos(0);
              Constant.sendToNext(context, homeScreenRoute);
            }, EdgeInsets.zero,
                isBorder: true, borderColor: getAccentColor(context)),
          )
        ],
      ),
    );
  }

  TextEditingController couponController = TextEditingController();

  String inputCoupon = '';

  List<ModelCart> cartList = DataFile.getAllCartList();

  BottomItemSelectionController bottomController =
      Get.find<BottomItemSelectionController>();

  RxInt selectedIndex = 2.obs;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: GetBuilder<CartController>(
          init: CartController(),
          builder: (controller) {
            if (cartList.isNotEmpty) {
              return ListView(
                padding: EdgeInsets.zero,
                children: [
                  Container(
                    padding: EdgeInsets.all(20.h),
                    margin: EdgeInsets.symmetric(vertical: 20.h),
                    color: getCardColor(context),
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        ModelCart cart = cartList[index];
                        return buildMyCartItem(
                          context,
                          cart,
                          112.h,
                          () {
                            Constant.sendToNext(
                                context, productDetailScreenRoute);
                          },
                        );
                      },
                      itemCount: cartList.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      separatorBuilder: (BuildContext context, int index) {
                        return getDivider(setColor: Colors.grey.shade300)
                            .marginSymmetric(vertical: 20.h);
                      },
                    ),
                  ),
                  Container(
                    color: getCardColor(context),
                    padding: EdgeInsets.all(20.h),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 18.h),
                            decoration: getButtonDecoration(Colors.transparent,
                                withCorners: true,
                                corner: 12.h,
                                withBorder: true,
                                borderColor: black20),
                            height: 60.h,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: TextField(
                                    onChanged: (value) {},
                                    controller: couponController,
                                    cursorColor: getFontColor(context),
                                    style: buildTextStyle(
                                        context,
                                        getFontColor(context),
                                        FontWeight.w400,
                                        16),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.zero,
                                      isDense: true,
                                      isCollapsed: true,
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                      border: InputBorder.none,
                                      hintText: "Coupon Code",
                                      hintMaxLines: 1,
                                      hintStyle: buildTextStyle(context,
                                          black40, FontWeight.w400, 16),
                                    ),
                                  ),
                                ),
                                GetBuilder<CartController>(
                                  init: CartController(),
                                  builder: (controller) {
                                    // final double totalPrice =
                                    // controller.cartTotalPriceF(1);

                                    return GestureDetector(
                                      onTap: () async {
                                        // if (inputCoupon == '') {
                                        //   ScaffoldMessenger.of(context)
                                        //       .showSnackBar(const SnackBar(
                                        //     content: Text(
                                        //       "Enter Coupon",
                                        //     ),
                                        //   ));
                                        // } else {
                                        //   // EasyLoading.show(
                                        //   //     status: "Loading");
                                        //   // setState(() {
                                        //   // finalInputCoupon = inputCoupon;
                                        //   // couponController.text =
                                        //   //     finalInputCoupon;
                                        //   // });
                                        //   // CouponLines coupon = CouponLines(
                                        //   //     code: inputCoupon);
                                        //   // controller.addCoupon(coupon);
                                        //   // var promoPrice =
                                        //   // await homeController
                                        //   //     .wooCommerce!
                                        //   //     .retrieveCoupon(
                                        //   //     finalInputCoupon,
                                        //   //     totalPrice);
                                        //   // print("promoprice==$promoPrice");
                                        //   // if (promoPrice > 0.0) {
                                        //   //   controller
                                        //   //       .updatePrice(promoPrice);
                                        //     // setState(() {
                                        //     // isCouponApply.value = true;
                                        //     // });
                                        //     // EasyLoading.showSuccess(
                                        //     //     "Applied");
                                        //   // } else {
                                        //   //   EasyLoading.showError("Failed");
                                        //   // }
                                        // }
                                      },
                                      child: getCustomFont(
                                        "Apply",
                                        16,
                                        getAccentColor(context),
                                        1,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    );
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                        getHorSpace(24.h),
                        InkWell(
                          onTap: () {
                            Constant.sendToNext(context, couponsScreenRoute);
                          },
                          child: getCustomFont(
                            "View all",
                            17,
                            black40,
                            1,
                            fontWeight: FontWeight.w400,
                            textAlign: TextAlign.start,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20.h),
                    margin: EdgeInsets.symmetric(vertical: 20.h),
                    color: getCardColor(context),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildSubtotalRow(context, "Subtotal", "\$80.00"),
                        getDivider(setColor: Colors.grey.shade300)
                            .marginSymmetric(vertical: 14.h),
                        getCustomFont('Shipping', 16, getFontColor(context), 1,
                            fontWeight: FontWeight.w500,
                            textAlign: TextAlign.start),
                        getVerSpace(14.h),
                        ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            List<String> shippingMtd = [
                              "Flat Rate",
                              "Local Pickup",
                              "Free Shipping (On order up to \$40.00"
                            ];
                            // ModelShippingMethod shippingMtd =
                            // shippingMethods[index];
                            return Row(
                              children: [
                                ObxValue(
                                    (p0) => InkWell(
                                          onTap: () {
                                            selectedIndex.value = index;
                                            // cartController
                                            //     .selectedShippingMethod
                                            //     .value = shippingMtd;
                                            // cartController.addShippingLines(ShippingLines(
                                            //     methodId:
                                            //     shippingMtd
                                            //         .methodId,
                                            //     methodTitle:
                                            //     shippingMtd
                                            //         .methodTitle,
                                            //     total: shippingMtd
                                            //         .settings!
                                            //         .cost!
                                            //         .value));
                                            //
                                            // storageController
                                            //     .selectedShipping(
                                            //     shippingMtd
                                            //         .methodTitle);
                                            //
                                            // storageController
                                            //     .selectedShippingRate(
                                            //     shippingMtd
                                            //         .settings!
                                            //         .cost!
                                            //         .value);
                                          },
                                          child: Container(
                                            height: 20.h,
                                            width: 20.h,
                                            decoration: getButtonDecoration(
                                                (selectedIndex.value == index)
                                                    ? getAccentColor(context)
                                                    : Colors.transparent,
                                                withBorder: true,
                                                borderColor:
                                                    getFontHint(context),
                                                withCorners: true,
                                                corner: 6.h),
                                            child: Center(
                                              child: getSvgImage(
                                                context,
                                                "right.svg",
                                                12.h,
                                              ),
                                            ),
                                          ),
                                        ),
                                    selectedIndex),
                                getHorSpace(8.h),
                                getCustomFont(shippingMtd[index], 14,
                                    getFontColor(context), 1,
                                    fontWeight: FontWeight.w400,
                                    textAlign: TextAlign.start)
                              ],
                            ).marginSymmetric(vertical: 8.h);
                          },
                        ),
                        // getDivider(setColor: Colors.grey.shade300)
                        //     .marginSymmetric(vertical: 16.h),
                        // buildSubtotalRow(
                        //     context,
                        //     "Shipping Charge",
                        //     // "Tax ${(taxModel.value != null) ? taxModel.value!.rate!.replaceRange(1, 6, "") : ""}%",
                        //     "+\$2.00"),
                        getDivider(setColor: Colors.grey.shade300)
                            .marginSymmetric(vertical: 14.h),
                        buildSubtotalRow(
                          context,
                          "Tax",
                          // "Tax ${(taxModel.value != null) ? taxModel.value!.rate!.replaceRange(1, 6, "") : ""}%",
                          "+\$2.00",
                        ),
                        getDivider(setColor: Colors.grey.shade300)
                            .marginSymmetric(vertical: 14.h),
                        buildSubtotalRow(context, "Discount", "-\$5.00"),
                        getDivider(setColor: Colors.grey.shade300)
                            .marginSymmetric(vertical: 14.h),
                        buildTotalRow(
                          context,
                          "Total",
                          "\$77.00",
                        ),
                      ],
                    ),
                  ),
                  getRowButtonFigma(context, getAccentColor(context), true,
                      "3 item", "\$30.00", "Continue", Colors.white, () {
                    // if (cartController.selectedShippingMethod.value !=
                    //     null) {
                    //   if (homeController.currentCustomer != null) {
                    (isLoggedIn)
                        ? Constant.sendToNext(
                            context, checkoutShippingScreenRoute)
                        : Constant.sendToNext(context, loginRoute);
                    //   } else {
                    //     Constant.sendToNext(context, loginRoute);
                    //   }
                    // } else {
                    //   showCustomToast("Select Valid Shipping Method");
                    // }
                  }, EdgeInsets.symmetric(horizontal: 20.h)),
                  getVerSpace(30.h),
                ],
              );
            } else {
              return getEmptyWidget(
                  context,
                  "empty_card.svg",
                  "Your Cart is Empty Yet!",
                  "Explore more and shortlist some products.",
                  "Go to Shop", () {
                bottomController.changePos(0);
              });
            }
          },
        ));
  }
}
