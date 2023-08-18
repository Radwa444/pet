import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../base/color_data.dart';
import '../../base/constant.dart';
import '../../base/fetch_pixels.dart';
import '../../base/get/route_key.dart';
import '../../base/get/storage.dart';
import '../../base/widget_utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LoginScreen();
  }
}

class _LoginScreen extends State<LoginScreen> {
  backClick(BuildContext context) {
    Constant.backToFinish(context);
  }

  RxBool showPass = false.obs;

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    RxBool agreeTerm = false.obs;
    Constant.setupSize(context);

    double horSpace = FetchPixels.getDefaultHorSpaceFigma(context);
    return buildTitleDefaultWidget(context, "Login", () {
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
            20.h.verticalSpace,
            getCustomFont("Password", 16, getFontColor(context), 1,
                    fontWeight: FontWeight.w400)
                .marginSymmetric(horizontal: horSpace),
            8.h.verticalSpace,
            ObxValue((p0) {
              return getPassTextFiled(
                context,
                "Enter Password",
                passController,
                getFontColor(context),
                showPass.value,
                () {
                  showPass.value = !showPass.value;
                },
                validator: (password) {
                  if (password!.isNotEmpty) {
                    return null;
                  } else {
                    return 'Please enter password';
                  }
                },
              );
            }, showPass),
            20.h.verticalSpace,
            Row(
              children: [
                ObxValue((p0) {
                  return Checkbox(
                    visualDensity: VisualDensity.compact,
                    side:
                        BorderSide(color: getAccentColor(context), width: 1.h),
                    activeColor: getAccentColor(context),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6.h))),
                    onChanged: (value) {
                      agreeTerm.value = value!;
                    },
                    value: agreeTerm.value,
                  );
                }, agreeTerm),
                getCustomFont("Remember me", 14, getFontColor(context), 1,
                    fontWeight: FontWeight.w400),
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {
                        Constant.sendToNext(context, forgotPassScreenRoute);
                      },
                      child: getCustomFont(
                          "Forgot password ?", 16, getFontColor(context), 1,
                          fontWeight: FontWeight.w400,
                          textAlign: TextAlign.end),
                    ),
                  ).paddingOnly(right: horSpace),
                ),
              ],
            ),
            getButtonFigma(
                context, getAccentColor(context), true, "Log In", Colors.white,
                () {
              setLoggedIn(true);
              Constant.sendToNext(context, homeScreenRoute);
            }, EdgeInsets.symmetric(horizontal: horSpace, vertical: 62.h)),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: [
            //     Expanded(
            //       child:
            //           getDivider(setColor: getCurrentTheme(context).hintColor),
            //       flex: 1,
            //     ),
            //     // getCustomFont(" OR Sign in with ", 16, getFontColor(context), 1,
            //     //     fontWeight: FontWeight.w400, textAlign: TextAlign.center),
            //     Expanded(
            //       child:
            //           getDivider(setColor: getCurrentTheme(context).hintColor),
            //       flex: 1,
            //     )
            //   ],
            // ).marginSymmetric(horizontal: horSpace),
            30.h.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                getCustomFont(
                  "Already have an account?",
                  16,
                  getFontBlackColor(context),
                  1,
                  fontWeight: FontWeight.w400,
                ),
                InkWell(
                  onTap: () {
                    Constant.sendToNext(context, registrationRoute);
                  },
                  child: getCustomFont(
                    " Sign up",
                    18,
                    accentColor,
                    1,
                    fontWeight: FontWeight.w700,
                  ),
                )
              ],
            )
          ],
        ));
  }
}
