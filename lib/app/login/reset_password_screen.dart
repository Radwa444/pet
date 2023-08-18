import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../base/color_data.dart';
import '../../base/constant.dart';
import '../../base/fetch_pixels.dart';
import '../../base/get/route_key.dart';
import '../../base/widget_utils.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ResetPasswordScreen();
  }
}

class _ResetPasswordScreen extends State<ResetPasswordScreen> {
  backClick(BuildContext context) {
    Constant.backToFinish(context);
  }

  RxBool showPass = false.obs;

  // TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController newPassController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Constant.setupSize(context);

    double horSpace = FetchPixels.getDefaultHorSpaceFigma(context);
    return buildTitleDefaultWidget(context, "Reset Password", () {
      backClick(context);
    },
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            getCustomFont("New password", 16, getFontColor(context), 1,
                    fontWeight: FontWeight.w400)
                .marginSymmetric(horizontal: horSpace),
            8.h.verticalSpace,
            ObxValue((p0) {
              return getPassTextFiled(
                context,
                "Create new password",
                newPassController,
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
            getCustomFont("Confirm password", 16, getFontColor(context), 1,
                    fontWeight: FontWeight.w400)
                .marginSymmetric(horizontal: horSpace),
            8.h.verticalSpace,

            ObxValue((p0) {
              return getPassTextFiled(
                context,
                "Confirm your password",
                confirmPassController,
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
            getButtonFigma(context, getAccentColor(context), true,
                "Change Password", Colors.white, () {
              showGetDialog(context, "unlock.png", "Password Changed",
                  "Your account has been successfully\nchanged!", "Ok", () {
                backClick(context);
                Constant.sendToNext(context, loginRoute);
              },
                  dialogHeight: 464,
                  imgHeight: 146,
                  imgWidth: 146,
                  fit: BoxFit.fill);
            }, EdgeInsets.symmetric(horizontal: horSpace, vertical: 60.h)),
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
