import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../base/color_data.dart';
import '../../base/constant.dart';
import '../../base/fetch_pixels.dart';
import '../../base/get/home_controller.dart';
import '../../base/get/image_controller.dart';
import '../../base/widget_utils.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _EditProfile();
  }
}

class _EditProfile extends State<EditProfile> {
  final imageController = Get.put(ImageController());

  onBackClick(BuildContext context) {
    // Get.delete<ImageController>();
    Constant.backToPrev(context);
  }

  HomeController homeController = Get.find<HomeController>();

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    nameController.text = "Leslie Alexander";
    phoneController.text = "(684) 555-0102";
    emailController.text = "lesliealexander@gmail.com";
    super.initState();
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
              getDefaultHeader(context, "Edit Profile", () {
                onBackClick(context);
              }, isShowSearch: false),
              Expanded(
                  child: ListView(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                children: [
                  30.h.verticalSpace,
                  Center(
                    child: getCircleProfileImage(context, "L", 90.h),
                  ),
                  48.h.verticalSpace,
                  getDefaultUnderlineTextFiled(
                    context,
                    'Name',
                    nameController,
                    getFontHint(context),
                    (value) {},
                  ),
                  30.h.verticalSpace,
                  getDefaultUnderlineTextFiled(
                    context,
                    'Email Address',
                    emailController,
                    getFontHint(context),
                    (value) {},
                  ),
                  30.h.verticalSpace,
                  getDefaultUnderlineTextFiled(
                    context,
                    'Phone Number',
                    phoneController,
                    getFontHint(context),
                    (value) {},
                  ),
                ],
              )),
              getButtonFigma(context, getAccentColor(context), true, 'Save',
                      Colors.white, () async {
                Constant.backToPrev(context);
                // // await EasyLoading.show();
                // // if (imageController.imagePath.value.isNotEmpty) {
                // //   await homeController.wooCommerce!.updateCustomerWithImage(
                // //       id: homeController.currentCustomer!.id!,
                // //       data: {
                // //         "first_name": "name",
                // //         "email": emailController.text.toString(),
                // //         "billing":
                // //             "{'phone': ${phoneController.text.toString()}}"
                // //       },
                // //       imgPath: imageController.imagePath.value.toString());
                // // } else {
                //   await homeController.wooCommerce!.updateCustomer(
                //       id: homeController.currentCustomer!.id!,
                //       data: {
                //         "first_name": nameController.text.toString(),
                //         "email": emailController.text.toString(),
                //         "avatar_url": "https://en.gravatar.com/avatar/dfdaafd0950fe22715d2bc323e7b3bdf",
                //         "billing": {"phone": phoneController.text.toString()}
                //       });
                // // }
                // // homeController.currentCustomer=getCurrentCustomer;
                // homeController.updateCurrentCustomer();
                //
                // // homeController.updateCurrentCustomer();
                // await EasyLoading.dismiss();
                // onBackClick(context);
                // // Constant.sendToNext(context, myProfileRoute);
                //
                // // Constant.sendToNext(context, editProfileRoute);
              }, edgeInsets)
                  .marginSymmetric(vertical: 30.h),
            ],
          ),
        ),
        onWillPop: () async {
          onBackClick(context);
          return false;
        });

    // return getScreenDetailDefaultView(
    //   context,
    //   'Edit Profile',
    //   () {
    //     onBackClick(context);
    //   },
    //   Column(
    //     children: [
    //       Expanded(
    //         flex: 1,
    //         child: ListView(
    //           shrinkWrap: true,
    //           children: [
    //             50.h.verticalSpace,
    //             getProfileCell(context),
    //             40.h.verticalSpace,
    //             getDefaultTextFiled(
    //               context,
    //               "Full Name",
    //               nameController,
    //               getFontGreyColor(context),
    //               (value) {},
    //             ),
    //             20.h.verticalSpace,
    //             getDefaultTextFiled(
    //               context,
    //               "Phone",
    //               phoneController,
    //               getFontGreyColor(context),
    //               (value) {},
    //             ),
    //             20.h.verticalSpace,
    //             getDefaultTextFiled(
    //               context,
    //               "Email",
    //               emailController,
    //               getFontGreyColor(context),
    //               (value) {},
    //             ),
    //             20.h.verticalSpace,
    //           ],
    //         ),
    //       ),
    //       getButtonFigma(
    //         context,
    //         getAccentColor(context),
    //         true,
    //         'Save profile',
    //         Colors.white,
    //         () {
    //           onBackClick(context);
    //         },
    //         EdgeInsets.zero,
    //       ).marginSymmetric(horizontal: horSpace),
    //       30.h.verticalSpace,
    //     ],
    //   ),
    // );
  }

  getProfileCell(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 90.h,
        height: 90.h,
        child: Stack(
          children: [
            Positioned.fill(
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Obx(
                    () => getCircleImageProfile(
                      context,
                      (imageController.imagePath.value.isNotEmpty)
                          ? imageController.imagePath.value
                          : homeController.currentCustomer!.avatarUrl ?? "",
                      100.h,
                      fileImage: (imageController.imagePath.value.isNotEmpty),
                    ),
                  )),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomRight,
                child: InkWell(
                  onTap: () {
                    imageController.getImage();
                  },
                  child: Container(
                    width: 32.h,
                    height: 32.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x2d7a6054),
                          blurRadius: 23,
                          offset: Offset(1, 8),
                        ),
                      ],
                      color: Colors.white,
                    ),
                    child: Center(
                      child: getSvgImage(
                        context,
                        'camera.svg',
                        18,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
