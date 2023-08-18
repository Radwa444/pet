import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_shop/base/get/route_key.dart';

import '../../base/color_data.dart';
import '../../base/constant.dart';
import '../../base/fetch_pixels.dart';
import '../../base/flutter_pin_code_fields.dart';
import '../../base/get/storage.dart';
import '../../base/widget_utils.dart';

// ignore: must_be_immutable
class VerificationScreen extends StatefulWidget {
  String email;
  bool fromResetPass;

  VerificationScreen(this.email, this.fromResetPass, {Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _VerificationScreen();
  }
}

class _VerificationScreen extends State<VerificationScreen> {
  backClick(BuildContext context) {
    Constant.backToFinish(context);
  }

  EmailOTP myauth = EmailOTP();

  // sendOtp(bool fromResend) async {
  //   await myauth.sendOTP();
  //       if(fromResend){
  //         showCustomToast('Otp send to ${widget.email}');
  //       }
  //
  // }

  TextEditingController otpController = TextEditingController();

  void initState() {
    // if(widget.fromResetPass) {
    //   Future.delayed(Duration.zero, () {
    //     myauth.setConfig(
    //         appEmail: "me@rohitchouhan.com",
    //         appName: S
    //             .of(context)
    //             .app_name,
    //         userEmail: widget.email,
    //         otpLength: 4,
    //         otpType: OTPType.digitsOnly
    //     );
    //     sendOtp(false);
    //   });
    // }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Constant.setupSize(context);

    double horSpace = FetchPixels.getDefaultHorSpaceFigma(context);
    // return getScreenDetailDefaultView(context, "", () {
    //   backClick(context);
    // },
    //     ListView(
    //       children: [
    //         buildTitleListItem(
    //             context, "Verify", "Enter code sent to your Email"),
    //         PinCodeFields(
    //           enabled: true,
    //           controller: otpController,
    //           autofocus: true,
    //           onComplete: (value) {},
    //           padding: EdgeInsets.symmetric(horizontal: horSpace),
    //           textStyle: buildTextStyle(
    //               context, getFontColor(context), FontWeight.w700, 17),
    //           fieldHeight: 50.h,
    //           fieldWidth: 50.h,
    //           responsive: false,
    //           fieldBackgroundColor: Colors.transparent,
    //           margin: EdgeInsets.symmetric(horizontal: 10.w),
    //           activeBorderColor: getAccentColor(context),
    //           fieldBorderStyle: FieldBorderStyle.square,
    //           borderWidth: 1.h,
    //           borderRadius: BorderRadius.all(Radius.circular(16.h)),
    //           borderColor: getCurrentTheme(context).hintColor,
    //         ),
    //         30.h.verticalSpace,
    //
    //         Visibility(
    //           visible: !widget.fromResetPass,
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             children: [
    //               getCustomFont(
    //                 "Don’t receive code?",
    //                 16,
    //                 getFontBlackColor(context),
    //                 1,
    //                 fontWeight: FontWeight.w400,
    //               ),
    //               GestureDetector(
    //                 onTap: (){
    //                   sendOtp(true);
    //                 },
    //                 child: getCustomFont(
    //                   " Resend",
    //                   18,
    //                   getFontBlackColor(context),
    //                   1,
    //                   fontWeight: FontWeight.w700,
    //                 ),
    //               )
    //             ],
    //           ),
    //         ),
    //         getButtonFigma(context, getAccentColor(context), true,
    //             "Verify & Proceed", Colors.white, () async {
    //
    //           if(otpController.text.length == 4 ){
    //
    //
    //             var inputOTP = otpController.text;
    //          if(widget.fromResetPass){
    //
    //          }else{
    //
    //            //which is entered by client, after receive mail
    //            bool isValid =  await myauth.verifyOTP(
    //                otp: inputOTP
    //            );
    //            if(isValid){
    //
    //
    //              showGetDialog(context, "acc_created.png", "Account Verified",
    //                  "Your account has been successfully\ncreated!", "Ok", () {
    //                    Constant.backToFinish(context);
    //                    Get.back(result: true);
    //                  },
    //                  dialogHeight: 464,
    //                  imgHeight: 146,
    //                  imgWidth: 146,
    //                  fit: BoxFit.fill);
    //
    //            }else{
    //              showCustomToast('Otp invalid');
    //            }
    //          }
    //           }else{
    //             showCustomToast('Enter valid otp');
    //           }
    //
    //         }, EdgeInsets.symmetric(horizontal: horSpace, vertical: 40.h)),
    //       ],
    //     ));

    return buildTitleDefaultWidget(context, "Verify", () {
      backClick(context);
    },
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            PinCodeFields(
              enabled: true,
              controller: otpController,
              autofocus: true,
              onComplete: (value) {},
              padding: EdgeInsets.symmetric(horizontal: horSpace),
              textStyle: buildTextStyle(
                  context, getFontColor(context), FontWeight.w600, 17),
              fieldHeight: 50.h,
              fieldWidth: 50.h,
              responsive: false,
              margin: EdgeInsets.symmetric(horizontal: 10.w),
              activeBorderColor: getFontColor(context),
              fieldBorderStyle: FieldBorderStyle.square,
              borderWidth: 1.h,
              borderRadius: BorderRadius.all(Radius.circular(16.h)),
              borderColor: getFontHint(context),
            ),
            getVerSpace(30.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                getCustomFont(
                  "Don’t receive code?",
                  16,
                  getFontBlackColor(context),
                  1,
                  fontWeight: FontWeight.w400,
                ),
                getCustomFont(
                  " Resend",
                  18,
                  getFontBlackColor(context),
                  1,
                  fontWeight: FontWeight.w700,
                )
              ],
            ),
            getButtonFigma(context, getAccentColor(context), true,
                "Verify & Proceed ", Colors.white, () {
              showGetDialog(context, "account_created.png", "Account Created",
                  "Your account has been successfully \nchanged!", "Ok", () {
                Get.back();
                setLoggedIn(true);
                Constant.sendToNext(context, loginRoute);
              }, dialogHeight: 465, imgWidth: 170, imgHeight: 162);
            }, EdgeInsets.symmetric(horizontal: horSpace, vertical: 30.h)),
          ],
        ));
  }
}
