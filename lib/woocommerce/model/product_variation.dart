import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

// ignore: must_be_immutable
class WooProductVariation extends Equatable {
  int? id;
  DateTime? dateCreated;
  DateTime? dateCreatedGmt;
  DateTime? dateModified;
  DateTime? dateModifiedGmt;
  String? description;
  String? permalink;
  String? sku;
  String? price;
  String? regularPrice;
  String? salePrice;
  DateTime? dateOnSaleFrom;
  DateTime? dateOnSaleFromGmt;
  DateTime? dateOnSaleTo;
  DateTime? dateOnSaleToGmt;
  bool? onSale;
  String? status;
  bool? purchasable;
  bool? virtual;
  bool? downloadable;
  List<WooProductVariationDownload>? downloads;
  int? downloadLimit;
  int? downloadExpiry;
  String? taxStatus;
  String? taxClass;
  bool? manageStock;
  int? stockQuantity;
  String? stockStatus;
  String? backorders;
  bool? backordersAllowed;
  bool? backordered;
  List<Attribute>? attributes;
  String? weight;
  String? shippingClass;
  int? shippingClassId;
  int? menuOrder;
  WooProductVariationDimension? dimensions;
  List<WooProductVariationMetaData>? metaData;
  WooProductVariationImage? image;

  WooProductVariation(
      {this.id,
      this.dateCreated,
      this.dateCreatedGmt,
      this.dateModified,
      this.dateModifiedGmt,
      this.description,
      this.permalink,
      this.sku,
      this.price,
      this.attributes,
      this.regularPrice,
      this.salePrice,
      this.dateOnSaleFrom,
      this.dateOnSaleFromGmt,
      this.dateOnSaleTo,
      this.dateOnSaleToGmt,
      this.onSale,
      this.status,
      this.purchasable,
      this.virtual,
      this.downloadable,
      this.downloads,
      this.downloadLimit,
      this.downloadExpiry,
      this.taxStatus,
      this.taxClass,
      this.manageStock,
      this.stockQuantity,
      this.stockStatus,
      this.backorders,
      this.backordersAllowed,
      this.backordered,
      this.weight,
      this.shippingClass,
      this.shippingClassId,
      this.menuOrder,
      this.dimensions,
      this.metaData,
      this.image});

  @override
  bool operator ==(Object other) {
    WooProductVariation? productVariation =
        (other is WooProductVariation) ? other : null;
    print(
        "match===${(other is WooProductVariation)}-66${listEquals(attributes, productVariation!.attributes)}-$productVariation");
    return (listEquals(attributes, productVariation.attributes));
  }

  //
  // @override
  // // TODO: implement props
  // List<Object?> get props =>
  //     [id, sku, price, regularPrice, salePrice, attributes];

  @override
  // TODO: implement hashCode
  int get hashCode => attributes.hashCode;

  WooProductVariation.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        permalink = json['permalink'],
        status = json['status'],
        description = json['description'],
        sku = json['sku'],
        price = json['price'],
        regularPrice = json['regular_price'],
        salePrice = json['sale_price'],
        onSale = json['on_sale'],
        purchasable = json['purchasable'],
        virtual = json['virtual'],
        downloadable = json['downloadable'],
        downloads = (json['downloads'] as List)
            .map((i) => WooProductVariationDownload.fromJson(i))
            .toList(),
        downloadLimit = json['download_limit'],
        downloadExpiry = json['download_expiry'],
        taxStatus = json['tax_status'],
        taxClass = json['tax_class'],
        manageStock =
            (json['manage_stock'] != null && json['manage_stock'] is bool)
                ? json['manage_stock']
                : false,
        stockQuantity = json['stock_quantity'],
        stockStatus = json['stock_status'],
        backorders = json['backorders'],
        backordersAllowed = json['backorders_allowed'],
        weight = json['weight'],
        dimensions = WooProductVariationDimension.fromJson(json['dimensions']),
        shippingClass = json['shipping_class'],
        shippingClassId = json['shipping_class_id'],
        menuOrder = json['menu_order'],
        attributes = (json['attributes'] as List)
            .map((i) => Attribute.fromJson(i))
            .toList(),
        metaData = (json['meta_data'] as List)
            .map((i) => WooProductVariationMetaData.fromJson(i))
            .toList();

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        permalink,
        status,
        description,
        sku,
        price,
        regularPrice,
        salePrice,
        onSale,
        purchasable,
        virtual,
        downloadable,
        downloads,
        downloadLimit,
        downloadExpiry,
        taxStatus,
        taxClass,
        manageStock,
        stockQuantity,
        stockStatus,
        backorders,
        backordersAllowed,
        weight,
        dimensions,
        shippingClass,
        shippingClassId,
        menuOrder,
        attributes,
        metaData
      ];
}

class WooProductVariationMetaData {
  final int? id;
  final String? key;
  final String value;

  WooProductVariationMetaData(this.id, this.key, this.value);

  WooProductVariationMetaData.fromJson(Map<String, dynamic> json)
      : id = json['name'],
        key = json['email'],
        value = json['value'].toString();

  Map<String, dynamic> toJson() => {'id': id, 'key': key, 'value': value};
}

