import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../base/color_data.dart';
import '../../base/constant.dart';
import '../../base/fetch_pixels.dart';
import '../../base/get/route_key.dart';
import '../../base/widget_utils.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _RegistrationScreen();
  }
}

class _RegistrationScreen extends State<RegistrationScreen> {
  backClick(BuildContext context) {
    Constant.backToFinish(context);
  }

  RxBool showPass = false.obs;

  TextEditingController emailController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController pass2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Constant.setupSize(context);

    double horSpace = FetchPixels.getDefaultHorSpaceFigma(context);
    return buildTitleDefaultWidget(context, "Sign Up", () {
      backClick(context);
    },
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getCustomFont("Full Name", 16, getFontColor(context), 1,
                    fontWeight: FontWeight.w400)
                .marginSymmetric(horizontal: horSpace),
            8.h.verticalSpace,
            getDefaultTextFiled(context, "Enter your name", nameController,
                getFontColor(context), (value) {}, validator: (email) {
              if (email!.isNotEmpty) {
                return null;
              } else {
                return 'Please enter full name';
              }
            }),
            20.h.verticalSpace,
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
                "Enter your password",
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
            getCustomFont("Confirm Password", 16, getFontColor(context), 1,
                    fontWeight: FontWeight.w400)
                .marginSymmetric(horizontal: horSpace),
            8.h.verticalSpace,
            ObxValue((p0) {
              return getPassTextFiled(
                context,
                "Enter your password",
                pass2Controller,
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
            getButtonFigma(
                context, getAccentColor(context), true, "Sign Up", Colors.white,
                () {
              Constant.sendToNext(context, verificationScreenRoute);
            }, EdgeInsets.symmetric(horizontal: horSpace, vertical: 50.h)),
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
                    Constant.sendToNext(context, loginRoute);
                  },
                  child: getCustomFont(
                    " Login",
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

// class LoginScreen extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return _LoginScreen();
//   }
// }
//
// class _LoginScreen extends State<LoginScreen> {
//   backClick(BuildContext context) {
//     Constant.backToFinish(context);
//   }
//
//   RxBool showPass = false.obs;
//
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     Constant.setupSize(context);
//
//     double horSpace = FetchPixels.getDefaultHorSpaceFigma(context);
//     return buildTitleDefaultWidget(context, "Login", "Glad to meet you again! ",
//         () {
//       backClick(context);
//     },
//         Column(
//           children: [
//             getDefaultTextFiled(
//                 context, "Email", emailController, getFontColor(context),(value) {
//
//                 }),
//             20.h.verticalSpace,
//             ObxValue((p0) {
//               return getPassTextFiled(context, "Password", passController,
//                   getFontColor(context), showPass.value, () {
//                 showPass.value = !showPass.value;
//               });
//             }, showPass),
//             20.h.verticalSpace,
//             Align(
//               alignment: Alignment.bottomRight,
//               child: InkWell(
//                 onTap: () {
//                   Constant.sendToNext(context, forgotPassRoute);
//                 },
//                 child: getCustomFont(
//                     "Forgot password ?", 16, getFontColor(context), 1,
//                     fontWeight: FontWeight.w400, textAlign: TextAlign.end),
//               ),
//             ).paddingOnly(right: horSpace),
//             getButtonFigma(
//                 context,
//                 getAccentColor(context),
//                 true,
//                 "Log In",
//                 Colors.white,
//                 () {},
//                 EdgeInsets.symmetric(horizontal: horSpace, vertical: 40.h)),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Expanded(
//                   child:
//                       getDivider(setColor: getCurrentTheme(context).hintColor),
//                   flex: 1,
//                 ),
//                 getCustomFont(" OR Sign in with ", 16, getFontColor(context), 1,
//                     fontWeight: FontWeight.w400, textAlign: TextAlign.center),
//                 Expanded(
//                   child:
//                       getDivider(setColor: getCurrentTheme(context).hintColor),
//                   flex: 1,
//                 )
//               ],
//             ).marginSymmetric(horizontal: horSpace),
//             30.h.verticalSpace,
//             getButtonFigma(
//                 context,
//                 getCardColor(context),
//                 true,
//                 "Login with Google",
//                 getFontColor(context),
//                 () {},
//                 EdgeInsets.zero,
//                 isIcon: true,
//                 icons: "Google.svg",
//                 shadow: [
//                   const BoxShadow(
//                       color: Color.fromRGBO(130, 164, 131, 0.2199999988079071),
//                       offset: Offset(0, 7),
//                       blurRadius: 33)
//                 ]).marginSymmetric(horizontal: horSpace, vertical: 10.h),
//             getButtonFigma(
//                 context,
//                 getCardColor(context),
//                 true,
//                 "Login with Facebook",
//                 getFontColor(context),
//                 () {},
//                 EdgeInsets.zero,
//                 isIcon: true,
//                 icons: "Facebook.svg",
//                 shadow: [
//                   BoxShadow(
//                       color: Color.fromRGBO(130, 164, 131, 0.2199999988079071),
//                       offset: Offset(0, 7),
//                       blurRadius: 33)
//                 ]).marginSymmetric(horizontal: horSpace, vertical: 10.h),
//             80.h.verticalSpace,
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 getCustomFont(
//                   "Already have an account?",
//                   16,
//                   getFontBlackColor(context),
//                   1,
//                   fontWeight: FontWeight.w400,
//                 ),
//                 getCustomFont(
//                   " Sign up",
//                   18,
//                   getFontBlackColor(context),
//                   1,
//                   fontWeight: FontWeight.w700,
//                 )
//               ],
//             )
//           ],
//         ));
//   }
// }
