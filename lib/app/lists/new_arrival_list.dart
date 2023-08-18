import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_shop/base/color_data.dart';
import 'package:pet_shop/base/constant.dart';
import 'package:pet_shop/base/fetch_pixels.dart';
import 'package:pet_shop/base/get/home_controller.dart';
import 'package:pet_shop/base/widget_utils.dart';
import 'package:pet_shop/woocommerce/model/products.dart';

import '../../base/get/product_data.dart';
import '../../base/pref_data.dart';

class NewArrivalList extends StatefulWidget {
  const NewArrivalList({Key? key}) : super(key: key);

  @override
  State<NewArrivalList> createState() => _NewArrivalListState();
}

class _NewArrivalListState extends State<NewArrivalList> {
  ProductDataController productController = Get.find<ProductDataController>();

  HomeController homeController = Get.find<HomeController>();

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
    // setState(() {
    //     // List<dynamic> getData = jsonDecode(string);
    //     // favProductList = string.map((e) => WooProduct.fromJson(e)).toList();
    //     //  string.map((e) {
    //        // var map = WooProduct.fromJson(json.decode(e));
    //        // print("favlistsize==${result.length}");
    //      // }).toList();
    //   });
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
    if (productController.newArriveProductList.isEmpty) {
      productController.getNewArrivalProductList(homeController.wooCommerce!);
    }
    double margin = FetchPixels.getDefaultHorSpaceFigma(context);
    int crossCount = 2;
    double screenWidth = context.width - (margin * 2) + margin;
    double itemWidth = screenWidth / crossCount;
    double itemHeight = 219.w;

    return WillPopScope(
        child: Scaffold(
          backgroundColor: getCurrentTheme(context).scaffoldBackgroundColor,
          appBar: getTitleAppBar(context, () {
            backClick(context);
          }, title: "New Arrival"),
          body: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: ObxValue<RxBool>((p0) {
              print(
                  "getdata===${productController.newArriveProductList.length}");
              if (!p0.value &&
                  productController.newArriveProductList.isNotEmpty) {
                return GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: margin,
                    crossAxisSpacing: margin,
                    padding: EdgeInsets.only(
                        left: margin, right: margin, top: 0, bottom: 15.h),
                    childAspectRatio: itemWidth / itemHeight,
                    children: List.generate(
                        productController.newArriveProductList.length, (index) {
                      WooProduct product =
                          productController.newArriveProductList[index];
                      return Obx(() => buildNewArrivalItem(
                              context, itemWidth, itemHeight, product, () {},
                              () {
                            checkInFavouriteList(product);
                            List<String> strList = favProductList
                                .map((i) => i.toString())
                                .toList();
                            PrefData().setFavouriteList(strList);
                          },
                              withFav: true,
                              isFav: favProductList
                                  .contains(product.id.toString())));
                    }));
              } else {
                return getProgressDialog();
              }
            }, productController.isNewArrivalDataLoading),
          ),
        ),
        onWillPop: () async {
          backClick(context);
          return false;
        });
  }
}
