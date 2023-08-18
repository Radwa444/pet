import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:pet_shop/app/model_ui/model_order.dart';
import 'package:pet_shop/base/data_file.dart';
import '../app/model_ui/model_cart.dart';
import '../woocommerce/model/cart_item.dart';
import '../woocommerce/model/products.dart';
import 'color_data.dart';
import 'constant.dart';
import 'fetch_pixels.dart';
import 'get/product_data.dart';
import 'get/route_key.dart';

void showCustomToast(String texts) {
  Fluttertoast.showToast(
      msg: texts,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 12.0.sp);
}

Widget buildProfileRowItem(
    BuildContext context, String title, Function function) {
  return InkWell(
    onTap: () {
      function();
    },
    child: Container(
      width: double.infinity,
      height: 64.h,
      decoration: getButtonDecoration(
        getGreyCardColor(context),
        withCorners: true,
        corner: 12.h,
      ),
      margin: EdgeInsets.symmetric(vertical: 6.h),
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: getCustomFont(title, 16, getFontColor(context), 1,
                fontWeight: FontWeight.w600, textAlign: TextAlign.start),
          ),
          getSvgImageWithSize(context, "arrow_right_profile.svg", 16.h, 16.h,
              color: getFontColor(context))
        ],
      ),
    ),
  );
}

Widget getCustomFont(String text, double fontSize, Color fontColor, int maxLine,
    {String fontFamily = Constant.fontsFamily,
    TextOverflow overflow = TextOverflow.ellipsis,
    TextDecoration decoration = TextDecoration.none,
    FontWeight fontWeight = FontWeight.normal,
    TextAlign textAlign = TextAlign.start,
    txtHeight,
    bool horFactor = false}) {
  return Text(
    text,
    overflow: overflow,
    style: TextStyle(
        decoration: decoration,
        fontSize: fontSize.sp,
        fontStyle: FontStyle.normal,
        color: fontColor,
        fontFamily: fontFamily,
        height: txtHeight,
        fontWeight: fontWeight),
    maxLines: maxLine,
    softWrap: true,
    textAlign: textAlign,
    // textScaleFactor: 0.5,
    // textScaleFactor: FetchPixels.getTextScale(horFactor: horFactor),
  );
}

Widget buildDatePickerButton(
    BuildContext context, String title, String image, Function function) {
  return InkWell(
    onTap: () {
      function();
    },
    child: Container(
      width: double.infinity,
      height: getButtonHeightFigma(),
      margin: EdgeInsets.symmetric(
          horizontal: FetchPixels.getDefaultHorSpaceFigma(context)),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: getButtonDecoration(Colors.transparent,
          withCorners: true,
          corner: 20.h,
          withBorder: true,
          borderColor: indicatorColor),
      child: Row(children: [
        Expanded(
          flex: 1,
          child: getCustomFont(title, 16, getFontColor(context), 1,
              fontWeight: FontWeight.w500),
        ),
        getSvgImageWithSize(context, image, 18.h, 18.h,
            color: getFontColor(context), fit: BoxFit.fill)
      ]),
    ),
  );
}

Widget getCustomFontHor(BuildContext context, String text, double fontSize,
    Color fontColor, int maxLine,
    {String fontFamily = Constant.fontsFamily,
    TextOverflow overflow = TextOverflow.ellipsis,
    TextDecoration decoration = TextDecoration.none,
    FontWeight fontWeight = FontWeight.normal,
    TextAlign textAlign = TextAlign.start,
    txtHeight,
    bool horFactor = false}) {
  double width = context.width;
  double height = context.height;

  double textScaleFactor = (width > height)
      ? width / Constant.defScreenWidth
      : height / Constant.defScreenHeight;
//     if (DeviceUtil.isTablet && !horFactor) {
//       textScaleFactor = height / mockupHeight;
//     }
  return Text(
    text,
    overflow: overflow,
    style: TextStyle(
        decoration: decoration,
        fontSize: fontSize.sp,
        fontStyle: FontStyle.normal,
        color: fontColor,
        fontFamily: fontFamily,
        height: txtHeight,
        fontWeight: fontWeight),
    maxLines: maxLine,
    softWrap: true,
    textAlign: textAlign,
    textScaleFactor: textScaleFactor,
    // textScaleFactor: 0.5,
    // textScaleFactor: FetchPixels.getTextScale(horFactor: horFactor),
  );
}

TextStyle buildTextStyle(BuildContext context, Color fontColor,
    FontWeight fontWeight, double fontSize,
    {double txtHeight = 1}) {
  return TextStyle(
      color: fontColor,
      fontWeight: fontWeight,
      fontFamily: Constant.fontsFamily,
      fontSize: fontSize.sp,
      height: txtHeight);
}

DecorationImage getDecorationAssetImage(BuildContext buildContext, String image,
    {BoxFit fit = BoxFit.contain}) {
  // var darkThemeProvider = Provider.of<DarkMode>(buildContext);

  return DecorationImage(
    // image: AssetImage(((darkThemeProvider.darkMode &&
    //             darkThemeProvider.assetList.contains(image))
    //         ? Constant.assetImagePathNight
    //         : Constant.assetImagePath) +
    //     image),
    image: AssetImage(Constant.assetImagePath + image),
    fit: fit,
    // scale: FetchPixels.getScale()
  );
}

DecorationImage getDecorationNetworkImage(
    BuildContext buildContext, String image,
    {BoxFit fit = BoxFit.contain}) {
  // var darkThemeProvider = Provider.of<DarkMode>(buildContext);

  return DecorationImage(
    // image: AssetImage(((darkThemeProvider.darkMode &&
    //             darkThemeProvider.assetList.contains(image))
    //         ? Constant.assetImagePathNight
    //         : Constant.assetImagePath) +
    //     image),
    image: NetworkImage(image),
    fit: fit,
    // scale: FetchPixels.getScale()
  );
}

Widget getCloseButton(BuildContext context, Function function) {
  return InkWell(
    onTap: () {
      function();
    },
    child: getSvgImageWithSize(context, "Close.svg", 24.h, 24.h),
  );
}

Widget getMultilineCustomFont(String text, double fontSize, Color fontColor,
    {String fontFamily = Constant.fontsFamily,
    TextOverflow overflow = TextOverflow.ellipsis,
    TextDecoration decoration = TextDecoration.none,
    FontWeight fontWeight = FontWeight.normal,
    TextAlign textAlign = TextAlign.start,
    txtHeight = 1.5}) {
  return Text(
    text,
    style: TextStyle(
        decoration: decoration,
        fontSize: fontSize.sp,
        fontStyle: FontStyle.normal,
        color: fontColor,
        fontFamily: Constant.fontsFamily,
        height: txtHeight,
        fontWeight: fontWeight),
    textAlign: textAlign,
    // textScaleFactor: FetchPixels.getTextScale(),
  );
}

double getButtonHeightFigma() {
  return 60.h;
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

Widget getButtonContainer(
    BuildContext context, IconData iconData, Function function,
    {double size = 40, double iconSize = 24}) {
  return InkWell(
    onTap: () {
      function();
    },
    child: Container(
      width: size.h,
      decoration:
          BoxDecoration(color: "#FFF3F3".toColor(), shape: BoxShape.circle),
      height: size.h,
      child: Center(
        child: Icon(iconData, size: iconSize.h, color: getAccentColor(context)),
      ),
    ),
  );
}

Widget getEmptyWidget(BuildContext context, String image, String title,
    String description, String btnTxt, Function function,
    {bool withButton = true}) {
  double imgSize = 140.h;
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      getSvgImageWithSize(context, image, imgSize, imgSize),
      getVerSpace(30.h),
      getCustomFont(title, 22, getFontColor(context), 1,
          fontWeight: FontWeight.w700, textAlign: TextAlign.center),
      getVerSpace(5.h),
      getMultilineCustomFont(description, 16, getFontColor(context),
          fontWeight: FontWeight.w400, textAlign: TextAlign.center),
      (withButton)
          ? InkWell(
              onTap: () {
                function();
              },
              child: Container(
                  margin: EdgeInsets.only(top: 40.h),
                  width: 192.h,
                  height: 60.h,
                  decoration: getButtonDecoration(Colors.transparent,
                      withCorners: true,
                      withBorder: true,
                      borderColor: getAccentColor(context),
                      corner: 14.h),
                  child: Center(
                      child: getMultilineCustomFont(
                          btnTxt, 16, getAccentColor(context),
                          fontWeight: FontWeight.w600,
                          textAlign: TextAlign.center))))
          : getHorSpace(0)
    ],
  );
}

double getEditHeightFigma() {
  return 56.h;
}

double getEditFontSizeFigma() {
  return 16;
}

double getEditRadiusSize() {
  return 35.h;
}

double getEditRadiusSizeFigma() {
  return 12.h;
}

double getEditIconSize() {
  return 24;
}

double getButtonCorners() {
  return 35.h;
}

double getButtonCornersFigma() {
  return 12.h;
}

//
// Widget getToolbarWidget(BuildContext context, String title, Function backClick,
//     {bool settingVisible = false,
//       Function? settingFun,
//       Color color = Colors.transparent,
//       String setText = "",
//       bool withBack = true,
//       String setIcon = "translate.svg",
//       DarkMode? darkThemeProvider,ValueChanged<String?>? changed}) {
//   return Container(
//     padding: EdgeInsets.symmetric(
//         horizontal: FetchPixels.getDefaultHorSpaceFigma(context),
//         vertical:20.h),
//     color: color,
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         (withBack)
//             ? getToolbarIcons(context, "arrow_back.svg", () {
//           backClick();
//         })
//             : getHorSpace(0),
//         (withBack)
//             ? getHorSpace(FetchPixels.getPixelWidth(20))
//             : getHorSpace(0),
//         Expanded(
//           child: getHeaderTitle(context, title),
//           flex: 1,
//         ),
//         (settingVisible && setIcon == "translate.svg")
//             ? getLangButton(context, darkThemeProvider!,changed!,)
//             : (settingVisible
//             ? getToolbarIcons(
//           context,
//           setIcon,
//               () {
//             settingFun!();
//           },
//         )
//             : getHorSpace(0))
//         // Visibility(
//         //     visible: settingVisible,
//         //     child:(setIcon=="translate.svg")?getLangButton(context, darkThemeProvider):
//         //    )
//       ],
//     ),
//   );
// }
Widget getToolbarIcons(BuildContext context, String name, Function click,
    {bool withTheme = true, Color? color}) {
  return InkWell(
    child: getSvgImageWithSize(context, name, 24.h, 24.h,
        color: (color == null) ? getFontColor(context) : color),
    onTap: () {
      click();
    },
  );
}

double getButtonFontSizeFigma() {
  return 18;
}

ShapeDecoration getButtonDecoration(Color bgColor,
    {withBorder = false,
    Color borderColor = Colors.transparent,
    bool withCorners = true,
    double corner = 0,
    double cornerSmoothing = 1.1,
    List<BoxShadow> shadow = const []}) {
  return ShapeDecoration(
      color: bgColor,
      shadows: shadow,
      shape: SmoothRectangleBorder(
          side: BorderSide(
            width: 1,
            color: (withBorder) ? borderColor : Colors.transparent,
          ),
          borderRadius: SmoothBorderRadius(
              cornerRadius: (withCorners) ? corner : 0,
              cornerSmoothing: (withCorners) ? cornerSmoothing : 0)));
}

ShapeDecoration getButtonDecorationWithGradient(Color bgColor,
    {withBorder = false,
    Color borderColor = Colors.transparent,
    bool withCorners = true,
    double corner = 0,
    double cornerSmoothing = 1.1,
    List<BoxShadow> shadow = const []}) {
  return ShapeDecoration(
      shadows: shadow,
      gradient: getGradients(),
      shape: SmoothRectangleBorder(
          side: BorderSide(
              width: 1, color: (withBorder) ? borderColor : Colors.transparent),
          borderRadius: SmoothBorderRadius(
              cornerRadius: (withCorners) ? corner : 0,
              cornerSmoothing: (withCorners) ? cornerSmoothing : 0)));
}

getGradients() {
  return LinearGradient(colors: [
    "#FF8080".toColor(),
    "#F44144".toColor(),
  ], begin: Alignment.topCenter, end: Alignment.bottomCenter);
}

Widget getCenterTitleHeader(BuildContext context, String title,
    EdgeInsets edgeInsets, Function backClick,
    {bool visibleMore = false,
    String moreImg = "More.svg",
    Function? moreFunc}) {
  return getPaddingWidget(
      edgeInsets,
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          getBackIcon(context, () {
            backClick();
          }),
          Expanded(
            flex: 1,
            child: getCustomFont(title, 22, getFontColor(context), 1,
                textAlign: TextAlign.center, fontWeight: FontWeight.w600),
          ),
          Visibility(
            visible: visibleMore,
            maintainAnimation: true,
            maintainState: true,
            maintainSize: true,
            child: getBackIcon(context, () {
              moreFunc!();
            }, icon: moreImg),
          )
        ],
      ));
}

Widget buildProfilePhotoWidget(BuildContext context,
    {Function? function, String icons = "ic_edit.svg"}) {
  return Center(
    child: SizedBox(
      width: 102.h,
      height: 100.h,
      child: Stack(
        children: [
          getCircleImage(context, "profile.png", double.infinity),
          Align(
            alignment: Alignment.bottomRight,
            child: InkWell(
              onTap: () {
                if (function != null) {
                  function();
                }
              },
              child: Container(
                width: 30.h,
                height: 30.h,
                decoration:
                    const BoxDecoration(shape: BoxShape.circle, boxShadow: [
                  BoxShadow(
                      color: Color.fromRGBO(61, 61, 61, 0.11999999731779099),
                      offset: Offset(-4, 8),
                      blurRadius: 25)
                ]),
                child: getSvgImageWithSize(
                    context, icons, double.infinity, double.infinity),
              ),
            ),
          )
        ],
      ),
    ),
  );
}

Widget getToolbarWidget(BuildContext context, String title, Function fun,
    {bool isShowBack = true}) {
  SmoothRadius smoothRadius =
      SmoothRadius(cornerRadius: 90.h, cornerSmoothing: 0);
  return Container(
    width: double.infinity,
    height: 132.h,
    padding: EdgeInsets.only(
        left: FetchPixels.getDefaultHorSpaceFigma(context),
        right: FetchPixels.getDefaultHorSpaceFigma(context),
        bottom: 30.h),
    decoration: ShapeDecoration(
        color: getAccentColor(context),
        shape: SmoothRectangleBorder(
            borderRadius: SmoothBorderRadius.only(bottomRight: smoothRadius))),
    child: Stack(
      children: [
        (isShowBack)
            ? Align(
                alignment: Alignment.bottomLeft,
                child: getBackIcon(context, () {
                  fun();
                }, colors: Colors.black),
              )
            : getHorSpace(0),
        Align(
          alignment: Alignment.bottomCenter,
          child: getCustomFont(title, 22, getFontColor(context), 1,
              fontWeight: FontWeight.w700),
        ),
      ],
    ),
  );
}

Widget getDetailWidget(BuildContext context, Function backClick, String title,
    Widget childWidget) {
  double topView = 291.h;
  double radius = topView / 2;
  SmoothRadius smoothRadius =
      SmoothRadius(cornerRadius: radius, cornerSmoothing: 0.6);

  return WillPopScope(
      child: Scaffold(
        backgroundColor: getCurrentTheme(context).scaffoldBackgroundColor,
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: topView,
                decoration: ShapeDecoration(
                    color: getAccentColor(context),
                    shape: SmoothRectangleBorder(
                        borderRadius: SmoothBorderRadius.only(
                            bottomRight: smoothRadius))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 109.h,
                      height: 109.h,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              getCurrentTheme(context).scaffoldBackgroundColor),
                      child: Center(
                        child: getSvgImageWithSize(
                            context, "Logo.svg", 53.h, 60.h,
                            fit: BoxFit.fill),
                      ),
                    ),
                    getVerSpace(20.h),
                    getCustomFont(title, 28, getFontColor(context), 1,
                        fontWeight: FontWeight.w700)
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: childWidget,
              )
            ],
          ),
        ),
      ),
      onWillPop: () async {
        backClick();
        return false;
      });
}

Widget getDefaultUnderlineTextFiled(
    BuildContext context,
    String s,
    TextEditingController textEditingController,
    Color fontColor,
    ValueChanged<String> changed,
    {bool withPrefix = false,
    String imgName = "",
    bool minLines = false,
    bool isFilled = false,
    bool withFilter = false,
    bool readOnly = false,
    Function? filterClick,
    Function? editTap,
    EdgeInsetsGeometry margin = EdgeInsets.zero,
    bool withPadding = true}) {
  double height = 56.h;
  return SizedBox(
    height: height,
    width: double.infinity,
    child: TextField(
      onTap: () {
        if (editTap != null) {
          editTap();
        }
      },
      maxLines: (minLines) ? null : 1,
      controller: textEditingController,
      autofocus: false,
      textAlign: TextAlign.start,
      expands: minLines,
      style: buildTextStyle(context, black40, FontWeight.w400, 16),
      onChanged: changed,
      readOnly: readOnly,
      decoration: InputDecoration(
        // prefixIcon: (withPrefix)
        //     ? getSvgImageWithSize(context, imgName, getEditIconSize().h,
        //             getEditIconSize().h)
        //         .marginOnly(left: 20.w, right: 16.w)
        //     : 0.horizontalSpace,
        // prefixIconConstraints: BoxConstraints(
        //   minWidth: 20.w,
        //   minHeight: 0,
        //   maxWidth: getEditIconSize().h + (20.w + 16.w),
        //   maxHeight: getEditIconSize().h,
        // ),
        suffixIconConstraints: BoxConstraints(
          minWidth: 20.w,
          minHeight: 0,
          maxWidth: getEditIconSize().h + (20.w + 16.w),
          maxHeight: getEditIconSize().h,
        ),
        contentPadding: EdgeInsets.zero,
        filled: isFilled,
        fillColor: getCardColor(context),
        suffixIcon: (withFilter)
            ? InkWell(
                onTap: () {
                  if (filterClick != null) {
                    filterClick();
                  }
                },
                child: getSvgImageWithSize(context, "filter.svg",
                        getEditIconSize().h, getEditIconSize().h)
                    .marginOnly(right: 20.w, left: 16.w),
              )
            : 0.horizontalSpace,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: (isFilled) ? Colors.transparent : getFontHint(context),
              width: 2.h),
        ),
        disabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: (isFilled) ? Colors.transparent : getFontHint(context),
              width: 2.h),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: (isFilled) ? Colors.transparent : getFontHint(context),
              width: 2.h),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(
              color: (isFilled) ? Colors.transparent : getFontHint(context),
              width: 2.h),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: (isFilled) ? Colors.transparent : getAccentColor(context),
              width: 2.h),
        ),

        labelText: s,
        labelStyle:
            buildTextStyle(context, getFontColor(context), FontWeight.w600, 15),
      ),
    ).marginSymmetric(
        horizontal:
            (withPadding) ? FetchPixels.getDefaultHorSpaceFigma(context) : 0),
  );
}

Widget getCircleImageProfile(BuildContext context, String imgName, double size,
    {bool fileImage = false}) {
  if (fileImage) {
    return SizedBox(
      width: size,
      height: size,
      child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(size / 2)),
          // child: material.Image.file(file),
          child: (fileImage)
              ? material.Image.file(File(imgName))
              : getNetworkImage(
                  context, imgName, double.infinity, double.infinity)
          // getAssetImage(context, imgName, double.infinity, double.infinity),
          ),
    );
  } else {
    return getCircleProfileImage(context, imgName, size);
  }
}

Widget getCircleImage(BuildContext context, String imgName, double size) {
  return SizedBox(
    width: size,
    height: size,
    child: ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(size / 2)),
      child: getAssetImage(context, imgName, double.infinity, double.infinity),
    ),
  );
}

