import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pet_shop/base/constant.dart';
import 'package:pet_shop/base/widget_utils.dart';

import '../../../base/fetch_pixels.dart';
import '../../../base/get/home_controller.dart';
import '../../../base/get/product_data.dart';

class TabMyOrder extends StatefulWidget {
  const TabMyOrder({Key? key}) : super(key: key);

  @override
  State<TabMyOrder> createState() => _TabMyOrderState();
}

class _TabMyOrderState extends State<TabMyOrder> {
  ProductDataController productController = Get.find<ProductDataController>();

  HomeController homeController = Get.find<HomeController>();

  @override
  void initState() {
    super.initState();
    productController.getAllMyOrder(homeController.wooCommerce!);
  }

  @override
  Widget build(BuildContext context) {
    Constant.setupSize(context);
    double margin = FetchPixels.getDefaultHorSpaceFigma(context);

    return buildCommonMyOrderScreen(context, margin, () {}, refresh: () {
      productController.getAllMyOrder(homeController.wooCommerce!);
    });
  }
}
