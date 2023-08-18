import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:pet_shop/app/model_ui/model_best_selling_pro.dart';
import 'package:pet_shop/app/model_ui/model_blog.dart';
import 'package:pet_shop/app/model_ui/model_category.dart';
import 'package:pet_shop/app/model_ui/model_popular_product.dart';
import 'package:pet_shop/base/color_data.dart';
import 'package:pet_shop/base/constant.dart';
import 'package:pet_shop/base/data_file.dart';
import 'package:pet_shop/base/fetch_pixels.dart';
import 'package:pet_shop/base/get/route_key.dart';
import 'package:pet_shop/base/get/storage_controller.dart';
import 'package:pet_shop/base/pref_data.dart';
import 'package:pet_shop/base/widget_utils.dart';

import '../../../base/get/bottom_selection_controller.dart';
import '../../../base/get/home_controller.dart';
import '../../../base/get/product_data.dart';
import '../../lists/best_selling_list.dart';

class TabHome extends StatefulWidget {
  const TabHome({Key? key}) : super(key: key);

  @override
  State<TabHome> createState() => _TabHomeState();
}

class _TabHomeState extends State<TabHome> with TickerProviderStateMixin {
  StorageController storeController = Get.find<StorageController>();

  ProductDataController productController = Get.find<ProductDataController>();

  HomeController homeController = Get.find<HomeController>();

  final controller = Get.find<BottomItemSelectionController>();

  List<ModelPopularProduct> popularPro = DataFile.getAllPopularProductList();
  List<ModelBestSellingProduct> bestSellList = DataFile.getAllBestSellProduct();
  List<ModelBlog> blogList = DataFile.getAllBlog();
  List<ModelCategory> categoryList = DataFile.getAllCategory();

