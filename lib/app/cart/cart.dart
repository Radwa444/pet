import 'package:flutter/material.dart';
import 'package:pet_shop/app/cart/cart_comman_widget.dart';
import 'package:pet_shop/base/constant.dart';
import 'package:pet_shop/base/widget_utils.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CartScreen();
  }
}

class _CartScreen extends State<CartScreen> {
  backClick(BuildContext context) {
    Constant.backToPrev(context);
  }

  //
  // Widget EmptyCard() {
  //   return Center(
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: [
  //         getSvgImageWithSize(context, "empty_card.svg", 150.h, 150.h,
  //             fit: BoxFit.fill),
  //         getCustomFont("Your cart is empty", 28, getFontColor(context), 1,
  //                 textAlign: TextAlign.center, fontWeight: FontWeight.w700)
  //             .marginSymmetric(vertical: 30.h),
  //         SizedBox(
  //           width: 194.h,
  //           child: getButtonFigma(context, Colors.transparent, true,
  //               "Explore Now", getAccentColor(context), () {
  //             Constant.sendToNext(context, homeScreenRoute);
  //           }, EdgeInsets.zero,
  //               isBorder: true, borderColor: getAccentColor(context)),
  //         )
  //       ],
  //     ),
  //   );
  // }
  //
  // Row buildTotalRow(BuildContext context, String title, String total) {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: [
  //       getCustomFont(
  //         title,
  //         22,
  //         getFontColor(context),
  //         1,
  //         fontWeight: FontWeight.w700,
  //       ),
  //       getCustomFont(
  //         total,
  //         22,
  //         getFontColor(context),
  //         1,
  //         fontWeight: FontWeight.w700,
  //       ),
  //     ],
  //   );
  // }
  //
  // StorageController storageController = Get.find<StorageController>();
  // HomeController homeController = Get.find<HomeController>();

  // CartController cartController = Get.find<CartController>();

  // ProductDataController productController = Get.find<ProductDataController>();

  @override
  void initState() {
    super.initState();
    // Constant.getDelayFunction(() {
    //   print("useridget---${homeController.currentCustomer}");
    //   //   if (homeController.currentCustomer == null) {
    //   //     productController.getAllCartList(homeController.wooCommerce!);
    //   //   } else {
    //   //     productController.getAllMyCartList(homeController.wooCommerce!);
    //   //   }
    // });
  }

  // ProgressDialog progressDialog = ProgressDialog();

  @override
  Widget build(BuildContext context) {
    Constant.setupSize(context);

    return WillPopScope(
        child: Scaffold(
            appBar: getTitleAppBar(context, () {
              backClick(context);
            }, title: "Cart", isCartAvailable: false),
            body: const CartCommonWidget()),
        onWillPop: () async {
          backClick(context);
          return true;
        });
  }
}
