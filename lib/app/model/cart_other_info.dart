import 'package:pet_shop/woocommerce/model/product_variation.dart';

class CartOtherInfo {
  int? variationId;
  int? productId;
  String? type;
  String? productName;
  String? productImage;
  double? productPrice;
  List<Attribute>? variationList;

  // Color? productColor;
  // String? productSize;
  int? quantity;
  String? stockStatus;

  CartOtherInfo({
    this.variationId,
    this.variationList,
    this.productId,
    this.type,
    this.productName,
    this.productImage,
    this.productPrice,
    // this.productColor,
    // this.productSize,
    this.quantity,
    this.stockStatus,
  });
}
