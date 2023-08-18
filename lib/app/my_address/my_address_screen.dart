import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_shop/base/get/route_key.dart';

import '../../base/color_data.dart';
import '../../base/constant.dart';
import '../../base/widget_utils.dart';

class MyAddressScreen extends StatefulWidget {
  const MyAddressScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MyAddressScreen();
  }
}

class _MyAddressScreen extends State<MyAddressScreen> {
  backClick(BuildContext context) {
    Constant.backToPrev(context);
  }

  List list = [0];

  @override
  Widget build(BuildContext context) {
    Constant.setupSize(context);
    return WillPopScope(
      onWillPop: () async {
        backClick(context);
        return false;
      },
      child: Scaffold(
        backgroundColor: getScaffoldColor(context),
        body: Column(
          children: [
            getDefaultHeader(context, "My Address", () {
              backClick(context);
            }, isShowSearch: false),
            getVerSpace(20.h),
            Expanded(
                flex: 1,
                child: (list.isNotEmpty)
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildAddressWidget(
                            EdgeInsets.symmetric(
                                horizontal: 20.h, vertical: 10.h),
                            context,
                            "Hawaii ",
                            "1901 Thornridge Cir. Shiloh, Hawaii 81063",
                            "(319) 555-0115",
                            true,
                            () {},
                            (value) {
                              switch (value) {
                                case "edit":
                                  Constant.sendToNext(
                                      context, editAddressScreenRoute);
                                  // Constant.sendToScreen(
                                  //   EditShippingAdd(
                                  //       isBilling: true,
                                  //       isShipping: false),
                                  //   context,
                                  //       (value) {},
                                  // );
                                  break;
                                case "delete":
                                  getDialog(() {
                                    backClick(context);
                                  }, () {
                                    backClick(context);
                                  });
                                  break;
                              }
                            },
                          ),
                          Container(
                            color: getCardColor(context),
                            child: getDivider(setColor: Colors.grey.shade300)
                                .marginSymmetric(horizontal: 20.h),
                          ),
                          buildAddressWidget(
                            EdgeInsets.symmetric(
                                horizontal: 20.h, vertical: 10.h),
                            context,
                            "Kentucky",
                            "4517 Washington Ave. Manchester, Kentucky 39495",
                            "(704) 555-0127",
                            true,
                            () {},
                            (value) {
                              switch (value) {
                                case "edit":
                                  Constant.sendToNext(
                                      context, editAddressScreenRoute);
                                  // Constant.sendToScreen(
                                  //   EditShippingAdd(
                                  //       isBilling: false,
                                  //       isShipping: true),
                                  //   context,
                                  //       (value) {},
                                  // );
                                  break;
                                case "delete":
                                  getDialog(() {
                                    backClick(context);
                                  }, () {
                                    backClick(context);
                                  });
                                  break;
                              }
                            },
                          ),
                        ],
                      )
                    : getEmptyWidget(
                        context,
                        "no_add_img.svg",
                        "No Address Yet!",
                        "Add your address and lets get started.",
                        "Add", () {
                        // Constant.sendToNext(context, addShippingAddRoute);
                      })),
          ],
        ),
      ),
    );
  }

  getDialog(Function function, Function cancelFunction) {
    showGetDeleteDialog(
        context,
        "Are you sure you want to delete this address?",
        "Delete",
        () {
          function();
        },
        withCancelBtn: true,
        functionCancel: () {
          cancelFunction();
        });
  }

  Container buildAddressWidget(
    EdgeInsets margin,
    BuildContext context,
    String title,
    String add,
    String mobile,
    bool isSelected,
    Function click,
    ValueChanged? menuFunction,
  ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.h),
      color: getCardColor(context),
      child: InkWell(
        onTap: () {
          click();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: getCustomFont(title, 16, getFontColor(context), 1,
                      fontWeight: FontWeight.w600),
                ),
                PopupMenuButton(
                  onSelected: menuFunction,
                  child: getSvgImageWithSize(context, "menu.svg", 20.h, 16.h)
                      .paddingOnly(right: 20.h),
                  itemBuilder: (_) => <PopupMenuItem<String>>[
                    const PopupMenuItem<String>(
                        value: 'edit',
                        child: Text(
                          'Edit',
                          style: TextStyle(fontSize: 14),
                        )),
                    const PopupMenuItem<String>(
                        value: 'delete',
                        child: Text(
                          'Delete',
                          style: TextStyle(fontSize: 14),
                        )),
                  ],
                )
              ],
            ),
            getVerSpace(8.h),
            getCustomFont(add, 14, getFontColor(context), 2,
                fontWeight: FontWeight.w400),
            getVerSpace(8.h),
            getCustomFont(mobile, 14, getFontColor(context), 1,
                fontWeight: FontWeight.w400)
          ],
        ),
      ),
      // child: (homeController.currentCustomer!.shipping!=null)?:,
    );
  }
}
