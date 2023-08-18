import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_shop/base/get/home_controller.dart';
import '../../base/color_data.dart';
import '../../base/constant.dart';
import '../../base/fetch_pixels.dart';
import '../../base/get/route_key.dart';
import '../../base/widget_utils.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MyProfileScreen();
  }
}

class _MyProfileScreen extends State<MyProfileScreen> {
  HomeController homeController = Get.find<HomeController>();

  @override
  void initState() {
    super.initState();
  }

  onBackClick(BuildContext context) {
    Constant.backToPrev(context);
  }

  @override
  Widget build(BuildContext context) {
    Constant.setupSize(context);

    double horSpace = FetchPixels.getDefaultHorSpaceFigma(context);
    EdgeInsets edgeInsets = EdgeInsets.symmetric(horizontal: horSpace);

    return WillPopScope(
        child: Scaffold(
          backgroundColor: getScaffoldColor(context),
          body: Column(
            children: [
              getDefaultHeader(
                context,
                "My Profile",
                () {
                  onBackClick(context);
                },
                isShowSearch: false,
              ),
              Expanded(
                  child: ListView(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                children: [
                  30.h.verticalSpace,
                  Center(child: getCircleProfileImage(context, "L", 90.h)),
                  40.h.verticalSpace,
                  getDefaultUnderlineTextFiled(
                    context,
                    'Name',
                    TextEditingController(text: "Leslie Alexander"),
                    getFontHint(context),
                    (value) {},
                    readOnly: true,
                  ),
                  30.h.verticalSpace,
                  getDefaultUnderlineTextFiled(
                      context,
                      'Email Address',
                      TextEditingController(text: "lesliealexander@gmail.com"),
                      getFontHint(context),
                      (value) {},
                      readOnly: true),
                  30.h.verticalSpace,
                  getDefaultUnderlineTextFiled(
                    context,
                    'Phone Number',
                    TextEditingController(text: "(684) 555-0102"),
                    getFontHint(context),
                    (value) {},
                    readOnly: true,
                  ),
                ],
              )),
              getButtonFigma(context, getAccentColor(context), true,
                      'Edit profile', Colors.white, () {
                Constant.sendToNextWithBackResult(
                    context, editProfileRoute, (val) {});
              }, edgeInsets)
                  .marginSymmetric(vertical: 30.h)
            ],
          ),
        ),
        onWillPop: () async {
          onBackClick(context);
          return false;
        });
  }
}