class WooProductVariationCategory {
  final int? id;
  final String? name;
  final String? slug;

  WooProductVariationCategory(this.id, this.name, this.slug);

  WooProductVariationCategory.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        slug = json['slug'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'slug': slug,
      };
}

class WooProductVariationDimension {
  final String? length;
  final String? width;
  final String? height;

  WooProductVariationDimension(this.length, this.height, this.width);

  WooProductVariationDimension.fromJson(Map<String, dynamic> json)
      : length = json['length'],
        width = json['width'],
        height = json['height'];

  Map<String, dynamic> toJson() =>
      {'length': length, 'width': width, 'height': height};
}

class Attribute extends Equatable {
  final int? id;
  final String? name;
  final String? option;

  Attribute(this.name, this.option, {this.id});

  Attribute.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        option = json['option'];

  @override
  bool operator ==(Object productVariation) {
    return (productVariation is Attribute &&
        productVariation.option == option &&
        productVariation.name == name);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [name, option, id];

  // List<Object?> get props => [name, option];
  /*id remain*/

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'option': option,
      };
}

class WooProductVariationDownload {
  final String? id;
  final String? name;
  final String? file;

  WooProductVariationDownload(this.id, this.name, this.file);

  WooProductVariationDownload.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        file = json['file'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'file': file,
      };
}

class WooProductVariationImage {
  final int? id;
  final DateTime dateCreated;
  final DateTime dateCreatedGMT;
  final DateTime dateModified;
  final DateTime dateModifiedGMT;
  final String? src;
  final String? name;
  final String? alt;

  WooProductVariationImage(
      this.id,
      this.src,
      this.name,
      this.alt,
      this.dateCreated,
      this.dateCreatedGMT,
      this.dateModified,
      this.dateModifiedGMT);

  WooProductVariationImage.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        src = json['src'],
        name = json['name'],
        alt = json['alt'],
        dateCreated = DateTime.parse(json['date_created']),
        dateModifiedGMT = DateTime.parse(json['date_modified_gmt']),
        dateModified = DateTime.parse(json['date_modified']),
        dateCreatedGMT = DateTime.parse(json['date_created_gmt']);
}

// // To parse this JSON data, do
// //
// //     final wooProductVariation = wooProductVariationFromJson(jsonString);
//
// import 'dart:convert';
//
// import 'package:equatable/equatable.dart';
// import 'package:flutter/foundation.dart';
//
// List<WooProductVariation> wooProductVariationFromJson(String str) =>
//     List<WooProductVariation>.from(
//         json.decode(str).map((x) => WooProductVariation.fromJson(x)));
//
// String wooProductVariationToJson(List<WooProductVariation> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
//
// class WooProductVariation extends Equatable {
//   WooProductVariation({
//     this.id,
//     this.sku,
//     this.price,
//     this.regularPrice,
//     this.salePrice,
//     this.attributes,
//   });
//
//   int? id;
//   String? sku;
//   String? price;
//   String? regularPrice;
//   String? salePrice;
//   List<Attribute>? attributes;
//
//   factory WooProductVariation.fromJson(Map<String, dynamic> json) =>
//       WooProductVariation(
//         id: json["id"],
//         sku: json["sku"],
//         price: json["price"],
//         regularPrice: json["regular_price"],
//         salePrice: json["sale_price"],
//         attributes: List<Attribute>.from(
//             json["attributes"].map((x) => Attribute.fromJson(x))),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "sku": sku,
//         "price": price,
//         "regular_price": regularPrice,
//         "sale_price": salePrice,
//         "attributes": List<dynamic>.from(attributes!.map((x) => x.toJson())),
//       };
//
//   @override
//   bool operator ==(Object other) {
//     // print("chekkktop===${other is WooProductVariation})");
//
//     WooProductVariation productVariation=(other is WooProductVariation)?other:WooProductVariation();
//     // print("chekkk===${attributes!.toList().toString()}---${productVariation.attributes!.toList().toString()}");
//     // print("chekkk===111${attributes == productVariation.attributes}---${listEquals(attributes,productVariation.attributes)}");
//     return other is WooProductVariation && listEquals(attributes,productVariation.attributes);
//             // attributes == other.attributes;
//   }
//
//   @override
//   // TODO: implement props
//   List<Object?> get props =>
//       [id, sku, price, regularPrice, salePrice, attributes];
//
//   @override
//   // TODO: implement hashCode
//   int get hashCode => attributes.hashCode;
// }
//
// class Attribute extends Equatable {
//   Attribute({
//     this.name,
//     this.option,
//   });
//
//   String? name;
//   String? option;
//
//   // @override
//   // bool operator == (Object other) {
//   //   return identical(this, other) ||
//   //       other is Attribute &&
//   //           name == other.name &&
//   //           option == other.option;
//   // }
//
//
//   // @override
//   // bool get stringify {
//   //   return false;
//   // }
//
//   factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
//         name: json["name"],
//         option: json["option"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "name": name,
//         "option": option,
//       };
//
//   @override
//   // TODO: implement props
//   List<Object?> get props => [name, option];
//
//   // @override
//   // // TODO: implement hashCode
//   // int get hashCode => name.hashCode ^ option.hashCode;
// }