Widget buildCommonMyOrderScreen(
    BuildContext context, double margin, Function backClick,
    {bool isBackAvailable = false, Function? refresh}) {
  // ProductDataController productController = Get.find<ProductDataController>();
  List<ModelOrder> orderList = DataFile.getAllOrderList();

  return GetBuilder<ProductDataController>(
    builder: (productController) {
      return Column(
        children: [
          getDefaultHeader(context, "My Order", () {
            Constant.backToPrev(context);
          }, isShowSearch: false),
          getVerSpace(20.h),
          Expanded(
            flex: 1,
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Builder(
                builder: (context) {
                  if (orderList.isNotEmpty) {
                    return Container(
                      // padding: EdgeInsets.all(20.h),
                      // color: getCardColor(context),
                      child: ListView.separated(
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          ModelOrder order = orderList[index];
                          return Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: margin, vertical: margin),
                            color: getCardColor(context),
                            child: InkWell(
                              onTap: () {
                                Constant.sendToNext(
                                    context, trackOrderScreenRoute);
                              },
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  getCustomFont("Order ID: ${order.orderId}",
                                      16, getFontColor(context), 1,
                                      fontWeight: FontWeight.w600),
                                  6.h.verticalSpace,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: getCustomFont(
                                            "Item(${order.item})",
                                            16,
                                            getFontColor(context),
                                            1,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      getCustomFont("Total Amount:", 16,
                                          getFontColor(context), 1,
                                          fontWeight: FontWeight.w400),
                                      getCustomFont(order.amount, 16,
                                          getFontColor(context), 1,
                                          fontWeight: FontWeight.w600)
                                    ],
                                  ),
                                  10.h.verticalSpace,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: getCustomFont(order.date, 14,
                                            getFontColor(context), 1,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      getCustomFont(
                                          order.status,
                                          16,
                                          Constant.getOrderStatusColor(
                                              order.status),
                                          1,
                                          fontWeight: FontWeight.w500),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        shrinkWrap: true,
                        itemCount: orderList.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return Container(
                            color: getCardColor(context),
                            child: getDivider(setColor: Colors.grey.shade300)
                                .marginSymmetric(horizontal: margin),
                          );
                        },
                      ),
                    );
                  } else {
                    return getEmptyWidget(
                        context,
                        "no_order.png",
                        "No Order Yet!",
                        "Explore more and shortlist some products.",
                        "Add",
                        () {});
                  }
                },
              ),
            ),
          ),
        ],
      );
    },
    init: ProductDataController(),
  );
}

Widget buildRowWidget(
    BuildContext context, String svgImg, String title, Function function) {
  return InkWell(
    onTap: () {
      function();
    },
    child: Row(
      children: [
        getSvgImageWithSize(context, svgImg, 24.h, 24.h,
            fit: BoxFit.fill, color: getAccentColor(context)),
        12.h.horizontalSpace,
        Expanded(
          flex: 1,
          child: getCustomFont(title, 16, getFontColor(context), 1,
              fontWeight: FontWeight.w400),
        ),
        getSvgImageWithSize(context, "arrow-right.svg", 16.h, 16.h,
            fit: BoxFit.fill)
      ],
    ),
  );
}

Widget getDividerWidget() {
  return getDivider(setColor: Colors.grey.shade300)
      .marginSymmetric(vertical: 20.h);
}

Widget getCircleProfileImage(
    BuildContext context, String profileName, double size) {
  return SizedBox(
    width: size,
    height: size,
    child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(size / 2)),
        child: Container(
          color: getAccentColor(context),
          child: (profileName.isNotEmpty)
              ? Center(
                  child: getCustomFont(profileName, 36, Colors.white, 1,
                      fontWeight: FontWeight.w700))
              : getAssetImage(context, "dummy_profile.png", double.infinity,
                  double.infinity),
        )),
  );
}

Widget getSvgImage(BuildContext context, String image, double size,
    {Color? color, BoxFit boxFit = BoxFit.fill}) {
  // var darkThemeProvider = Provider.of<DarkMode>(context);

  return SvgPicture.asset(
    // ((darkThemeProvider.darkMode && darkThemeProvider.assetList.contains(image))
    //         ? Constant.assetImagePathNight
    //         : Constant.assetImagePath) +
    Constant.assetImagePath + image,
    color: color,
    width: size.h,
    height: size.h,
    fit: boxFit,
  );
}

Widget getTopViewHeader(BuildContext context, String titleMain, String titleSub,
    {bool visibleSub = true}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      getVerSpace(80.h),
      getHeaderTitle(context, titleMain),
      (!visibleSub) ? getVerSpace(0) : getVerSpace(30.h),
      (!visibleSub) ? getVerSpace(0) : getSubHeaderTitle(context, titleSub),
      getVerSpace(60.h),
    ],
  );
}

Widget getHeaderTitle(BuildContext context, String str) {
  return getCustomFont(str, 55, getFontColor(context), 1,
      fontWeight: FontWeight.w900, textAlign: TextAlign.start);
}

Widget getHeaderTitleCustom(BuildContext context, String str) {
  return getCustomFont(str, 28, getFontColor(context), 1,
      fontWeight: FontWeight.w700,
      textAlign: TextAlign.start,
      horFactor: false);
}

Widget getSubHeaderTitle(BuildContext context, String title) {
  return getCustomFont(title, 40, getFontColor(context), 2,
      fontWeight: FontWeight.w400);
}

Widget getRichText(
    String firstText,
    Color firstColor,
    FontWeight firstWeight,
    double firstSize,
    String secondText,
    Color secondColor,
    FontWeight secondWeight,
    double secondSize,
    {TextAlign textAlign = TextAlign.center,
    double? txtHeight,
    Function? function}) {
  return RichText(
    textAlign: textAlign,
    text: TextSpan(
        text: firstText,
        style: TextStyle(
          color: firstColor,
          fontWeight: firstWeight,
          fontFamily: Constant.fontsFamily,
          fontSize: firstSize,
          height: txtHeight,
        ),
        children: [
          TextSpan(
            text: secondText,
            style: TextStyle(
                color: secondColor,
                fontWeight: secondWeight,
                fontFamily: Constant.fontsFamily,
                fontSize: secondSize,
                height: txtHeight),
            // recognizer: TapGestureRecognizer()
            //   ..onTap = () {
            //     function!();
            //   }
          ),
        ]),
  );
}

Widget getSvgImageWithSize(
    BuildContext context, String image, double width, double height,
    {Color? color, BoxFit fit = BoxFit.fill, bool listen = true}) {
  // var darkThemeProvider = Provider.of<DarkMode>(context, listen: listen);
  return SvgPicture.asset(
    // ((darkThemeProvider.darkMode && darkThemeProvider.assetList.contains(image))
    //         ? Constant.assetImagePathNight
    //         : Constant.assetImagePath) +
    Constant.assetImagePath + image,
    color: color,
    width: width,
    height: height,
    fit: fit,
  );
}

Widget getProfileTopView(
  BuildContext context,
  Function backClick,
  String title, {
  bool visibleMore = false,
  Function? moreFunc,
  bool visibleEdit = false,
  Function? funcEdit,
}) {
  double horSpace = FetchPixels.getDefaultHorSpaceFigma(context);
  return SizedBox(
    height: (223 + 9).h,
    child: Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: 201.h,
          child: getSvgImage(
            context,
            "profile_rect.svg",
            double.infinity,
          ),
        ),
        getCenterTitleHeader(
            context,
            title,
            EdgeInsets.only(
                left: horSpace,
                right: horSpace,
                top: Constant.getToolbarTopHeight(context) + 10.h), () {
          backClick();
        }, visibleMore: visibleMore, moreFunc: moreFunc),
        Padding(
          padding: EdgeInsets.only(left: horSpace),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: SizedBox(
              width: 120.h,
              height: 120.h,
              child: Stack(
                children: [
                  getCircleImage(
                      context, "profile_Setting.png", double.infinity),
                  Visibility(
                    visible: visibleEdit,
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: InkWell(
                        onTap: () {
                          funcEdit!();
                        },
                        child: getSvgImageWithSize(
                            context, "edit_icon.svg", 36.h, 36.h),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    ),
  );
}

Widget getBackIcon(BuildContext context, Function function,
    {String icon = "arrow_back.svg", Color? colors}) {
  return InkWell(
      onTap: () {
        function();
      },
      child: Icon(
        Icons.arrow_back_ios_new_rounded,
        size: 24.h,
        color: colors,
      ));
  // child: getSvgImageWithSize(context, icon, 24.h, 24.h, color: colors));
}

Widget getAssetImage(
    BuildContext context, String image, double width, double height,
    {Color? color, BoxFit boxFit = BoxFit.contain, bool listen = true}) {
  // var darkThemeProvider = Provider.of<DarkMode>(context, listen: listen);
  return material.Image.asset(
    // ((darkThemeProvider.darkMode && darkThemeProvider.assetList.contains(image))
    //         ? Constant.assetImagePathNight
    //         : Constant.assetImagePath) +
    Constant.assetImagePath + image,
    color: color,
    width: width,
    height: height,
    fit: boxFit,
    // scale: FetchPixels.getScale(),
  );
}

Widget buildFavButton(BuildContext context,
    {bool isFav = false, Color color = Colors.grey}) {
  return Container(
    width: 26.w,
    height: 26.w,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: getGreyCardColor(context),
    ),
    child: Center(
      child: getSvgImageWithSize(
          context, (isFav) ? "heart_selected.svg" : "heart.svg", 16.w, 16.w,
          fit: BoxFit.scaleDown,
          color: (isFav) ? getAccentColor(context) : null),
      // fit: BoxFit.scaleDown, color: Colors.black),
    ),
  );
}

Widget buildShareButton(BuildContext context) {
  return Container(
    width: 30.w,
    height: 30.w,
    decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: getCardColor(context),
        boxShadow: const [
          BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.11999999731779099),
              offset: Offset(0, 6),
              blurRadius: 23)
        ]),
    child: Center(
      child: getSvgImageWithSize(context, "share.svg", 16.w, 16.w,
          fit: BoxFit.scaleDown, color: Colors.black),
    ),
  );
}

Widget getNetworkImage(
    BuildContext context, String image, double width, double height,
    {Color? color,
    BoxFit boxFit = BoxFit.scaleDown,
    bool listen = true,
    double sizePlaceHolder = 50,
    EdgeInsets edgeInset = EdgeInsets.zero}) {
  // var darkThemeProvider = Provider.of<DarkMode>(context, listen: listen);
  // print("geterr---load--$image");
  // String img=image.replaceAll("https:", "http:");
  print("imgsize===$width---$height");
  return Center(
    child: CachedNetworkImage(
      placeholder: (context, url) {
        return Shimmer.fromColors(
            baseColor: Colors.grey.shade100,
            highlightColor: Colors.grey.shade200,
            child: Container(
              margin: edgeInset,
              color: Colors.white,
            ));

        //   SizedBox(
        //   width: width,
        //   height:height,
        //   // child: Shimmer.fromColors(
        //   //   loop: 5,
        //   //   direction: ShimmerDirection.ltr,
        //   //   baseColor: Colors.black,
        //   //   // baseColor: Colors.grey.shade900,
        //   //   highlightColor: Colors.red,
        //   //   period: Duration(seconds: 1),
        //   //   // highlightColor: Colors.grey.shade500,
        //   //   enabled: true,
        //   //   child: Container(
        //   //     width:width,
        //   //     height: height,
        //   //   ),
        //   // ),
        //   child: Container(
        //     width: width,height: height,
        //       color: Colors.green,
        //       child: ShimmerLoading(isLoading: true, child: SizedBox(width: width,height: height,))),
        // );
        // return Image.asset("assets/images/loading.gif");
      },
      // fadeOutDuration: const Duration(seconds: 1),
      // fadeInDuration: const Duration(seconds: 1),
      placeholderFadeInDuration: Duration.zero,
      imageUrl: image,
      cacheKey: image,
      useOldImageOnUrlChange: false,
      height: height,
      width: width,
      fit: boxFit,
    ),
  );
  // return FadeInImage(
  //
  //     imageErrorBuilder: (context, error, stackTrace) {
  //       return Image.asset("assets/images/loading.gif");
  //     },
  //     // key: ValueKey(image),
  //     placeholder: AssetImage("assets/images/loading.gif"),
  //     // placeholder: "assets/images/loading.gif",
  //     // placeholderCacheHeight:sizePlaceHolder.h.toInt(),
  //     // placeholderCacheWidth: sizePlaceHolder.h.toInt(),
  //     image: CachedNetworkImage.(),
  // // image: NetworkImage(image),
  // height: height,
  // width: width,
  // fit: boxFit
  // ,
  // );
  // // return Image.network(
  // //   "https://photo.tuchong.com/4870004/f/298584322.jpg",
  // //   // image,
  // //   loadingBuilder: (context, child, loadingProgress) {
  // //     if (loadingProgress == null) {
  // //       return child;
  // //     }
  // //     return getProgressDialog();
  // //   },
  // //   errorBuilder: (context, error, stackTrace) {
  // //     print("geterr---${error.toString()}");
  // //     return 0.verticalSpace;
  // //     // return 0.verticalSpace;
  // //   },
  // //   color: color,
  // //   width: width,
  // //   height: height,
  // //   fit: boxFit,
  // //   // scale: FetchPixels.getScale(),
  // // );
}

Widget getDialogDividerBottom(BuildContext context) {
  return Container(
    width: 134.w,
    decoration: getButtonDecoration(getFontColor(context),
        withCorners: true, withBorder: false, corner: 5.h),
    height: 5.h,
  );
}

Widget getDialogDividerTop(BuildContext context) {
  return Container(
    width: 48.w,
    decoration: getButtonDecoration(getCardColor(context),
        withCorners: true, withBorder: false, corner: 4.h),
    height: 4.h,
  );
}

Widget getTextFieldView(BuildContext context, Widget widget, bool minLines,
    EdgeInsetsGeometry margin) {
  double height = getEditHeightFigma();
  return Container(
    height: (minLines) ? (height * 2.2) : height,
    margin: margin,
    padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 0),
    alignment: (minLines) ? Alignment.topLeft : Alignment.centerLeft,
    decoration: ShapeDecoration(
      color: Colors.transparent,
      shape: SmoothRectangleBorder(
        side: BorderSide(
            color: getCurrentTheme(context).unselectedWidgetColor, width: 1),
        borderRadius: SmoothBorderRadius(
          cornerRadius: getEditRadiusSize(),
          cornerSmoothing: 0.8,
        ),
      ),
    ),
    child: widget,
  );
}

Widget getTextFieldViewCustom(BuildContext context, Widget widget,
    bool minLines, EdgeInsetsGeometry margin) {
  double height = getEditHeightFigma();
  return Container(
    height: (minLines) ? (height * 2.2) : height,
    margin: margin,
    padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 0),
    alignment: (minLines) ? Alignment.topLeft : Alignment.centerLeft,
    decoration: ShapeDecoration(
      color: Colors.transparent,
      shape: SmoothRectangleBorder(
        side: BorderSide(
            color: getCurrentTheme(context).unselectedWidgetColor, width: 1),
        borderRadius: SmoothBorderRadius(
          cornerRadius: getEditRadiusSizeFigma(),
          cornerSmoothing: 0.8,
        ),
      ),
    ),
    child: widget,
  );
}

buildTitleListItem(BuildContext context, String title, String description) {
  return Column(
    children: [
      getCustomFont(title, 28, getFontColor(context), 1,
          fontWeight: FontWeight.w700),
      6.h.verticalSpace,
      getCustomFont(description, 16, getFontGreyColor(context), 2,
          fontWeight: FontWeight.w400, textAlign: TextAlign.center),
      40.h.verticalSpace
    ],
  );
}

Widget getScreenDetailDefaultView(
    BuildContext context, String title, Function backClick, Widget childView,
    {bool centerTitle = true}) {
  return WillPopScope(
      child: Scaffold(
        backgroundColor: getAccentColor(context),
        appBar: getBackAppBar(context, () {
          backClick();
        }, title: title, iconColor: Colors.white, centerTitle: centerTitle),
        body: getDefaultContainerView(context, childView,
            padding: EdgeInsets.only(top: 30.h)),
      ),
      onWillPop: () async {
        backClick();
        return false;
      });
}

// Widget getTabDetailDefaultView(
//     BuildContext context, String title, Function backClick, Widget childView,
//     {bool centerTitle = true}) {
//   return Column(
//     children: [
//       getBackAppBar(context, () {
//         backClick();
//       }, title: title, iconColor: Colors.white, centerTitle: centerTitle),
//       Expanded(
//         flex: 1,
//         child: getDefaultContainerView(
//             context, childView.paddingOnly(bottom: 104.h)),
//       )
//     ],
//   );
// }

Widget itemSlotBooking(int index, BuildContext context, bool isSelected,
    String title, double width) {
  return Container(
    width: width,
    height: 33.w,
    decoration: getButtonDecoration(
        (isSelected) ? lightAccentColor : Colors.transparent,
        withBorder: true,
        borderColor: (isSelected) ? getAccentColor(context) : indicatorColor,
        withCorners: true,
        corner: 16.w),
    child: Center(
        child: getCustomFont(title, 14,
            (isSelected) ? getAccentColor(context) : getFontHint(context), 1,
            fontWeight: (isSelected) ? FontWeight.w700 : FontWeight.w400)),
  );
}

Widget buildItemNearestSalonDetail(BuildContext context, Function function) {
  return InkWell(
    onTap: () {},
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
      width: double.infinity,
      height: 161.h,
      decoration: getButtonDecoration(getCardColor(context),
          withCorners: true,
          corner: 20.h,
          shadow: [
            const BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.07999999821186066),
                offset: Offset(-4, 5),
                blurRadius: 16)
          ]),
      margin: EdgeInsets.symmetric(
          horizontal: FetchPixels.getDefaultHorSpaceFigma(context),
          vertical: 10.h),
      child: Row(
        children: [
          SizedBox(
            width: 165.h,
            height: double.infinity,
            child: Stack(
              children: [
                getCircularImage(context, double.infinity, double.infinity,
                    20.h, "salon3.png",
                    boxFit: BoxFit.cover),
                Align(
                  alignment: Alignment.topLeft,
                  child: buildFavouriteBtn(EdgeInsets.all(10.h)),
                )
              ],
            ),
          ),
          12.w.horizontalSpace,
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getCustomFont(
                    "Octopas barbershop", 16, getFontColor(context), 1,
                    fontWeight: FontWeight.w700),
                10.h.verticalSpace,
                buildLocationRow(context, "4140 Parker Rd.  New Mexico 31134",
                    getFontGreyColor(context)),
                10.h.verticalSpace,
                Row(
                  children: [
                    buildStarView(context, "4.9"),
                    10.w.horizontalSpace,
                    buildDistanceView(context, "50 m"),
                  ],
                ),
                10.h.verticalSpace,
                Align(
                  alignment: Alignment.bottomRight,
                  child: buildButtonBookNow(context, () {}),
                )
              ],
            ),
          )
        ],
      ),
    ),
  );
}

Row buildLocationRow(BuildContext context, String location, Color locationColor,
    {FontWeight weight = FontWeight.w400,
    int maxLine = 1,
    double fontSize = 14}) {
  return Row(
    children: [
      getSvgImageWithSize(context, "location.svg", 20.h, 20.h,
          fit: BoxFit.fill, color: getFontGreyColor(context)),
      6.w.horizontalSpace,
      Expanded(
        flex: 1,
        child: getCustomFont(location, fontSize, locationColor, maxLine,
            fontWeight: weight),
      ),
    ],
  );
}

Widget getDefaultContainerView(BuildContext context, Widget childView,
    {EdgeInsets padding = EdgeInsets.zero}) {
  // {EdgeInsets padding = EdgeInsets.zero}) {
  return Container(
    width: double.infinity,
    height: double.infinity,
    padding: padding,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22.h)),
        // color:greenColor),
        color: getCurrentTheme(context).scaffoldBackgroundColor),
    child: childView,
  );
}

showGetDialog(BuildContext context, String img, String title,
    String description, String btnText, Function function,
    {double dialogHeight = 455,
    double imgWidth = 140,
    double imgHeight = 140,
    BoxFit fit = BoxFit.fill,
    bool withCancelBtn = false,
    String btnTextCancel = "Cancel",
    Function? functionCancel,
    bool barrierDismissible = true}) {
  Get.dialog(
      barrierDismissible: barrierDismissible,
      AlertDialog(
        contentPadding: EdgeInsets.zero,
        backgroundColor: getCardColor(context),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(22.h))),
        content: WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: SizedBox(
            width: 374.h,
            height: dialogHeight.h,
            child: Column(
              children: [
                getAssetImage(context, img, imgWidth.h, imgHeight.h,
                    boxFit: fit),
                Expanded(
                  flex: 1,
                  child: 0.verticalSpace,
                ),
                getCustomFont(title, 22, getFontColor(context), 1,
                    textAlign: TextAlign.center, fontWeight: FontWeight.w700),
                12.h.verticalSpace,
                getMultilineCustomFont(description, 16, getFontColor(context),
                    textAlign: TextAlign.center, fontWeight: FontWeight.w400),
                Expanded(
                  flex: 1,
                  child: 0.verticalSpace,
                ),
                Row(
                  children: [
                    Expanded(
                        child: getButtonFigma(context, getAccentColor(context),
                            true, btnText, Colors.white, () {
                      function();
                    }, EdgeInsets.zero)),
                    (withCancelBtn) ? 20.w.horizontalSpace : 0.horizontalSpace,
                    (withCancelBtn)
                        ? Expanded(
                            child: getButtonFigma(context, Colors.transparent,
                                true, btnText, getAccentColor(context), () {
                            function();
                          }, EdgeInsets.zero,
                                isBorder: true,
                                borderColor: getAccentColor(context)))
                        : 0.horizontalSpace
                  ],
                ).paddingSymmetric(horizontal: 20.h)
              ],
            ).paddingSymmetric(
                vertical: 36.h,
                horizontal: FetchPixels.getDefaultHorSpaceFigma(context)),
          ),
        ),
      ));
}

