import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_shop/app/home/tabs/tab_cart.dart';
import 'package:pet_shop/app/home/tabs/tab_favourite.dart';
import 'package:pet_shop/app/home/tabs/tab_home.dart';
import 'package:pet_shop/app/home/tabs/tab_profile.dart';
import 'package:pet_shop/app/home/tabs/tab_search.dart';

import '../../base/BottomBar.dart';
import '../../base/color_data.dart';
import '../../base/constant.dart';
import '../../base/data_file.dart';
import '../../base/get/bottom_selection_controller.dart';
import '../../base/get/home_controller.dart';
import '../../base/get/product_data.dart';
import '../../base/widget_utils.dart';
import '../model/model_bottom_nav.dart';

class HomeScreen extends StatefulWidget {
  int pos;

  HomeScreen({Key? key, this.pos = 0}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeScreen();
  }
}

class _HomeScreen extends State<HomeScreen> {
  ProductDataController productController = Get.find<ProductDataController>();
  HomeController homeController = Get.find<HomeController>();
  final controller = Get.find<BottomItemSelectionController>();

  @override
  void initState() {
    super.initState();

    Constant.getDelayFunction(() {
      productController.getAllProductCategoryList(homeController.wooCommerce!);
      // productController.getBestSellingProductList(homeController.wooCommerce!);
      productController.getAllBannerList(homeController.wooCommerce!);
      productController.getFlashSaleList(homeController.wooCommerce!);
      productController.getNewArrivalProductList(homeController.wooCommerce!);
      // controller.bottomBarSelectedItem.value=widget.pos;
      //
      // controller.changePos(widget.pos);
    });

    // Timer.run(() {
    //   productController.getAllProductCategoryList(homeController.wooCommerce!);
    //   productController.getBestSellingProductList(homeController.wooCommerce!);
    //   productController.getAllBannerList(homeController.wooCommerce!);
    //   productController.getFlashSaleList(homeController.wooCommerce!);
    //   productController.getNewArrivalProductList(homeController.wooCommerce!);
    //   // You can call setState from here
    // });
  }

  List<Widget> bottomViewList = [
    TabHome(),
    // TabCategory(),
    TabSearch(),
    TabCart(),
    TabFavourite(),
    TabProfile(),
  ];
  List<ModelBottomNav> allBottomNavList = DataFile.getAllBottomNavList();

  @override
  Widget build(BuildContext context) {
    Constant.setupSize(context);

    // productController.getFlashSaleList(homeController.wooCommerce!);
    double bottomNavHeight = 100.h;
    return WillPopScope(
        child: Scaffold(
          backgroundColor: getScaffoldColor(context),
          appBar: getInVisibleAppBar(),
          extendBodyBehindAppBar: true,
          bottomNavigationBar: Container(
            width: double.infinity,
            height: bottomNavHeight,
            decoration: ShapeDecoration(
                shadows: const [
                  BoxShadow(
                      color: Color.fromRGBO(133, 126, 150, 0.12999999523162842),
                      offset: Offset(0, -4),
                      blurRadius: 27)
                ],
                color: getCardColor(context),
                shape: SmoothRectangleBorder(
                    borderRadius: SmoothBorderRadius.vertical(
                        top: SmoothRadius(
                            cornerRadius: 40.h, cornerSmoothing: 0.5)))),
            child: Obx(() => BottomBar(
                  onTap: (p0) {
                    controller.changePos(p0);
                  },
                  currentIndex: controller.bottomBarSelectedItem.value,
                  selectedItemColor: getAccentColor(context),
                  selectedColorOpacity: 1,
                  unselectedItemColor: getFontBlackColor(context),
                  itemShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(27.h))),
                  itemPadding:
                      EdgeInsets.symmetric(horizontal: 11.w, vertical: 8.h),
                  items: List.generate(allBottomNavList.length, (index) {
                    return BottomBarItem(
                        // title: getCustomFont(
                        //     allBottomNavList[index].title,
                        //     14,
                        //     Colors.white,
                        //     1,
                        //     fontWeight: FontWeight.w700),
                        icon: getSvgImageWithSize(
                            context, allBottomNavList[index].icon, 24.h, 24.h,
                            fit: BoxFit.scaleDown,
                            color: getFontBlackColor(context)),
                        activeIcon: getSvgImageWithSize(context,
                            allBottomNavList[index].activeIcon, 24.h, 24.h,
                            fit: BoxFit.scaleDown, color: Colors.white));
                  }),
                )),
          ),
          body: GetBuilder<BottomItemSelectionController>(
            init: BottomItemSelectionController(),
            builder: (controller) {
              return bottomViewList[controller.bottomBarSelectedItem.value];
            },
          ),
        ),
        onWillPop: () async {
          // backClick();
          Constant.closeApp();
          return false;
        });
  }
}
