import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_shop/base/color_data.dart';
import 'package:pet_shop/base/constant.dart';
import 'package:pet_shop/base/fetch_pixels.dart';
import 'package:pet_shop/base/get/home_controller.dart';
import 'package:pet_shop/base/get/storage_controller.dart';
import 'package:pet_shop/base/widget_utils.dart';
import 'package:pet_shop/woocommerce/model/cart_item.dart';

import '../../base/custom_progress_dialog.dart';

// ignore: must_be_immutable
class BuyNow extends StatelessWidget {
  BuyNow({Key? key}) : super(key: key);

  backClick(BuildContext context) {
    Constant.backToPrev(context);
  }

  StorageController storageController = Get.find<StorageController>();
  HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    Constant.setupSize(context);

    double margin = FetchPixels.getDefaultHorSpaceFigma(context);
    return WillPopScope(
        child: Scaffold(
          appBar: getTitleAppBar(context, () {
            backClick(context);
          }, title: "Buy Now", isCartAvailable: false),
          body: Column(
            children: [
              Expanded(
                flex: 1,
                child: ListView(
                  children: [
                    // ObxValue(
                    //     (p0) => buildBuyNowCartItem(
                    //             context,
                    //             cartItem,
                    //             double.infinity,
                    //             130.w,
                    //             () {},
                    //             cartItem.quantity!, () {
                    //           storageController.currentQuantity.value++;
                    //         }, () {
                    //           if (storageController.currentQuantity.value > 1) {
                    //             storageController.currentQuantity.value--;
                    //           }
                    //         }).marginSymmetric(
                    //             horizontal: margin, vertical: 20.h),
                    //     storageController.currentQuantity)
                    ObxValue((p0) {
                      ProgressDialog progressDialog = ProgressDialog();
                      WooCartItem cartItem =
                          storageController.wooCartItem.value!;
                      return buildBuyNowCartItem(
                          context,
                          cartItem,
                          double.infinity,
                          130.w,
                          () {},
                          cartItem.quantity!, () async {
                        progressDialog.showProgressDialog(context);
                        int quantity =
                            storageController.wooCartItem.value!.quantity! + 1;
                        WooCartItem? item = await homeController.wooCommerce!
                            .updateCartQuantity(
                                cartItem.key!,
                                quantity,
                                homeController.wooCommerceNonce!,
                                homeController.currentCustomer != null);
                        if (item != null) {
                          storageController.wooCartItem.value = item;
                          Future.delayed(
                            Duration.zero,
                            () {
                              progressDialog.dismissProgressDialog(context);
                            },
                          );
                        }

                        // storageController.currentQuantity.value++;
                      }, () async {
                        int quantity =
                            storageController.wooCartItem.value!.quantity!;

                        if (quantity > 1) {
                          quantity--;
                          progressDialog.showProgressDialog(context);
                          WooCartItem? item = await homeController.wooCommerce!
                              .updateCartQuantity(
                                  cartItem.key!,
                                  quantity,
                                  homeController.wooCommerceNonce!,
                                  homeController.currentCustomer != null);
                          if (item != null) {
                            storageController.wooCartItem.value = item;
                            Future.delayed(
                              Duration.zero,
                              () {
                                progressDialog.dismissProgressDialog(context);
                              },
                            );
                          }
                        }
                      }).marginSymmetric(horizontal: margin, vertical: 20.h);
                    }, storageController.wooCartItem)
                  ],
                ),
              ),
              ObxValue(
                  (p0) => buildTotalRow(context,
                          "${storageController.wooCartItem.value!.totals!.currencySymbol!} ${storageController.wooCartItem.value!.totals!.lineTotal!}")
                      .marginSymmetric(horizontal: margin),
                  storageController.wooCartItem),
              getButtonFigma(
                  context,
                  getAccentColor(context),
                  true,
                  "Check Out",
                  Colors.white,
                  () {},
                  EdgeInsets.symmetric(horizontal: margin, vertical: 20.h))
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