Widget buildTitles(BuildContext context, String title,
    {bool withPadding = true}) {
  return getCustomFont(title, 18, getFontColor(context), 1,
          fontWeight: FontWeight.w700)
      .marginSymmetric(
          horizontal:
              (withPadding) ? FetchPixels.getDefaultHorSpaceFigma(context) : 0);
}

Widget buildTabView(
    List<String> tabList, BuildContext context, RxInt selectedIndex) {
  return Container(
    width: double.infinity,
    height: 56.h,
    margin: EdgeInsets.symmetric(
        horizontal: FetchPixels.getDefaultHorSpaceFigma(context),
        vertical: 16.h),
    decoration: getButtonDecoration(Colors.white,
        withCorners: true,
        corner: 15.h,
        shadow: [
          const BoxShadow(
              color: Color.fromRGBO(130, 164, 131, 0.2199999988079071),
              offset: Offset(0, 7),
              blurRadius: 33)
        ]),
    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
    child: Row(
        children: List.generate(tabList.length, (index) {
      return ObxValue((p0) {
        bool isSelected = selectedIndex.value == index;
        return Expanded(
          flex: 1,
          child: InkWell(
            onTap: () {
              selectedIndex.value = index;
            },
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: getButtonDecoration(
                  (isSelected) ? lightAccentColor : Colors.transparent,
                  withCorners: true,
                  corner: 15.h),
              child: Center(
                child: getCustomFont(
                  tabList[index],
                  16,
                  (isSelected) ? getAccentColor(context) : getFontHint(context),
                  1,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        );
      }, selectedIndex);
    })),
  );
}

Widget getDefaultTextFiled(
    BuildContext context,
    String s,
    TextEditingController textEditingController,
    Color fontColor,
    ValueChanged<String> changed,
    {bool withPrefix = false,
    String imgName = "",
    bool minLines = false,
    bool isFilled = false,
    bool withFilter = false,
    bool readOnly = false,
    Function? filterClick,
    Function? editTap,
    FormFieldValidator<String>? validator,
    EdgeInsetsGeometry margin = EdgeInsets.zero,
    bool withPadding = true,
    TextInputType keyboardType = TextInputType.text,
    ValueChanged<String>? onSubmit}) {
  double height = getEditHeightFigma();

  return SizedBox(
    height: height,
    width: double.infinity,
    child: TextFormField(
      onTap: () {
        if (editTap != null) {
          editTap();
        }
      },
      maxLines: (minLines) ? null : 1,
      controller: textEditingController,
      autofocus: false,
      validator: validator,
      textAlign: TextAlign.start,
      // expands: minLines,
      style: TextStyle(
          fontFamily: Constant.fontsFamily,
          color: fontColor,
          fontWeight: FontWeight.w400,
          fontSize: getEditFontSizeFigma().sp),
      onChanged: changed,
      keyboardType: keyboardType,
      readOnly: readOnly,
      onFieldSubmitted: onSubmit,
      // onSubmitted: onSubmit,
      decoration: InputDecoration(
          // isDense: true,
          prefixIcon: (withPrefix)
              ? getSvgImageWithSize(context, imgName, getEditIconSize().h,
                      getEditIconSize().h)
                  .marginOnly(left: 20.w, right: 14.w)
              : 0.horizontalSpace,
          // prefixIcon: (withPrefix)?getSvgImage(context, imgName, getEditIconSize()):0.horizontalSpace,
          prefixIconConstraints: BoxConstraints(
            minWidth: 20.w,
            minHeight: 0,
            maxWidth: getEditIconSize().h + (20.w + 14.w),
            maxHeight: getEditIconSize().h,
          ),
          suffixIconConstraints: BoxConstraints(
            minWidth: 20.w,
            minHeight: 0,
            maxWidth: getEditIconSize().h + (20.w + 14.w),
            maxHeight: getEditIconSize().h,
          ),
          contentPadding: EdgeInsets.zero,
          // contentPadding: EdgeInsets.only(right: 20.w),
          filled: isFilled,
          fillColor: getCardColor(context),
          suffixIcon: (withFilter)
              ? InkWell(
                  onTap: () {
                    if (filterClick != null) {
                      filterClick();
                    }
                  },
                  child: getSvgImageWithSize(context, "filter.svg",
                          getEditIconSize().h, getEditIconSize().h)
                      .marginOnly(right: 20.w, left: 16.w),
                )
              : 0.horizontalSpace,
          // fillColor: Colors.green,
          // prefixIcon: (withPrefix)
          //     ? Padding(
          //         padding: EdgeInsets.only(right: 3.w),
          //         child: getSvgImage(context, imgName, getEditIconSize()),
          //       )
          //     : getHorSpace(0),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: (isFilled) ? Colors.transparent : black20, width: 1.h),
              borderRadius: BorderRadius.all(Radius.circular(20.h))),
          disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: (isFilled) ? Colors.transparent : black20, width: 1.h),
              borderRadius: BorderRadius.all(Radius.circular(20.h))),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: (isFilled) ? Colors.transparent : black20, width: 1.h),
              borderRadius: BorderRadius.all(Radius.circular(20.h))),
          border: OutlineInputBorder(
              borderSide: BorderSide(
                  color: (isFilled) ? Colors.transparent : black20, width: 1.h),
              borderRadius: BorderRadius.all(Radius.circular(20.h))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color:
                      (isFilled) ? Colors.transparent : getAccentColor(context),
                  width: 1.h),
              borderRadius: BorderRadius.all(Radius.circular(20.h))),
          hintText: s,
          hintStyle: TextStyle(
              fontFamily: Constant.fontsFamily,
              color: getFontHint(context),
              fontWeight: FontWeight.w400,
              fontSize: getEditFontSizeFigma().sp)),
    ).marginSymmetric(
        horizontal:
            (withPadding) ? FetchPixels.getDefaultHorSpaceFigma(context) : 0),
  );

  // return StatefulBuilder(
  //   builder: (context, setState) {
  //     // final mqData = MediaQuery.of(context);
  //     // final mqDataNew =
  //     // mqData.copyWith(textScaleFactor: FetchPixels.getTextScale());
  //     return Container(
  //       height: (minLines) ? (height * 2.2) : height,
  //       margin: margin,
  //       padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0),
  //       alignment: (minLines) ? Alignment.topLeft : Alignment.centerLeft,
  //       // decoration: ShapeDecoration(
  //       //   color: Colors.transparent,
  //       //   shape: SmoothRectangleBorder(
  //       //     side: BorderSide(
  //       //         color: isAutoFocus
  //       //             ? getAccentColor(context)
  //       //             : getCurrentTheme(context).focusColor,
  //       //         width: 1),
  //       //     borderRadius: SmoothBorderRadius(
  //       //       cornerRadius: getEditRadiusSize(),
  //       //       cornerSmoothing: 0.8,
  //       //     ),
  //       //   ),
  //       // ),
  //       child: Focus(
  //           onFocusChange: (hasFocus) {
  //             if (hasFocus) {
  //               setState(() {
  //                 myFocusNode.canRequestFocus = true;
  //               });
  //             } else {
  //               setState(() {
  //                 myFocusNode.canRequestFocus = false;
  //               });
  //             }
  //           },
  //           child: SizedBox(
  //             height: double.infinity,
  //             child: (minLines)
  //                 ? TextField(
  //                     // minLines: null,
  //                     // maxLines: null,
  //                     maxLines: (minLines) ? null : 1,
  //                     controller: textEditingController,
  //                     autofocus: false,
  //                     focusNode: myFocusNode,
  //                     textAlign: TextAlign.start,
  //                     // expands: true,
  //                     expands: minLines,
  //                     // textAlignVertical:(minLines)?TextAlignVertical.top:TextAlignVertical.center,
  //                     style: TextStyle(
  //                         fontFamily: Constant.fontsFamily,
  //                         color: fontColor,
  //                         fontWeight: FontWeight.w400,
  //                         fontSize: getEditFontSizeFigma().sp),
  //                     decoration: InputDecoration(
  //                         prefixIconConstraints: const BoxConstraints(
  //                           minWidth: 0,
  //                           minHeight: 0,
  //                         ),
  //                         filled: true,
  //                         // fillColor: Colors.green,
  //                         prefixIcon: (withPrefix)
  //                             ? Padding(
  //                                 padding: EdgeInsets.only(right: 3.w),
  //                                 child: getSvgImage(
  //                                     context, imgName, getEditIconSize()),
  //                               )
  //                             : getHorSpace(0),
  //                         border: UnderlineInputBorder(
  //                             borderSide:
  //                                 BorderSide(color: getAccentColor(context))),
  //                         focusedBorder: UnderlineInputBorder(
  //                             borderSide:
  //                                 BorderSide(color: getAccentColor(context))),
  //                         // border: InputBorder.none,
  //                         isDense: true,
  //                         // focusedBorder: InputBorder.none,
  //                         // enabledBorder: InputBorder.none,
  //                         // errorBorder: InputBorder.none,
  //                         // disabledBorder: InputBorder.none,
  //                         hintText: s,
  //                         // prefixIconConstraints: const BoxConstraints(minHeight: 0, minWidth: 0),
  //                         hintStyle: TextStyle(
  //                             fontFamily: Constant.fontsFamily,
  //                             color: getFontHint(context),
  //                             fontWeight: FontWeight.w400,
  //                             fontSize: getEditFontSizeFigma().sp)),
  //                   )
  //                 : Center(
  //                     child: TextField(
  //                     // minLines: null,
  //                     // maxLines: null,
  //                     maxLines: (minLines) ? null : 1,
  //                     controller: textEditingController,
  //                     autofocus: false,
  //                     focusNode: myFocusNode,
  //                     textAlign: TextAlign.start,
  //                     // expands: true,
  //                     expands: minLines,
  //                     // textAlignVertical:(minLines)?TextAlignVertical.top:TextAlignVertical.center,
  //                     style: TextStyle(
  //                         fontFamily: Constant.fontsFamily,
  //                         color: fontColor,
  //                         fontWeight: FontWeight.w400,
  //                         fontSize: getEditFontSizeFigma().sp),
  //                     decoration: InputDecoration(
  //                         prefixIconConstraints: const BoxConstraints(
  //                           minWidth: 0,
  //                           minHeight: 0,
  //                         ),
  //                         // filled: true,
  //                         // fillColor: Colors.green,
  //                         prefixIcon: (withPrefix)
  //                             ? Padding(
  //                                 padding: EdgeInsets.only(right: 3.w),
  //                                 child: getSvgImage(
  //                                     context, imgName, getEditIconSize()),
  //                               )
  //                             : getHorSpace(0),
  //                         border: UnderlineInputBorder(
  //                             borderSide:
  //                                 BorderSide(color: getAccentColor(context))),
  //                         focusedBorder: UnderlineInputBorder(
  //                             borderSide:
  //                                 BorderSide(color: getAccentColor(context))),
  //
  //                         // border: InputBorder.none,
  //                         isDense: true,
  //                         // focusedBorder: InputBorder.none,
  //                         // enabledBorder: InputBorder.none,
  //                         // errorBorder: InputBorder.none,
  //                         // disabledBorder: InputBorder.none,
  //                         hintText: s,
  //                         // prefixIconConstraints: const BoxConstraints(minHeight: 0, minWidth: 0),
  //                         hintStyle: TextStyle(
  //                             fontFamily: Constant.fontsFamily,
  //                             color: getFontHint(context),
  //                             fontWeight: FontWeight.w400,
  //                             fontSize: getEditFontSizeFigma().sp)),
  //                   )),
  //             // child: MediaQuery(
  //             //   data: mqDataNew,
  //             // child: IntrinsicHeight(
  //             // child: IntrinsicHeight(
  //             //   child: Align(
  //             //     alignment: (minLines)?Alignment.topLeft:Alignment.centerLeft,
  //             // ),
  //             // ),
  //             // ),
  //           )),
  //       // child: MediaQuery(
  //       //     data: mqDataNew,
  //       //     child: Focus(
  //       //         onFocusChange: (hasFocus) {
  //       //           if (hasFocus) {
  //       //             setState(() {
  //       //               isAutoFocus = true;
  //       //               myFocusNode.canRequestFocus = true;
  //       //             });
  //       //           } else {
  //       //             setState(() {
  //       //               isAutoFocus = false;
  //       //               myFocusNode.canRequestFocus = false;
  //       //             });
  //       //           }
  //       //         },
  //       //         child: SizedBox(
  //       //           height: double.infinity,
  //       //           child: (minLines)
  //       //               ? TextField(
  //       //                   // minLines: null,
  //       //                   // maxLines: null,
  //       //                   maxLines: (minLines) ? null : 1,
  //       //                   controller: textEditingController,
  //       //                   autofocus: false,
  //       //                   focusNode: myFocusNode,
  //       //                   textAlign: TextAlign.start,
  //       //                   // expands: true,
  //       //                   expands: minLines,
  //       //                   // textAlignVertical:(minLines)?TextAlignVertical.top:TextAlignVertical.center,
  //       //                   style: TextStyle(
  //       //                       fontFamily: Constant.fontsFamily,
  //       //                       color: fontColor,
  //       //                       fontWeight: FontWeight.w400,
  //       //                       fontSize: getEditFontSizeFigma()),
  //       //                   decoration: InputDecoration(
  //       //                       prefixIconConstraints: const BoxConstraints(
  //       //                         minWidth: 0,
  //       //                         minHeight: 0,
  //       //                       ),
  //       //                       filled: true,
  //       //                       // fillColor: Colors.green,
  //       //                       prefixIcon: (withPrefix)
  //       //                           ? Padding(
  //       //                               padding: EdgeInsets.only(
  //       //                                   right: 3.w),
  //       //                               child: getSvgImage(
  //       //                                   context, imgName, getEditIconSize()),
  //       //                             )
  //       //                           : getHorSpace(0),
  //       //                       border: UnderlineInputBorder(
  //       //                           borderSide: BorderSide(
  //       //                               color: getAccentColor(context))),
  //       //                       focusedBorder: UnderlineInputBorder(
  //       //                           borderSide: BorderSide(
  //       //                               color: getAccentColor(context))),
  //       //                       // border: InputBorder.none,
  //       //                       isDense: true,
  //       //                       // focusedBorder: InputBorder.none,
  //       //                       // enabledBorder: InputBorder.none,
  //       //                       // errorBorder: InputBorder.none,
  //       //                       // disabledBorder: InputBorder.none,
  //       //                       hintText: s,
  //       //                       // prefixIconConstraints: const BoxConstraints(minHeight: 0, minWidth: 0),
  //       //                       hintStyle: TextStyle(
  //       //                           fontFamily: Constant.fontsFamily,
  //       //                           color: getFontHint(context),
  //       //                           fontWeight: FontWeight.w400,
  //       //                           fontSize: getEditFontSizeFigma())),
  //       //                 )
  //       //               : Center(
  //       //                   child: TextField(
  //       //                   // minLines: null,
  //       //                   // maxLines: null,
  //       //                   maxLines: (minLines) ? null : 1,
  //       //                   controller: textEditingController,
  //       //                   autofocus: false,
  //       //                   focusNode: myFocusNode,
  //       //                   textAlign: TextAlign.start,
  //       //                   // expands: true,
  //       //                   expands: minLines,
  //       //                   // textAlignVertical:(minLines)?TextAlignVertical.top:TextAlignVertical.center,
  //       //                   style: TextStyle(
  //       //                       fontFamily: Constant.fontsFamily,
  //       //                       color: fontColor,
  //       //                       fontWeight: FontWeight.w400,
  //       //                       fontSize: getEditFontSizeFigma()),
  //       //                   decoration: InputDecoration(
  //       //                       prefixIconConstraints: const BoxConstraints(
  //       //                         minWidth: 0,
  //       //                         minHeight: 0,
  //       //                       ),
  //       //                       // filled: true,
  //       //                       // fillColor: Colors.green,
  //       //                       prefixIcon: (withPrefix)
  //       //                           ? Padding(
  //       //                               padding: EdgeInsets.only(
  //       //                                   right: 3.w),
  //       //                               child: getSvgImage(
  //       //                                   context, imgName, getEditIconSize()),
  //       //                             )
  //       //                           : getHorSpace(0),
  //       //                       border: UnderlineInputBorder(
  //       //                           borderSide: BorderSide(
  //       //                               color: getAccentColor(context))),
  //       //                       focusedBorder: UnderlineInputBorder(
  //       //                           borderSide: BorderSide(
  //       //                               color: getAccentColor(context))),
  //       //
  //       //                       // border: InputBorder.none,
  //       //                       isDense: true,
  //       //                       // focusedBorder: InputBorder.none,
  //       //                       // enabledBorder: InputBorder.none,
  //       //                       // errorBorder: InputBorder.none,
  //       //                       // disabledBorder: InputBorder.none,
  //       //                       hintText: s,
  //       //                       // prefixIconConstraints: const BoxConstraints(minHeight: 0, minWidth: 0),
  //       //                       hintStyle: TextStyle(
  //       //                           fontFamily: Constant.fontsFamily,
  //       //                           color: getFontHint(context),
  //       //                           fontWeight: FontWeight.w400,
  //       //                           fontSize: getEditFontSizeFigma())),
  //       //                 )),
  //       //           // child: MediaQuery(
  //       //           //   data: mqDataNew,
  //       //           // child: IntrinsicHeight(
  //       //           // child: IntrinsicHeight(
  //       //           //   child: Align(
  //       //           //     alignment: (minLines)?Alignment.topLeft:Alignment.centerLeft,
  //       //           // ),
  //       //           // ),
  //       //           // ),
  //       //         ))),
  //       // child: MediaQuery(
  //       //     data: mqDataNew,
  //       //     child: Container(
  //       //       height:double.infinity,
  //       //       // color: Colors.red,
  //       //       child: IntrinsicHeight(
  //       //         // child: IntrinsicHeight(
  //       //         child: TextField(
  //       //           maxLines: (minLines) ? null : 1,
  //       //           controller: textEditingController,
  //       //           autofocus: false,
  //       //           focusNode: myFocusNode,
  //       //           textAlign: TextAlign.start,
  //       //           // textAlignVertical: TextAlignVertical.center,
  //       //           style: TextStyle(
  //       //               fontFamily: Constant.fontsFamily,
  //       //               color: fontColor,
  //       //               fontWeight: FontWeight.w400,
  //       //               fontSize: getEditFontSizeFigma()),
  //       //           decoration: InputDecoration(
  //       //               prefixIconConstraints: const BoxConstraints(
  //       //                 minWidth: 0,
  //       //                 minHeight: 0,
  //       //               ),
  //       //               // filled: true,
  //       //               // fillColor: Colors.green,
  //       //               prefixIcon: (withPrefix)
  //       //                   ? Padding(
  //       //                 padding: EdgeInsets.only(
  //       //                     right: FetchPixels.getPixelWidth(3)),
  //       //                 child: getSvgImage(
  //       //                     context, imgName, getEditIconSize()),
  //       //               )
  //       //                   : getHorSpace(0),
  //       //               border: InputBorder.none,
  //       //               isDense: true,
  //       //               focusedBorder: InputBorder.none,
  //       //               enabledBorder: InputBorder.none,
  //       //               errorBorder: InputBorder.none,
  //       //               disabledBorder: InputBorder.none,
  //       //               hintText: s,
  //       //               // prefixIconConstraints: const BoxConstraints(minHeight: 0, minWidth: 0),
  //       //               hintStyle: TextStyle(
  //       //                   fontFamily: Constant.fontsFamily,
  //       //                   color: getFontHint(context),
  //       //                   fontWeight: FontWeight.w400,
  //       //                   fontSize: getEditFontSizeFigma())),
  //       //         ),
  //       //         // ),
  //       //       ),
  //       //     ))),
  //     );
  //
  //     //   getTextFieldView(
  //     //     context,
  //     //     MediaQuery(
  //     //         data: mqDataNew,
  //     //         child: Focus(
  //     //             onFocusChange: (hasFocus) {
  //     //               if (hasFocus) {
  //     //                 setState(() {
  //     //                   isAutoFocus = true;
  //     //                   myFocusNode.canRequestFocus = true;
  //     //                 });
  //     //               } else {
  //     //                 setState(() {
  //     //                   isAutoFocus = false;
  //     //                   myFocusNode.canRequestFocus = false;
  //     //                 });
  //     //               }
  //     //             },
  //     //             child: SizedBox(
  //     //               height: double.infinity,
  //     //               child: (minLines)
  //     //                   ? TextField(
  //     //                 // minLines: null,
  //     //                 // maxLines: null,
  //     //                 maxLines: (minLines) ? null : 1,
  //     //                 controller: textEditingController,
  //     //                 autofocus: false,
  //     //                 focusNode: myFocusNode,
  //     //                 textAlign: TextAlign.start,
  //     //                 // expands: true,
  //     //                 expands: minLines,
  //     //                 // textAlignVertical:(minLines)?TextAlignVertical.top:TextAlignVertical.center,
  //     //                 style: TextStyle(
  //     //                     fontFamily: Constant.fontsFamily,
  //     //                     color: fontColor,
  //     //                     fontWeight: FontWeight.w400,
  //     //                     fontSize: getEditFontSizeFigma()),
  //     //                 decoration: InputDecoration(
  //     //                     prefixIconConstraints: const BoxConstraints(
  //     //                       minWidth: 0,
  //     //                       minHeight: 0,
  //     //                     ),
  //     //                     // filled: true,
  //     //                     // fillColor: Colors.green,
  //     //                     prefixIcon: (withPrefix)
  //     //                         ? Padding(
  //     //                       padding: EdgeInsets.only(
  //     //                           right:
  //     //                           FetchPixels.getPixelWidth(3)),
  //     //                       child: getSvgImage(context, imgName,
  //     //                           getEditIconSize()),
  //     //                     )
  //     //                         : getHorSpace(0),
  //     //                     border: InputBorder.none,
  //     //                     isDense: true,
  //     //                     focusedBorder: InputBorder.none,
  //     //                     enabledBorder: InputBorder.none,
  //     //                     errorBorder: InputBorder.none,
  //     //                     disabledBorder: InputBorder.none,
  //     //                     hintText: s,
  //     //                     // prefixIconConstraints: const BoxConstraints(minHeight: 0, minWidth: 0),
  //     //                     hintStyle: TextStyle(
  //     //                         fontFamily: Constant.fontsFamily,
  //     //                         color: getFontHint(context),
  //     //                         fontWeight: FontWeight.w400,
  //     //                         fontSize: getEditFontSizeFigma())),
  //     //               )
  //     //                   : Center(
  //     //                   child: TextField(
  //     //                     // minLines: null,
  //     //                     // maxLines: null,
  //     //                     maxLines: (minLines) ? null : 1,
  //     //                     controller: textEditingController,
  //     //                     autofocus: false,
  //     //                     focusNode: myFocusNode,
  //     //                     textAlign: TextAlign.start,
  //     //                     // expands: true,
  //     //                     expands: minLines,
  //     //                     // textAlignVertical:(minLines)?TextAlignVertical.top:TextAlignVertical.center,
  //     //                     style: TextStyle(
  //     //                         fontFamily: Constant.fontsFamily,
  //     //                         color: fontColor,
  //     //                         fontWeight: FontWeight.w400,
  //     //                         fontSize: getEditFontSizeFigma()),
  //     //                     decoration: InputDecoration(
  //     //                         prefixIconConstraints: const BoxConstraints(
  //     //                           minWidth: 0,
  //     //                           minHeight: 0,
  //     //                         ),
  //     //                         // filled: true,
  //     //                         // fillColor: Colors.green,
  //     //                         prefixIcon: (withPrefix)
  //     //                             ? Padding(
  //     //                           padding: EdgeInsets.only(
  //     //                               right:
  //     //                               FetchPixels.getPixelWidth(3)),
  //     //                           child: getSvgImage(context, imgName,
  //     //                               getEditIconSize()),
  //     //                         )
  //     //                             : getHorSpace(0),
  //     //                         border: InputBorder.none,
  //     //                         isDense: true,
  //     //                         focusedBorder: InputBorder.none,
  //     //                         enabledBorder: InputBorder.none,
  //     //                         errorBorder: InputBorder.none,
  //     //                         disabledBorder: InputBorder.none,
  //     //                         hintText: s,
  //     //                         // prefixIconConstraints: const BoxConstraints(minHeight: 0, minWidth: 0),
  //     //                         hintStyle: TextStyle(
  //     //                             fontFamily: Constant.fontsFamily,
  //     //                             color: getFontHint(context),
  //     //                             fontWeight: FontWeight.w400,
  //     //                             fontSize: getEditFontSizeFigma())),
  //     //                   )),
  //     //               // child: MediaQuery(
  //     //               //   data: mqDataNew,
  //     //               // child: IntrinsicHeight(
  //     //               // child: IntrinsicHeight(
  //     //               //   child: Align(
  //     //               //     alignment: (minLines)?Alignment.topLeft:Alignment.centerLeft,
  //     //               // ),
  //     //               // ),
  //     //               // ),
  //     //             ))),
  //     //     minLines,
  //     //     margin);
  //     // //   MediaQuery(
  //     // //   data: mqDataNew,
  //     // //   child: getTextFieldView(context, Focus(
  //     // //       onFocusChange: (hasFocus) {
  //     // //         if (hasFocus) {
  //     // //           setState(() {
  //     // //             isAutoFocus = true;
  //     // //             myFocusNode.canRequestFocus = true;
  //     // //           });
  //     // //         } else {
  //     // //           setState(() {
  //     // //             isAutoFocus = false;
  //     // //             myFocusNode.canRequestFocus = false;
  //     // //           });
  //     // //         }
  //     // //       },
  //     // //       child: SizedBox(
  //     // //         height: double.infinity,
  //     // //         child: (minLines)
  //     // //             ? TextField(
  //     // //           // minLines: null,
  //     // //           // maxLines: null,
  //     // //           maxLines: (minLines) ? null : 1,
  //     // //           controller: textEditingController,
  //     // //           autofocus: false,
  //     // //           focusNode: myFocusNode,
  //     // //           textAlign: TextAlign.start,
  //     // //           // expands: true,
  //     // //           expands: minLines,
  //     // //           // textAlignVertical:(minLines)?TextAlignVertical.top:TextAlignVertical.center,
  //     // //           style: TextStyle(
  //     // //               fontFamily: Constant.fontsFamily,
  //     // //               color: fontColor,
  //     // //               fontWeight: FontWeight.w400,
  //     // //               fontSize: getEditFontSizeFigma()),
  //     // //           decoration: InputDecoration(
  //     // //               prefixIconConstraints: const BoxConstraints(
  //     // //                 minWidth: 0,
  //     // //                 minHeight: 0,
  //     // //               ),
  //     // //               // filled: true,
  //     // //               // fillColor: Colors.green,
  //     // //               prefixIcon: (withPrefix)
  //     // //                   ? Padding(
  //     // //                 padding: EdgeInsets.only(
  //     // //                     right: FetchPixels.getPixelWidth(3)),
  //     // //                 child: getSvgImage(
  //     // //                     context, imgName, getEditIconSize()),
  //     // //               )
  //     // //                   : getHorSpace(0),
  //     // //               border: InputBorder.none,
  //     // //               isDense: true,
  //     // //               focusedBorder: InputBorder.none,
  //     // //               enabledBorder: InputBorder.none,
  //     // //               errorBorder: InputBorder.none,
  //     // //               disabledBorder: InputBorder.none,
  //     // //               hintText: s,
  //     // //               // prefixIconConstraints: const BoxConstraints(minHeight: 0, minWidth: 0),
  //     // //               hintStyle: TextStyle(
  //     // //                   fontFamily: Constant.fontsFamily,
  //     // //                   color: getFontHint(context),
  //     // //                   fontWeight: FontWeight.w400,
  //     // //                   fontSize: getEditFontSizeFigma())),
  //     // //         )
  //     // //             : Center(
  //     // //             child: TextField(
  //     // //               // minLines: null,
  //     // //               // maxLines: null,
  //     // //               maxLines: (minLines) ? null : 1,
  //     // //               controller: textEditingController,
  //     // //               autofocus: false,
  //     // //               focusNode: myFocusNode,
  //     // //               textAlign: TextAlign.start,
  //     // //               // expands: true,
  //     // //               expands: minLines,
  //     // //               // textAlignVertical:(minLines)?TextAlignVertical.top:TextAlignVertical.center,
  //     // //               style: TextStyle(
  //     // //                   fontFamily: Constant.fontsFamily,
  //     // //                   color: fontColor,
  //     // //                   fontWeight: FontWeight.w400,
  //     // //                   fontSize: getEditFontSizeFigma()),
  //     // //               decoration: InputDecoration(
  //     // //                   prefixIconConstraints: const BoxConstraints(
  //     // //                     minWidth: 0,
  //     // //                     minHeight: 0,
  //     // //                   ),
  //     // //                   // filled: true,
  //     // //                   // fillColor: Colors.green,
  //     // //                   prefixIcon: (withPrefix)
  //     // //                       ? Padding(
  //     // //                     padding: EdgeInsets.only(
  //     // //                         right: FetchPixels.getPixelWidth(3)),
  //     // //                     child: getSvgImage(
  //     // //                         context, imgName, getEditIconSize()),
  //     // //                   )
  //     // //                       : getHorSpace(0),
  //     // //                   border: InputBorder.none,
  //     // //                   isDense: true,
  //     // //                   focusedBorder: InputBorder.none,
  //     // //                   enabledBorder: InputBorder.none,
  //     // //                   errorBorder: InputBorder.none,
  //     // //                   disabledBorder: InputBorder.none,
  //     // //                   hintText: s,
  //     // //                   // prefixIconConstraints: const BoxConstraints(minHeight: 0, minWidth: 0),
  //     // //                   hintStyle: TextStyle(
  //     // //                       fontFamily: Constant.fontsFamily,
  //     // //                       color: getFontHint(context),
  //     // //                       fontWeight: FontWeight.w400,
  //     // //                       fontSize: getEditFontSizeFigma())),
  //     // //             )),
  //     // //         // child: MediaQuery(
  //     // //         //   data: mqDataNew,
  //     // //         // child: IntrinsicHeight(
  //     // //         // child: IntrinsicHeight(
  //     // //         //   child: Align(
  //     // //         //     alignment: (minLines)?Alignment.topLeft:Alignment.centerLeft,
  //     // //         // ),
  //     // //         // ),
  //     // //         // ),
  //     // //       )), minLines, margin),
  //     // // );
  //   },
  // );
}

