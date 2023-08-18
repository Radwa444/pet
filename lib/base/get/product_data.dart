import 'package:get/get.dart';
import 'package:pet_shop/app/model/model_banner.dart';
import 'package:pet_shop/app/model/product_review.dart';
import 'package:pet_shop/csc_picker/csc_picker.dart';
import 'package:pet_shop/woocommerce/model/cart.dart';
import 'package:pet_shop/woocommerce/model/model_shipping_zone_country_location.dart';
import 'package:pet_shop/woocommerce/model/model_shipping_zones.dart';
import 'package:pet_shop/woocommerce/model/product_category.dart';
import 'package:pet_shop/woocommerce/model/woo_get_created_order.dart';

import '../../app/model/woo_payment_gateway.dart';
import '../../woocommerce/model/products.dart';
import '../../woocommerce/woocommerce.dart';
import '../pref_data.dart';

class ProductDataController extends GetxController {
  var isDataLoading = false.obs;
  var isMyCartLoading = false.obs;
  var isCategoryDataLoading = false.obs;
  var isFlashDataLoading = false.obs;
  var isBannerDataLoading = false.obs;

  // var isBestSellingDataLoading = false.obs;
  var isNewArrivalDataLoading = false.obs;
  var isRecentProductDataLoading = false.obs;
  var isProductReviewLoading = false.obs;
  var isPaymentMethodLoading = false.obs;
  var isMyOrderLoading = false.obs;
  var isFavouriteLoading = false.obs;

  List<WooProduct> productList = [];
  Rx<WooCart?> myCartList = (null).obs;
  List<ModelReviewProduct> productReviewList = [];
  List<WooProduct> flashSaleList = [];

  // List<WooProduct> bestSellingProductList = [];
  List<WooProduct> newArriveProductList = [];
  List<WooProduct> recentProductList = [];
  List<ModelBanner> bannerList = [];
  List<WooProductCategory> categoryList = [];
  List<WooProduct> relatedProductList = [];
  List<WooPaymentGateway?> modelPaymentGateway = [];
  List<WooGetCreatedOrder?> myOrderList = [];
  RxList<String> favProductList = <String>[].obs;

  getAllFavouriteList(WooCommerce wooCommerce) async {
    isFavouriteLoading.value = true;
    favProductList.value = await PrefData().getFavouriteList();
    // var result = await wooCommerce.getProducts();
    // print('result-------${result.toString()}');
    // favouriteList = result;
    isFavouriteLoading.value = false;
    // print("checkval===${result.toString()}");
  }

  getAllProductList(WooCommerce wooCommerce) async {
    isDataLoading.value = true;
    var result = await wooCommerce.getProducts();

    productList = result;
    isDataLoading.value = false;
    print("checkval===${result.toString()}");
  }

  Future<String> getShippingMethodZoneId(
      WooCommerce wooCommerce, String country) async {
    String countrySet = await CSCPickerState().getCountriesCode(country) ?? "";

    print("getcountry===$countrySet");
    String zoneId = "0";
    List<ModelShippingZone> shippingZone =
        await wooCommerce.getAllShippingZone();

    if (shippingZone.isNotEmpty) {
      for (int i = 0; i < shippingZone.length; i++) {
        final response = await wooCommerce
            .getShippingZoneLocations(shippingZone[i].id.toString());
        List parseRes = response;

        List<ModelShippingZoneCountryLocations> countryList = parseRes
            .map((e) => ModelShippingZoneCountryLocations.fromJson(e))
            .toList();
        print(
            "matchaval==${countryList.length}==${countryList.contains(ModelShippingZoneCountryLocations(code: countrySet))}");

        // if (countryList.contains(ModelShippingZoneCountryLocations(code: countrySet))) {
        if (countryList.any((element) => element.code == countrySet)) {
          zoneId = shippingZone[i].id.toString();
          return zoneId;
        }
      }
    }
    print("getshippingZones===${shippingZone.length}");

    return zoneId;
  }

  getAllPaymentMethodList(WooCommerce wooCommerce) async {
    modelPaymentGateway = [];
    isPaymentMethodLoading.value = true;

    // var res = await http.get(Uri.parse("https://devsite.clientdemoweb.com/petshop/wp-json/wc/v3/payment_gateways?consumer_key=ck_608c214e855c5bfefc143ddcb2ca4ee57c4c632f&consumer_secret=cs_9c87d4d6fd23ef4e5468fcbb1723ecbce0fd9276"));

    // print("pay_res===${res.body}");

    var result = await wooCommerce.getPaymentGateways();
    result.forEach((element) {
      if (element!.enabled ?? false) {
        modelPaymentGateway.add(element);
      }
    });
    // modelPaymentGateway = result;
    isPaymentMethodLoading.value = false;
    update();
    print("checkvalpayment===${result.toString()}");
  }

  getAllCartList(WooCommerce wooCommerce) async {
    isMyCartLoading.value = true;

    var result = await wooCommerce.getCartWithoutLogin();

    myCartList.value = result;
    isMyCartLoading.value = false;
    print("checkvalcart===${result.toString()}");
  }

