import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_shop/app/model_ui/model_category.dart';
import 'package:pet_shop/base/color_data.dart';
import 'package:pet_shop/base/constant.dart';
import 'package:pet_shop/base/data_file.dart';
import 'package:pet_shop/base/fetch_pixels.dart';
import 'package:pet_shop/base/get/route_key.dart';
import 'package:pet_shop/base/widget_utils.dart';
import '../model_ui/model_sub_category.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>
    with TickerProviderStateMixin {
  // StorageController storeController = Get.find<StorageController>();

  // ProductDataController productController = Get.find<ProductDataController>();

  // HomeController homeController = Get.find<HomeController>();
  // StorageController storageController = Get.find<StorageController>();
  //
  // final controller = Get.find<BottomItemSelectionController>();
  //
  // int flashSale = 17;

  RxInt selectedId = 0.obs;

  @override
  void initState() {
    super.initState();
    // Future.delayed(Duration.zero, () async {
    //   getFavDataList();
    // });
  }

  // RxList<String> favProductList = <String>[].obs;
  //
  // void getFavDataList() async {
  //   favProductList.value = await PrefData().getFavouriteList();
  //   print("getvals========${favProductList.length}");
  // }
  //
  // checkInFavouriteList(WooProduct cat) async {
  //   if (favProductList.contains(cat.id.toString())) {
  //     favProductList.remove(cat.id.toString());
  //   } else {
  //     favProductList.add(cat.id!.toString());
  //   }
  // }
  //
  // RxString imageUrl = ''.obs;
  //
  // List<WooProductCategory> catList = [];
  //
  List<ModelSubCategory> subCategory = DataFile.getAllSubCategory();
  List<ModelCategory> allCategory = DataFile.getAllCategory();

  @override
  Widget build(BuildContext context) {
    double margin = FetchPixels.getDefaultHorSpaceFigma(context);

    int crossCount = 2;
    double screenWidth = context.width - 200.w - (margin * 3) + margin;
    double itemWidth = screenWidth / crossCount;
    double itemHeight = 102.w;

    Constant.setupSize(context);
    void backClick() {
      Constant.backToPrev(context);
    }

    return WillPopScope(
      onWillPop: () async {
        backClick();
        return false;
      },
      child: Scaffold(
        backgroundColor: getScaffoldColor(context),
        body: Column(
          children: [
            getDefaultHeader(context, "Category", () {
              backClick();
            }, isShowSearch: false),
            20.h.verticalSpace,
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      width: 100.w,
                      height: double.infinity,
                      color: getCardColor(context),
                      child: SizedBox(
                          width: double.infinity,
                          child: ListView.builder(
                              primary: true,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                ModelCategory category = allCategory[index];
                                return Obx(() => InkWell(
                                      onTap: () {
                                        selectedId(index);
                                        // imageUrl(category.image!.src!);
                                        // productController
                                        //     .getAllProductListByCategory(
                                        //     homeController
                                        //         .wooCommerce!,
                                        //     category.id.toString());
                                        // Constant.sendToNextWithResult(context,CategoryProductList(category.id.toString(),category.name!),(value){getFavDataList();});
                                      },
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 20.h, vertical: 5.h),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.h, vertical: 10.h),
                                        // margin: EdgeInsets,
                                        decoration: getButtonDecoration(
                                            (selectedId.value == index)
                                                ? getAccentColor(context)
                                                    .withOpacity(0.1)
                                                : Colors.transparent,
                                            withCorners: true,
                                            corner: 6.w,
                                            withBorder: false,
                                            borderColor:
                                                getDividerColor(context)),

                                        child: getCustomFont(
                                            category.name,
                                            16,
                                            (selectedId.value == index)
                                                ? getAccentColor(context)
                                                : getFontColor(context),
                                            3,
                                            fontWeight: FontWeight.w500,
                                            txtHeight: 1.5,
                                            textAlign: TextAlign.start),
                                      ),
                                    ));
                              },
                              // shrinkWrap: true,
                              // primary: false,
                              scrollDirection: Axis.vertical,
                              itemCount: allCategory.length)
                          // ,

                          )),
                  10.h.horizontalSpace,
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: getCardColor(context),
                      child: GridView.count(
                          crossAxisCount: 3,
                          mainAxisSpacing: margin,
                          crossAxisSpacing: margin,
                          padding: EdgeInsets.only(
                              left: margin,
                              right: margin,
                              top: 20.h,
                              bottom: 15.h),
                          childAspectRatio: itemWidth / itemHeight,
                          children: List.generate(subCategory.length, (index) {
                            ModelSubCategory subCat = subCategory[index];
                            return InkWell(
                              onTap: () {
                                Constant.sendToNext(
                                    context, productDetailScreenRoute);
                              },
                              child: SizedBox(
                                height: itemHeight,
                                width: itemWidth,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        height: double.infinity,
                                        width: double.infinity,
                                        padding: EdgeInsets.all(8.h),
                                        decoration: getButtonDecoration(
                                            getGreyCardColor(context),
                                            withCorners: true,
                                            corner: 12.h),
                                        child: getAssetImage(
                                            context,
                                            subCat.image,
                                            double.infinity,
                                            double.infinity),
                                      ),
                                    ),
                                    7.h.verticalSpace,
                                    getCustomFont(
                                      subCat.name,
                                      15,
                                      getFontColor(context),
                                      1,
                                      fontWeight: FontWeight.w500,
                                    )
                                  ],
                                ),
                              ),
                            );
                          })),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSeeMoreWidget(
      BuildContext context, String title, double margin, Function function) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        getCustomFont(title, 20, getFontColor(context), 1,
            fontWeight: FontWeight.w700, textAlign: TextAlign.start),
        InkWell(
          onTap: () {
            function();
          },
          child: getCustomFont("See more", 16, getFontGreyColor(context), 1,
              fontWeight: FontWeight.w400, textAlign: TextAlign.start),
        )
      ],
    ).paddingSymmetric(horizontal: margin);
  }
}
