import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:pet_shop/base/widget_utils.dart';

import '../../base/color_data.dart';
import '../../base/constant.dart';
import '../../base/data_file.dart';
import '../model_ui/model_payment_method.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PaymentMethodScreen();
  }
}

class _PaymentMethodScreen extends State<PaymentMethodScreen> {
  void backClick() {
    Constant.backToPrev(context);
  }

  RxInt selectedIndex = (-1).obs;

  List<ModelPaymentMtd> paymentList = DataFile.getAllPaymentMthList();

  @override
  Widget build(BuildContext context) {
    Constant.setupSize(context);

    return WillPopScope(
        child: Scaffold(
          backgroundColor: getScaffoldColor(context),
          body: Column(
            children: [
              getDefaultHeader(context, "Payment method", () {
                backClick();
              }, isShowSearch: false),
              getVerSpace(20.h),
              Expanded(
                flex: 1,
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    // WooPaymentGateway wooGateway =
                    // productDataController.modelPaymentGateway[index]!;
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
              ObxValue(
                  (p0) => getButtonFigma(
                          context,
                          (selectedIndex.value < 0)
                              ? "#DBEFE8".toColor()
                              : getAccentColor(context),
                          true,
                          "Save",
                          Colors.white, () {
                        backClick();
                      },
                          EdgeInsets.symmetric(
                              horizontal: 20.h, vertical: 20.h)),
                  selectedIndex)
            ],
          ),
        ),
        onWillPop: () async {
          backClick();
          return false;
        });
  }
}
