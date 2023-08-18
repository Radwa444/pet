import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:pet_shop/base/color_data.dart';
import 'package:pet_shop/base/constant.dart';
import 'package:pet_shop/base/fetch_pixels.dart';
import 'package:pet_shop/base/get/home_controller.dart';
import 'package:pet_shop/base/get/storage_controller.dart';
import 'package:pet_shop/base/widget_utils.dart';
import 'package:pet_shop/woocommerce/model/products.dart';

import '../../base/get/product_data.dart';
import '../../base/get/route_key.dart';
import '../../base/pref_data.dart';

class CategoryProductList extends StatefulWidget {
  String? id;
  String? name;

  CategoryProductList(this.id, this.name, {Key? key}) : super(key: key);

  @override
  State<CategoryProductList> createState() => _CategoryProductListState();
}

class _CategoryProductListState extends State<CategoryProductList> {
  ProductDataController productController = Get.find<ProductDataController>();

  HomeController homeController = Get.find<HomeController>();

  StorageController storageController = Get.find<StorageController>();

  backClick(BuildContext context) {
    Constant.backToPrev(context);
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      getFavDataList();
    });
  }

  RxList<String> favProductList = <String>[].obs;

  void getFavDataList() async {
    favProductList.value = await PrefData().getFavouriteList();
    print("getvals========${favProductList.length}");
  }

  checkInFavouriteList(WooProduct cat) async {
    if (favProductList.contains(cat.id.toString())) {
      favProductList.remove(cat.id.toString());
    } else {
      favProductList.add(cat.id!.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    Constant.setupSize(context);
    // if (productController.productList.isEmpty) {
    productController.getAllProductListByCategory(
        homeController.wooCommerce!, widget.id!);
    // }
    double margin = FetchPixels.getDefaultHorSpaceFigma(context);
    int crossCount = 2;
    double screenWidth = context.width - (margin * 2) + margin;
    double itemWidth = screenWidth / crossCount;
    double itemHeight = 217.w;

    return WillPopScope(
        child: Scaffold(
          backgroundColor: getCurrentTheme(context).scaffoldBackgroundColor,
          appBar: getTitleAppBar(
              context,
              () {
                backClick(context);
              },
              title: widget.name!,
              centerTitle: true,
              isFilterAvailable: true,
              filterFun: (value) {
                switch (value) {
                  case "NewAdded":
                    productController.getListBFilter();
                    break;
                  case "PriceHigh":
                    productController.getHighToLowFilter();
                    break;
                  case "PriceLow":
                    productController.getLowToHighFilter();
                    break;
                }
              }),
          body: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: ObxValue<RxBool>((p0) {
              print("getdata===${productController.productList.length}");
              if (!p0.value && productController.productList.isNotEmpty) {
                return AnimationLimiter(
                  child: GridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: margin,
                      crossAxisSpacing: margin,
                      padding: EdgeInsets.only(
                          left: margin, right: margin, top: 0, bottom: 15.h),
                      childAspectRatio: itemWidth / itemHeight,
                      children: List.generate(
                          productController.productList.length, (index) {
                        WooProduct product =
                            productController.productList[index];
                        return AnimationConfiguration.staggeredGrid(
                          position: index,
                          duration: const Duration(milliseconds: 400),
                          columnCount: 2,
                          child: SlideAnimation(
                            verticalOffset: 60,
                            child: Obx(() => buildNewArrivalItem(
                                    context, itemWidth, itemHeight, product,
                                    () {
                                  storageController
                                      .setSelectedWooProduct(product);
                                  Constant.sendToNext(
                                      context, productDetailScreenRoute);
                                }, () {
                                  checkInFavouriteList(product);
                                  List<String> strList = favProductList
                                      .map((i) => i.toString())
                                      .toList();
                                  PrefData().setFavouriteList(strList);
                                },
                                    withFav: true,
                                    isFav: favProductList
                                        .contains(product.id.toString()))),
                          ),
                        );
                      })),
                );

                // return ListView.builder(
                //   itemBuilder: (context, index) {
                //     WooProduct product =
                //         productController.bestSellingProductList[index];
                //     return buildBestSellingItem(
                //         context, product, double.infinity, 130.w,(){},
                //         margin: EdgeInsets.symmetric(
                //             horizontal: margin, vertical: 10.h));
                //   },
                //   padding: EdgeInsets.zero,
                //   itemCount: productController.bestSellingProductList.length,
                //   shrinkWrap: true,
                // );
              } else {
                return getProgressDialog();
              }
            }, productController.isDataLoading),
          ),
        ),
        onWillPop: () async {
          backClick(context);
          return false;
        });
  }

// void _showPopupMenu(Offset offset) async {
//
//   await showMenu(
//     context: context,
//     position: offset,
//     items: [
//       PopupMenuItem<String>(
//           child: const Text('Doge'), value: 'Doge'),
//       PopupMenuItem<String>(
//           child: const Text('Lion'), value: 'Lion'),
//     ],
//     elevation: 8.0,
//   );
// }
}
