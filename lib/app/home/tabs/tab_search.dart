import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_shop/base/color_data.dart';
import 'package:pet_shop/base/constant.dart';
import 'package:pet_shop/base/data_file.dart';
import 'package:pet_shop/base/get/product_data.dart';

import 'package:pet_shop/base/get/storage.dart';
import 'package:pet_shop/base/widget_utils.dart';

import '../../../base/fetch_pixels.dart';
import '../../../base/get/route_key.dart';
import '../../../base/pref_data.dart';
import '../../../woocommerce/model/products.dart';
import '../../model_ui/model_best_selling_pro.dart';

class TabSearch extends StatefulWidget {
  const TabSearch({Key? key}) : super(key: key);

  @override
  State<TabSearch> createState() => _TabSearchState();
}

class _TabSearchState extends State<TabSearch> {
  TextEditingController searchController = TextEditingController();

  SearchController search = Get.find<SearchController>();

  ProductDataController productController = Get.find<ProductDataController>();

  RxBool listChange = false.obs;

  RxList<String> favProductList = <String>[].obs;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      getFavDataList();
    });
  }

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

  List<String> hisList = ["Dry Food", "Rope Leash", "Healthy Treats "];
  List<String> searchList = ["Food", "Bathing", "Grooming", "Collar"];
  RxInt selectedId = 0.obs;
  List<ModelBestSellingProduct> productList = DataFile.getAllBestSellProduct();

  @override
  Widget build(BuildContext context) {
    Constant.setupSize(context);
    double margin = FetchPixels.getDefaultHorSpaceFigma(context);
    int crossCount = 2;
    double screenWidth = context.width - (margin * 2) + margin;
    double itemWidth = screenWidth / crossCount;
    double itemHeight = 219.w;

    return Column(
      children: [
        getDefaultHeader(context, "Search", () {},
            isShowSearch: true, isShowBack: false),
        20.h.verticalSpace,
        Expanded(
          flex: 1,
          child: ListView(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            children: [
              Container(
                padding: EdgeInsets.all(20.h),
                color: getCardColor(context),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 13.0,
                      runSpacing: 10.0,
                      children: List.generate(searchList.length, (index) {
                        return Obx(() => InkWell(
                              onTap: () {
                                selectedId(index);
                                // Constant.sendToScreen(se(cat.id.toString(), cat.name), context, (value) { });
                              },
                              child: Container(
                                  decoration: getButtonDecoration(
                                      Colors.transparent,
                                      withCorners: true,
                                      corner: 15.h,
                                      withBorder: true,
                                      borderColor: (selectedId.value == index)
                                          ? getAccentColor(context)
                                          : black40),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 13.h, vertical: 3.h),
                                  child: getCustomFont(
                                      searchList[index],
                                      14,
                                      (selectedId.value == index)
                                          ? getAccentColor(context)
                                          : black40,
                                      1,
                                      fontWeight: FontWeight.w400)),
                            ));
                      }),
                    ),
                    20.h.verticalSpace,
                    SizedBox(
                      height: 184.h,
                      width: double.infinity,
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.horizontal,
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          ModelBestSellingProduct product = productList[index];
                          return InkWell(
                            onTap: () {
                              Constant.sendToNext(
                                  context, productDetailScreenRoute);
                            },
                            child: SizedBox(
                              height: double.infinity,
                              width: 143.w,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          left: (index == 0) ? 20.h : 10.h,
                                          right: (index == 2) ? 20.h : 10.h),
                                      decoration: getButtonDecoration(
                                          getGreyCardColor(context),
                                          withCorners: true,
                                          corner: 12.h),
                                      child: Stack(
                                        children: [
                                          getAssetImage(
                                                  context,
                                                  product.image,
                                                  double.infinity,
                                                  double.infinity)
                                              .marginSymmetric(
                                                  horizontal: 25.h,
                                                  vertical: 10.h),
                                          Align(
                                              alignment: Alignment.topRight,
                                              child: buildFavButton(context,
                                                  isFav: false,
                                                  color:
                                                      getCardColor(context))),
                                        ],
                                      ),
                                    ),
                                  ),
                                  8.h.verticalSpace,
                                  getCustomFont(product.name, 17,
                                      getFontColor(context), 1,
                                      fontWeight: FontWeight.w700,
                                      txtHeight: 1.24,
                                      textAlign: TextAlign.start),
                                  8.h.verticalSpace,
                                  getCustomFont(product.price, 16,
                                      getFontColor(context), 1,
                                      fontWeight: FontWeight.w500,
                                      txtHeight: 1.28),
                                  8.h.verticalSpace
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    30.h.verticalSpace,
                    Row(
                      children: [
                        getSvgImageWithSize(context, "history.svg", 20.h, 20.h,
                            fit: BoxFit.fill),
                        12.w.horizontalSpace,
                        getCustomFont(
                            "Search History", 17, getFontColor(context), 1,
                            fontWeight: FontWeight.w600)
                      ],
                    ).marginOnly(bottom: 7.h),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              flex: 1,
                              child: getCustomFont(
                                  hisList[index], 16, getFontColor(context), 1,
                                  fontWeight: FontWeight.w500),
                            ),
                            InkWell(
                              onTap: () {
                                hisList.removeAt(index);
                                setData(keySearchHistory, hisList);
                                listChange.refresh();
                              },
                              child: getSvgImageWithSize(
                                  context, "close.svg", 20.h, 20.h,
                                  fit: BoxFit.fill),
                            )
                          ],
                        ).marginSymmetric(horizontal: margin, vertical: 7.h);
                      },
                      shrinkWrap: true,
                      itemCount: hisList.length,
                      padding: EdgeInsets.only(bottom: 10.h),
                    ),
                    // GetBuilder<SearchController>(
                    //   init: SearchController(),
                    //   builder: (controller) {
                    //     if (controller.isLoading) {
                    //       // return Container(width: 50,height: 50,color:Colors.green,);
                    //       return getProgressDialog();
                    //     } else if (!controller.isLoading &&
                    //         controller.searchProductList.isEmpty) {
                    //       return (hisList.isEmpty) ? getEmptyWidget(
                    //           context,
                    //           "no_search.svg",
                    //           "No Search Result! ",
                    //           "You have no recent searches.",
                    //           "",
                    //               () {},
                    //           withButton: false)
                    //           .marginOnly(top: 149.h) : 0.h.verticalSpace;
                    //     } else {
                    //       return GridView.count(
                    //           crossAxisCount: crossCount,
                    //           mainAxisSpacing: margin,
                    //           crossAxisSpacing: margin,
                    //           shrinkWrap: true,
                    //           padding: EdgeInsets.only(
                    //               left: margin,
                    //               right: margin,
                    //               top: 0,
                    //               bottom: 15.h),
                    //           childAspectRatio: itemWidth / itemHeight,
                    //           children: List.generate(
                    //               controller.searchProductList.length, (index) {
                    //             WooProduct product =
                    //             controller.searchProductList[index];
                    //             return buildNewArrivalItem(
                    //                 context, itemWidth, itemHeight,
                    //                 product, () {}, () {
                    //               // checkInFavouriteList(product);
                    //               // List<String> strList = favProductList.map((i) => i.toString()).toList();
                    //               // PrefData().setFavouriteList(strList);
                    //             },
                    //                 withFav: true,
                    //                 isFav: false);
                    //           }));
                    //     }
                    //   },
                    // )
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