// Widget getDefaultTextFiledFigma(BuildContext context, String s,
//     TextEditingController textEditingController, Color fontColor,
//     {bool withPrefix = false,
//     String imgName = "",
//     bool minLines = false,
//     EdgeInsetsGeometry margin = EdgeInsets.zero,
//     bool isDisable = false}) {
//   double height = getEditHeightFigma();
//   FocusNode myFocusNode = FocusNode();
//   bool isAutoFocus = false;
//   return StatefulBuilder(
//     builder: (context, setState) {
//       // final mqData = MediaQuery.of(context);
//       // final mqDataNew =
//       //     mqData.copyWith(textScaleFactor: FetchPixels.getTextScale());
//
//       return Container(
//         height: (minLines) ? (height * 2.2) : height,
//         margin: margin,
//         padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 0),
//         alignment: (minLines) ? Alignment.topLeft : Alignment.centerLeft,
//         decoration: ShapeDecoration(
//           color: Colors.transparent,
//           shape: SmoothRectangleBorder(
//             side: BorderSide(
//                 color: isAutoFocus
//                     ? getAccentColor(context)
//                     : getCurrentTheme(context).unselectedWidgetColor,
//                 width: 1.h),
//             borderRadius: SmoothBorderRadius(
//               cornerRadius: getEditRadiusSizeFigma(),
//               cornerSmoothing: 0.8,
//             ),
//           ),
//         ),
//         child: Focus(
//             onFocusChange: (hasFocus) {
//               if (hasFocus) {
//                 setState(() {
//                   isAutoFocus = true;
//                   myFocusNode.canRequestFocus = true;
//                 });
//               } else {
//                 setState(() {
//                   isAutoFocus = false;
//                   myFocusNode.canRequestFocus = false;
//                 });
//               }
//             },
//             child: AbsorbPointer(
//               absorbing: isDisable,
//               child: SizedBox(
//                 height: double.infinity,
//                 child: (minLines)
//                     ? TextField(
//                         maxLines: (minLines) ? null : 1,
//                         controller: textEditingController,
//                         autofocus: false,
//                         focusNode: myFocusNode,
//                         textAlign: TextAlign.start,
//                         expands: minLines,
//                         style: TextStyle(
//                             fontFamily: Constant.fontsFamily,
//                             color: fontColor,
//                             fontWeight: FontWeight.w500,
//                             fontSize: getEditFontSizeFigma().sp),
//                         decoration: InputDecoration(
//                             prefixIconConstraints: const BoxConstraints(
//                               minWidth: 0,
//                               minHeight: 0,
//                             ),
//                             prefixIcon: (withPrefix)
//                                 ? Padding(
//                                     padding: EdgeInsets.only(right: 3.w),
//                                     child: getSvgImage(context, imgName,
//                                         getEditIconSizeFigma()),
//                                   )
//                                 : getHorSpace(0),
//                             border: InputBorder.none,
//                             isDense: true,
//                             focusedBorder: InputBorder.none,
//                             enabledBorder: InputBorder.none,
//                             errorBorder: InputBorder.none,
//                             disabledBorder: InputBorder.none,
//                             hintText: s,
//                             hintStyle: TextStyle(
//                                 fontFamily: Constant.fontsFamily,
//                                 color: getFontHint(context),
//                                 fontWeight: FontWeight.w500,
//                                 fontSize: getEditFontSizeFigma().sp)),
//                       )
//                     : Center(
//                         child: TextField(
//                         maxLines: (minLines) ? null : 1,
//                         controller: textEditingController,
//                         autofocus: false,
//                         focusNode: myFocusNode,
//                         textAlign: TextAlign.start,
//                         expands: minLines,
//                         style: TextStyle(
//                             fontFamily: Constant.fontsFamily,
//                             color: fontColor,
//                             fontWeight: FontWeight.w500,
//                             fontSize: getEditFontSizeFigma().sp),
//                         decoration: InputDecoration(
//                             prefixIconConstraints: const BoxConstraints(
//                               minWidth: 0,
//                               minHeight: 0,
//                             ),
//                             prefixIcon: (withPrefix)
//                                 ? Padding(
//                                     padding: EdgeInsets.only(right: 3.w),
//                                     child: getSvgImage(context, imgName,
//                                         getEditIconSizeFigma()),
//                                   )
//                                 : getHorSpace(0),
//                             border: InputBorder.none,
//                             isDense: true,
//                             focusedBorder: InputBorder.none,
//                             enabledBorder: InputBorder.none,
//                             errorBorder: InputBorder.none,
//                             disabledBorder: InputBorder.none,
//                             hintText: s,
//                             hintStyle: TextStyle(
//                                 fontFamily: Constant.fontsFamily,
//                                 color: getFontHint(context),
//                                 fontWeight: FontWeight.w500,
//                                 fontSize: getEditFontSizeFigma().sp)),
//                       )),
//               ),
//             )),
//         // child: MediaQuery(
//         //     data: mqDataNew,
//         //     child: Focus(
//         //         onFocusChange: (hasFocus) {
//         //           if (hasFocus) {
//         //             setState(() {
//         //               isAutoFocus = true;
//         //               myFocusNode.canRequestFocus = true;
//         //             });
//         //           } else {
//         //             setState(() {
//         //               isAutoFocus = false;
//         //               myFocusNode.canRequestFocus = false;
//         //             });
//         //           }
//         //         },
//         //         child: AbsorbPointer(
//         //           absorbing: isDisable,
//         //           child: SizedBox(
//         //             height: double.infinity,
//         //             child: (minLines)
//         //                 ? TextField(
//         //                     maxLines: (minLines) ? null : 1,
//         //                     controller: textEditingController,
//         //                     autofocus: false,
//         //                     focusNode: myFocusNode,
//         //                     textAlign: TextAlign.start,
//         //                     expands: minLines,
//         //                     style: TextStyle(
//         //                         fontFamily: Constant.fontsFamily,
//         //                         color: fontColor,
//         //                         fontWeight: FontWeight.w500,
//         //                         fontSize: getEditFontSizeFigma()),
//         //                     decoration: InputDecoration(
//         //                         prefixIconConstraints: const BoxConstraints(
//         //                           minWidth: 0,
//         //                           minHeight: 0,
//         //                         ),
//         //                         prefixIcon: (withPrefix)
//         //                             ? Padding(
//         //                                 padding: EdgeInsets.only(
//         //                                     right:
//         //                                         FetchPixels.getPixelWidth(3)),
//         //                                 child: getSvgImage(context, imgName,
//         //                                     getEditIconSizeFigma()),
//         //                               )
//         //                             : getHorSpace(0),
//         //                         border: InputBorder.none,
//         //                         isDense: true,
//         //                         focusedBorder: InputBorder.none,
//         //                         enabledBorder: InputBorder.none,
//         //                         errorBorder: InputBorder.none,
//         //                         disabledBorder: InputBorder.none,
//         //                         hintText: s,
//         //                         hintStyle: TextStyle(
//         //                             fontFamily: Constant.fontsFamily,
//         //                             color: getFontHint(context),
//         //                             fontWeight: FontWeight.w500,
//         //                             fontSize: getEditFontSizeFigma())),
//         //                   )
//         //                 : Center(
//         //                     child: TextField(
//         //                     maxLines: (minLines) ? null : 1,
//         //                     controller: textEditingController,
//         //                     autofocus: false,
//         //                     focusNode: myFocusNode,
//         //                     textAlign: TextAlign.start,
//         //                     expands: minLines,
//         //                     style: TextStyle(
//         //                         fontFamily: Constant.fontsFamily,
//         //                         color: fontColor,
//         //                         fontWeight: FontWeight.w500,
//         //                         fontSize: getEditFontSizeFigma()),
//         //                     decoration: InputDecoration(
//         //                         prefixIconConstraints: const BoxConstraints(
//         //                           minWidth: 0,
//         //                           minHeight: 0,
//         //                         ),
//         //                         prefixIcon: (withPrefix)
//         //                             ? Padding(
//         //                                 padding: EdgeInsets.only(
//         //                                     right:
//         //                                         FetchPixels.getPixelWidth(3)),
//         //                                 child: getSvgImage(context, imgName,
//         //                                     getEditIconSizeFigma()),
//         //                               )
//         //                             : getHorSpace(0),
//         //                         border: InputBorder.none,
//         //                         isDense: true,
//         //                         focusedBorder: InputBorder.none,
//         //                         enabledBorder: InputBorder.none,
//         //                         errorBorder: InputBorder.none,
//         //                         disabledBorder: InputBorder.none,
//         //                         hintText: s,
//         //                         hintStyle: TextStyle(
//         //                             fontFamily: Constant.fontsFamily,
//         //                             color: getFontHint(context),
//         //                             fontWeight: FontWeight.w500,
//         //                             fontSize: getEditFontSizeFigma())),
//         //                   )),
//         //           ),
//         //         ))),
//       );
//     },
//   );
// }

