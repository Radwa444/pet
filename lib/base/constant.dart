import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:pet_shop/base/color_data.dart';
import 'dart:ui' as ui;

import 'package:pet_shop/base/size_config.dart';

import 'enums/symbol_position_enums.dart';
import 'get/home_controller.dart';

class Constant {
  static SymbolPositionType appCurrencySymbolPosition = SymbolPositionType.left;
  static String assetImagePath = "assets/images/";
  static String assetImagePathNight = "assets/imagesNight/";
  static bool isDriverApp = false;
  static const String fontsFamily = "Manrope";
  static const String fromLogin = "getFromLoginClick";
  static const String homePos = "getTabPos";
  static const String nameSend = "name";
  static const String imageSend = "image";
  static const String bgColor = "bgColor";
  static const String heroKey = "sendHeroKey";
  static const String sendVal = "sendVal";
  static const int stepStatusNone = 0;
  static const int stepStatusActive = 1;
  static const int stepStatusDone = 2;
  static const int stepStatusWrong = 3;
  static const double defScreenWidth = 414;

  // static const double defScreenHeight = 1133;
  static const double defScreenHeight = 896;
  static const String colorVariation = "color";
  static List<String> icons = ["location.svg", "card.svg", "done.svg"];
  static List<String> filledIcon = [
    "location_fill.svg",
    "card_filled.svg",
    "done.svg"
  ];

  static double getPercentSize(double total, double percent) {
    return (percent * total) / 100;
  }

  static void setupSize(BuildContext context,
      {double width = defScreenWidth, double height = defScreenHeight}) {
    ScreenUtil.init(context,
        // designSize: Size(width, height));
        designSize: Size(width, height),
        minTextAdapt: true);
  }

  static backToPrev(BuildContext context) {
    // Navigator.of(context).pop();
    Get.back();
  }

  // static sendToDetail(
  //     BuildContext context, String name, String img, String? colors,{String heroKey1=""}) {
  //   sendToNext(context, Routes.detailScreenPath,
  //       arguments: {nameSend: name, imageSend: img, bgColor: colors,heroKey:heroKey1});
  // }

  static Future<ui.Image> getImage(String name) {
    final Image image =
        Image(image: AssetImage(Constant.assetImagePath + name));

    Completer<ui.Image> completer = Completer<ui.Image>();
    image.image
        .resolve(const ImageConfiguration())
        .addListener(ImageStreamListener((ImageInfo image, bool _) {
      completer.complete(image.image);
    }));
    return completer.future;
  }

  static Color getOrderStatusColor(String status) {
    switch (status) {
      case "pending":
        return "#FBBB00".toColor();
      case "processing":
        return "#FBBB00".toColor();
      case "on-hold":
        return "#FBBB00".toColor();
      case "Delivered":
        return "#04B155".toColor();
      case "cancelled":
        return "#FF6565".toColor();
      case "refunded":
        return "#FBBB00".toColor();
      case "failed":
        return "#FF6565".toColor();
      case "trash":
        return "#FBBB00".toColor();
    }
    return "#FBBB00".toColor();
  }

  static double parseWcPrice(String? price) =>
      (double.tryParse(price ?? "0") ?? 0);

  static String formatStringCurrency(
      {required String? total, required BuildContext context}) {
    double tmpVal = 0;
    if (total != null && total != "") {
      tmpVal = parseWcPrice(total);
    }
    return moneyFormatter(tmpVal, context);
  }

  static String moneyFormatter(double amount, BuildContext context) {
    MoneyFormatter fmf = MoneyFormatter(
      amount: amount,
      settings: MoneyFormatterSettings(
        symbol: Constant.getCurrency(context),
      ),
    );
    if (appCurrencySymbolPosition == SymbolPositionType.left) {
      return fmf.output.symbolOnLeft;
    } else if (appCurrencySymbolPosition == SymbolPositionType.right) {
      return fmf.output.symbolOnRight;
    }
    return fmf.output.symbolOnLeft;
  }

  static getCurrency(BuildContext context) {
    HomeController homeController = Get.find<HomeController>();
    var unescape = HtmlUnescape();
    String currency = "";
    if (homeController.wooCurrentCurrency != null) {
      currency = homeController.wooCurrentCurrency!.symbol ?? "";
    }
    return unescape.convert(currency);
  }

  static getConvertedText(String string) {
    var unescape = HtmlUnescape();
    return unescape.convert(string);
  }

  static sendToNext(BuildContext context, String route, {Object? arguments}) {
    print("getvals===$route");

    if (arguments != null) {
      Get.toNamed(route, arguments: arguments);
      // Navigator.pushNamed(context, route, arguments: arguments);
    } else {
      Get.toNamed(route);
      // Navigator.pushNamed(context, route);
    }
  }

  static sendToNextWidget(BuildContext context, Widget route) {
    Get.to(route);
  }

  static sendToNextWithResult(
      BuildContext context, Widget route, Function function) {
    Get.to(route)!.then((value) => function(value));
  }

  static sendToNextWithBackResult(
      BuildContext context, String route, ValueChanged<dynamic> fun,
      {Object? arguments}) {
    if (arguments != null) {
      Get.toNamed(route, arguments: arguments)!.then((value) {
        fun(value);
      });
      // Navigator.pushNamed(context, route, arguments: arguments).then((value) {
      //   fun(value);
      // });
    } else {
      Get.toNamed(route)!.then((value) {
        fun(value);
      });
      // Navigator.pushNamed(context, route).then(
      //   (value) {
      //     fun(value);
      //   },
      // );
    }
  }

  static double getWidthPercentSize(double percent) {
    double screenWidth = SizeConfig.safeBlockHorizontal! * 100;
    return (percent * screenWidth) / 100;
  }

  static double getHeightPercentSize(double percent) {
    double screenHeight = SizeConfig.safeBlockVertical! * 100;
    return (percent * screenHeight) / 100;
  }

  static double getToolbarHeight(BuildContext context) {
    return MediaQuery.of(context).padding.top + kToolbarHeight;
  }

  static double getToolbarTopHeight(BuildContext context) {
    return MediaQuery.of(context).padding.top;
  }

  static sendToScreen(
      Widget widget, BuildContext context, ValueChanged<dynamic> setChange) {
    Get.to(() => widget)!.then(setChange);
    // Navigator.of(context).push(MaterialPageRoute(
    //   builder: (context) => widget,
    // ));
  }

  static getDelayFunction(Function function) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      // make pop action to next cycle
      function();
    });
  }

  static backToFinish(BuildContext context) {
    // Navigator.of(context).pop();
    Get.back();
  }

  static formatTime(Duration d) =>
      d.toString().split('.').first.padLeft(8, "0");

  static closeApp() {
    // Get.close(times)close();
    Future.delayed(const Duration(milliseconds: 1000), () {
      // exit(0);
      if (Platform.isAndroid) {
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      } else {
        exit(0);
      }

      // SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    });
  }
}