  RxInt selectedPos = 0.obs;

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
  }

  @override
  Widget build(BuildContext context) {
    Constant.setupSize(context);
    RxInt sliderPos = 0.obs;
    double margin = FetchPixels.getDefaultHorSpaceFigma(context);

    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          Container(
            color: getCardColor(context),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  color: getCardColor(context),
                  padding: EdgeInsets.only(
                    top: Constant.getToolbarTopHeight(context) + 14.h,
                  ),
                  margin: EdgeInsets.symmetric(horizontal: margin),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            getCustomFont(
                                "Location", 14, getFontGreyColor(context), 1,
                                fontWeight: FontWeight.w400),
                            4.h.verticalSpace,
                            getCustomFont(
                                "New Mexico", 17, getFontColor(context), 1,
                                fontWeight: FontWeight.w600)
                          ],
                        ),
                      ),
                      InkWell(
                          onTap: () {
                            controller.changePos(1);
                          },
                          child: getSvgImageWithSize(
                              context, "search.svg", 24.h, 24.h)),
                    ],
                  ),
                ),
                20.h.verticalSpace,
              ],
            ),
          ),
          20.h.verticalSpace,
          Expanded(
            flex: 1,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                SizedBox(
                  height: 140.h,
                  width: double.infinity,
                  child: CarouselSlider(
                      items: List.generate(3, (index) {
                        return Container(
                          decoration: getButtonDecoration(
                            "#CDF5E7".toColor(),
                            withCorners: true,
                            corner: 22.h,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                  flex: 3,
                                  child: Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 17.h),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        getCustomFont(
                                          "Now Get 10% Off",
                                          17,
                                          getFontColor(context),
                                          1,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        getVerSpace(8.h),
                                        getCustomFont(
                                          "On Your First Purchase By Using \nCode 2409AB ",
                                          12,
                                          getFontColor(context),
                                          2,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        getVerSpace(12.h),
                                        Row(
                                          children: [
                                            getCustomFont(
                                              "SHOP NOW",
                                              12,
                                              getFontColor(context),
                                              1,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            getHorSpace(6.h),
                                            getSvgImage(
                                                context, "arrow.svg", 16)
                                          ],
                                        ),
                                      ],
                                    ),
                                  )),
                              Expanded(
                                  flex: 2,
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: Container(
                                          height: 100.h,
                                          width: 120.h,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  topLeft:
                                                      Radius.circular(43.h),
                                                  bottomRight:
                                                      Radius.circular(22.h)),
                                              color: "#95DEC4".toColor()),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.all(15.h),
                                        decoration: BoxDecoration(
                                            image: getDecorationAssetImage(
                                                context, "cat_product.png",
                                                fit: BoxFit.cover)),
                                      ),
                                    ],
                                  ))
                            ],
                          ),
                        );
                      }),
                      options: CarouselOptions(
                        viewportFraction: 0.9,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: false,
                        autoPlayInterval: const Duration(seconds: 3),
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        onPageChanged: (position, reason) {
                          sliderPos.value = position;
                        },
                      )),
                ),
                12.h.verticalSpace,
                ObxValue(
                    (p0) => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: indicators(context, 3, sliderPos.value)),
                    sliderPos),
                20.h.verticalSpace,
                Container(
                  color: getCardColor(context),
                  padding: EdgeInsets.symmetric(vertical: margin),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildViewAllWidget(context, "Choose Your Pet", () {
                        Constant.sendToNext(context, categoryScreenRoute);
                      }),
                      20.h.verticalSpace,
                      SizedBox(
                          height: 107.w,
                          width: double.infinity,
                          child: ListView.builder(
                              primary: false,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                ModelCategory cat = categoryList[index];
                                return InkWell(
                                  onTap: () {
                                    Constant.sendToNext(
                                        context, categoryScreenRoute);
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        // bottom: 6.w,
                                        //   top: 1,
                                        left: (index == 0
                                            ? margin
                                            : (margin / 2)),
                                        right: (index == categoryList.length - 1
                                            ? margin
                                            : (margin / 2))),
                                    width: 79.w,
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            width: double.infinity,
                                            decoration: getButtonDecoration(
                                              getGreyCardColor(context),
                                              // getCardColor(context),
                                              withCorners: true,
                                              corner: 22.h,
                                            ),
                                            child: Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: getAssetImage(
                                                        context,
                                                        cat.image,
                                                        double.infinity,
                                                        double.infinity)
                                                    .marginOnly(
                                                  top: 10.h,
                                                )),
                                          ),
                                        ),
                                        8.h.verticalSpace,
                                        Center(
                                          child: getCustomFont(cat.name, 15,
                                              getFontColor(context), 1,
                                              fontWeight: FontWeight.w500,
                                              txtHeight: 1.5,
                                              textAlign: TextAlign.center),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                              // shrinkWrap: true,
                              // primary: false,
                              scrollDirection: Axis.horizontal,
                              itemCount: 4)
                          // ,

                          ),
                    ],
                  ),
                ),
                20.h.verticalSpace,
                Container(
                  color: getCardColor(context),
                  padding: EdgeInsets.symmetric(vertical: margin),
                  child: Column(
                    children: [
                      buildViewAllWidget(context, "Best Selling Products", () {
                        Constant.sendToNext(context, bestSellingScreenList);
                        // Constant.sendToNextWithBackResult(
                        //     context, bestSellingScreenList, (value) {
                        //   getFavDataList();
                        // });
                      }),
                      20.h.verticalSpace,
                      SizedBox(
                        height: 180.w,
                        width: double.infinity,
                        child: AnimationLimiter(
                          child: ListView.builder(
                              primary: false,
                              // shrinkWrap: true,
                              itemBuilder: (context, index) {
                                ModelBestSellingProduct bestSell =
                                    bestSellList[index];
                                return InkWell(
                                  onTap: () {
                                    Constant.sendToNext(
                                        context, productDetailScreenRoute);
                                    // storeController
                                    //     .setSelectedWooProduct(category);
                                    // Constant.sendToNext(context,
                                    //     productDetailScreenRoute);
                                  },
                                  child: Container(
                                    decoration: getButtonDecoration(
                                      getCardColor(context),
                                      withCorners: true,
                                      corner: 22.w,
                                    ),
                                    margin: EdgeInsets.only(
                                      left:
                                          (index == 0 ? margin : (margin / 2)),
                                      right: (index == bestSellList.length - 1
                                          ? margin
                                          : (margin / 2)),
                                    ),
                                    width: 145.w,
                                    padding: EdgeInsets.all(6.w),
                                    height: double.infinity,
                                    child: buildCommonProductView(
                                        context,
                                        bestSell.image,
                                        bestSell.name,
                                        bestSell.price,
                                        isDiscount:
                                            (index == 1) ? true : false),
                                  ),
                                );
                              },
                              // shrinkWrap: true,
                              // primary: false,
                              scrollDirection: Axis.horizontal,
                              itemCount: 3),
                        ),
                      )
                    ],
                  ),
                ),
                20.h.verticalSpace,
                Container(
                  color: getCardColor(context),
                  padding: EdgeInsets.symmetric(vertical: margin),
                  child: Column(
                    children: [
                      buildViewAllWidget(context, "Popular Product", () {
                        Constant.sendToNext(context, popularProductScreenRoute);
                      }),
                      20.h.verticalSpace,
                      SizedBox(
                        height: 217.h,
                        width: double.infinity,
                        child: ListView.builder(
                            primary: false,
                            // shrinkWrap: true,
                            itemBuilder: (context, index) {
                              ModelPopularProduct product = popularPro[index];
                              return InkWell(
                                onTap: () {
                                  Constant.sendToNext(
                                      context, productDetailScreenRoute);
                                },
                                child: Container(
                                    decoration: getButtonDecoration(
                                      getCardColor(context),
                                    ),
                                    margin: EdgeInsets.only(
                                      left:
                                          (index == 0 ? margin : (margin / 2)),
                                      right: (index == popularPro.length - 1
                                          ? margin
                                          : (margin / 2)),
                                    ),
                                    width: 177.w,
                                    height: double.infinity,
                                    child: buildCommonProductView(
                                        context,
                                        product.img,
                                        product.name,
                                        product.price)),
                              );
                            },
                            scrollDirection: Axis.horizontal,
                            itemCount: 2),
                      )
                    ],
                  ),
                ),
                20.h.verticalSpace,
                Container(
                  color: getCardColor(context),
                  padding: EdgeInsets.symmetric(vertical: margin),
                  child: Column(
                    children: [
                      buildViewAllWidget(context, "Blog", () {
                        Constant.sendToNext(context, blogScreenRoute);
                      }),
                      20.h.verticalSpace,
                      InkWell(
                        onTap: () {
                          Constant.sendToNext(context, blogDetailScreenRoute);
                        },
                        child: buildCommonBlogView(
                            margin,
                            context,
                            blogList[0].name,
                            blogList[0].image,
                            blogList[0].date),
                      )
                    ],
                  ),
                ),
                20.h.verticalSpace,
              ],
            ),
          )
        ],
      ),
    );
  }
}