// Widget getDefaultCountryPickerTextFiled(BuildContext context, String s,
//     TextEditingController textEditingController, Color fontColor,
//     {bool withPrefix = false,
//     String imgName = "",
//     bool minLines = false,
//     EdgeInsetsGeometry margin = EdgeInsets.zero}) {
//   double height = getEditHeightFigma();
//
//   FocusNode myFocusNode = FocusNode();
//   bool isAutoFocus = false;
//   return StatefulBuilder(
//     builder: (context, setState) {
//       // final mqData = MediaQuery.of(context);
//       // final mqDataNew =
//       //     mqData.copyWith(textScaleFactor: FetchPixels.getTextScale());
//
//       return Container(
//         height: (minLines) ? (height * 2.2) : height,
//         margin: margin,
//         padding: EdgeInsets.symmetric(
//           horizontal: 20.w,
//         ),
//         alignment: (minLines) ? Alignment.topLeft : Alignment.centerLeft,
//         decoration: ShapeDecoration(
//           color: Colors.transparent,
//           shape: SmoothRectangleBorder(
//             side: BorderSide(
//                 color: isAutoFocus
//                     ? getAccentColor(context)
//                     : getCurrentTheme(context).unselectedWidgetColor,
//                 width: 1),
//             borderRadius: SmoothBorderRadius(
//               cornerRadius: getEditRadiusSize(),
//               cornerSmoothing: 0.8,
//             ),
//           ),
//         ),
//         child: Focus(
//             onFocusChange: (hasFocus) {
//               if (hasFocus) {
//                 setState(() {
//                   isAutoFocus = true;
//                   myFocusNode.canRequestFocus = true;
//                 });
//               } else {
//                 setState(() {
//                   isAutoFocus = false;
//                   myFocusNode.canRequestFocus = false;
//                 });
//               }
//             },
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 CountryCodePicker(
//                   onChanged: print,
//                   initialSelection: 'IN',
//                   flagWidth: 40.w,
//                   padding: EdgeInsets.zero,
//                   textStyle: TextStyle(
//                       fontFamily: Constant.fontsFamily,
//                       color: fontColor,
//                       fontWeight: FontWeight.w400,
//                       fontSize: getEditFontSizeFigma().sp),
//                   favorite: const ['+91', 'IN'],
//                   showCountryOnly: false,
//                   showDropDownButton: true,
//                   showOnlyCountryWhenClosed: false,
//                   alignLeft: false,
//                 ),
//                 Expanded(
//                   flex: 1,
//                   child: TextField(
//                     keyboardType: TextInputType.number,
//                     maxLines: (minLines) ? null : 1,
//                     controller: textEditingController,
//                     autofocus: false,
//                     focusNode: myFocusNode,
//                     textAlign: TextAlign.start,
//                     style: TextStyle(
//                         fontFamily: Constant.fontsFamily,
//                         color: fontColor,
//                         fontWeight: FontWeight.w400,
//                         fontSize: getEditFontSizeFigma().sp),
//                     decoration: InputDecoration(
//                         prefixIcon: (withPrefix)
//                             ? Padding(
//                                 padding: EdgeInsets.only(right: 3.w),
//                                 child: getSvgImage(
//                                     context, imgName, getEditIconSize()),
//                               )
//                             : const SizedBox(
//                                 width: 0,
//                                 height: 0,
//                               ),
//                         border: InputBorder.none,
//                         isDense: true,
//                         focusedBorder: InputBorder.none,
//                         enabledBorder: InputBorder.none,
//                         errorBorder: InputBorder.none,
//                         disabledBorder: InputBorder.none,
//                         hintText: s,
//                         prefixIconConstraints:
//                             const BoxConstraints(minHeight: 0, minWidth: 0),
//                         hintStyle: TextStyle(
//                             fontFamily: Constant.fontsFamily,
//                             color: getFontHint(context),
//                             fontWeight: FontWeight.w400,
//                             fontSize: getEditFontSizeFigma().sp)),
//                   ),
//                 )
//               ],
//             )),
//         // child: MediaQuery(
//         //   data: mqDataNew,
//         //   child: Row(
//         //     mainAxisAlignment: MainAxisAlignment.start,
//         //     crossAxisAlignment: CrossAxisAlignment.center,
//         //     children: [
//         //       CountryCodePicker(
//         //         onChanged: print,
//         //         initialSelection: 'IN',
//         //         flagWidth: 24.w,
//         //         padding: EdgeInsets.zero,
//         //         textStyle: TextStyle(
//         //             fontFamily: Constant.fontsFamily,
//         //             color: fontColor,
//         //             fontWeight: FontWeight.w400,
//         //             fontSize: getEditFontSizeFigma()),
//         //         favorite: const ['+91', 'IN'],
//         //         showCountryOnly: false,
//         //         showDropDownButton: true,
//         //         showOnlyCountryWhenClosed: false,
//         //         alignLeft: false,
//         //       ),
//         //       Expanded(
//         //         child: TextField(
//         //           keyboardType: TextInputType.number,
//         //           maxLines: (minLines) ? null : 1,
//         //           controller: textEditingController,
//         //           autofocus: false,
//         //           focusNode: myFocusNode,
//         //           textAlign: TextAlign.start,
//         //           style: TextStyle(
//         //               fontFamily: Constant.fontsFamily,
//         //               color: fontColor,
//         //               fontWeight: FontWeight.w400,
//         //               fontSize: getEditFontSizeFigma()),
//         //           decoration: InputDecoration(
//         //               prefixIcon: (withPrefix)
//         //                   ? Padding(
//         //                       padding: EdgeInsets.only(
//         //                           right: 3.w),
//         //                       child: getSvgImage(
//         //                           context, imgName, getEditIconSize()),
//         //                     )
//         //                   : const SizedBox(
//         //                       width: 0,
//         //                       height: 0,
//         //                     ),
//         //               border: InputBorder.none,
//         //               isDense: true,
//         //               focusedBorder: InputBorder.none,
//         //               enabledBorder: InputBorder.none,
//         //               errorBorder: InputBorder.none,
//         //               disabledBorder: InputBorder.none,
//         //               hintText: s,
//         //               prefixIconConstraints:
//         //                   const BoxConstraints(minHeight: 0, minWidth: 0),
//         //               hintStyle: TextStyle(
//         //                   fontFamily: Constant.fontsFamily,
//         //                   color: getFontHint(context),
//         //                   fontWeight: FontWeight.w400,
//         //                   fontSize: getEditFontSizeFigma())),
//         //         ),
//         //         flex: 1,
//         //       )
//         //     ],
//         //   ),
//         // )),
//       );
//     },
//   );
// }

getProgressDialog() {
  return Container(
      color: Colors.transparent,
      child: Center(
          child: Theme(
              data: ThemeData(
                  cupertinoOverrideTheme:
                      const CupertinoThemeData(brightness: Brightness.dark)),
              child: const CupertinoActivityIndicator())));
}

Widget getDivider({double dividerHeight = 1, Color setColor = Colors.grey}) {
  return Divider(
    height: dividerHeight.h,
    color: setColor,
  );
}

const _DefaultDecoration = BoxDecoration(
  color: Colors.white,
  shape: BoxShape.rectangle,
  borderRadius: BorderRadius.all(Radius.circular(10)),
);

bool isShowDialog = false;
// showCloseDialog(BuildContext context)
showCloseDialog(BuildContext context) async {
  if (!isShowDialog) {
    isShowDialog = true;
    Get.dialog(
            Scaffold(
              backgroundColor: Colors.transparent,
              body: Center(
                child: Container(
                  height: 100,
                  width: 100,
                  padding: const EdgeInsets.all(20),
                  decoration: _DefaultDecoration,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        CircularProgressIndicator(),
                      ]),
                ),
              ),
            ),
            barrierDismissible: true)
        .then((value) {
      isShowDialog = false;
    });
  }
  // var result = await showDialog(
  //   builder: (context) {
  //     return  WillPopScope(
  //       onWillPop: () async{
  //         return true;
  //       },
  //       child: Scaffold(
  //         backgroundColor: Colors.transparent,
  //         body: Center(
  //           child: Container(
  //             height: 100,
  //             width: 100,
  //             padding: const EdgeInsets.all(20),
  //             decoration:_DefaultDecoration,
  //             child:
  //             Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
  //               CircularProgressIndicator(),
  //
  //             ]),
  //           ),
  //         ),
  //       ),
  //     );
  //   },
  //
  //     context: context,
  //     barrierDismissible: true);

  //     builder: (context) => FutureProgressDialog()).then((value) {
  //     // builder: (context) => FutureProgressDialog()).then((value) {
  //   isShowDialog = false;
  // });
  // showResultDialog(context, result);

  //
  //
  // Get.dialog(SizedBox(
  //   width:50,
  //   height:50,
  //   child: CircularProgressIndicator(
  //     backgroundColor: Colors.red,
  //   ),
  // ),
  //     // useSafeArea: true,
  //     // // title: "GeeksforGeeks",
  //     // // middleText: "Hello world!",
  //     // backgroundColor: Colors.green,
  //     // titleStyle: TextStyle(color: Colors.white),
  //     // middleTextStyle: TextStyle(color: Colors.white),
  //     // // textConfirm: "Confirm",
  //     // // textCancel: "Cancel",
  //     //
  //     // cancelTextColor: Colors.white,
  //     // confirmTextColor: Colors.white,
  //     // contentPadding: EdgeInsets.zero,
  //     // titlePadding: EdgeInsets.zero,
  //     // buttonColor: Colors.red,
  //     // barrierDismissible: false,
  //     // radius: 50,
  //     // custom: SizedBox(
  //     //   width:50,
  //     //   height:50,
  //     //   child: CircularProgressIndicator(
  //     //     backgroundColor: Colors.red,
  //     //   ),
  //     // )
  // );

  // Get.dialog(
  //   AlertDialog(
  //     scrollable: true,
  //     contentPadding: EdgeInsets.zero,
  //     insetPadding: EdgeInsets.zero,
  //     buttonPadding: EdgeInsets.zero,
  //     actionsPadding: EdgeInsets.zero,
  //     titlePadding: EdgeInsets.zero,
  //     content: Wrap(
  //       children: [
  //         SizedBox(
  //           width: 80.h,
  //           height: 80.h,.
  //           child: Center(
  //             child: SizedBox(
  //                 height: 20.h,
  //                 width: 20.h,
  //                 child: CircularProgressIndicator(
  //                   strokeWidth: 3.h,
  //                 )),
  //           ),
  //         )
  //         // SizedBox(
  //         //   width: 60,
  //         //   height: 60,
  //         //   child: Center(
  //         //     child: CircularProgressIndicator(
  //         //       strokeWidth: 10,
  //         //     ),
  //         //   ),
  //         // )
  //       ],
  //     ),
  //   ),
  //   barrierDismissible: false,
  // );
}

