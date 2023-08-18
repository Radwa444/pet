// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:pet_shop/base/color_data.dart';
// import 'package:pet_shop/base/constant.dart';
// import 'package:pet_shop/base/fetch_pixels.dart';
// import 'package:pet_shop/base/get/home_controller.dart';
// import 'package:pet_shop/base/get/product_data.dart';
// import 'package:pet_shop/base/get/route_key.dart';
// import 'package:pet_shop/base/get/storage_controller.dart';
// import 'package:pet_shop/base/widget_utils.dart';
//
// import '../../base/custom_progress_dialog.dart';
// import '../../woocommerce/model/cart.dart';
// import '../../woocommerce/model/cart_item.dart';
//
// class CartScreen extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return _CartScreen();
//   }
// }
//
// class _CartScreen extends State<CartScreen> {
//   backClick(BuildContext context) {
//     Constant.backToPrev(context);
//   }
//
//   StorageController storageController = Get.find<StorageController>();
//   HomeController homeController = Get.find<HomeController>();
//   ProductDataController productController = Get.find<ProductDataController>();
//
//   @override
//   void initState() {
//     super.initState();
//     Constant.getDelayFunction(() {
//       print("useridget---${homeController.currentCustomer}");
//       if (homeController.currentCustomer == null) {
//         productController.getAllCartList(homeController.wooCommerce!);
//       } else {
//         productController.getAllMyCartList(homeController.wooCommerce!);
//       }
//     });
//   }
//
//   ProgressDialog progressDialog = ProgressDialog();
//
//   @override
//   Widget build(BuildContext context) {
//     Constant.setupSize(context);
//
//     double margin = FetchPixels.getDefaultHorSpaceFigma(context);
//     return WillPopScope(
//         child: Scaffold(
//           appBar: getTitleAppBar(context, () {
//             backClick(context);
//           }, title: "Cart", isCartAvailable: false),
//           body: ObxValue((p0) {
//             // print(
//             //     "checkcartval===${productController.isMyCartLoading.value}===${productController.myCartList.value!.items!.length}");
//             // bool isDataLoading =productController.isMyCartLoading.value;
//             if (productController.isMyCartLoading.value) {
//               return getProgressDialog();
//             } else if (productController.myCartList.value!=null && productController.myCartList.value!.items!.isNotEmpty) {
//               return Column(
//                 children: [
//                   Expanded(
//                       flex: 1,
//                       child: ListView.builder(
//                         itemBuilder: (context, index) {
//                           WooCartItem items =
//                               productController.myCartList.value!.items![index];
//                           return buildMyCartItem(
//                               context,
//                               items,
//                               double.infinity,
//                               130.w,
//                               () {},
//                               items.quantity!, () async {
//                             int quantity = items.quantity!;
//
//                             quantity++;
//                             progressDialog.showProgressDialog(context);
//                             WooCartItem? item = await homeController
//                                 .wooCommerce!
//                                 .updateCartQuantity(items.key!, quantity,
//                                     homeController.wooCommerceNonce!,homeController.currentCustomer!=null);
//                             if (item != null) {
//                               progressDialog.dismissProgressDialog(context);
//                               String res = jsonEncode(item);
//                               WooCartItem items =
//                                   WooCartItem.fromJson(jsonDecode(res));
//                               productController
//                                   .myCartList.value!.items![index] = items;
//                               productController.myCartList.refresh();
//                             }
//                           }, () async {
//                             int quantity = items.quantity!;
//
//                             if (quantity > 1) {
//                               quantity--;
//                               progressDialog.showProgressDialog(context);
//                               WooCartItem? item = await homeController
//                                   .wooCommerce!
//                                   .updateCartQuantity(items.key!, quantity,
//                                       homeController.wooCommerceNonce!,homeController.currentCustomer!=null);
//                               if (item != null) {
//                                 progressDialog.dismissProgressDialog(context);
//                                 String res = jsonEncode(item);
//                                 WooCartItem items =
//                                     WooCartItem.fromJson(jsonDecode(res));
//                                 productController
//                                     .myCartList.value!.items![index] = items;
//                                 productController.myCartList.refresh();
//                               }
//                             }
//                           }).marginSymmetric(
//                               horizontal: margin, vertical: 20.h);
//                         },
//                         itemCount:
//                             productController.myCartList.value!.items!.length,
//                         shrinkWrap: true,
//                         padding: EdgeInsets.zero,
//                       )),
//                   ObxValue((p0) {
//                     print(
//                         "chkval==${productController.myCartList.value.toString().isEmpty}");
//                     return FutureBuilder<WooCart?>(
//                       builder: (context, snapshot) {
//                         return (snapshot.data != null)
//                             ? Column(
//                                 children: [
//                                   buildTotalRow(
//                                       context,
//                                       "Total",
//                                       Constant.formatStringCurrency(
//                                           total: snapshot
//                                               .data!.totals!.totalPrice!,
//                                           context: context))
//                                 ],
//                               ).marginSymmetric(
//                                 horizontal: margin, vertical: 15.h)
//                             : 0.verticalSpace;
//                       },
//                       future: (homeController.currentCustomer != null)
//                           ? homeController.wooCommerce!.getMyCart()
//                           : homeController.wooCommerce!.getCartWithoutLogin(),
//                     );
//                   }, productController.myCartList),
//                   // ObxValue(
//                   //     (p0) => buildTotalRow(context,
//                   //             "${storageController.wooCartItem.value!.totals!.currencySymbol!} ${storageController.wooCartItem.value!.totals!.lineTotal!}")
//                   //         .marginSymmetric(horizontal: margin),
//                   //     storageController.wooCartItem),
//                   getButtonFigma(context, getAccentColor(context), true,
//                       "Check Out", Colors.white, () {
//                     Constant.sendToNext(context, checkoutScreenRoute);
//                   }, EdgeInsets.symmetric(horizontal: margin, vertical: 20.h))
//                 ],
//               );
//             } else {
//               return EmptyCard();
//             }
//           }, productController.isMyCartLoading),
//         ),
//         onWillPop: () async {
//           backClick(context);
//           return true;
//         });
//   }
//
//   Widget EmptyCard() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           getSvgImageWithSize(context, "empty_card.svg", 150.h, 150.h,
//               fit: BoxFit.fill),
//           getCustomFont("Your cart is empty", 28, getFontColor(context), 1,
//                   textAlign: TextAlign.center, fontWeight: FontWeight.w700)
//               .marginSymmetric(vertical: 30.h),
//           SizedBox(
//             width: 194.h,
//             child: getButtonFigma(context, Colors.transparent, true,
//                 "Explore Now", getAccentColor(context), () {
//               Constant.sendToNext(context, homeScreenRoute);
//             }, EdgeInsets.zero,
//                 isBorder: true, borderColor: getAccentColor(context)),
//           )
//         ],
//       ),
//     );
//   }
//
//   Row buildTotalRow(BuildContext context, String title, String total) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         getCustomFont(
//           title,
//           22,
//           getFontColor(context),
//           1,
//           fontWeight: FontWeight.w700,
//         ),
//         getCustomFont(
//           total,
//           22,
//           getFontColor(context),
//           1,
//           fontWeight: FontWeight.w700,
//         ),
//       ],
//     );
//   }
// }
