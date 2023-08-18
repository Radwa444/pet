import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_shop/app/model_ui/model_payment_method.dart';
import 'package:pet_shop/base/checkout_slider.dart';
import 'package:pet_shop/base/color_data.dart';
import 'package:pet_shop/base/constant.dart';
import 'package:pet_shop/base/data_file.dart';
import 'package:pet_shop/base/fetch_pixels.dart';
import 'package:pet_shop/base/get/route_key.dart';
import 'package:pet_shop/base/widget_utils.dart';

class CheckOut extends StatefulWidget {
  const CheckOut({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CheckOut();
  }
}

class _CheckOut extends State<CheckOut> {
  backClick(BuildContext context) {
    Constant.backToPrev(context);
  }

  RxInt selectedIndex = 0.obs;

  @override
  void initState() {
    super.initState();
  }

  List<ModelPaymentMtd> paymentList = DataFile.getAllPaymentMthList();

  @override
  Widget build(BuildContext context) {
    Constant.setupSize(context);

    double margin = FetchPixels.getDefaultHorSpaceFigma(context);
    return WillPopScope(
        child: Scaffold(
          backgroundColor: getScaffoldColor(context),
          body: Column(
            children: [
              getDefaultHeader(context, "Check Out", () {},
                  isShowSearch: false),
              20.h.verticalSpace,
              CheckOutSlider(
                icons: Constant.icons,
                filledIcons: Constant.filledIcon,
                itemSize: 24,
                completeColor: getAccentColor(context),
                currentColor: getFontGreyColor(context),
                currentPos: 1,
              ).marginSymmetric(horizontal: margin, vertical: margin),
              getVerSpace(20.h),
              Expanded(
                flex: 1,
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    ModelPaymentMtd payment = paymentList[index];
                    return ObxValue(
                        (p0) => InkWell(
                              onTap: () {
                                selectedIndex.value = index;
                              },
                              child: Container(
                                color: getCardColor(context),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20.h, vertical: 21.h),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Row(
                                        children: [
                                          getSvgImage(
                                              context, payment.icon, 46),
                                          36.h.horizontalSpace,
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              getCustomFont(payment.title, 14,
                                                  getFontColor(context), 1,
                                                  fontWeight: FontWeight.w700),
                                              (payment.num != null)
                                                  ? getCustomFont(
                                                      payment.num ?? "",
                                                      14,
                                                      getFontColor(context),
                                                      1,
                                                      fontWeight:
                                                          FontWeight.w700)
                                                  : 0.h.verticalSpace,
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    getSvgImageWithSize(
                                        context,
                                        (selectedIndex.value == index)
                                            ? "selected_radio.svg"
                                            : "unselected_radio.svg",
                                        25.h,
                                        25.h)
                                  ],
                                ),
                              ),
                            ),
                        selectedIndex);
                  },
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: 3,
                  separatorBuilder: (BuildContext context, int index) {
                    return Container(
                      color: getCardColor(context),
                      child: getDivider(setColor: Colors.grey.shade300)
                          .marginSymmetric(horizontal: 20.h),
                    );
                  },
                ),
              ),
              Builder(
                builder: (context) {
                  return getButtonFigma(context, getAccentColor(context), true,
                      "Next", Colors.white, () {
                    Constant.sendToNext(context, checkoutCompleteScreenRoute);
                  }, EdgeInsets.symmetric(horizontal: margin, vertical: 15.h));
                },
              )
            ],
          ),
        ),
        onWillPop: () async {
          backClick(context);
          return true;
        });
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
