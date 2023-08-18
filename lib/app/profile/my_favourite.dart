import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:pet_shop/base/constant.dart';
import 'package:pet_shop/base/fetch_pixels.dart';
import 'package:pet_shop/base/get/bottom_selection_controller.dart';
import 'package:pet_shop/base/get/route_key.dart';
import 'package:pet_shop/woocommerce/model/products.dart';

import '../../base/get/home_controller.dart';
import '../../base/get/product_data.dart';
import '../../base/get/storage_controller.dart';
import '../../base/pref_data.dart';
import '../../base/widget_utils.dart';

class MyFavourite extends StatefulWidget {
  const MyFavourite({Key? key}) : super(key: key);

  @override
  State<MyFavourite> createState() => _MyFavouriteState();
}

class _MyFavouriteState extends State<MyFavourite> {
  ProductDataController productController = Get.find<ProductDataController>();

  HomeController homeController = Get.find<HomeController>();

  StorageController storageController = Get.find<StorageController>();
  BottomItemSelectionController bottomController =
      Get.find<BottomItemSelectionController>();

  backClick(BuildContext context) {
    // Constant.backToPrev(context);
    Constant.sendToNext(context, homeScreenRoute);
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      productController.getAllFavouriteList(homeController.wooCommerce!);
    });
  }

  @override
  Widget build(BuildContext context) {
    Constant.setupSize(context);
    double margin = FetchPixels.getDefaultHorSpaceFigma(context);
    int crossCount = 2;
    double screenWidth = context.width - (margin * 2) + margin;
    double itemWidth = screenWidth / crossCount;
    double itemHeight = 217.w;

    return WillPopScope(
        child: Column(
          children: [
            getTitleAppBar(context, () {
              backClick(context);
            },
                title: "My Favourite",
                isCartAvailable: false,
                withBack: true,
                centerTitle: true),
            Expanded(
              flex: 1,
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: ObxValue<RxBool>((p0) {
                  print("getdata===${productController.favProductList.length}");
                  if (!p0.value &&
                      productController.favProductList.isNotEmpty) {
                    return AnimationLimiter(
                      child: GridView.count(
                          crossAxisCount: 2,
                          mainAxisSpacing: margin,
                          crossAxisSpacing: margin,
                          padding: EdgeInsets.only(
                              left: margin,
                              right: margin,
                              top: 0,
                              bottom: 15.h),
                          childAspectRatio: itemWidth / itemHeight,
                          children: List.generate(
                              productController.favProductList.length, (index) {
                            return FutureBuilder<WooProduct>(
                              future: homeController.wooCommerce!
                                  .getProductById(
                                      id: productController
                                          .favProductList[index]
                                          .toString()),
                              builder: (context, snapshot) {
                                if (snapshot.hasData && snapshot.data != null) {
                                  WooProduct product = snapshot.data!;
                                  return AnimationConfiguration.staggeredGrid(
                                    position: index,
                                    columnCount: 2,
                                    duration: const Duration(milliseconds: 600),
                                    child: FadeInAnimation(
                                      // verticalOffset: 60,

                                      child: buildNewArrivalItem(context,
                                          itemWidth, itemHeight, product, () {
                                        storageController
                                            .setSelectedWooProduct(product);
                                        Constant.sendToNext(
                                            context, productDetailScreenRoute);
                                      }, () {
                                        productController.favProductList
                                            .remove(product.id.toString());
                                        List<String> strList = productController
                                            .favProductList
                                            .map((i) => i.toString())
                                            .toList();
                                        PrefData().setFavouriteList(strList);
                                      },
                                          withFav: true,
                                          isFav: productController
                                              .favProductList
                                              .contains(product.id.toString())),
                                    ),
                                  );
                                } else {
                                  return 0.horizontalSpace;
                                }
                              },
                            );
                          })),
                    );
                  } else if (!p0.value &&
                      productController.favProductList.isEmpty) {
                    return getEmptyWidget(
                        context,
                        "no_order.png",
                        "No Favourite Yet!",
                        "Explore more and shortlist some products.",
                        "Add", () {
                      bottomController.changePos(0);
                      Constant.sendToNext(context, homeScreenRoute);
                    });
                  } else {
                    return getProgressDialog();
                  }
                }, productController.isFavouriteLoading),
              ),
            ),
          ],
        ),
        onWillPop: () async {
          backClick(context);
          return false;
        });

    // return buildCommanMyFavouriteScreen(context, margin, () {
    //   backClick(context);
    // });
  }
}