Widget getDefaultTextFiledWithCustomPrefix(BuildContext context, String s,
    TextEditingController textEditingController, Color fontColor, Widget widget,
    {bool withPrefix = false,
    String imgName = "",
    bool minLines = false,
    bool isFilled = false,
    EdgeInsetsGeometry margin = EdgeInsets.zero}) {
  double height = getEditHeightFigma();

  return SizedBox(
    height: height,
    width: double.infinity,
    child: TextField(
      onEditingComplete: () {},
      onChanged: (value) {},
      onSubmitted: (value) {
        return;
      },
      maxLines: (minLines) ? null : 1,
      controller: textEditingController,
      autofocus: false,
      textAlign: TextAlign.start,
      // expands: minLines,
      style: TextStyle(
          fontFamily: Constant.fontsFamily,
          color: fontColor,
          fontWeight: FontWeight.w400,
          fontSize: getEditFontSizeFigma().sp),
      decoration: InputDecoration(
          // prefix:widget,
          prefixIcon: widget,
          prefixIconConstraints:
              BoxConstraints(minWidth: 20.h, maxWidth: 90.h + 20.w),
          contentPadding: EdgeInsets.zero,
          // contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: (isFilled)
                      ? Colors.transparent
                      : getDividerColor(context),
                  width: 1.h),
              borderRadius: BorderRadius.all(Radius.circular(20.h))),
          disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: (isFilled)
                      ? Colors.transparent
                      : getDividerColor(context),
                  width: 1.h),
              borderRadius: BorderRadius.all(Radius.circular(20.h))),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: (isFilled)
                      ? Colors.transparent
                      : getDividerColor(context),
                  width: 1.h),
              borderRadius: BorderRadius.all(Radius.circular(20.h))),
          border: OutlineInputBorder(
              borderSide: BorderSide(
                  color: (isFilled)
                      ? Colors.transparent
                      : getDividerColor(context),
                  width: 1.h),
              borderRadius: BorderRadius.all(Radius.circular(20.h))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color:
                      (isFilled) ? Colors.transparent : getAccentColor(context),
                  width: 1.h),
              borderRadius: BorderRadius.all(Radius.circular(20.h))),
          hintText: s,
          hintStyle: TextStyle(
              fontFamily: Constant.fontsFamily,
              color: getFontHint(context),
              fontWeight: FontWeight.w400,
              fontSize: getEditFontSizeFigma().sp)),
    ).marginSymmetric(horizontal: FetchPixels.getDefaultHorSpaceFigma(context)),
  );

  // return StatefulBuilder(
  //   builder: (context, setState) {
  //     // final mqData = MediaQuery.of(context);
  //     // final mqDataNew =
  //     // mqData.copyWith(textScaleFactor: FetchPixels.getTextScale());
  //     return Container(
  //       height: (minLines) ? (height * 2.2) : height,
  //       margin: margin,
  //       padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0),
  //       alignment: (minLines) ? Alignment.topLeft : Alignment.centerLeft,
  //       // decoration: ShapeDecoration(
  //       //   color: Colors.transparent,
  //       //   shape: SmoothRectangleBorder(
  //       //     side: BorderSide(
  //       //         color: isAutoFocus
  //       //             ? getAccentColor(context)
  //       //             : getCurrentTheme(context).focusColor,
  //       //         width: 1),
  //       //     borderRadius: SmoothBorderRadius(
  //       //       cornerRadius: getEditRadiusSize(),
  //       //       cornerSmoothing: 0.8,
  //       //     ),
  //       //   ),
  //       // ),
  //       child: Focus(
  //           onFocusChange: (hasFocus) {
  //             if (hasFocus) {
  //               setState(() {
  //                 myFocusNode.canRequestFocus = true;
  //               });
  //             } else {
  //               setState(() {
  //                 myFocusNode.canRequestFocus = false;
  //               });
  //             }
  //           },
  //           child: SizedBox(
  //             height: double.infinity,
  //             child: (minLines)
  //                 ? TextField(
  //                     // minLines: null,
  //                     // maxLines: null,
  //                     maxLines: (minLines) ? null : 1,
  //                     controller: textEditingController,
  //                     autofocus: false,
  //                     focusNode: myFocusNode,
  //                     textAlign: TextAlign.start,
  //                     // expands: true,
  //                     expands: minLines,
  //                     // textAlignVertical:(minLines)?TextAlignVertical.top:TextAlignVertical.center,
  //                     style: TextStyle(
  //                         fontFamily: Constant.fontsFamily,
  //                         color: fontColor,
  //                         fontWeight: FontWeight.w400,
  //                         fontSize: getEditFontSizeFigma().sp),
  //                     decoration: InputDecoration(
  //                         prefixIconConstraints: const BoxConstraints(
  //                           minWidth: 0,
  //                           minHeight: 0,
  //                         ),
  //                         filled: true,
  //                         // fillColor: Colors.green,
  //                         prefixIcon: (withPrefix)
  //                             ? Padding(
  //                                 padding: EdgeInsets.only(right: 3.w),
  //                                 child: getSvgImage(
  //                                     context, imgName, getEditIconSize()),
  //                               )
  //                             : getHorSpace(0),
  //                         border: UnderlineInputBorder(
  //                             borderSide:
  //                                 BorderSide(color: getAccentColor(context))),
  //                         focusedBorder: UnderlineInputBorder(
  //                             borderSide:
  //                                 BorderSide(color: getAccentColor(context))),
  //                         // border: InputBorder.none,
  //                         isDense: true,
  //                         // focusedBorder: InputBorder.none,
  //                         // enabledBorder: InputBorder.none,
  //                         // errorBorder: InputBorder.none,
  //                         // disabledBorder: InputBorder.none,
  //                         hintText: s,
  //                         // prefixIconConstraints: const BoxConstraints(minHeight: 0, minWidth: 0),
  //                         hintStyle: TextStyle(
  //                             fontFamily: Constant.fontsFamily,
  //                             color: getFontHint(context),
  //                             fontWeight: FontWeight.w400,
  //                             fontSize: getEditFontSizeFigma().sp)),
  //                   )
  //                 : Center(
  //                     child: TextField(
  //                     // minLines: null,
  //                     // maxLines: null,
  //                     maxLines: (minLines) ? null : 1,
  //                     controller: textEditingController,
  //                     autofocus: false,
  //                     focusNode: myFocusNode,
  //                     textAlign: TextAlign.start,
  //                     // expands: true,
  //                     expands: minLines,
  //                     // textAlignVertical:(minLines)?TextAlignVertical.top:TextAlignVertical.center,
  //                     style: TextStyle(
  //                         fontFamily: Constant.fontsFamily,
  //                         color: fontColor,
  //                         fontWeight: FontWeight.w400,
  //                         fontSize: getEditFontSizeFigma().sp),
  //                     decoration: InputDecoration(
  //                         prefixIconConstraints: const BoxConstraints(
  //                           minWidth: 0,
  //                           minHeight: 0,
  //                         ),
  //                         // filled: true,
  //                         // fillColor: Colors.green,
  //                         prefixIcon: (withPrefix)
  //                             ? Padding(
  //                                 padding: EdgeInsets.only(right: 3.w),
  //                                 child: getSvgImage(
  //                                     context, imgName, getEditIconSize()),
  //                               )
  //                             : getHorSpace(0),
  //                         border: UnderlineInputBorder(
  //                             borderSide:
  //                                 BorderSide(color: getAccentColor(context))),
  //                         focusedBorder: UnderlineInputBorder(
  //                             borderSide:
  //                                 BorderSide(color: getAccentColor(context))),
  //
  //                         // border: InputBorder.none,
  //                         isDense: true,
  //                         // focusedBorder: InputBorder.none,
  //                         // enabledBorder: InputBorder.none,
  //                         // errorBorder: InputBorder.none,
  //                         // disabledBorder: InputBorder.none,
  //                         hintText: s,
  //                         // prefixIconConstraints: const BoxConstraints(minHeight: 0, minWidth: 0),
  //                         hintStyle: TextStyle(
  //                             fontFamily: Constant.fontsFamily,
  //                             color: getFontHint(context),
  //                             fontWeight: FontWeight.w400,
  //                             fontSize: getEditFontSizeFigma().sp)),
  //                   )),
  //             // child: MediaQuery(
  //             //   data: mqDataNew,
  //             // child: IntrinsicHeight(
  //             // child: IntrinsicHeight(
  //             //   child: Align(
  //             //     alignment: (minLines)?Alignment.topLeft:Alignment.centerLeft,
  //             // ),
  //             // ),
  //             // ),
  //           )),
  //       // child: MediaQuery(
  //       //     data: mqDataNew,
  //       //     child: Focus(
  //       //         onFocusChange: (hasFocus) {
  //       //           if (hasFocus) {
  //       //             setState(() {
  //       //               isAutoFocus = true;
  //       //               myFocusNode.canRequestFocus = true;
  //       //             });
  //       //           } else {
  //       //             setState(() {
  //       //               isAutoFocus = false;
  //       //               myFocusNode.canRequestFocus = false;
  //       //             });
  //       //           }
  //       //         },
  //       //         child: SizedBox(
  //       //           height: double.infinity,
  //       //           child: (minLines)
  //       //               ? TextField(
  //       //                   // minLines: null,
  //       //                   // maxLines: null,
  //       //                   maxLines: (minLines) ? null : 1,
  //       //                   controller: textEditingController,
  //       //                   autofocus: false,
  //       //                   focusNode: myFocusNode,
  //       //                   textAlign: TextAlign.start,
  //       //                   // expands: true,
  //       //                   expands: minLines,
  //       //                   // textAlignVertical:(minLines)?TextAlignVertical.top:TextAlignVertical.center,
  //       //                   style: TextStyle(
  //       //                       fontFamily: Constant.fontsFamily,
  //       //                       color: fontColor,
  //       //                       fontWeight: FontWeight.w400,
  //       //                       fontSize: getEditFontSizeFigma()),
  //       //                   decoration: InputDecoration(
  //       //                       prefixIconConstraints: const BoxConstraints(
  //       //                         minWidth: 0,
  //       //                         minHeight: 0,
  //       //                       ),
  //       //                       filled: true,
  //       //                       // fillColor: Colors.green,
  //       //                       prefixIcon: (withPrefix)
  //       //                           ? Padding(
  //       //                               padding: EdgeInsets.only(
  //       //                                   right: 3.w),
  //       //                               child: getSvgImage(
  //       //                                   context, imgName, getEditIconSize()),
  //       //                             )
  //       //                           : getHorSpace(0),
  //       //                       border: UnderlineInputBorder(
  //       //                           borderSide: BorderSide(
  //       //                               color: getAccentColor(context))),
  //       //                       focusedBorder: UnderlineInputBorder(
  //       //                           borderSide: BorderSide(
  //       //                               color: getAccentColor(context))),
  //       //                       // border: InputBorder.none,
  //       //                       isDense: true,
  //       //                       // focusedBorder: InputBorder.none,
  //       //                       // enabledBorder: InputBorder.none,
  //       //                       // errorBorder: InputBorder.none,
  //       //                       // disabledBorder: InputBorder.none,
  //       //                       hintText: s,
  //       //                       // prefixIconConstraints: const BoxConstraints(minHeight: 0, minWidth: 0),
  //       //                       hintStyle: TextStyle(
  //       //                           fontFamily: Constant.fontsFamily,
  //       //                           color: getFontHint(context),
  //       //                           fontWeight: FontWeight.w400,
  //       //                           fontSize: getEditFontSizeFigma())),
  //       //                 )
  //       //               : Center(
  //       //                   child: TextField(
  //       //                   // minLines: null,
  //       //                   // maxLines: null,
  //       //                   maxLines: (minLines) ? null : 1,
  //       //                   controller: textEditingController,
  //       //                   autofocus: false,
  //       //                   focusNode: myFocusNode,
  //       //                   textAlign: TextAlign.start,
  //       //                   // expands: true,
  //       //                   expands: minLines,
  //       //                   // textAlignVertical:(minLines)?TextAlignVertical.top:TextAlignVertical.center,
  //       //                   style: TextStyle(
  //       //                       fontFamily: Constant.fontsFamily,
  //       //                       color: fontColor,
  //       //                       fontWeight: FontWeight.w400,
  //       //                       fontSize: getEditFontSizeFigma()),
  //       //                   decoration: InputDecoration(
  //       //                       prefixIconConstraints: const BoxConstraints(
  //       //                         minWidth: 0,
  //       //                         minHeight: 0,
  //       //                       ),
  //       //                       // filled: true,
  //       //                       // fillColor: Colors.green,
  //       //                       prefixIcon: (withPrefix)
  //       //                           ? Padding(
  //       //                               padding: EdgeInsets.only(
  //       //                                   right: 3.w),
  //       //                               child: getSvgImage(
  //       //                                   context, imgName, getEditIconSize()),
  //       //                             )
  //       //                           : getHorSpace(0),
  //       //                       border: UnderlineInputBorder(
  //       //                           borderSide: BorderSide(
  //       //                               color: getAccentColor(context))),
  //       //                       focusedBorder: UnderlineInputBorder(
  //       //                           borderSide: BorderSide(
  //       //                               color: getAccentColor(context))),
  //       //
  //       //                       // border: InputBorder.none,
  //       //                       isDense: true,
  //       //                       // focusedBorder: InputBorder.none,
  //       //                       // enabledBorder: InputBorder.none,
  //       //                       // errorBorder: InputBorder.none,
  //       //                       // disabledBorder: InputBorder.none,
  //       //                       hintText: s,
  //       //                       // prefixIconConstraints: const BoxConstraints(minHeight: 0, minWidth: 0),
  //       //                       hintStyle: TextStyle(
  //       //                           fontFamily: Constant.fontsFamily,
  //       //                           color: getFontHint(context),
  //       //                           fontWeight: FontWeight.w400,
  //       //                           fontSize: getEditFontSizeFigma())),
  //       //                 )),
  //       //           // child: MediaQuery(
  //       //           //   data: mqDataNew,
  //       //           // child: IntrinsicHeight(
  //       //           // child: IntrinsicHeight(
  //       //           //   child: Align(
  //       //           //     alignment: (minLines)?Alignment.topLeft:Alignment.centerLeft,
  //       //           // ),
  //       //           // ),
  //       //           // ),
  //       //         ))),
  //       // child: MediaQuery(
  //       //     data: mqDataNew,
  //       //     child: Container(
  //       //       height:double.infinity,
  //       //       // color: Colors.red,
  //       //       child: IntrinsicHeight(
  //       //         // child: IntrinsicHeight(
  //       //         child: TextField(
  //       //           maxLines: (minLines) ? null : 1,
  //       //           controller: textEditingController,
  //       //           autofocus: false,
  //       //           focusNode: myFocusNode,
  //       //           textAlign: TextAlign.start,
  //       //           // textAlignVertical: TextAlignVertical.center,
  //       //           style: TextStyle(
  //       //               fontFamily: Constant.fontsFamily,
  //       //               color: fontColor,
  //       //               fontWeight: FontWeight.w400,
  //       //               fontSize: getEditFontSizeFigma()),
  //       //           decoration: InputDecoration(
  //       //               prefixIconConstraints: const BoxConstraints(
  //       //                 minWidth: 0,
  //       //                 minHeight: 0,
  //       //               ),
  //       //               // filled: true,
  //       //               // fillColor: Colors.green,
  //       //               prefixIcon: (withPrefix)
  //       //                   ? Padding(
  //       //                 padding: EdgeInsets.only(
  //       //                     right: FetchPixels.getPixelWidth(3)),
  //       //                 child: getSvgImage(
  //       //                     context, imgName, getEditIconSize()),
  //       //               )
  //       //                   : getHorSpace(0),
  //       //               border: InputBorder.none,
  //       //               isDense: true,
  //       //               focusedBorder: InputBorder.none,
  //       //               enabledBorder: InputBorder.none,
  //       //               errorBorder: InputBorder.none,
  //       //               disabledBorder: InputBorder.none,
  //       //               hintText: s,
  //       //               // prefixIconConstraints: const BoxConstraints(minHeight: 0, minWidth: 0),
  //       //               hintStyle: TextStyle(
  //       //                   fontFamily: Constant.fontsFamily,
  //       //                   color: getFontHint(context),
  //       //                   fontWeight: FontWeight.w400,
  //       //                   fontSize: getEditFontSizeFigma())),
  //       //         ),
  //       //         // ),
  //       //       ),
  //       //     ))),
  //     );
  //
  //     //   getTextFieldView(
  //     //     context,
  //     //     MediaQuery(
  //     //         data: mqDataNew,
  //     //         child: Focus(
  //     //             onFocusChange: (hasFocus) {
  //     //               if (hasFocus) {
  //     //                 setState(() {
  //     //                   isAutoFocus = true;
  //     //                   myFocusNode.canRequestFocus = true;
  //     //                 });
  //     //               } else {
  //     //                 setState(() {
  //     //                   isAutoFocus = false;
  //     //                   myFocusNode.canRequestFocus = false;
  //     //                 });
  //     //               }
  //     //             },
  //     //             child: SizedBox(
  //     //               height: double.infinity,
  //     //               child: (minLines)
  //     //                   ? TextField(
  //     //                 // minLines: null,
  //     //                 // maxLines: null,
  //     //                 maxLines: (minLines) ? null : 1,
  //     //                 controller: textEditingController,
  //     //                 autofocus: false,
  //     //                 focusNode: myFocusNode,
  //     //                 textAlign: TextAlign.start,
  //     //                 // expands: true,
  //     //                 expands: minLines,
  //     //                 // textAlignVertical:(minLines)?TextAlignVertical.top:TextAlignVertical.center,
  //     //                 style: TextStyle(
  //     //                     fontFamily: Constant.fontsFamily,
  //     //                     color: fontColor,
  //     //                     fontWeight: FontWeight.w400,
  //     //                     fontSize: getEditFontSizeFigma()),
  //     //                 decoration: InputDecoration(
  //     //                     prefixIconConstraints: const BoxConstraints(
  //     //                       minWidth: 0,
  //     //                       minHeight: 0,
  //     //                     ),
  //     //                     // filled: true,
  //     //                     // fillColor: Colors.green,
  //     //                     prefixIcon: (withPrefix)
  //     //                         ? Padding(
  //     //                       padding: EdgeInsets.only(
  //     //                           right:
  //     //                           FetchPixels.getPixelWidth(3)),
  //     //                       child: getSvgImage(context, imgName,
  //     //                           getEditIconSize()),
  //     //                     )
  //     //                         : getHorSpace(0),
  //     //                     border: InputBorder.none,
  //     //                     isDense: true,
  //     //                     focusedBorder: InputBorder.none,
  //     //                     enabledBorder: InputBorder.none,
  //     //                     errorBorder: InputBorder.none,
  //     //                     disabledBorder: InputBorder.none,
  //     //                     hintText: s,
  //     //                     // prefixIconConstraints: const BoxConstraints(minHeight: 0, minWidth: 0),
  //     //                     hintStyle: TextStyle(
  //     //                         fontFamily: Constant.fontsFamily,
  //     //                         color: getFontHint(context),
  //     //                         fontWeight: FontWeight.w400,
  //     //                         fontSize: getEditFontSizeFigma())),
  //     //               )
  //     //                   : Center(
  //     //                   child: TextField(
  //     //                     // minLines: null,
  //     //                     // maxLines: null,
  //     //                     maxLines: (minLines) ? null : 1,
  //     //                     controller: textEditingController,
  //     //                     autofocus: false,
  //     //                     focusNode: myFocusNode,
  //     //                     textAlign: TextAlign.start,
  //     //                     // expands: true,
  //     //                     expands: minLines,
  //     //                     // textAlignVertical:(minLines)?TextAlignVertical.top:TextAlignVertical.center,
  //     //                     style: TextStyle(
  //     //                         fontFamily: Constant.fontsFamily,
  //     //                         color: fontColor,
  //     //                         fontWeight: FontWeight.w400,
  //     //                         fontSize: getEditFontSizeFigma()),
  //     //                     decoration: InputDecoration(
  //     //                         prefixIconConstraints: const BoxConstraints(
  //     //                           minWidth: 0,
  //     //                           minHeight: 0,
  //     //                         ),
  //     //                         // filled: true,
  //     //                         // fillColor: Colors.green,
  //     //                         prefixIcon: (withPrefix)
  //     //                             ? Padding(
  //     //                           padding: EdgeInsets.only(
  //     //                               right:
  //     //                               FetchPixels.getPixelWidth(3)),
  //     //                           child: getSvgImage(context, imgName,
  //     //                               getEditIconSize()),
  //     //                         )
  //     //                             : getHorSpace(0),
  //     //                         border: InputBorder.none,
  //     //                         isDense: true,
  //     //                         focusedBorder: InputBorder.none,
  //     //                         enabledBorder: InputBorder.none,
  //     //                         errorBorder: InputBorder.none,
  //     //                         disabledBorder: InputBorder.none,
  //     //                         hintText: s,
  //     //                         // prefixIconConstraints: const BoxConstraints(minHeight: 0, minWidth: 0),
  //     //                         hintStyle: TextStyle(
  //     //                             fontFamily: Constant.fontsFamily,
  //     //                             color: getFontHint(context),
  //     //                             fontWeight: FontWeight.w400,
  //     //                             fontSize: getEditFontSizeFigma())),
  //     //                   )),
  //     //               // child: MediaQuery(
  //     //               //   data: mqDataNew,
  //     //               // child: IntrinsicHeight(
  //     //               // child: IntrinsicHeight(
  //     //               //   child: Align(
  //     //               //     alignment: (minLines)?Alignment.topLeft:Alignment.centerLeft,
  //     //               // ),
  //     //               // ),
  //     //               // ),
  //     //             ))),
  //     //     minLines,
  //     //     margin);
  //     // //   MediaQuery(
  //     // //   data: mqDataNew,
  //     // //   child: getTextFieldView(context, Focus(
  //     // //       onFocusChange: (hasFocus) {
  //     // //         if (hasFocus) {
  //     // //           setState(() {
  //     // //             isAutoFocus = true;
  //     // //             myFocusNode.canRequestFocus = true;
  //     // //           });
  //     // //         } else {
  //     // //           setState(() {
  //     // //             isAutoFocus = false;
  //     // //             myFocusNode.canRequestFocus = false;
  //     // //           });
  //     // //         }
  //     // //       },
  //     // //       child: SizedBox(
  //     // //         height: double.infinity,
  //     // //         child: (minLines)
  //     // //             ? TextField(
  //     // //           // minLines: null,
  //     // //           // maxLines: null,
  //     // //           maxLines: (minLines) ? null : 1,
  //     // //           controller: textEditingController,
  //     // //           autofocus: false,
  //     // //           focusNode: myFocusNode,
  //     // //           textAlign: TextAlign.start,
  //     // //           // expands: true,
  //     // //           expands: minLines,
  //     // //           // textAlignVertical:(minLines)?TextAlignVertical.top:TextAlignVertical.center,
  //     // //           style: TextStyle(
  //     // //               fontFamily: Constant.fontsFamily,
  //     // //               color: fontColor,
  //     // //               fontWeight: FontWeight.w400,
  //     // //               fontSize: getEditFontSizeFigma()),
  //     // //           decoration: InputDecoration(
  //     // //               prefixIconConstraints: const BoxConstraints(
  //     // //                 minWidth: 0,
  //     // //                 minHeight: 0,
  //     // //               ),
  //     // //               // filled: true,
  //     // //               // fillColor: Colors.green,
  //     // //               prefixIcon: (withPrefix)
  //     // //                   ? Padding(
  //     // //                 padding: EdgeInsets.only(
  //     // //                     right: FetchPixels.getPixelWidth(3)),
  //     // //                 child: getSvgImage(
  //     // //                     context, imgName, getEditIconSize()),
  //     // //               )
  //     // //                   : getHorSpace(0),
  //     // //               border: InputBorder.none,
  //     // //               isDense: true,
  //     // //               focusedBorder: InputBorder.none,
  //     // //               enabledBorder: InputBorder.none,
  //     // //               errorBorder: InputBorder.none,
  //     // //               disabledBorder: InputBorder.none,
  //     // //               hintText: s,
  //     // //               // prefixIconConstraints: const BoxConstraints(minHeight: 0, minWidth: 0),
  //     // //               hintStyle: TextStyle(
  //     // //                   fontFamily: Constant.fontsFamily,
  //     // //                   color: getFontHint(context),
  //     // //                   fontWeight: FontWeight.w400,
  //     // //                   fontSize: getEditFontSizeFigma())),
  //     // //         )
  //     // //             : Center(
  //     // //             child: TextField(
  //     // //               // minLines: null,
  //     // //               // maxLines: null,
  //     // //               maxLines: (minLines) ? null : 1,
  //     // //               controller: textEditingController,
  //     // //               autofocus: false,
  //     // //               focusNode: myFocusNode,
  //     // //               textAlign: TextAlign.start,
  //     // //               // expands: true,
  //     // //               expands: minLines,
  //     // //               // textAlignVertical:(minLines)?TextAlignVertical.top:TextAlignVertical.center,
  //     // //               style: TextStyle(
  //     // //                   fontFamily: Constant.fontsFamily,
  //     // //                   color: fontColor,
  //     // //                   fontWeight: FontWeight.w400,
  //     // //                   fontSize: getEditFontSizeFigma()),
  //     // //               decoration: InputDecoration(
  //     // //                   prefixIconConstraints: const BoxConstraints(
  //     // //                     minWidth: 0,
  //     // //                     minHeight: 0,
  //     // //                   ),
  //     // //                   // filled: true,
  //     // //                   // fillColor: Colors.green,
  //     // //                   prefixIcon: (withPrefix)
  //     // //                       ? Padding(
  //     // //                     padding: EdgeInsets.only(
  //     // //                         right: FetchPixels.getPixelWidth(3)),
  //     // //                     child: getSvgImage(
  //     // //                         context, imgName, getEditIconSize()),
  //     // //                   )
  //     // //                       : getHorSpace(0),
  //     // //                   border: InputBorder.none,
  //     // //                   isDense: true,
  //     // //                   focusedBorder: InputBorder.none,
  //     // //                   enabledBorder: InputBorder.none,
  //     // //                   errorBorder: InputBorder.none,
  //     // //                   disabledBorder: InputBorder.none,
  //     // //                   hintText: s,
  //     // //                   // prefixIconConstraints: const BoxConstraints(minHeight: 0, minWidth: 0),
  //     // //                   hintStyle: TextStyle(
  //     // //                       fontFamily: Constant.fontsFamily,
  //     // //                       color: getFontHint(context),
  //     // //                       fontWeight: FontWeight.w400,
  //     // //                       fontSize: getEditFontSizeFigma())),
  //     // //             )),
  //     // //         // child: MediaQuery(
  //     // //         //   data: mqDataNew,
  //     // //         // child: IntrinsicHeight(
  //     // //         // child: IntrinsicHeight(
  //     // //         //   child: Align(
  //     // //         //     alignment: (minLines)?Alignment.topLeft:Alignment.centerLeft,
  //     // //         // ),
  //     // //         // ),
  //     // //         // ),
  //     // //       )), minLines, margin),
  //     // // );
  //   },
  // );
}

Widget getPassTextFiled(
    BuildContext context,
    String s,
    TextEditingController textEditingController,
    Color fontColor,
    bool showPass,
    Function function,
    {String imgName = "pass.svg",
    bool minLines = false,
    FormFieldValidator? validator,
    bool isFilled = false,
    EdgeInsetsGeometry margin = EdgeInsets.zero}) {
  double height = getEditHeightFigma();

  // FocusNode myFocusNode = FocusNode();
  return SizedBox(
    height: height,
    width: double.infinity,
    child: TextFormField(
      maxLines: (minLines) ? null : 1,
      controller: textEditingController,
      autofocus: false,
      validator: validator,
      obscureText: (showPass) ? false : true,
      textAlign: TextAlign.start,
      // expands: minLines,
      style: TextStyle(
          fontFamily: Constant.fontsFamily,
          color: fontColor,
          fontWeight: FontWeight.w400,
          fontSize: getEditFontSizeFigma().sp),
      decoration: InputDecoration(
          // prefixIcon: getSvgImageWithSize(
          //         context, imgName, getEditIconSize().h, getEditIconSize().h)
          //     .marginOnly(left: 20.w, right: 14.w),
          // // prefixIcon: (withPrefix)?getSvgImage(context, imgName, getEditIconSize()):0.horizontalSpace,
          // prefixIconConstraints: BoxConstraints(
          //   minWidth: 20.w,
          //   minHeight: 0,
          //   maxWidth: getEditIconSize().h + (20.w + 14.w),
          //   maxHeight: getEditIconSize().h,
          // ),
          // prefixIcon: (withPrefix)?getSvgImage(context, imgName, getEditIconSize()):0.horizontalSpace,
          // prefixIconConstraints: const BoxConstraints(
          //   minWidth: 0,
          //   minHeight: 0,
          // ),
          contentPadding: EdgeInsets.only(left: 20.w),
          // filled: true,
          // fillColor: Colors.green,
          // prefixIcon: (withPrefix)
          //     ? Padding(
          //         padding: EdgeInsets.only(right: 3.w),
          //         child: getSvgImage(context, imgName, getEditIconSize()),
          //       )
          //     : getHorSpace(0),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: (isFilled)
                      ? Colors.transparent
                      : getDividerColor(context),
                  width: 1.h),
              borderRadius: BorderRadius.all(Radius.circular(20.h))),
          disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: (isFilled)
                      ? Colors.transparent
                      : getDividerColor(context),
                  width: 1.h),
              borderRadius: BorderRadius.all(Radius.circular(20.h))),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: (isFilled)
                      ? Colors.transparent
                      : getDividerColor(context),
                  width: 1.h),
              borderRadius: BorderRadius.all(Radius.circular(20.h))),
          border: OutlineInputBorder(
              borderSide: BorderSide(
                  color: (isFilled)
                      ? Colors.transparent
                      : getDividerColor(context),
                  width: 1.h),
              borderRadius: BorderRadius.all(Radius.circular(20.h))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color:
                      (isFilled) ? Colors.transparent : getAccentColor(context),
                  width: 1.h),
              borderRadius: BorderRadius.all(Radius.circular(20.h))),
          hintText: s,
          hintStyle: TextStyle(
              fontFamily: Constant.fontsFamily,
              color: getFontHint(context),
              fontWeight: FontWeight.w400,
              fontSize: getEditFontSizeFigma().sp)),
    ).marginSymmetric(horizontal: FetchPixels.getDefaultHorSpaceFigma(context)),
  );
}

// Widget getMediaQueryWidget(BuildContext context, Widget widget) {
//   final mqData = MediaQuery.of(context);
//   final mqDataNew = mqData.copyWith(textScaleFactor: FetchPixels.getTextScale());
//   return MediaQuery(child: widget, data: mqDataNew);
// }

Widget getPaddingWidget(EdgeInsets edgeInsets, Widget widget) {
  return Padding(
    padding: edgeInsets,
    child: widget,
  );
}

AppBar getInVisibleAppBar({Color color = Colors.transparent}) {
  return AppBar(
    toolbarHeight: 0,
    elevation: 0,
    backgroundColor: color,
  );
}

double getToolbarTopViewHeight(BuildContext context) {
  return MediaQuery.of(context).viewPadding.top;
}

