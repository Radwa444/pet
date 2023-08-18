import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_shop/base/color_data.dart';
import 'package:pet_shop/base/constant.dart';
import 'package:pet_shop/base/widget_utils.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MoreScreen();
  }
}

class _MoreScreen extends State<MoreScreen> {
  void backClick() {
    Constant.backToPrev(context);
  }

  @override
  Widget build(BuildContext context) {
    Constant.setupSize(context);
    return WillPopScope(
        child: Scaffold(
          backgroundColor: getScaffoldColor(context),
          body: Column(
            children: [
              getDefaultHeader(context, "More", () {
                backClick();
              }, isShowSearch: false),
              getVerSpace(20.h),
              Flexible(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    Container(
                      color: getCardColor(context),
                      padding: EdgeInsets.all(20.h),
                      child: Column(
                        children: [
                          buildRowWidget(
                              context, "info.svg", "About Us", () {}),
                          getDividerWidget(),
                          buildRowWidget(
                              context, "lock.svg", "Privacy Policy ", () {}),
                          getDividerWidget(),
                          buildRowWidget(
                              context, "like.svg", "Feedback", () {}),
                          getDividerWidget(),
                          buildRowWidget(
                              context, "Vector.svg", "Rate Us", () {}),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        onWillPop: () async {
          backClick();
          return false;
        });
  }
}