  getAllMyCartList(WooCommerce wooCommerce) async {
    isMyCartLoading.value = true;

    var result = await wooCommerce.getMyCart();

    myCartList.value = result;
    isMyCartLoading.value = false;
    print("checkvalcart===${result.toString()}");
  }

  getAllProductReview(WooCommerce wooCommerce, int productId) async {
    productReviewList = [];
    isProductReviewLoading.value = true;
    var result =
        await wooCommerce.getProductReviewByProductId(productId: productId);

    productReviewList = result;
    isProductReviewLoading.value = false;
    print("checkval=review==${result.toString()}");
  }

  getAllProductListByCategory(WooCommerce wooCommerce, String id) async {
    isDataLoading.value = true;
    var result = await wooCommerce.getProducts(category: id);

    productList = result;
    isDataLoading.value = false;
    print("checkval=bycat==${result.toString()}");
  }

  getListBFilter() async {
    productList.sort((a, b) {
      print('vreatedat------${a.date_created}');
      return a.date_created!.compareTo(b.date_created!);
    });
    productList.forEach((element) {
      print('vreatedat------${element.name}');
    });
    isDataLoading.refresh();

    // refresh();
  }

  getHighToLowFilter() async {
    productList.sort((a, b) {
      print('vreatedat------${a.price}');
      return b.price!.compareTo(a.price!);
    });
    productList.forEach((element) {
      print('vreatedat------${element.price}');
    });
    isDataLoading.refresh();

    // refresh();
  }

  getLowToHighFilter() async {
    productList.sort((a, b) {
      print('vreatedat------${a.price}');
      return a.price!.compareTo(b.price!);
    });
    productList.forEach((element) {
      print('vreatedat------${element.price}');
    });
    isDataLoading.refresh();

    // refresh();
  }

  // getBestSellingProductList(WooCommerce wooCommerce) async {
  //   isBestSellingDataLoading.value = true;
  //   var result = await wooCommerce.getProducts(category: "16");
  //   // var result = await wooCommerce.getProducts(category: "18");
  //
  //   bestSellingProductList = result;
  //   isBestSellingDataLoading.value = false;
  //   print("checkvalbestSelling===${result.toString()}");
  // }

  getNewArrivalProductList(WooCommerce wooCommerce) async {
    isNewArrivalDataLoading.value = true;
    var result = await wooCommerce.getProducts(category: "18");
    // var result = await wooCommerce.getProducts(category: "20");

    newArriveProductList = result;
    isNewArrivalDataLoading.value = false;
    print("checkvalbestSelling===${result.toString()}");
  }

  getRecentProductList(WooCommerce wooCommerce) async {
    /*Retrieve last modified products after a given time: /wp-json/wc/v3/products/?modified_after=2021-01-20T11:35:00
Retrieve last modified orders after a given time: /wp-json/wc/v3/orders/?modified_after=2021-01-20T18:35:00*/

    isRecentProductDataLoading.value = true;
    var result = await wooCommerce.getProducts(
      ratingCount: 4,
    );

    recentProductList = result;
    isRecentProductDataLoading.value = false;
    print("checkvalbestSelling===${result.toString()}");
  }

  getAllProductCategoryList(WooCommerce wooCommerce) async {
    isCategoryDataLoading.value = true;
    var result = await wooCommerce.getProductCategories();

    categoryList = result;
    isCategoryDataLoading.value = false;
    print("checkval===${result.toString()}");
  }

  getAllMyOrder(WooCommerce wooCommerce) async {
    print("getorder===");
    myOrderList = [];
    isMyOrderLoading.value = true;
    var result = await wooCommerce.getMyOrder();
    myOrderList = result;
    isMyOrderLoading.value = false;
    print("checkval===${result.toString()}");
  }

  getFlashSaleList(WooCommerce wooCommerce) async {
    isFlashDataLoading.value = true;
    var result = await wooCommerce.getProducts();
    // var result = await wooCommercce.getProducts(category: "17");

    flashSaleList = result;
    isFlashDataLoading.value = false;
    print("checkval===${result.toString()}");
  }

  getListFlashFilter() async {
    flashSaleList.sort((a, b) {
      print('vreatedat------${a.date_created}');
      return a.date_created!.compareTo(b.date_created!);
    });
    isFlashDataLoading.refresh();
  }

  getHighToLowFlashFilter() async {
    flashSaleList.sort((a, b) {
      print('vreatedat------${a.price}');
      return b.price!.compareTo(a.price!);
    });
    isFlashDataLoading.refresh();
  }

  getLowToHighFlashFilter() async {
    flashSaleList.sort((a, b) {
      print('vreatedat------${a.price}');
      return a.price!.compareTo(b.price!);
    });
    isFlashDataLoading.refresh();
  }

  getAllBannerList(WooCommerce wooCommerce) async {
    isBannerDataLoading.value = true;
    var result = await wooCommerce.getBanner();

    bannerList = result;
    isBannerDataLoading.value = false;
    print("checkval===${result.toString()}");
  }

  getRelatedProductList(WooCommerce wooCommerce, String id) async {
    isDataLoading.value = true;
    var result = await wooCommerce.getProducts(category: id);

    relatedProductList = result;
    isDataLoading.value = false;
    print("checkRelated===${result.toString()}");
  }
}
