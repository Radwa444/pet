import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_shop/base/color_data.dart';
import 'package:pet_shop/base/constant.dart';
import 'package:pet_shop/base/fetch_pixels.dart';
import 'package:pet_shop/base/get/bottom_selection_controller.dart';
import 'package:pet_shop/base/get/route_key.dart';
import 'package:pet_shop/base/widget_utils.dart';

// ignore: must_be_immutable
class TabProfile extends StatelessWidget {
  BottomItemSelectionController bottomController =
      Get.find<BottomItemSelectionController>();

  TabProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double margin = FetchPixels.getDefaultHorSpaceFigma(context);
    return Container(
      color: "#E7FEF5".toColor(),
      child: Column(
        children: [
          Column(
            children: [
              getDefaultHeader(context, "Profile", () {},
                  color: Colors.transparent, isShowSearch: false),
              30.h.verticalSpace,
              getCircleProfileImage(context, "L", 90.h),
              14.h.verticalSpace,
              getCustomFont("Leslie Alexander", 16, getFontColor(context), 1,
                  fontWeight: FontWeight.w600),
              6.h.verticalSpace,
              getCustomFont(
                  "lesliealexander@gmail.com", 14, getFontColor(context), 1,
                  fontWeight: FontWeight.w400),
              20.h.verticalSpace,
              // 30.h.verticalSpace
            ],
          ),
          Expanded(
            flex: 1,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: margin),
              decoration: BoxDecoration(
                  color: getCardColor(context),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.h),
                      topRight: Radius.circular(40.h))),
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: ListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      children: [
                        30.h.verticalSpace,
                        buildRowWidget(context, "profile.svg", "My Profile",
                            () {
                          // if (wooCustomer != null) {
                          Constant.sendToNext(context, myProfileRoute);
                          // }
                        }),
                        getDividerWidget(),
                        buildRowWidget(context, "my_order.svg", "My Order", () {
                          Constant.sendToNext(context, myOrderScreenRoute);
                        }),
                        getDividerWidget(),
                        buildRowWidget(context, "location.svg", "My Address",
                            () {
                          Constant.sendToNext(context, myAddressScreenRoute);
                        }),
                        getDividerWidget(),
                        buildRowWidget(context, "card.svg", "Payment Method",
                            () {
                          Constant.sendToNext(
                              context, paymentMethodScreenRoute);
                        }),
                        getDividerWidget(),
                        buildRowWidget(context, "more.svg", "More", () {
                          Constant.sendToNext(context, moreScreenRoute);
                        }),

                        20.h.verticalSpace,
                        // (wooCustomer == null)
                        //     ?
                        //     : getButtonFigma(context, Colors.transparent, true,
                        //         "Logout", getAccentColor(context), () {
                        //         setLoggedIn(false);
                        //         homeController.currentCustomer = null;
                        //         final controller = Get.find<BottomItemSelectionController>();
                        //         controller.bottomBarSelectedItem.value=0;
                        //         clearKey(keyCurrentUser);
                        //         Constant.sendToNext(context, splashRoute);
                        //
                        //       }, EdgeInsets.zero,
                        //         isBorder: true, borderColor: getAccentColor(context)),
                      ],
                    ),
                  ),
                  getButtonFigma(context, Colors.transparent, true, "Logout",
                      getAccentColor(context), () {
                    bottomController.changePos(0);
                    Constant.sendToNext(context, loginRoute);
                  }, EdgeInsets.zero,
                      isBorder: true, borderColor: getAccentColor(context)),
                  20.h.verticalSpace,
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
