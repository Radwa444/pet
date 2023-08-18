import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_shop/base/get/route_key.dart';

import '../../base/color_data.dart';
import '../../base/constant.dart';
import '../../base/fetch_pixels.dart';
import '../../base/widget_utils.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ForgotPasswordScreen();
  }
}

class _ForgotPasswordScreen extends State<ForgotPasswordScreen> {
  backClick(BuildContext context) {
    Constant.backToFinish(context);
  }

  // RxBool showPass = false.obs;

  TextEditingController emailController = TextEditingController();

  // TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Constant.setupSize(context);

    double horSpace = FetchPixels.getDefaultHorSpaceFigma(context);
    return buildTitleDefaultWidget(context, "Forgot Password", () {
      backClick(context);
    },
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getCustomFont("Email", 16, getFontColor(context), 1,
                    fontWeight: FontWeight.w400)
                .marginSymmetric(horizontal: horSpace),
            8.h.verticalSpace,
            getDefaultTextFiled(context, "Enter Email Address", emailController,
                getFontColor(context), (value) {}, validator: (email) {
              if (email!.isNotEmpty) {
                return null;
              } else {
                return 'Please enter email address';
              }
            }),

            // getDefaultTextFiledWithCustomPrefix(
            //     context,
            //     "Phone number",
            //     numberController,
            //     getFontColor(context),
            //     Container(width: 100.h,height: 24.h,color: Colors.green,)
            //     // CountryCodePicker(
            //     //   onChanged: print,
            //     //   initialSelection: 'IN',
            //     //   flagWidth: 40.h,
            //     //   padding: EdgeInsets.zero,
            //     //   textStyle:buildTextStyle(context,getFontColor(context), FontWeight.w400, 16.sp),
            //     //   favorite: const ['+91', 'IN'],
            //     //   showCountryOnly: false,
            //     //   showDropDownButton: true,
            //     //   showOnlyCountryWhenClosed: false,
            //     //   alignLeft: false,
            //     // ).marginOnly(left: 20.w)
            //     ),
            // getDefaultCountryPickerTextFiled(context, "Phone number",
            //         numberController, getFontColor(context))
            //     .marginSymmetric(horizontal: horSpace),
            getButtonFigma(
                context, getAccentColor(context), true, "Submit", Colors.white,
                () {
              Constant.sendToNext(context, resetPassScreenRoute);
            }, EdgeInsets.symmetric(horizontal: horSpace, vertical: 60.h)),
          ],
        ));
  }
}
