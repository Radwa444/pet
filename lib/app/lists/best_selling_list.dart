import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_shop/base/color_data.dart';
import 'package:pet_shop/base/constant.dart';
import 'package:pet_shop/base/data_file.dart';
import 'package:pet_shop/base/fetch_pixels.dart';
import 'package:pet_shop/base/get/route_key.dart';
import 'package:pet_shop/base/widget_utils.dart';

import '../model_ui/model_best_selling_pro.dart';

class BestSellingList extends StatefulWidget {
  const BestSellingList({Key? key}) : super(key: key);

  @override
  State<BestSellingList> createState() => _BestSellingListState();
}

class _BestSellingListState extends State<BestSellingList> {
  // ProductDataController productController = Get.find<ProductDataController>();
  //
  // HomeController homeController = Get.find<HomeController>();
  //
  // StorageController storageController = Get.find<StorageController>();
  //
  backClick(BuildContext context) {
    Constant.backToPrev(context);
  }

  // @override
  // void initState() {
  //   super.initState();
  //   // Future.delayed(Duration.zero, () async {
  //   // getFavDataList();
  //   // });
  // }

  // RxList<String> favProductList = <String>[].obs;

  // void getFavDataList() async {
  //   favProductList.value = await PrefData().getFavouriteList();
  //   print("getvals========${favProductList.length}");
  // }

  // checkInFavouriteList(WooProduct cat) async {
  //   if (favProductList.contains(cat.id.toString())) {
  //     favProductList.remove(cat.id.toString());
  //   } else {
  //     favProductList.add(cat.id!.toString());
  //   }
  // }

  List<ModelBestSellingProduct> bestSellingProduct =
      DataFile.getAllBestSellProduct();

  @override
  Widget build(BuildContext context) {
    Constant.setupSize(context);
    // if (productController.flashSaleList.isEmpty) {
    //   productController.getFlashSaleList(homeController.wooCommerce!);
    // }
    double margin = FetchPixels.getDefaultHorSpaceFigma(context);
    int crossCount = 2;
    double screenWidth = context.width - (margin * 2) + margin;
    double itemWidth = screenWidth / crossCount;
    double itemHeight = 220.h;

    return WillPopScope(
        child: Scaffold(
          backgroundColor: getScaffoldColor(context),
          body: Column(
            children: [
              getDefaultHeader(context, "Best Selling Product", () {
                backClick(context);
              }, isShowSearch: false, withFilter: true),
              20.h.verticalSpace,
              Expanded(
                flex: 1,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 20.h),
                  color: getCardColor(context),
                  child: GridView.count(
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      crossAxisCount: crossCount,
                      mainAxisSpacing: margin,
                      crossAxisSpacing: margin,
                      childAspectRatio: itemWidth / itemHeight,
                      children:
                          List.generate(bestSellingProduct.length, (index) {
                        ModelBestSellingProduct bestSell =
                            bestSellingProduct[index];
                        return InkWell(
                          onTap: () {
                            Constant.sendToNext(
                                context, productDetailScreenRoute);
                          },
                          child: Container(
                            height: itemHeight,
                            width: itemWidth,
                            decoration: getButtonDecoration(
                              getCardColor(context),
                            ),
                            child: buildCommonProductView(context,
                                bestSell.image, bestSell.name, bestSell.price),
                          ),
                        );
                      })),
                ),
              ),
            ],
          ),
        ),
        onWillPop: () async {
          backClick(context);
          return false;
        });
  }
}

Column buildCommonProductView(
    BuildContext context, String image, String name, String price,
    {bool isDiscount = false, bool isSoldOut = false, bool isFav = false}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        flex: 1,
        child: Container(
          decoration: getButtonDecoration(getGreyCardColor(context),
              withCorners: true, corner: 12.h),
          child: Stack(
            children: [
              getAssetImage(context, image, double.infinity, double.infinity)
                  .marginSymmetric(horizontal: 25.h, vertical: 10.h),
              (isDiscount || name == "Pedigree Nutritions")
                  ? Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 4.h, horizontal: 6.h),
                        margin: EdgeInsets.symmetric(
                            horizontal: 10.h, vertical: 10.h),
                        decoration: getButtonDecoration(
                          getAccentColor(context),
                          withCorners: true,
                          corner: 4.h,
                        ),
                        child: getCustomFont("Sale", 12, Colors.white, 1,
                            fontWeight: FontWeight.w600,
                            textAlign: TextAlign.center),
                      ),
                    )
                  : (name == "Dry Food Mini")
                      ? Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 10.h, vertical: 10.h),
                            padding: EdgeInsets.symmetric(
                                vertical: 4.h, horizontal: 6.h),
                            decoration: getButtonDecoration(
                              "#F25A59".toColor(),
                              withCorners: true,
                              corner: 4.h,
                            ),
                            child: getCustomFont(
                                "Sold Out", 12, Colors.white, 1,
                                fontWeight: FontWeight.w600,
                                textAlign: TextAlign.center),
                          ),
                        )
                      : 0.h.horizontalSpace
            ],
          ),
        ),
      ),
      8.h.verticalSpace,
      getCustomFont(name, 17, getFontColor(context), 1,
          fontWeight: FontWeight.w700,
          txtHeight: 1.24,
          textAlign: TextAlign.start),
      8.h.verticalSpace,
      Row(
        children: [
          Expanded(
            flex: 1,
            child: Row(
              children: [
                getCustomFont(price, 16, getFontColor(context), 1,
                    fontWeight: FontWeight.w500, txtHeight: 1.28),
                (isDiscount)
                    ? getCustomFont("\$34.00", 16, Colors.red, 1,
                        fontWeight: FontWeight.w400,
                        txtHeight: 1.28,
                        decoration: TextDecoration.lineThrough)
                    : 0.h.horizontalSpace,
              ],
            ),
          ),
          buildFavButton(context,
              isFav: isFav, color: getGreyCardColor(context)),
        ],
      ),
      8.h.verticalSpace
    ],
  );
}