WillPopScope buildTitleDefaultWidget(
    BuildContext context, String title, Function backClick, Widget widget) {
  return WillPopScope(
      child: Scaffold(
        backgroundColor: getCurrentTheme(context).scaffoldBackgroundColor,
        body: Stack(
          children: [
            SizedBox(
              height: 260.h,
              width: double.infinity,
              child: Stack(
                alignment: Alignment.bottomCenter,
                fit: StackFit.expand,
                children: [
                  Positioned(
                      left: -108.h,
                      top: -30.h,
                      child: SizedBox(
                          height: 232.h,
                          width: 229.h,
                          child: Align(
                              alignment: Alignment.topLeft,
                              child: getSvgImage(
                                  context, "Paw_Print.svg", double.infinity)))),
                  Positioned(
                      right: -108.h,
                      child: SizedBox(
                          height: 180.h,
                          width: 177.w,
                          child: Align(
                              alignment: Alignment.bottomRight,
                              child: getSvgImage(
                                  context, "Paw_Print.svg", double.infinity)))),
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        getSvgImageWithSize(context, "Logo1.svg", 60.h, 60.h,
                            fit: BoxFit.fill),
                        8.h.verticalSpace,
                        getCustomFont(title, 26, getFontColor(context), 1,
                            fontWeight: FontWeight.w700,
                            textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                ],
              ).paddingOnly(bottom: 30.h),
            ),
            ListView(
              padding: EdgeInsets.only(top: 240.h),
              shrinkWrap: true,
              children: [widget],
            )
          ],
        ),
      ),
      onWillPop: () async {
        backClick();
        return false;
      });
}

Container getSmoothImage(BuildContext context, String img, double width,
    double height, double corner,
    {BoxFit fit = BoxFit.fill}) {
  print("image---$img");
  return Container(
    height: height,
    width: width,
    decoration: ShapeDecoration(
        // color: Colors.grey,
        shape: SmoothRectangleBorder(
            borderRadius:
                SmoothBorderRadius(cornerRadius: corner, cornerSmoothing: 0.9)),
        image: getDecorationNetworkImage(context, img, fit: fit)),
  );
}

Widget buildBestSellingItem(BuildContext context, WooProduct product,
    double width, double height, Function function,
    {EdgeInsets margin = EdgeInsets.zero, bool isfav = false}) {
  return InkWell(
    onTap: () {
      function();
    },
    child: Container(
      padding: EdgeInsets.all(9.w),
      margin: margin,
      width: width,
      height: height,
      decoration: getButtonDecoration(getCardColor(context),
          corner: 22.h,
          withCorners: true,
          shadow: [
            const BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.11999999731779099),
                offset: Offset(0, 6),
                blurRadius: 23)
          ]),
      child: Row(
        children: [
          getSmoothImage(context, product.images[0].src ?? "", 112.w,
              double.infinity, 18.w,
              fit: BoxFit.cover),
          12.w.horizontalSpace,
          Expanded(
            flex: 1,
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getCustomFont(
                        product.name ?? "", 16, getFontColor(context), 1,
                        fontWeight: FontWeight.w400),
                    8.w.verticalSpace,
                    getCustomFont(
                        "${Constant.getCurrency(context)}${product.salePrice ?? ""}",
                        16,
                        getFontColor(context),
                        1,
                        fontWeight: FontWeight.w600),
                    8.w.verticalSpace,
                    Row(
                      children: [
                        getSvgImageWithSize(context, "star.svg", 16.w, 16.w),
                        6.w.horizontalSpace,
                        Expanded(
                          flex: 1,
                          child: getCustomFont(
                              "(${product.ratingCount.toString()})",
                              14,
                              getFontColor(context),
                              1,
                              fontWeight: FontWeight.w400),
                        )
                      ],
                    )
                  ],
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: buildFavButton(context,
                      isFav: isfav, color: getGreyCardColor(context)),
                )
              ],
            ),
          )
        ],
      ),
    ),
  );
}

Widget buildCartItem(
    BuildContext context,
    WooProduct product,
    double width,
    double height,
    Function function,
    int quantity,
    Function functionAdd,
    Function functionRemove,
    {EdgeInsets margin = EdgeInsets.zero}) {
  return InkWell(
    onTap: () {
      function();
    },
    child: Container(
      padding: EdgeInsets.all(9.w),
      margin: margin,
      width: width,
      height: height,
      decoration: getButtonDecoration(getCardColor(context),
          corner: 22.h,
          withCorners: true,
          shadow: [
            const BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.11999999731779099),
                offset: Offset(0, 6),
                blurRadius: 23)
          ]),
      child: Row(
        children: [
          getSmoothImage(context, product.images[0].src ?? "", 112.w,
              double.infinity, 18.w,
              fit: BoxFit.cover),
          12.w.horizontalSpace,
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getCustomFont(product.name ?? "", 16, getFontColor(context), 1,
                    fontWeight: FontWeight.w400),
                8.w.verticalSpace,
                getCustomFont(
                    "${Constant.getCurrency(context)}${product.salePrice ?? ""}",
                    16,
                    getFontColor(context),
                    1,
                    fontWeight: FontWeight.w600),
                8.w.verticalSpace,
                Row(
                  children: [
                    getSvgImageWithSize(context, "star.svg", 16.w, 16.w),
                    6.w.horizontalSpace,
                    Expanded(
                      flex: 1,
                      child: getCustomFont(
                          "(${product.ratingCount.toString()})",
                          14,
                          getFontColor(context),
                          1,
                          fontWeight: FontWeight.w400),
                    )
                  ],
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(2.w),
            decoration: getButtonDecoration(getGreyCardColor(context),
                withCorners: true, corner: 13.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                buildCartQuantityBtn(context, "minus.svg", functionRemove,
                    bgColor: getCardColor(context),
                    iconColor: getFontColor(context)),
                getCustomFont(quantity.toString(), 16, getFontColor(context), 1,
                        fontWeight: FontWeight.w400)
                    .marginSymmetric(vertical: 5.w),
                buildCartQuantityBtn(context, "add.svg", functionAdd,
                    bgColor: getAccentColor(context), iconColor: Colors.white),
              ],
            ),
          )
        ],
      ),
    ),
  );
}

Widget buildBuyNowCartItem(
    BuildContext context,
    WooCartItem product,
    double width,
    double height,
    Function function,
    int quantity,
    Function functionAdd,
    Function functionRemove,
    {EdgeInsets margin = EdgeInsets.zero}) {
  return InkWell(
    onTap: () {
      function();
    },
    child: Container(
      padding: EdgeInsets.all(9.w),
      margin: margin,
      width: width,
      height: height,
      decoration: getButtonDecoration(getCardColor(context),
          corner: 22.h,
          withCorners: true,
          shadow: [
            const BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.11999999731779099),
                offset: Offset(0, 6),
                blurRadius: 23)
          ]),
      child: Row(
        children: [
          getSmoothImage(context, product.images![0].src ?? "", 112.w,
              double.infinity, 18.w,
              fit: BoxFit.cover),
          12.w.horizontalSpace,
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getCustomFont(product.name ?? "", 16, getFontColor(context), 1,
                    fontWeight: FontWeight.w400),

                8.w.verticalSpace,

                getCustomFont(
                    "${Constant.getCurrency(context)}${product.prices!.salePrice ?? ""}",
                    16,
                    getFontColor(context),
                    1,
                    fontWeight: FontWeight.w600),

                // 8.w.verticalSpace,
                // Row(
                //   children: [
                //     getSvgImageWithSize(context, "star.svg", 16.w, 16.w),
                //     6.w.horizontalSpace,
                //     Expanded(
                //       flex: 1,
                //       child: getCustomFont(
                //           "(${product.prices!.currencySymbol.toString()} ${product.prices!.salePrice.toString()})",
                //           14,
                //           getFontColor(context),
                //           1,
                //           fontWeight: FontWeight.w400),
                //     )
                //   ],
                // )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(2.w),
            decoration: getButtonDecoration(getGreyCardColor(context),
                withCorners: true, corner: 13.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                buildCartQuantityBtn(context, "minus.svg", functionRemove,
                    bgColor: getCardColor(context),
                    iconColor: getFontColor(context)),
                getCustomFont(quantity.toString(), 16, getFontColor(context), 1,
                        fontWeight: FontWeight.w400)
                    .marginSymmetric(vertical: 5.w),
                buildCartQuantityBtn(context, "add.svg", functionAdd,
                    bgColor: getAccentColor(context), iconColor: Colors.white),
              ],
            ),
          )
        ],
      ),
    ),
  );
}

Widget getCardView(BuildContext context, Widget child) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.symmetric(
        horizontal: FetchPixels.getDefaultHorSpaceFigma(context),
        vertical: 10.h),
    decoration: getButtonDecoration(getCardColor(context),
        withCorners: true,
        corner: 22.h,
        shadow: [
          const BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.11999999731779099),
              offset: Offset(0, 6),
              blurRadius: 23)
        ]),
    child: child,
  );
}

Widget buildMyCartItem(
    BuildContext context,
    ModelCart product,
    // double width,
    double height,
    Function function,
    // String quantity,
    // Function functionAdd,
    // Function functionRemove,
    // Function removeCart,
    {EdgeInsets margin = EdgeInsets.zero}) {
  return InkWell(
    onTap: () {
      function();
    },
    child: SizedBox(
      height: height,
      width: double.infinity,
      child: Row(
        children: [
          Container(
              height: height,
              width: height,
              padding: EdgeInsets.all(12.h),
              decoration: getButtonDecoration(getGreyCardColor(context),
                  withCorners: true, corner: 12.h),
              child: getAssetImage(
                  context, product.image, double.infinity, double.infinity)),
          getHorSpace(14.h),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getCustomFont(product.name, 17, getFontColor(context), 1,
                    fontWeight: FontWeight.w700),
                getVerSpace(10.h),
                product.attribute != null && product.attribute!.isNotEmpty
                    ? Container(
                        margin: EdgeInsets.only(bottom: 10.h),
                        height: 22.h,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          // padding: EdgeInsets.symmetric(vertical: 4.h),
                          itemCount: product.attribute!.length,
                          itemBuilder: (context, index) {
                            return Container(
                              height: 22.h,
                              padding: EdgeInsets.only(
                                  left: (index == 0) ? 0.h : 10.h,
                                  right:
                                      (index == product.attribute!.length - 1)
                                          ? 0.h
                                          : 10.h),
                              decoration: BoxDecoration(
                                  border: Border(
                                      right: BorderSide(
                                          width: 1,
                                          color: (index ==
                                                  product.attribute!.length - 1)
                                              ? Colors.transparent
                                              : Colors.grey.shade300))),
                              child: Row(
                                children: [
                                  getCustomFont(
                                      "${product.attribute!.keys.elementAt(index)} : ",
                                      14,
                                      getFontColor(context),
                                      1,
                                      fontWeight: FontWeight.w500),
                                  getCustomFont(
                                      product.attribute!.values
                                          .elementAt(index),
                                      14,
                                      black40,
                                      1,
                                      fontWeight: FontWeight.w400),
                                ],
                              ),
                            );
                          },
                        ),
                      )
                    : 0.h.verticalSpace,
                getCustomFont(
                    product.price,
                    // "${Constant.getCurrency(context)}${product.prices!.salePrice ?? ""}",
                    15,
                    getFontColor(context),
                    1,
                    fontWeight: FontWeight.w400),
              ],
            ),
          ),
          Align(
              alignment: Alignment.bottomRight,
              child: getCustomFont(
                  "Qty : ${product.qty}", 16, getFontColor(context), 1,
                  fontWeight: FontWeight.w400)),
        ],
      ),
    ),
  );
}

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

Widget buildCartQuantityBtn(
    BuildContext context, String image, Function function,
    {Color bgColor = Colors.white, Color iconColor = Colors.black}) {
  return
      // Material(
      // shape: CircleBorder(),
      // clipBehavior: Clip.hardEdge,
      // color: Colors.transparent,
      // child:
      InkWell(
    onTap: () {
      function();
    },
    child: Center(
      child: getSvgImageWithSize(context, image, 16.w, 16.w, color: iconColor),
    ),
  );
}

Widget buildNewArrivalItem(
  BuildContext context,
  double width,
  double height,
  WooProduct product,
  Function function,
  Function favFunction, {
  EdgeInsets margin = EdgeInsets.zero,
  bool withFav = false,
  bool isFav = false,
}) {
  return InkWell(
    onTap: () {
      function();
    },
    child: Container(
      // color: Colors.transparent,
      margin: margin,
      width: width,
      height: height,
      padding: EdgeInsets.all(6.w),
      decoration: getButtonDecoration(getCardColor(context),
          withCorners: true,
          corner: 22.w,
          shadow: [
            const BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.11999999731779099),
                offset: Offset(0, 6),
                blurRadius: 23)
          ]),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  flex: 1,
                  child: getSmoothImage(
                      context,
                      (product.images.isNotEmpty)
                          ? product.images[0].src ?? ""
                          : "",
                      double.infinity,
                      double.infinity,
                      22.w,
                      fit: BoxFit.cover)
                  // getCircularNetworkImage(context, double.infinity,
                  //     double.infinity, 22.h, product.images[0].src ?? "",
                  //     boxFit: BoxFit.cover),
                  ),
              8.w.verticalSpace,
              getCustomFont(product.name ?? "", 19, getFontColor(context), 1,
                      fontWeight: FontWeight.w700, txtHeight: 1.24)
                  .marginSymmetric(horizontal: 6.w),
              4.w.verticalSpace,
              Row(
                children: [
                  getCustomFont(
                      (product.salePrice != null &&
                              product.salePrice!.isNotEmpty)
                          ? Constant.formatStringCurrency(
                              total: product.salePrice, context: context)
                          : Constant.formatStringCurrency(
                              total: product.regularPrice, context: context),
                      // "${Constant.getCurrency(context)}${product.salePrice}",
                      18,
                      getFontColor(context),
                      1,
                      fontWeight: FontWeight.w500,
                      txtHeight: 1.24),
                  8.w.horizontalSpace,
                  ((product.salePrice != null && product.salePrice!.isNotEmpty))
                      ? Expanded(
                          flex: 1,
                          child: getCustomFont(
                            Constant.formatStringCurrency(
                                total: product.regularPrice, context: context),
                            // "${Constant.getCurrency(context)}${product.regularPrice}",
                            18,
                            getFontColor(context),
                            1,
                            fontWeight: FontWeight.w400,
                            decoration: TextDecoration.lineThrough,
                            txtHeight: 1.24,
                          ))
                      : 0.horizontalSpace
                ],
              ).marginSymmetric(horizontal: 6.w),
              2.w.verticalSpace
            ],
          ),
          (withFav)
              ? Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {
                      favFunction();
                    },
                    child: buildFavButton(context,
                            isFav: isFav, color: getGreyCardColor(context))
                        .marginOnly(right: 8.w, top: 8.w),
                  ),
                )
              : 0.verticalSpace
        ],
      ),
    ),
  );
}

AppBar getTitleAppBar(BuildContext context, Function backClick,
    {Color color = Colors.transparent,
    String title = "",
    Color fontColor = Colors.white,
    Color iconColor = Colors.black,
    bool centerTitle = false,
    bool isCartAvailable = true,
    bool isFilterAvailable = false,
    bool withBack = true,
    ValueChanged? filterFun}) {
  return AppBar(
    centerTitle: centerTitle,
    title: getCustomFont(title, 22, getFontColor(context), 1,
        fontWeight: FontWeight.w700),
    backgroundColor: Colors.transparent,
    elevation: 0,
    // getSvgImageWithSize(context, "Logo.svg", 86.h, 73.h, fit: BoxFit.fill)
    //     .marginOnly(top: 27.h, bottom: 30.h),
    leading: (withBack)
        ? getBackIcon(context, () {
            backClick();
          }, colors: iconColor)
        : 0.horizontalSpace,
    actions: [
      Row(
        children: [
          (isCartAvailable)
              ? Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    child: getSvgImageWithSize(context, "bag.svg", 24.h, 24.h),
                    onTap: () {
                      Constant.sendToNext(context, myCartScreenRoute);
                    },
                  ).marginOnly(
                      right: FetchPixels.getDefaultHorSpaceFigma(context)),
                )
              : 0.verticalSpace,
          (isFilterAvailable)
              ? PopupMenuButton(
                  onSelected: filterFun,
                  child: getSvgImageWithSize(context, "bag.svg", 24.h, 24.h)
                      .paddingOnly(right: 20.h),
                  itemBuilder: (_) => <PopupMenuItem<String>>[
                    const PopupMenuItem<String>(
                        value: 'NewAdded', child: Text('New Added')),
                    // PopupMenuItem<String>(
                    // child: Text('Last Mode'), value: 'NewAdded'),
                    const PopupMenuItem<String>(
                        value: 'PriceHigh', child: Text('Price High To Low')),
                    const PopupMenuItem<String>(
                        value: 'PriceLow', child: Text('Price Low To High')),
                  ],
                )
              : 0.verticalSpace,
        ],
      )
    ],
  );
}

Widget getRowButtonFigma(
  BuildContext context,
  Color bgColor,
  bool withCorners,
  String text,
  String totalTxt,
  String btnTxt,
  Color textColor,
  Function function,
  EdgeInsetsGeometry insetsGeometry, {
  isBorder = false,
  borderColor = Colors.transparent,
  FontWeight weight = FontWeight.w600,
  List<BoxShadow> shadow = const [],
  bool withGradient = false,
  GestureTapDownCallback? onTapDown,
  GestureTapUpCallback? onTapUp,
}) {
  double buttonHeight = getButtonHeightFigma();
  double fontSize = getButtonFontSizeFigma();
  return InkWell(
    onTapDown: onTapDown,
    onTapUp: onTapUp,
    onTap: () {
      function();
    },
    child: Container(
      margin: insetsGeometry,
      width: double.infinity,
      height: buttonHeight,
      decoration: (withGradient)
          ? getButtonDecorationWithGradient(bgColor,
              withCorners: withCorners,
              corner: (withCorners) ? getButtonCornersFigma() : 0,
              withBorder: isBorder,
              borderColor: borderColor,
              shadow: shadow)
          : getButtonDecoration(bgColor,
              withCorners: withCorners,
              corner: (withCorners) ? getButtonCornersFigma() : 0,
              withBorder: isBorder,
              borderColor: borderColor,
              shadow: shadow),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: Row(
            children: [
              getSvgImageWithSize(
                  context, "bag.svg", getEditIconSize().h, getEditIconSize().h,
                  color: Colors.white),
              getHorSpace(8.w),
              getCustomFont(
                text,
                fontSize,
                textColor,
                1,
                textAlign: TextAlign.center,
                fontWeight: weight,
              ),
              getHorSpace(12.h),
              getCustomFont(
                totalTxt,
                17,
                textColor,
                1,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.w400,
              ),
            ],
          )),
          getCustomFont(
            btnTxt,
            fontSize,
            textColor,
            1,
            textAlign: TextAlign.center,
            fontWeight: weight,
          ),
          getSvgImageWithSize(context, "arrow-right.svg", 18.h, 18.h,
              color: Colors.white),
        ],
      ).marginSymmetric(horizontal: 18.h),
    ),
  );
}

Widget getDefaultHeader(BuildContext context, String title, Function function,
    {bool withSearchFilter = true,
    Color color = Colors.white,
    bool withFilter = false,
    Function? filterFun,
    bool isShowBack = true,
    bool isShowSearch = true,
    ValueChanged<String>? funChange,
    ValueChanged<String>? onSubmit,
    TextEditingController? controller}) {
  double horSpace = FetchPixels.getDefaultHorSpaceFigma(context);
  return Container(
    color: (color == Colors.white) ? getCardColor(context) : color,
    child: Column(
      children: [
        Container(
          width: double.infinity,
          color: (color == Colors.white) ? getCardColor(context) : color,
          padding: EdgeInsets.only(
            top: Constant.getToolbarTopHeight(context) + 14.h,
          ),
          margin: EdgeInsets.symmetric(horizontal: horSpace),
          // height: toolbarHeight,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Visibility(
                visible: isShowBack,
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: getBackIcon(context, function)),
              ),
              Center(
                  child: getCustomFont(title, 24, getFontColor(context), 1,
                      fontWeight: FontWeight.w700,
                      textAlign: TextAlign.center)),
              Align(
                alignment: Alignment.centerRight,
                child: (withFilter)
                    ? InkWell(
                        child: getSvgImageWithSize(
                            context, "filter.svg", 24.h, 24.h),
                        onTap: () {
                          filterFun!();
                        },
                      )
                    : 0.horizontalSpace,
              )
            ],
          ),
        ),
        (isShowSearch) ? getVerSpace(30.h) : getVerSpace(0.h),
        (isShowSearch)
            ? Container(
                margin: EdgeInsets.symmetric(horizontal: horSpace),
                width: double.infinity,
                height: 56.h,
                padding: EdgeInsets.symmetric(horizontal: 18.h),
                decoration: getButtonDecoration(
                  Colors.transparent,
                  withCorners: true,
                  corner: 22.h,
                  withBorder: true,
                  borderColor: black20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    getSvgImageWithSize(context, "search.svg", 24.h, 24.h),
                    getHorSpace(18.h),
                    Expanded(
                      flex: 1,
                      child: TextField(
                        controller: controller,
                        onChanged: funChange,
                        decoration: InputDecoration(
                            isDense: true,
                            hintText: "Search...",
                            border: InputBorder.none,
                            hintStyle: buildTextStyle(context,
                                getFontHint(context), FontWeight.w400, 17)),
                        style: buildTextStyle(context, getFontColor(context),
                            FontWeight.w400, 17),
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        onSubmitted: onSubmit,
                      ),
                    ),
                    (withSearchFilter)
                        ? InkWell(
                            child: getSvgImageWithSize(
                                context, "filter.svg", 24.h, 24.h,
                                color: getFontHint(context)),
                            onTap: () {
                              filterFun!();
                            },
                          )
                        : 0.horizontalSpace
                  ],
                ),
              )
            : 0.horizontalSpace,
        getVerSpace(20.h),
      ],
    ),
  );
}

