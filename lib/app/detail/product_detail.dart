import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/rating/gf_rating.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pet_shop/base/get/bottom_selection_controller.dart';
import 'package:readmore/readmore.dart';
import 'package:pet_shop/base/color_data.dart';
import 'package:pet_shop/base/constant.dart';
import 'package:pet_shop/base/data_file.dart';
import 'package:pet_shop/base/fetch_pixels.dart';
import 'package:pet_shop/base/widget_utils.dart';
import 'package:intl/intl.dart';

import '../../base/get/route_key.dart';
import '../home/tabs/tab_home.dart';
import '../lists/best_selling_list.dart';
import '../model_ui/model_popular_product.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ProductDetailScreen();
  }
}

class _ProductDetailScreen extends State<ProductDetailScreen>
    with TickerProviderStateMixin {
  // backToPrev(BuildContext context) {
  //   storageController.clearProductVariation();
  //   storageController.currentQuantity.value = 1;
  //   Constant.backToPrev(context);
  // }
  //
  // CartController cartController = Get.put(CartController());
  // AlreadyInCart isPurchaseController = Get.find<AlreadyInCart>();
  // StorageController storageController = Get.find<StorageController>();
  // HomeController homeController = Get.find<HomeController>();
  // List<WooProductVariation> listVariation = [];
  // RxBool isDescriptionOpen = true.obs;
  //
  // // RxBool isDescriptionOpen = false.obs;
  // RxBool isReviewOpen = false.obs;
  //
  // RxList<Attribute> selectedAttributes = <Attribute>[].obs;
  //
  // // RxBool alreadyInCart = false.obs;
  // RxInt cartIndex = 0.obs;

  // Rx<CartOtherInfo?> cartData=(null as CartOtherInfo?).obs;

  void backClick() {
    Constant.backToPrev(context);
  }

  @override
  void initState() {
    // storageController.setCurrentQuantity(1,isRefresh: false);
    // isPurchaseController.setPurchaseValue(false, isRefresh: false);
    //
    super.initState();
    // // getVariations();
    // checkAlreadyInCart();
  }

  // checkAlreadyInCart() {
  //   if (cartController.cartOtherInfoList.isNotEmpty) {
  //     var selectedId = storageController.selectedProduct!.id;
  //
  //     for (int i = 0; i < cartController.cartOtherInfoList.length; i++) {
  //       CartOtherInfo element = cartController.cartOtherInfoList[i];
  //       if (element.productId == selectedId) {
  //         cartIndex.value = i;
  //         storageController.setCurrentQuantity((element.quantity ?? 1));
  //         // storageController.currentQuantity = (element.quantity ?? 1).obs;
  //         // alreadyInCart.value = true;
  //         Future.delayed(
  //           Duration.zero,
  //           () {
  //             isPurchaseController.setPurchaseValue(true);
  //           },
  //         );
  //         return;
  //       }
  //     }
  //     // storageController.refreshStorageController();
  //
  //     // cartController.cartOtherInfoList.forEach((element) {
  //     //   if (element.productId == selectedId) {
  //     //     // cartData.value=element;
  //     //     storageController.currentQuantity=(element.quantity??1).obs;
  //     //     alreadyInCart.value = true;
  //     //     return;
  //     //   }
  //     // });
  //   }
  // }

  // getVariations() async {
  //   WooProduct selectedProduct1 = storageController.selectedProduct!;
  //
  //   listVariation = await homeController.wooCommerce!
  //       .getProductVariations(productId: selectedProduct1.id!);
  //   print("isEmpty===${listVariation.isEmpty}");
  //   if (listVariation.isNotEmpty) {
  //     if (storageController.attributeList.isNotEmpty) {
  //       storageController.attributeList.forEach((element) {
  //         selectedAttributes.add(Attribute(element.name, element.options![0]));
  //       });
  //
  //       changeVariationValue();
  //
  //       //
  //       // print("defValue===${selectedAttributes.toList().toString()}");
  //       // print("defValue111===${listVariation.toList().toString()}");
  //       // print("defValueindex===${listEquals(selectedAttributes, listVariation[0].attributes)}");
  //       // print("defValueindex22===${listVariation==WooProductVariation(attributes: selectedAttributes)}");
  //       // print("defValueindex22===${listVariation.indexOf(WooProductVariation(attributes: selectedAttributes))}");
  //     }
  //   }
  // }

  List<String> list = <String>["Green", "Yellow", "Blue"];
  List<String> list1 = <String>["Large", "Medium", "Small"];

  List<ModelPopularProduct> popularProduct =
      DataFile.getAllPopularProductList();
  List<ModelPopularProduct> popularProduct1 = [];

  BottomItemSelectionController bottomController =
      Get.find<BottomItemSelectionController>();

  @override
  Widget build(BuildContext context) {
    Constant.setupSize(context);
    double margin = FetchPixels.getDefaultHorSpaceFigma(context);
    double horSpace = FetchPixels.getDefaultHorSpaceFigma(context);

    popularProduct1.add(popularProduct[3]);
    popularProduct1.add(popularProduct[2]);

    return WillPopScope(
        child: Scaffold(
          backgroundColor: getScaffoldColor(context),
          body: Stack(
            children: [
              CustomScrollView(
                shrinkWrap: true,
                primary: true,
                slivers: [
                  SliverAppBar(
                    backgroundColor: Colors.transparent,
                    expandedHeight: 310.h,
                    leading: Center(
                        child: getBackIcon(context, () {
                      backClick();
                    }, colors: getFontColor(context))),
                    flexibleSpace: FlexibleSpaceBar(
                        background: Center(
                            child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        getAssetImage(context, "best_sell_4.png", 208.h, 208.h,
                            boxFit: BoxFit.cover),
                        9.h.verticalSpace,
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: indicators(context, 4, 0))
                      ],
                    ))),
                  ),
                  SliverList(
                      delegate: SliverChildListDelegate([
                    ListView(
                      padding: EdgeInsets.only(top: 20.h),
                      primary: false,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        Container(
                          padding: EdgeInsets.all(horSpace),
                          color: getCardColor(context),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              getCustomFont("Dog Rope Leash", 22,
                                  getFontColor(context), 1,
                                  textAlign: TextAlign.start,
                                  fontWeight: FontWeight.w700),
                              getVerSpace(12.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Row(
                                        children: [
                                          getCustomFont(
                                            "\$30.00",
                                            16,
                                            getFontGreyColor(context),
                                            1,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          getCustomFont(
                                                  "\$34.00", 16, redColor, 1,
                                                  fontWeight: FontWeight.w400,
                                                  decoration: TextDecoration
                                                      .lineThrough)
                                              .marginOnly(left: 5.w),
                                          12.h.horizontalSpace,
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 4.h, horizontal: 6.h),
                                            decoration: getButtonDecoration(
                                              getAccentColor(context),
                                              withCorners: true,
                                              corner: 4.h,
                                            ),
                                            child: getCustomFont(
                                                "Sale", 12, Colors.white, 1,
                                                fontWeight: FontWeight.w600,
                                                textAlign: TextAlign.center),
                                          )
                                        ],
                                      )),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      buildRectangleIconButton(
                                              context,
                                              "minus.svg",
                                              () {},
                                              getFontGreyColor(context))
                                          .marginAll(2.h),
                                      getCustomFont(
                                              "1", 18, getFontColor(context), 1,
                                              fontWeight: FontWeight.w900)
                                          .marginSymmetric(horizontal: 16.w),
                                      buildRectangleIconButton(
                                              context,
                                              "add.svg",
                                              () {},
                                              getAccentColor(context))
                                          .marginAll(2.h),
                                    ],
                                  ),
                                ],
                              ),
                              getVerSpace(10.h),
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.zero,
                                itemBuilder: (context, index1) {
                                  // if (itemAttributs.name ==
                                  //     Constant.colorVariation) {
                                  //   return Container(
                                  //     height: 50.h,
                                  //     color: Colors.grey,
                                  //     margin:
                                  //     EdgeInsets.symmetric(
                                  //         horizontal:
                                  //         horSpace),
                                  //   );
                                  // }

                                  return Container(
                                    height: 50.h,
                                    margin:
                                        EdgeInsets.symmetric(vertical: 30.h),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 18.h),
                                    decoration: getButtonDecoration(
                                        getCardColor(context),
                                        withBorder: true,
                                        borderColor: black20,
                                        withCorners: true,
                                        corner: 12.h),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                            child: getCustomFont("Select Color",
                                                16, "#7B7681".toColor(), 1,
                                                fontWeight: FontWeight.w400)),
                                        DropdownButton<String>(
                                          onChanged: (value) {
                                            // selectedAttributes[
                                            // index1] =
                                            //     Attribute(
                                            //         itemAttributs
                                            //             .name,
                                            //         value
                                            //             .toString());
                                            // changeVariationValue();
                                          },
                                          isExpanded: false,
                                          value: list[index1],
                                          // items: [DropdownMenuItem(child: Text("data"))],
                                          items: list
                                              .map((e) =>
                                                  DropdownMenuItem<String>(
                                                    value: e,
                                                    child: getCustomFont(
                                                            e,
                                                            16,
                                                            getFontColor(
                                                                context),
                                                            1,
                                                            fontWeight:
                                                                FontWeight.w400)
                                                        .paddingOnly(
                                                            right: 21.h),
                                                  ))
                                              .toList(),
                                          icon: getSvgImageWithSize(context,
                                              "arrow-down.svg", 20.h, 20.h),
                                          underline: Container(),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                itemCount: 1,
                                shrinkWrap: true,
                              ),
                              Container(
                                height: 50.h,
                                padding: EdgeInsets.symmetric(horizontal: 18.h),
                                decoration: getButtonDecoration(
                                    getCardColor(context),
                                    withBorder: true,
                                    borderColor: black20,
                                    withCorners: true,
                                    corner: 12.h),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                        child: getCustomFont("Select Size", 16,
                                            "#7B7681".toColor(), 1,
                                            fontWeight: FontWeight.w400)),
                                    DropdownButton<String>(
                                      onChanged: (value) {
                                        // selectedAttributes[
                                        // index1] =
                                        //     Attribute(
                                        //         itemAttributs
                                        //             .name,
                                        //         value
                                        //             .toString());
                                        // changeVariationValue();
                                      },
                                      isExpanded: false,
                                      value: list1[0],
                                      // items: [DropdownMenuItem(child: Text("data"))],
                                      items: list1
                                          .map((e) => DropdownMenuItem<String>(
                                                value: e,
                                                child: getCustomFont(e, 16,
                                                    getFontColor(context), 1,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ))
                                          .toList(),
                                      icon: getSvgImageWithSize(context,
                                          "arrow-down.svg", 20.h, 20.h),
                                      underline: Container(),
                                    ),
                                  ],
                                ),
                              ),
                              getVerSpace(30.h),
                            ],
                          ),
                        ),
                        getVerSpace(20.h),

                        Container(
                          color: getCardColor(context),
                          padding: EdgeInsets.all(20.h),
                          child: Column(
                            children: [
                              buildTitleExpanded(
                                  context, "Product Description", true, () {
                                // isDescriptionOpen.value =
                                // !isDescriptionOpen.value;
                              }),
                              getVerSpace(8.h),
                              ReadMoreText(
                                Bidi.stripHtmlIfNeeded(
                                    "Lorem ipsum dolor sit amet, "
                                    "consectetur adipiscing elit, sed do "
                                    "eiusmod tempor incididunt ut labore et "
                                    "dolore magna aliqua "),
                                trimLines: 3,
                                style: buildTextStyle(context,
                                    getFontColor(context), FontWeight.w400, 14,
                                    txtHeight: 1.5),
                                trimMode: TrimMode.Length,
                                trimCollapsedText: 'Read More.',
                                trimExpandedText: "less..",
                                delimiter: " ",
                                lessStyle: buildTextStyle(
                                    context,
                                    getAccentColor(context),
                                    FontWeight.w700,
                                    14,
                                    txtHeight: 1.5),
                                moreStyle: buildTextStyle(
                                    context,
                                    getAccentColor(context),
                                    FontWeight.w700,
                                    14,
                                    txtHeight: 1.5),
                              ),
                            ],
                          ),
                        ),

                        getVerSpace(20.h),

                        Container(
                          color: getCardColor(context),
                          padding: EdgeInsets.symmetric(vertical: horSpace),
                          child: Column(
                            children: [
                              buildViewAllWidget(context, "Related Product",
                                  () {
                                Constant.sendToNext(
                                    context, popularProductScreenRoute);
                              }),
                              20.h.verticalSpace,
                              SizedBox(
                                height: 217.h,
                                width: double.infinity,
                                child: AnimationLimiter(
                                  child: ListView.builder(
                                      primary: false,
                                      // shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        ModelPopularProduct product =
                                            popularProduct1[index];
                                        return AnimationConfiguration
                                            .staggeredList(
                                          position: index,
                                          duration:
                                              const Duration(milliseconds: 400),
                                          child: InkWell(
                                            onTap: () {
                                              Constant.sendToNext(context,
                                                  productDetailScreenRoute);
                                            },
                                            child: SlideAnimation(
                                              horizontalOffset: 50.0,
                                              child: FadeInAnimation(
                                                child: Container(
                                                    decoration:
                                                        getButtonDecoration(
                                                      getCardColor(context),
                                                    ),
                                                    margin: EdgeInsets.only(
                                                      left: (index == 0
                                                          ? margin
                                                          : (margin / 2)),
                                                      right: (index == 1
                                                          ? margin
                                                          : (margin / 2)),
                                                    ),
                                                    width: 177.w,
                                                    height: double.infinity,
                                                    child:
                                                        buildCommonProductView(
                                                            context,
                                                            product.img,
                                                            product.name,
                                                            product.price)),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      scrollDirection: Axis.horizontal,
                                      itemCount: popularProduct1.length),
                                ),
                              )
                            ],
                          ),
                        ),

                        getVerSpace(20.h),

                        getRowButtonFigma(
                            context,
                            getAccentColor(context),
                            true,
                            "1 item",
                            "\$30.00",
                            "View Cart",
                            Colors.white, () {
                          bottomController.changePos(2);
                          Constant.sendToNext(context, homeScreenRoute);
                          // ModelDummySelectedAdd selectedAdd =
                          // ModelDummySelectedAdd(
                          //     "zxc",
                          //     "xvxcv",
                          //     "zcv ",
                          //     "vcv cx",
                          //     "xcv",
                          //     "xcvc",
                          //     "ccbcvb",
                          //     "vcbvb",
                          //     "IN");
                          //
                          // storageController
                          //     .selectedShippingAddress =
                          //     selectedAdd;
                          //
                          // bottomController.changePos(2);
                          //
                          // Constant.sendToNextWithBackResult(
                          //     context, homeScreenRoute, (value) {
                          //   print("inback===true");
                          //   storageController.setCurrentQuantity(
                          //       1,
                          //       isRefresh: false);
                          //   // isPurchaseController.setPurchaseValue(false, isRefresh: false);
                          //   checkAlreadyInCart();
                          // });
                        }, EdgeInsets.symmetric(horizontal: 20.h)),

                        // GetBuilder<AlreadyInCart>(
                        //   init: AlreadyInCart(),
                        //   builder: (controller) {
                        //
                        //     if (controller.alreadyInPurchase.isTrue) {
                        //
                        //
                        //
                        //       return ;
                        //
                        //
                        //
                        //     } else {
                        //       return ObxValue(
                        //               (p0) => getRowButtonFigma(
                        //               context,
                        //               getAccentColor(context),
                        //               true,
                        //               "${storageController.currentQuantity.value.toString()} item",
                        //               Constant.formatStringCurrency(
                        //                   total: totalPrice(),
                        //                   context: context),
                        //               "Add To Cart",
                        //               Colors.white, () async {
                        //             await EasyLoading.show();
                        //             if (selectedProduct.stockStatus ==
                        //                 "instock") {
                        //               cartController
                        //                   .addItemInfo(CartOtherInfo(
                        //                 variationId: (storageController
                        //                     .variationModel.value !=
                        //                     null)
                        //                     ? storageController
                        //                     .variationModel.value!.id
                        //                     : 0,
                        //                 variationList: (storageController
                        //                     .variationModel.value !=
                        //                     null)
                        //                     ? storageController
                        //                     .variationModel
                        //                     .value!
                        //                     .attributes
                        //                     : [],
                        //                 productId: selectedProduct.id,
                        //                 quantity: storageController
                        //                     .currentQuantity.value,
                        //                 type: selectedProduct.type,
                        //                 productName: selectedProduct.name,
                        //                 stockStatus:
                        //                 selectedProduct.stockStatus,
                        //                 productImage:
                        //                 selectedProduct.images[0].src,
                        //                 productPrice: (storageController
                        //                     .variationModel.value !=
                        //                     null)
                        //                     ? (Constant.parseWcPrice(
                        //                     storageController
                        //                         .variationModel
                        //                         .value!
                        //                         .salePrice) <=
                        //                     0)
                        //                     ? Constant.parseWcPrice(
                        //                     storageController
                        //                         .variationModel
                        //                         .value!
                        //                         .regularPrice)
                        //                     : Constant.parseWcPrice(
                        //                     storageController
                        //                         .variationModel
                        //                         .value!
                        //                         .salePrice)
                        //                     : (Constant.parseWcPrice(selectedProduct.salePrice) <=
                        //                     0)
                        //                     ? Constant.parseWcPrice(selectedProduct.regularPrice)
                        //                     : Constant.parseWcPrice(selectedProduct.salePrice),
                        //               ));
                        //             } else {
                        //               showCustomToast(
                        //                   "Product in out of stock");
                        //             }
                        //
                        //             await EasyLoading.dismiss();
                        //             checkAlreadyInCart();
                        //           },
                        //               EdgeInsets.symmetric(
                        //                   horizontal: 20.h)),
                        //           storageController.currentQuantity);
                        //     }
                        //   },
                        // ),

                        // getButtonFigma(context, getAccentColor(context), true, 'Add To Cart', Colors.white, (){}, EdgeInsets.symmetric(horizontal: horSpace,vertical: 20.h))

                        getVerSpace(20.h)
                      ],
                    )
                  ]))
                ],
              )
            ],
          ),
        ),
        onWillPop: () async {
          backClick();
          return false;
        });
  }

  String getTextFromDays(int day) {
    if (day == 0) {
      return "Today";
    } else if (day <= 1) {
      return "$day day ago";
    } else {
      return "$day days ago";
    }
  }

  Row buildRateRow(BuildContext context, double rate) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GFRating(
          onChanged: (rating) {},
          value: rate,
          itemCount: rate.toInt(),
          size: 14.h,
          spacing: 2.w,
          filledIcon: getSvgImageWithSize(context, "star.svg", 14.h, 14.h,
              color: getAccentColor(context)),
        ),
        4.w.horizontalSpace,
        LinearPercentIndicator(
          width: 180.w,
          lineHeight: 6.h,
          percent: rate / 5,
          padding: EdgeInsets.zero,
          linearStrokeCap: LinearStrokeCap.round,
          progressColor: getAccentColor(context),
          backgroundColor: getDividerColor(context),
          barRadius: Radius.circular(10.h),
        )
      ],
    );
  }

  Widget buildTitleExpanded(
      BuildContext context, String title, bool isSelected, Function function) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        getCustomFont(title, 20, getFontColor(context), 1,
            fontWeight: FontWeight.w700),
      ],
    );
  }

  Widget buildRectangleIconButton(
      BuildContext context, String icon, Function function, Color borderColor) {
    return InkWell(
      onTap: () {
        function();
      },
      child: Container(
        width: 36.h,
        height: 36.h,
        decoration: BoxDecoration(
            color: getCardColor(context),
            borderRadius: BorderRadius.all(Radius.circular(6.h)),
            border: Border.all(color: borderColor, width: 1.h)),
        child: Center(
          child: getSvgImageWithSize(context, icon, 22.h, 22.h),
        ),
      ),
    );
  }
}
