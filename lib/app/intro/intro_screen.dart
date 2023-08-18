import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../base/color_data.dart';
import '../../base/constant.dart';
import '../../base/data_file.dart';
import '../../base/dots_indicator.dart';
import '../../base/fetch_pixels.dart';
import '../../base/get/route_key.dart';
import '../../base/get/storage.dart';
import '../../base/widget_utils.dart';
import '../model/model_intro.dart';

class IntroScreen extends StatelessWidget {
  IntroScreen({Key? key}) : super(key: key);

  backClick(BuildContext context) {
    Constant.backToFinish(context);
  }

  List<ModelIntro> introList = DataFile.getAllIntroList();
  PageController pageController = PageController(initialPage: 0);
  RxInt selectedPos = 0.obs;

  @override
  Widget build(BuildContext context) {
    Constant.setupSize(context);

    double horSpace = FetchPixels.getDefaultHorSpaceFigma(context);

    return WillPopScope(
        child: Scaffold(
          appBar: getInVisibleAppBar(),
          backgroundColor: getScaffoldColor(context),
          body: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: PageView.builder(
                        onPageChanged: (value) {
                          selectedPos.value = value;
                        },
                        controller: pageController,
                        itemBuilder: (context, index) {
                          ModelIntro modelIntro = introList[index];
                          return Column(
                            children: [
                              Expanded(
                                flex: 3,
                                child: getAssetImage(context, modelIntro.image,
                                    double.infinity, double.infinity,
                                    boxFit: BoxFit.fill),
                              ),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    getMultilineCustomFont(modelIntro.title, 28,
                                        getFontColor(context),
                                        textAlign: TextAlign.center,
                                        fontWeight: FontWeight.w700,
                                        txtHeight: 1.5),
                                    6.h.verticalSpace,
                                    getCustomFont(
                                        modelIntro.description,
                                        16,
                                        getFontColor(context),
                                        textAlign: TextAlign.center,
                                        2,
                                        fontWeight: FontWeight.w400,
                                        txtHeight: 1.5),
                                    30.h.verticalSpace,
                                  ],
                                ).marginSymmetric(horizontal: horSpace),
                              ),
                            ],
                          );
                        },
                        itemCount: introList.length,
                      ),
                    ),
                    ObxValue((p0) {
                      print("getvals==pos====${selectedPos.value}");
                      return DotsIndicator(
                        size: 10,
                        controller: pageController,
                        color: getDividerColor(context),
                        selectedPos: selectedPos.value,
                        selectedColor: getAccentColor(context),
                        onPageSelected: (value) {},
                        itemCount: introList.length,
                      );
                    }, selectedPos),
                    55.h.verticalSpace,
                    ObxValue(
                        (p0) => getButtonFigma(
                              context,
                              getAccentColor(context),
                              true,
                              (selectedPos.value == introList.length - 1)
                                  ? "Get started"
                                  : "Next",
                              Colors.white,
                              () {
                                if (selectedPos.value < introList.length - 1) {
                                  pageController
                                      .jumpToPage(selectedPos.value + 1);
                                } else {
                                  changeIntroVal(false);
                                  Constant.sendToNext(context, homeScreenRoute);
                                }
                              },
                              EdgeInsets.symmetric(horizontal: horSpace),
                            ),
                        selectedPos),
                    55.h.verticalSpace,
                  ],
                ),
                InkWell(
                  onTap: () {
                    changeIntroVal(false);
                    Constant.sendToNext(context, homeScreenRoute);
                  },
                  child: getCustomFont(
                    "Skip",
                    16,
                    getFontColor(context),
                    1,
                    fontWeight: FontWeight.w600,
                    textAlign: TextAlign.center,
                  ).marginAll(21.h),
                ),
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
