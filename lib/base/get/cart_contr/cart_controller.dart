import 'package:get/get.dart';

import '../../../app/model/cart_other_info.dart';
import '../../../app/model/order_create_model.dart';

class CartController extends GetxController {
  var cartItems = <LineItems>[];
  List<ShippingLines> shippingLines = <ShippingLines>[];
  var coupon = <CouponLines>[];
  double promoPrice = 0;
  var cartOtherInfoList = <CartOtherInfo>[];
  RxBool inStock = true.obs;

  void clearPromoPrice() {
    promoPrice = 0;
  }

  void clearCart() {
    cartItems = [];
    shippingLines = [];
    coupon = [];
    promoPrice = 0;
    cartOtherInfoList = [];
    inStock.value = true;
    update();
  }

  void addShippingLines(ShippingLines vals) {
    shippingLines = [];
    shippingLines.add(vals);
  }

  void createLineItems() {
    cartItems.clear();
    for (var element in cartOtherInfoList) {
      cartItems.add(LineItems(
        productId: element.productId,
        quantity: element.quantity,
        variationId: element.variationId,
      ));
    }
  }

  double updatePrice(double value) {
    promoPrice = value;
    update();
    return promoPrice;
  }

  void addCoupon(CouponLines couponLines) {
    coupon.add(couponLines);
    update();
  }

  void addItemInfo(CartOtherInfo cart) {
    cartOtherInfoList.add(cart);
    createLineItems();
    update();
  }

  void removeItemInfo(String name) {
    int? id;

    for (var element in cartOtherInfoList) {
      if (element.productName!.contains(name)) {
        id = element.productId;
      }
    }

    cartOtherInfoList.remove(
        cartOtherInfoList.firstWhere((element) => element.productName == name));
    cartItems
        .remove(cartItems.firstWhere((element) => element.productId == id));
    update();
  }

  double cartTotalPriceF(quantity) {
    double cartTotalPrice = 0;
    for (var element in cartOtherInfoList) {
      cartTotalPrice = cartTotalPrice +
          (element.productPrice!.toDouble() * element.quantity!.toDouble());
    }
    return cartTotalPrice;
  }

  void increaseQuantity(int index) {
    cartOtherInfoList[index].quantity =
        cartOtherInfoList[index].quantity!.toInt() + 1;
    createLineItems();
    update();
  }

  void decreaseQuantity(int index) {
    cartOtherInfoList[index].quantity =
        cartOtherInfoList[index].quantity!.toInt() - 1;
    createLineItems();
    update();
  }

  @override
  void onInit() {
    super.onInit();
  }
}
