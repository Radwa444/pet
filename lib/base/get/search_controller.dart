import 'package:get/get.dart';
import 'package:pet_shop/base/get/product_data.dart';
import 'package:pet_shop/woocommerce/model/products.dart';

import 'home_controller.dart';

class SearchController extends GetxController {
  HomeController storageController = Get.find<HomeController>();
  ProductDataController productController = Get.find<ProductDataController>();
  bool isLoading = false;
  List<WooProduct> searchProductList = [];

  loadData(String search) async {
    searchProductList = [];
    isLoading = true;
    update();
    searchProductList =
        await storageController.wooCommerce!.getProducts(search: search);
    isLoading = false;
    update();
  }

  clearData() {
    isLoading = false;
    searchProductList.clear();
    update();
  }
}
