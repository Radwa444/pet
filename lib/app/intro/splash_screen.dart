import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_shop/base/get/route_key.dart';
import 'package:pet_shop/base/get/storage.dart';
import '../../base/color_data.dart';
import '../../base/constant.dart';
import '../../base/widget_utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SplashScreen();
  }
}

class _SplashScreen extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(
      const Duration(seconds: 3),
      () {
        (isIntroAvailable)
            ? Constant.sendToNext(context, introRoute)
            : Constant.sendToNext(context, homeScreenRoute);
      },
    );
  }

  backClick(BuildContext context) {
    Constant.backToFinish(context);
  }

  @override
  Widget build(BuildContext context) {
    Constant.setupSize(context);

    return WillPopScope(
        child: Scaffold(
          backgroundColor: getAccentColor(context),
          body: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                getSvgImageWithSize(context, "Logo.svg", 102.h, 148.h,
                    fit: BoxFit.fill),
                26.h.verticalSpace,
                getCustomFont("PET SHOP", 28, Colors.white, 1,
                    fontWeight: FontWeight.w700,
                    fontFamily: Constant.fontsFamily,
                    textAlign: TextAlign.center)
              ],
            ),
          ),
        ),
        onWillPop: () async {
          backClick(context);
          return false;
        });
  }
}
