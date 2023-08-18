import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_shop/base/get/storage.dart';

import '../../woocommerce/model/current_currency.dart';
import '../../woocommerce/model/customer.dart';
import '../../woocommerce/woocommerce.dart';
import '../color_data.dart';

String webUrl = "https://devsite.clientdemoweb.com/petshop";
// String webUrl = "https://devsite.clientdemoweb.com/harrietcaseyart";
String consumerKey = "ck_608c214e855c5bfefc143ddcb2ca4ee57c4c632f";
// String consumerKey = "ck_aa350c2cdf4be86ae9b583c1bf2a27668cbcc144";
String consumerSecret = "cs_9c87d4d6fd23ef4e5468fcbb1723ecbce0fd9276";
// String consumerSecret = "cs_c83567d4f7183e567cc0993db6d790f49ce7de62";

class HomeController extends GetxController {
  ThemeData get theme => isDark ? getDarkThemeData() : getLightThemeData();

  bool get introAvailable => isIntroAvailable;

  // bool get isLogin => isLoggedIn;

  WooCommerce? wooCommerce;
  String? wooCommerceNonce;
  WooCurrentCurrency? wooCurrentCurrency;
  WooCustomer? currentCustomer;
  RxBool isBillingAdd = true.obs;

  updateCurrentCustomer() {
    currentCustomer = getCurrentCustomer;
    print("getcus===${currentCustomer}");
    update();
  }

  @override
  void onInit() {
    super.onInit();
    wooCommerce = WooCommerce(
      baseUrl: webUrl,
      consumerKey: consumerKey,
      consumerSecret: consumerSecret,
      isDebug: true,
    );

    currentCustomer = getCurrentCustomer;

    wooCommerce!.getNonce(currentCustomer != null);

    wooCommerce!.getCurrentCurrency().then((value) {
      wooCurrentCurrency = value;
    });
    // .
    // then((value) {
    //   wooCommerceNonce = value;
    // });
  }
}