AppBar getBackAppBar(BuildContext context, Function backClick,
    {Color color = Colors.transparent,
    String title = "",
    Color fontColor = Colors.white,
    Color iconColor = Colors.black,
    bool centerTitle = true}) {
  return AppBar(
    elevation: 0,
    toolbarHeight: 259.h,
    backgroundColor: color,
    flexibleSpace: Container(
      child: Stack(
        alignment: Alignment.bottomCenter,
        fit: StackFit.expand,
        children: [
          Positioned(
              left: -108.h,
              top: -30.h,
              child: SizedBox(
                  height: 200.h,
                  width: 229.h,
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: getSvgImage(
                          context, "Paw_Print.svg", double.infinity)))),
          Positioned(
              right: -108.h,
              child: SizedBox(
                  height: 200.h,
                  width: 229.h,
                  child: Align(
                      alignment: Alignment.bottomRight,
                      child: getSvgImage(
                          context, "Paw_Print.svg", double.infinity)))),
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                getSvgImageWithSize(context, "Logo1.svg", 60.h, 60.h,
                    fit: BoxFit.fill),
                8.h.verticalSpace,
                getCustomFont(title, 26, getFontColor(context), 1,
                    fontWeight: FontWeight.w700, textAlign: TextAlign.center),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: ListView(
              shrinkWrap: true,
              children: [getCustomFont("Email", 18, getFontColor(context), 1)],
            ),
          )
          // Align(
          //   alignment: Alignment.center,
          //   child:
          // ),

          // getAssetImage(context, "Paw_Print.svg", double.infinity, double.infinity)
          // Align(
          //     alignment: Alignment.centerLeft,
          //     child: getBackIcon(context, () {
          //       backClick();
          //     }, colors: iconColor)
          //         .marginOnly(left: 27.w))
        ],
      ).paddingOnly(bottom: 30.h),
    ),
    automaticallyImplyLeading: false,
    // centerTitle: centerTitle,
    // title: getSvgImageWithSize(context, "Logo.svg", 86.h, 73.h, fit: BoxFit.fill).marginOnly(top: 27.h,bottom: 30.h),
    // leading: getBackIcon(context, () {
    //   backClick();
    // }, colors: iconColor),
  );
}

// Widget getSettingRow(
//     BuildContext context, String image, String name, Function function,
//     {bool withSwitch = false,
//     ValueChanged<bool>? onToggle,
//     bool checked = false}) {
//   double horSpace = FetchPixels.getPixelWidth(16);
//   double iconSize = FetchPixels.getPixelHeight(24);
//   return Container(
//     width: double.infinity,
//     height: getButtonHeight(),
//     margin: EdgeInsets.symmetric(
//         horizontal: FetchPixels.getPixelWidth(20),
//         vertical: FetchPixels.getPixelHeight(10)),
//     decoration: getButtonDecoration(
//         getCurrentTheme(context).dialogBackgroundColor,
//         withCorners: true,
//         corner: getButtonCorners(),
//         withBorder: false,
//         shadow: [
//           BoxShadow(
//               color: getCurrentTheme(context).shadowColor,
//               offset: const Offset(-5, 6),
//               blurRadius: 40)
//         ]),
//     child: InkWell(
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           getHorSpace(horSpace),
//           getSvgImageWithSize(
//             context,
//             image,
//             iconSize,
//             iconSize,
//           ),
//           getHorSpace(FetchPixels.getPixelWidth(6)),
//           Expanded(
//             child: getCustomFont(name, 16, getFontColor(context), 1,
//                 fontWeight: FontWeight.w400),
//             flex: 1,
//           ),
//           (withSwitch)
//               ? FlutterSwitch(
//                   value: checked,
//                   padding: 0.5,
//                   inactiveColor: getCardColor(context),
//                   activeColor: getAccentColor(context),
//                   inactiveToggleColor: getAccentColor(context),
//                   width: FetchPixels.getPixelHeight(67),
//                   height: FetchPixels.getPixelHeight(35),
//                   onToggle: onToggle!,
//                 )
//               : getSvgImageWithSize(
//                   context,
//                   "arrow_right.svg",
//                   iconSize,
//                   iconSize,
//                 ),
//           getHorSpace(horSpace),
//         ],
//       ),
//       onTap: () {
//         function();
//       },
//     ),
//   );
// }

Widget getRowWidget(
    BuildContext context, String title, String icon, Function function) {
  double iconSize = 24.h;
  // double iconSize = FetchPixels.getPixelHeight(24);
  return InkWell(
    onTap: () {
      function();
    },
    child: Container(
      height: 60.h,
      // height: FetchPixels.getPixelHeight(60),
      width: double.infinity,
      margin: EdgeInsets.symmetric(
          horizontal: FetchPixels.getDefaultHorSpaceFigma(context),
          vertical: 10.h),
      padding: EdgeInsets.symmetric(horizontal: 21.w),
      decoration: getButtonDecoration(Colors.white,
          withCorners: true,
          corner: getButtonCornersFigma(),
          shadow: [
            const BoxShadow(
                color: Color.fromRGBO(155, 103, 103, 0.10999999940395355),
                offset: Offset(-5, 6),
                blurRadius: 28)
          ]),
      child: Row(
        children: [
          getSvgImageWithSize(
            context,
            icon,
            iconSize,
            iconSize,
          ),
          getHorSpace(17.w),
          Expanded(
            flex: 1,
            child: getCustomFont(title, 16, getFontColor(context), 1,
                fontWeight: FontWeight.w500),
          ),
          getSvgImageWithSize(
            context,
            "arrow_right.svg",
            iconSize,
            iconSize,
          ),
        ],
      ),
    ),
  );
}

Widget getButtonFigma(
  BuildContext context,
  Color bgColor,
  bool withCorners,
  String text,
  Color textColor,
  Function function,
  EdgeInsetsGeometry insetsGeometry, {
  isBorder = false,
  borderColor = Colors.transparent,
  FontWeight weight = FontWeight.w600,
  bool isIcon = false,
  String? icons,
  List<BoxShadow> shadow = const [],
  bool withGradient = false,
  GestureTapDownCallback? onTapDown,
  GestureTapUpCallback? onTapUp,
}) {
  double buttonHeight = getButtonHeightFigma();
  double fontSize = getButtonFontSizeFigma();
  return InkWell(
    onTapDown: onTapDown,
    onTapUp: onTapUp,
    onTap: () {
      function();
    },
    child: Container(
      margin: insetsGeometry,
      width: double.infinity,
      height: buttonHeight,
      decoration: (withGradient)
          ? getButtonDecorationWithGradient(bgColor,
              withCorners: withCorners,
              corner: (withCorners) ? getButtonCornersFigma() : 0,
              withBorder: isBorder,
              borderColor: borderColor,
              shadow: shadow)
          : getButtonDecoration(bgColor,
              withCorners: withCorners,
              corner: (withCorners) ? getButtonCornersFigma() : 0,
              withBorder: isBorder,
              borderColor: borderColor,
              shadow: shadow),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          (isIcon)
              ? getSvgImageWithSize(context, icons ?? "", getEditIconSize().h,
                  getEditIconSize().h)
              : getHorSpace(0),
          (isIcon) ? getHorSpace(10.w) : getHorSpace(0),
          getCustomFont(
            text,
            fontSize,
            textColor,
            1,
            textAlign: TextAlign.center,
            fontWeight: weight,
          )
        ],
      ),
    ),
  );
}

Widget getButtonWithEndIcon(
    BuildContext context,
    Color bgColor,
    bool withCorners,
    String text,
    Color textColor,
    Function function,
    EdgeInsetsGeometry insetsGeometry,
    {isBorder = false,
    borderColor = Colors.transparent,
    FontWeight weight = FontWeight.w600,
    bool isIcon = false,
    String? icons,
    List<BoxShadow> shadow = const []}) {
  double buttonHeight = getButtonHeightFigma();
  double fontSize = getButtonFontSizeFigma();
  return InkWell(
    onTap: () {
      function();
    },
    child: Container(
      margin: insetsGeometry,
      width: double.infinity,
      height: buttonHeight,
      decoration: getButtonDecoration(bgColor,
          withCorners: withCorners,
          corner: (withCorners) ? getButtonCorners() : 0,
          withBorder: isBorder,
          borderColor: borderColor,
          shadow: shadow),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          getHorSpace(10.w),
          Expanded(
            flex: 1,
            child: getCustomFont(
              text,
              fontSize,
              textColor,
              1,
              textAlign: TextAlign.start,
              fontWeight: weight,
            ),
          ),
          (isIcon)
              ? getSvgImage(context, icons ?? "", getEditIconSize())
              : getHorSpace(0),
          getHorSpace(10.w)
        ],
      ),
    ),
  );
}

Widget getSubButton(
    BuildContext context,
    Color bgColor,
    bool withCorners,
    String text,
    Color textColor,
    Function function,
    EdgeInsetsGeometry insetsGeometry,
    {isBorder = false,
    double width = double.infinity,
    borderColor = Colors.transparent,
    FontWeight weight = FontWeight.w600,
    bool isIcon = false,
    String? icons}) {
  double buttonHeight = 40.h;
  double buttonCorner = 20.h;
  return InkWell(
    onTap: () {
      function();
    },
    child: Container(
      margin: insetsGeometry,
      width: width,
      height: buttonHeight,
      decoration: getButtonDecoration(bgColor,
          withCorners: withCorners,
          corner: (withCorners) ? buttonCorner : 0,
          withBorder: isBorder,
          borderColor: borderColor),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          (isIcon)
              ? getSvgImage(context, icons ?? "", getEditIconSize())
              : getHorSpace(0),
          (isIcon) ? getHorSpace(10.w) : getHorSpace(0),
          // Text("wruiewru"),
          getCustomFont(
            text,
            16,
            textColor,
            1,
            textAlign: TextAlign.center,
            fontWeight: weight,
          )
        ],
      ),
    ),
  );
}

Widget getCircularImage(BuildContext context, double width, double height,
    double radius, String img,
    {BoxFit boxFit = BoxFit.contain, bool listen = true}) {
  return SizedBox(
    height: height,
    width: width,
    child: ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      child: getAssetImage(context, img, width, height,
          boxFit: boxFit, listen: listen),
    ),
  );
}

Widget getCircularNetworkImage(BuildContext context, double width,
    double height, double radius, String img,
    {BoxFit boxFit = BoxFit.contain, bool listen = true}) {
  return SizedBox(
    height: height,
    width: width,
    child: ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      child: getNetworkImage(context, img, width, height,
          boxFit: boxFit, listen: listen),
    ),
  );
}

Widget getVerSpace(double verSpace) {
  return SizedBox(
    height: verSpace,
  );
}

Widget buildFavouriteBtn(EdgeInsets edgeInsets) {
  return Container(
    margin: edgeInsets,
    height: 20.w,
    width: 20.w,
    decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.25),
              offset: Offset(0, 1),
              blurRadius: 1)
        ]),
    child: Center(
      child:
          Icon(Icons.favorite_border_rounded, size: 13.w, color: Colors.black),
    ),
  );
}

Widget buildStarView(BuildContext context, String rate) {
  return Row(
    children: [
      getSvgImageWithSize(context, "star.svg", 17.w, 17.w, fit: BoxFit.fill),
      6.w.horizontalSpace,
      getCustomFont(rate, 14, getAccentColor(context), 1,
          fontWeight: FontWeight.w400, txtHeight: 1.5)
    ],
  );
}

Widget buildDistanceView(BuildContext context, String rate) {
  return buildCustomDistanceView(
      context, rate, 17.w, 14, getAccentColor(context), FontWeight.w400);
  //   Row(
  //   children: [
  //     getSvgImageWithSize(context, "Distance.svg", 17.w, 17.w,
  //         fit: BoxFit.fill),
  //     6.w.horizontalSpace,
  //     getCustomFont(rate, 14, getAccentColor(context), 1,
  //         fontWeight: FontWeight.w400, txtHeight: 1.5)
  //   ],
  // );
}

Widget buildReviewItem(BuildContext context, String title, String review,
    String detail, String img) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.symmetric(vertical: 10.h),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getCircleImage(context, img, 30.h),
        8.w.horizontalSpace,
        Expanded(
          flex: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getCustomFont(title, 14, getFontColor(context), 1,
                  fontWeight: FontWeight.w500),
              6.h.verticalSpace,
              getMultilineCustomFont(review, 14, getFontGreyColor(context),
                  fontWeight: FontWeight.w400),
              6.h.verticalSpace,
              getCustomFont(detail, 12, getFontHint(context), 1,
                  fontWeight: FontWeight.w500),
            ],
          ),
        )
      ],
    ),
  );
}

Widget buildCustomDistanceView(BuildContext context, String rate,
    double imgSize, double fontSize, Color fontColor, FontWeight weight) {
  return Row(
    children: [
      getSvgImageWithSize(context, "Distance.svg", imgSize, imgSize,
          fit: BoxFit.fill),
      6.w.horizontalSpace,
      getCustomFont(rate, 14, fontColor, 1, fontWeight: weight, txtHeight: 1.5)
    ],
  );
}

Widget buildButtonBookNow(BuildContext context, Function function) {
  return InkWell(
    onTap: () {
      function();
    },
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        getCustomFont("Book Now", 16, getFontColor(context), 1,
            fontWeight: FontWeight.w600),
        8.w.horizontalSpace,
        Icon(
          Icons.arrow_forward_rounded,
          color: getFontColor(context),
          size: 18.w,
        )
      ],
    ),
  );
}

// Widget getSearchFigmaWidget(
//     BuildContext context,
//     TextEditingController searchController,
//     Function filterClick,
//     ValueChanged<String> onChanged,
//     {bool readOnly = false,
//     bool showFilter = true,
//     String hint = "Where do?",
//     Function? searchClick}) {
//   double height = getEditHeightFigma();
//   double iconSize = getEditIconSizeFigma().h;
//   double fontSize = getEditFontSizeFigma();
//
//   return Container(
//     width: double.infinity,
//     height: height,
//     child: Row(
//       children: [
//         Expanded(
//           child: InkWell(
//             onTap: () {
//               if (searchClick != null) {
//                 searchClick();
//               }
//             },
//             child: Container(
//               height: double.infinity,
//               padding: EdgeInsets.symmetric(horizontal: 14.w),
//               decoration: getButtonDecoration(Colors.transparent,
//                   withCorners: true,
//                   corner: getEditRadiusSizeFigma(),
//                   withBorder: true,
//                   borderColor: getCurrentTheme(context).unselectedWidgetColor),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   getSvgImageWithSize(context, "Search.svg", iconSize, iconSize,
//                       fit: BoxFit.scaleDown, color: getFontGreyColor(context)),
//                   getHorSpace(12.w),
//                   Expanded(
//                     child: IntrinsicHeight(
//                       child: TextField(
//                         readOnly: readOnly,
//                         controller: searchController,
//                         onChanged: onChanged,
//                         enabled: !readOnly,
//                         decoration: InputDecoration(
//                             isDense: true,
//                             hintText: hint,
//                             // focusColor: Colors.green,
//                             // hoverColor: Colors.green,
//                             // fillColor: Colors.green,
//                             border: InputBorder.none,
//                             hintStyle: TextStyle(
//                                 fontFamily: Constant.fontsFamily,
//                                 fontSize: fontSize.sp,
//                                 fontWeight: FontWeight.w500,
//                                 color: getFontHint(context))),
//                         style: TextStyle(
//                             fontFamily: Constant.fontsFamily,
//                             fontSize: fontSize.sp,
//                             fontWeight: FontWeight.w500,
//                             color: getFontColor(context)),
//                         textAlign: TextAlign.start,
//                         maxLines: 1,
//                       ),
//                     ),
//                     flex: 1,
//                   ),
//                   // getHorSpace(3.w),
//                   // InkWell(
//                   //   child: getSvgImageWithSize(
//                   //       context, "filter.svg", iconSize, iconSize),
//                   //   onTap: () {
//                   //     filterClick();
//                   //   },
//                   // )
//                 ],
//               ),
//             ),
//           ),
//           flex: 1,
//         ),
//         (showFilter) ? getHorSpace(8.w) : getHorSpace(0),
//         (showFilter)
//             ? InkWell(
//                 onTap: () {
//                   filterClick();
//                 },
//                 child: Container(
//                   decoration: getButtonDecoration(Colors.transparent,
//                       withCorners: true,
//                       corner: getEditRadiusSizeFigma(),
//                       withBorder: true,
//                       borderColor:
//                           getCurrentTheme(context).unselectedWidgetColor),
//                   padding: EdgeInsets.symmetric(horizontal: 9.w),
//                   height: double.infinity,
//                   child: Center(
//                       child: getSvgImageWithSize(
//                           context, "filter.svg", 24.h, 24.h,
//                           fit: BoxFit.scaleDown)),
//                 ),
//               )
//             : getHorSpace(0)
//       ],
//     ),
//   );
// }

Widget getSearchMapFigmaWidget(
    BuildContext context,
    TextEditingController searchController,
    ValueChanged<String> onChanged,
    String hint,
    {bool readOnly = false}) {
  double height = 46.h;
  double fontSize = 14;

  return SizedBox(
    width: double.infinity,
    height: height,
    child: Container(
      height: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      decoration: getButtonDecoration(getCardColor(context),
          withCorners: true,
          corner: getEditRadiusSizeFigma(),
          withBorder: true,
          borderColor: getCurrentTheme(context).unselectedWidgetColor),
      child: Align(
        alignment: Alignment.centerLeft,
        child: TextField(
          readOnly: readOnly,
          controller: searchController,
          onChanged: onChanged,
          decoration: InputDecoration(
              isDense: true,
              hintText: hint,
              border: InputBorder.none,
              hintStyle: TextStyle(
                  fontFamily: Constant.fontsFamily,
                  fontSize: fontSize.sp,
                  fontWeight: FontWeight.w500,
                  color: getFontHint(context))),
          style: TextStyle(
              fontFamily: Constant.fontsFamily,
              fontSize: fontSize.sp,
              fontWeight: FontWeight.w500,
              color: getFontColor(context)),
          textAlign: TextAlign.start,
          maxLines: 1,
        ),
      ),
      // child: IntrinsicHeight(
      //   child: TextField(
      //   readOnly: readOnly,
      //   controller: searchController,
      //   onChanged: onChanged,
      //   decoration: InputDecoration(
      //       isDense: true,
      //       hintText: hint,
      //       border: InputBorder.none,
      //       hintStyle: TextStyle(
      //           fontFamily: Constant.fontsFamily,
      //           fontSize: fontSize.sp,
      //           fontWeight: FontWeight.w500,
      //           color: getFontHint(context))),
      //   style: TextStyle(
      //       fontFamily: Constant.fontsFamily,
      //       fontSize: fontSize.sp,
      //       fontWeight: FontWeight.w500,
      //       color: getFontColor(context)),
      //   textAlign: TextAlign.start,
      //   maxLines: 1,
      // ),
      // ),
    ),
  );
}

Row buildTotalRow(BuildContext context, String title, String total) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      getCustomFont(
        title,
        17,
        getFontColor(context),
        1,
        fontWeight: FontWeight.w600,
      ),
      getCustomFont(
        total,
        17,
        getFontColor(context),
        1,
        fontWeight: FontWeight.w600,
      ),
    ],
  );
}

Row buildSubtotalRow(BuildContext context, String title, String total) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      getCustomFont(
        title,
        16,
        getFontColor(context),
        1,
        fontWeight: FontWeight.w400,
      ),
      getCustomFont(
        total,
        16,
        getFontColor(context),
        1,
        fontWeight: FontWeight.w400,
      ),
    ],
  );
}

Widget getHorSpace(double verSpace) {
  return SizedBox(
    width: verSpace,
  );
}

showGetDeleteDialog(
  BuildContext context,
  String title,
  String btnText,
  Function function, {
  bool withCancelBtn = false,
  String btnTextCancel = "No",
  Function? functionCancel,
  bool barrierDismissible = true,
}) {
  Get.dialog(
      barrierDismissible: barrierDismissible,
      AlertDialog(
        contentPadding: EdgeInsets.zero,
        backgroundColor: getCardColor(context),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.h))),
        content: Container(
          padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 20.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              getMultilineCustomFont(title, 20, getFontColor(context),
                  textAlign: TextAlign.center, fontWeight: FontWeight.w700),
              getVerSpace(30.h),
              Row(
                children: [
                  (withCancelBtn)
                      ? Expanded(
                          child: getButtonFigma(context, Colors.transparent,
                              true, btnTextCancel, getAccentColor(context), () {
                          if (functionCancel != null) {
                            functionCancel();
                          }
                        }, EdgeInsets.zero,
                              isBorder: true,
                              borderColor: getAccentColor(context)))
                      : 0.horizontalSpace,
                  (withCancelBtn) ? getHorSpace(20.h) : 0.horizontalSpace,
                  Expanded(
                      child: getButtonFigma(context, getAccentColor(context),
                          true, btnText, Colors.white, () {
                    function();
                  }, EdgeInsets.zero)),
                ],
              ),
            ],
          ),
        ),
      ));
}
