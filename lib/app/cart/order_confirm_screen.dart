import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_shop/base/color_data.dart';

import '../../base/constant.dart';
import '../../base/get/bottom_selection_controller.dart';
import '../../base/get/route_key.dart';
import '../../base/widget_utils.dart';

class OrderConfirmScreen extends StatefulWidget {
  int? id;
  String? status;

  OrderConfirmScreen({Key? key}) : super(key: key);

  // OrderConfirmScreen(this.id, this.status);

  @override
  State<StatefulWidget> createState() {
    return _OrderConfirmScreen();
  }
}

class _OrderConfirmScreen extends State<OrderConfirmScreen> {
  BottomItemSelectionController bottomController =
      Get.find<BottomItemSelectionController>();

  void backClick() {
    Constant.backToPrev(context);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Constant.setupSize(context);

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: getAccentColor(context),
        body: Container(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              getSvgImageWithSize(
                  context, "order_confirm_img.svg", 132.h, 132.h),
              getVerSpace(30.h),
              getCustomFont("Your order has been received", 22, Colors.white, 1,
                  fontWeight: FontWeight.w700),
              getVerSpace(4.h),
              getCustomFont("Status: On-Hold", 17, Colors.white, 1,
                  fontWeight: FontWeight.w600),
              getVerSpace(4.h),
              getCustomFont("Order ID: 74123698", 17, Colors.white, 1,
                  fontWeight: FontWeight.w600),
              getVerSpace(40.h),
              InkWell(
                onTap: () {
                  bottomController.changePos(0);
                  Constant.sendToNext(context, homeScreenRoute);
                },
                child: Container(
                  height: getButtonHeightFigma(),
                  width: 218.h,
                  alignment: Alignment.center,
                  decoration: getButtonDecoration(
                    getCardColor(context),
                    withCorners: true,
                    corner: 12.h,
                  ),
                  child: getCustomFont("Continue", 16, getFontColor(context), 1,
                      fontWeight: FontWeight.w600),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
