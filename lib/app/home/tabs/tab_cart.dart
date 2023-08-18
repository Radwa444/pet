import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pet_shop/app/cart/cart_comman_widget.dart';
import 'package:pet_shop/base/constant.dart';
import 'package:pet_shop/base/widget_utils.dart';

class TabCart extends StatelessWidget {
  const TabCart({Key? key}) : super(key: key);

  // TextEditingController searchController = TextEditingController();
  // SearchController search = Get.find<SearchController>();
  // RxBool listChange=false.obs;

  @override
  Widget build(BuildContext context) {
    Constant.setupSize(context);
    // Future.delayed(Duration.zero,() {
    //   productController.getAllMyOrder(homeController.wooCommerce!);
    // },);

    return Column(
      children: [
        getDefaultHeader(context, "Cart", () {}, isShowSearch: false),
        Expanded(
          flex: 1,
          child: const CartCommonWidget(),
        )
      ],
    );
  }
}
