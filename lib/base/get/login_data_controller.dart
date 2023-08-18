import 'package:get/get.dart';
import 'package:pet_shop/base/get/home_controller.dart';
import 'package:pet_shop/base/get/storage.dart';
import 'package:pet_shop/base/widget_utils.dart';

import '../../woocommerce/model/customer.dart';
import '../../woocommerce/woocommerce.dart';

class LoginDataController extends GetxController {
  var isDataLoading = false.obs;

  // WooCustomer? customer;
  HomeController storageController = Get.find<HomeController>();

  loginUser(WooCommerce wooCommerce, String userName, String password) async {
    isDataLoading.value = true;
    var result =
        await wooCommerce.loginCustomer(username: userName, password: password);
    print("getresult===${result.toString()}---${result is WooCustomer}");
    if (result is WooCustomer) {
      storageController.currentCustomer = result;
      setCurrentUser(storageController.currentCustomer);
      update();
      isDataLoading.value = false;
    } else {
      try {
        if (result["success"] == false) {
          showCustomToast(result["message"]);
        }
      } catch (e) {
        print(e);
      }
      isDataLoading.value = false;
    }
    // Future.delayed(Duration(seconds: 5),() {
    //   isDataLoading.value = false;
    // },);
    print("checkval===${result.toString()}");
  }
}
