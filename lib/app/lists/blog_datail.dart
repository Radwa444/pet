import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_shop/app/home/tabs/tab_home.dart';
import 'package:pet_shop/base/color_data.dart';
import 'package:pet_shop/base/constant.dart';
import 'package:pet_shop/base/fetch_pixels.dart';
import 'package:pet_shop/base/widget_utils.dart';

class BlogDetailScreen extends StatefulWidget {
  const BlogDetailScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _BlogDetailScreen();
  }
}

class _BlogDetailScreen extends State<BlogDetailScreen> {
  void backClick() {
    Constant.backToPrev(context);
  }

  // GlobalKey<FormState> _abcKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Constant.setupSize(context);
    double horSpace = FetchPixels.getDefaultHorSpaceFigma(context);
    return WillPopScope(
        child: Scaffold(
            backgroundColor: getScaffoldColor(context),
            body: Container(
              color: getCardColor(context),
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    leading: getBackIcon(context, () {
                      backClick();
                    }, colors: getCardColor(context)),
                    expandedHeight: 281.h,
                    backgroundColor: Colors.transparent,
                    flexibleSpace: FlexibleSpaceBar(
                      background: getAssetImage(context, "blog1.png",
                          double.infinity, double.infinity,
                          boxFit: BoxFit.cover),
                    ),
                  ),
                  SliverList(
                    // Use a delegate to build items as they're scrolled on screen.
                    delegate: SliverChildListDelegate([
                      20.h.verticalSpace,
                      getMultilineCustomFont(
                              "Ibendum est ultricies integer quis auctor.",
                              20,
                              getFontColor(context),
                              fontWeight: FontWeight.w700)
                          .marginSymmetric(horizontal: horSpace),
                      14.h.verticalSpace,
                      buildDateRow(context, "26 Sep,2022")
                          .marginSymmetric(horizontal: horSpace),
                      12.h.verticalSpace,
                      getMultilineCustomFont(
                        "Venenatis tellus in metus vulputate eu"
                        " scelerisque felis imperdiet proin. Nulla porttitor "
                        "massa id neque. Aliquam ultrices sagittis orci a scelerisque "
                        "purus semper. Adipiscing at in tellus integer feugiat scelerisque varius "
                        "morbi. Nisl nunc mi ipsum faucibus vitae aliquet.",
                        16,
                        getFontColor(context),
                        fontWeight: FontWeight.w400,
                      ).marginSymmetric(horizontal: horSpace),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(vertical: 20.h),
                        height: 131.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(12.h)),
                          image: getDecorationAssetImage(
                              context, "hikingdog.png",
                              fit: BoxFit.cover),
                        ),
                      ).marginSymmetric(horizontal: horSpace),
                      getMultilineCustomFont(
                              "Nec tincidunt praesent semper feugiat. "
                              "Mollis nunc sed id semper risus in hendrerit gravida. "
                              "Varius sit amet mattis vulputate enim nulla Nec "
                              "tincidunt praesent semper feugiat. Mollis nunc sed id "
                              "semper risus in hendrerit gravida. Varius sit ",
                              16,
                              getFontColor(context),
                              fontWeight: FontWeight.w400)
                          .marginSymmetric(horizontal: horSpace)
                    ]),
                  ),
                ],
              ),
            )),
        onWillPop: () async {
          backClick();
          return false;
        });
  }
}
