import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_shop/base/constant.dart';
import 'package:pet_shop/base/fetch_pixels.dart';
import 'package:pet_shop/base/get/route_key.dart';

import '../../base/get/home_controller.dart';
import '../../base/get/product_data.dart';
import '../../base/widget_utils.dart';

class MyOrder extends StatefulWidget {
  const MyOrder({Key? key}) : super(key: key);

  @override
  State<MyOrder> createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> {
// class _MyOrder extends State<MyOrder> {
  ProductDataController productController = Get.find<ProductDataController>();

  HomeController homeController = Get.find<HomeController>();

  backClick(BuildContext context) {
    // Constant.backToPrev(context);
    Constant.sendToNext(context, homeScreenRoute);
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () {
        productController.getAllMyOrder(homeController.wooCommerce!);
      },
    );
  } // @override

  @override
  Widget build(BuildContext context) {
    Constant.setupSize(context);
    double margin = FetchPixels.getDefaultHorSpaceFigma(context);
    return WillPopScope(
        child: buildCommonMyOrderScreen(
            context,
            margin,
            () {
              backClick(context);
            },
            isBackAvailable: true,
            refresh: () {
              // productController.getAllMyOrder(homeController.wooCommerce!);
            }),
        onWillPop: () async {
          backClick(context);
          return false;
        });
  }
}
