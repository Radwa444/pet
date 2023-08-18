import 'package:get/get.dart';
import 'package:pet_shop/app/model/model_dummy_selected_add.dart';

import '../../app/model/woo_payment_gateway.dart';
import '../../woocommerce/model/cart_item.dart';
import '../../woocommerce/model/product_variation.dart';
import '../../woocommerce/model/products.dart';

class StorageController extends GetxController {
  WooProduct? selectedProduct;
  RxInt currentQuantity = 1.obs;
  Rx<WooProductVariation?> variationModel = (null).obs;
  Rx<WooCartItem?> wooCartItem = (null).obs;

  // WooCartItem? wooCartItem;

  // var variationModel = WooProductVariation().obs;

  List<WooProductItemAttribute> attributeList = [];
  WooPaymentGateway? selectedPaymentGateway;
  ModelDummySelectedAdd? selectedShippingAddress;

  setCurrentQuantity(int quantity, {bool isRefresh = true}) {
    print("setval===$quantity");
    bool isSame = currentQuantity.value == quantity;
    currentQuantity.value = quantity;
    if (isRefresh) {
      print('Called----refresh');
      update();
    } else {
      if (!isSame) {
        print('Called----same');
        update();
      }
    }
  }

  // refreshStorageController()
  // {
  //   update();
  // }

  addCurrentQuantity() {
    currentQuantity.value = currentQuantity.value + 1;
    update();
  }

  removeCurrentQuantity() {
    currentQuantity.value = currentQuantity.value - 1;
    update();
  }

  clearProductVariation() {
    variationModel.value = null;
    attributeList = [];
  }

  setSelectedWooProduct(WooProduct product) {
    attributeList = [];
    selectedProduct = product;
    if (selectedProduct != null && selectedProduct!.attributes.isNotEmpty) {
      print("Variatiob===${selectedProduct!.attributes}");
      selectedProduct!.attributes.forEach((element) {
        if (element.variation!) {
          attributeList.add(element);
        }
      });
      print("getsize===${attributeList.length}");
    }
  }
}
