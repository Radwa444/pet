import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_shop/app/model_ui/model_cart.dart';
import 'package:pet_shop/base/constant.dart';
import 'package:pet_shop/base/data_file.dart';
import 'package:pet_shop/base/fetch_pixels.dart';

import '../../base/color_data.dart';
import '../../base/get/home_controller.dart';
import '../../base/widget_utils.dart';

class TrackOrder extends StatefulWidget {
  const TrackOrder({Key? key}) : super(key: key);

  // WooGetCreatedOrder? orderModel;
  //
  // TrackOrder({this.orderModel});

  @override
  State<StatefulWidget> createState() {
    return _TrackOrder();
  }
}

class _TrackOrder extends State<TrackOrder> {
  backClick(BuildContext context) {
    Constant.backToPrev(context);
  }

  @override
  void initState() {
    super.initState();
  }

  HomeController productDataController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    Constant.setupSize(context);
    double margin = FetchPixels.getDefaultHorSpaceFigma(context);

    return WillPopScope(
        child: Scaffold(
          backgroundColor: getScaffoldColor(context),
          body: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                children: [
                  getDefaultHeader(context, "Order Detail", () {
                    backClick(context);
                  }, isShowSearch: false),
                  Expanded(
                    flex: 1,
                    child: ListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                getCustomFont(
                                    "Order ID : ", 16, getFontColor(context), 1,
                                    fontWeight: FontWeight.w400),
                                getCustomFont(
                                    "5231874", 16, getFontColor(context), 1,
                                    fontWeight: FontWeight.w600),
                              ],
                            ),
                            Row(
                              children: [
                                getSvgImage(context, "clock.svg", 22),
                                getHorSpace(8.h),
                                getCustomFont("10:00 PM | 3-Oct-2022  ", 14,
                                    getFontColor(context), 1,
                                    fontWeight: FontWeight.w400)
                              ],
                            )
                          ],
                        ).marginSymmetric(vertical: margin, horizontal: margin),
                        Container(
                          color: getCardColor(context),
                          padding: EdgeInsets.all(20.h),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              getCustomFont(
                                  "Customer", 14, getFontColor(context), 1,
                                  fontWeight: FontWeight.w400),
                              getVerSpace(16.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                      child: Row(
                                    children: [
                                      getAssetImage(context,
                                          "dummy_profile.png", 60.h, 60.h),
                                      getHorSpace(18.h),
                                      getCustomFont("Guy Hawkins", 17,
                                          getFontColor(context), 1,
                                          fontWeight: FontWeight.w400),
                                    ],
                                  )),
                                  Container(
                                    height: 40.h,
                                    width: 40.h,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: getAccentColor(context),
                                    ),
                                    child: Center(
                                      child:
                                          getSvgImage(context, "call.svg", 20),
                                    ),
                                  ),
                                ],
                              ),
                              getVerSpace(20.h),
                              getDivider(setColor: Colors.grey.shade300),
                              getVerSpace(15.h),
                              getRichText(
                                  "Shipping Address: ",
                                  getFontColor(context),
                                  FontWeight.w600,
                                  16.sp,
                                  "1901 Thornridge Cir. Shiloh, Hawaii 81063 ",
                                  getFontColor(context),
                                  FontWeight.w400,
                                  16.sp,
                                  textAlign: TextAlign.start),
                              getVerSpace(16.h),
                              getRichText(
                                  "Billing Address: ",
                                  getFontColor(context),
                                  FontWeight.w600,
                                  16.sp,
                                  "18502 Preston Rd. Inglewood, Maine 98380",
                                  getFontColor(context),
                                  FontWeight.w400,
                                  16.sp,
                                  textAlign: TextAlign.start),
                              getVerSpace(16.h),
                              getRichText(
                                  "Order Note: ",
                                  getFontColor(context),
                                  FontWeight.w600,
                                  16.sp,
                                  "Order Note: I need the best one ",
                                  getFontColor(context),
                                  FontWeight.w400,
                                  16.sp,
                                  textAlign: TextAlign.start),
                              getVerSpace(24.h),
                              getDivider(setColor: Colors.grey.shade300),
                              getVerSpace(13.h),
                              GestureDetector(
                                  onTap: () {
                                    showGetDeleteDialog(
                                        context,
                                        "Are you sure you want to delete these order?",
                                        "Delete",
                                        () {
                                          backClick(context);
                                        },
                                        withCancelBtn: true,
                                        btnTextCancel: "Cancel",
                                        functionCancel: () {
                                          backClick(context);
                                        });
                                  },
                                  child: getCustomFont(
                                      "Cancel Order", 16, redColor, 1,
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                        getVerSpace(20.h),
                        Container(
                          color: getCardColor(context),
                          padding: EdgeInsets.all(20.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              getCustomFont(
                                  "Items(3)", 16, getFontColor(context), 1,
                                  fontWeight: FontWeight.w400),
                              getVerSpace(12.h),
                              ListView.separated(
                                itemBuilder: (context, index) {
                                  List<ModelCart> cart =
                                      DataFile.getAllCartList();
                                  return buildMyCartItem(
                                      context, cart[index], 112.h, () {});
                                },
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                itemCount: 1,
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return getDivider(
                                          setColor: Colors.grey.shade300)
                                      .marginSymmetric(vertical: 16.h);
                                },
                              ),
                            ],
                          ),
                        ),
                        getVerSpace(20.h),
                        Container(
                          color: getCardColor(context),
                          padding: EdgeInsets.all(20.h),
                          child: Column(
                            children: [
                              buildSubtotalRow(
                                context,
                                "Item Price",
                                "\$90.00",
                              ),
                              getVerSpace(16.h),
                              buildSubtotalRow(context, "Tax", "+\$2.00"),
                              getDivider(
                                setColor: Colors.grey.shade300,
                              ).marginSymmetric(vertical: 20.h),
                              buildSubtotalRow(context, "Sub Total", "\$92.00"),
                              getVerSpace(16.h),
                              buildSubtotalRow(
                                context,
                                "Discount",
                                "-\$5.00",
                              ),
                              getVerSpace(12.h),
                              buildSubtotalRow(
                                context,
                                "Coupon Discount",
                                "-\$0.00",
                              ),
                              getVerSpace(16.h),
                              buildSubtotalRow(
                                context,
                                "Shipping",
                                "Free",
                              ),
                              getDivider(
                                setColor: Colors.grey.shade300,
                              ).marginSymmetric(vertical: margin),
                              buildTotalRow(
                                context,
                                "Total",
                                "\$87.00",
                              ),
                            ],
                          ),
                        ),
                        getVerSpace(20.h),
                      ],
                    ),
                  ),
                ],
              )),
        ),
        onWillPop: () async {
          backClick(context);
          return false;
        });
  }
}
