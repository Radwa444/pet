import 'package:get/get.dart';
import 'package:pet_shop/base/get/already_in_cart.dart';
import 'package:pet_shop/base/get/bottom_selection_controller.dart';
import 'package:pet_shop/base/get/cart_contr/cart_controller.dart';
import 'package:pet_shop/base/get/payment_controller.dart';
import 'package:pet_shop/base/get/product_data.dart';
import 'package:pet_shop/base/get/register_data_controller.dart';
import 'package:pet_shop/base/get/search_controller.dart';

import 'cart_contr/shipping_add_controller.dart';
import 'image_controller.dart';
import 'login_data_controller.dart';
import 'storage_controller.dart';

class StoreBinding implements Bindings {
  @override
  void dependencies() {
    // Get.lazyPut(() => HomeController());
    Get.lazyPut(() => ProductDataController());
    Get.lazyPut(() => CartController());
    Get.lazyPut(() => AlreadyInCart());
    Get.lazyPut(() => PaymentController());
    Get.lazyPut(() => ImageController());

    Get.lazyPut(() => BottomItemSelectionController());
    Get.lazyPut(() => StorageController());
    Get.lazyPut(() => LoginDataController());
    Get.lazyPut(() => RegisterDataController());
    Get.lazyPut(() => ShippingAddressController());
    Get.lazyPut(() => SearchController());
  }
}
