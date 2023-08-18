import 'package:get/get.dart';
import '../../woocommerce/model/customer.dart';
import '../../woocommerce/woocommerce.dart';

class RegisterDataController extends GetxController {
  var isDataLoading = false.obs;

  bool isLogin = false;

  registerUser(WooCommerce wooCommerce, WooCustomer customer) async {
    isDataLoading.value = true;
    var result = await wooCommerce.createCustomer(customer);
    print("getresult===$result");
    if (result) {
      isLogin = true;
      isDataLoading.value = false;
    } else {
      isDataLoading.value = false;
    }
    // Future.delayed(Duration(seconds: 5),() {
    //   isDataLoading.value = false;
    // },);
    print("checkval===${result.toString()}");
  }
}
