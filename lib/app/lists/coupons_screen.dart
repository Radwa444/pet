import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_shop/base/data_file.dart';

import '../../base/color_data.dart';
import '../../base/constant.dart';
import '../../base/widget_utils.dart';
import '../model_ui/model_coupons.dart';

class CouponsScreen extends StatefulWidget {
  const CouponsScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CouponsScreen();
  }
}

class _CouponsScreen extends State<CouponsScreen> {
  void backClick() {
    Constant.backToPrev(context);
  }

  // ProductDataController productDataController =
  //     Get.find<ProductDataController>();
  // HomeController homeController = Get.find<HomeController>();

  @override
  void initState() {
    super.initState();

    // Future.delayed(Duration.zero, () {
    //   productDataController.getCouponsList(homeController.wooCommerce!);
    // });
  }

  List<ModelCoupons> couponsList = DataFile.getAllCouponsList();

  @override
  Widget build(BuildContext context) {
    Constant.setupSize(context);
    return WillPopScope(
      onWillPop: () async {
        backClick();
        return false;
      },
      child: Scaffold(
        backgroundColor: getScaffoldColor(context),
        body: Column(
          children: [
            getDefaultHeader(context, "Coupons", () {
              backClick();
            }, isShowSearch: false),
            getVerSpace(10.h),
            Expanded(
                flex: 1,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    // RetrieveCoupon coupon =
                    // productDataController.couponsList[index];
                    ModelCoupons coupons = couponsList[index];
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 10.h),
                      padding: EdgeInsets.all(20.h),
                      color: getCardColor(context),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                getCustomFont(coupons.discount, 20,
                                    getAccentColor(context), 1,
                                    fontWeight: FontWeight.w700,
                                    textAlign: TextAlign.start),
                                getMultilineCustomFont(
                                        coupons.desc, 16, getFontColor(context),
                                        fontWeight: FontWeight.w400)
                                    .marginSymmetric(vertical: 10.h),
                                getCustomFont("Expire On : ${coupons.date}", 16,
                                    black40, 1,
                                    fontWeight: FontWeight.w400,
                                    textAlign: TextAlign.start)
                              ],
                            ),
                          ),
                          Container(
                            width: 125.h,
                            height: 44.h,
                            decoration: getButtonDecoration(lightAccentColor,
                                withCorners: true,
                                corner: 12.h,
                                withBorder: true,
                                borderColor: getAccentColor(
                                  context,
                                )),
                            alignment: Alignment.center,
                            child: getCustomFont(
                                coupons.code, 16, getAccentColor(context), 1,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    );
                  },
                )),
            getButtonFigma(
                context,
                getAccentColor(context),
                true,
                "Apply",
                Colors.white,
                () {},
                EdgeInsets.symmetric(horizontal: 20.h, vertical: 20.h))
          ],
        ),
      ),
    );
  }
}
