import 'package:get/get.dart';

class AlreadyInCart extends GetxController {
  var alreadyInPurchase = false.obs;

  setPurchaseValue(bool update1, {bool isRefresh = true}) {
    print('alreadyInPurchase-------${alreadyInPurchase.value}');
    bool isSame = alreadyInPurchase.value == update1;
    alreadyInPurchase.value = update1;
    if (isRefresh) {
      update();
    } else {
      if (!isSame) {
        update();
      }
    }
  }
}