Widget buildViewAllWidget(
    BuildContext context, String title, Function function) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      getCustomFont(title, 22, getFontColor(context), 1,
          fontWeight: FontWeight.w700, textAlign: TextAlign.start),
      InkWell(
        onTap: () {
          function();
        },
        child: getCustomFont("View All", 16, accentColor, 1,
            fontWeight: FontWeight.w400, textAlign: TextAlign.start),
      )
    ],
  ).marginSymmetric(horizontal: 20.h);
}

SizedBox buildCommonBlogView(double margin, BuildContext context, String title,
    String image, String date) {
  return SizedBox(
    height: 110.h,
    width: double.infinity,
    child: Row(
      children: [
        Container(
          height: 110.h,
          width: 110.h,
          margin: EdgeInsets.symmetric(horizontal: margin),
          decoration:
              BoxDecoration(image: getDecorationAssetImage(context, image)),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              getMultilineCustomFont(title, 16, getFontColor(context),
                  fontWeight: FontWeight.w600),
              12.h.verticalSpace,
              buildDateRow(context, date),
            ],
          ),
        ),
      ],
    ),
  );
}

Row buildDateRow(BuildContext context, String date) {
  return Row(
    children: [
      getSvgImage(context, "calendar.svg", 18),
      10.h.horizontalSpace,
      getCustomFont(date, 14, getFontColor(context), 1,
          fontWeight: FontWeight.w400)
    ],
  );
}

List<Widget> indicators(BuildContext context, imagesLength, currentIndex) {
  return List<Widget>.generate(imagesLength, (index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      width: 6.w,
      height: 6.w,
      decoration: BoxDecoration(
          color: currentIndex == index ? black40 : Colors.grey.shade300,
          shape: BoxShape.circle),
    );
  });
}
