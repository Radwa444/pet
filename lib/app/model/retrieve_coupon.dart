import 'dart:convert';

List<RetrieveCoupon> retrieveCouponFromJson(String str) =>
    List<RetrieveCoupon>.from(
        json.decode(str).map((x) => RetrieveCoupon.fromJson(x)));

String retrieveCouponToJson(List<RetrieveCoupon> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RetrieveCoupon {
  RetrieveCoupon({
    this.id,
    this.code,
    this.amount,
    this.status,
    this.dateCreated,
    this.dateCreatedGmt,
    this.dateModified,
    this.dateModifiedGmt,
    this.discountType,
    this.description,
    this.dateExpires,
    this.dateExpiresGmt,
    this.usageCount,
    this.individualUse,
    this.productIds,
    this.excludedProductIds,
    this.usageLimit,
    this.usageLimitPerUser,
    this.limitUsageToXItems,
    this.freeShipping,
    this.productCategories,
    this.excludedProductCategories,
    this.excludeSaleItems,
    this.minimumAmount,
    this.maximumAmount,
    this.emailRestrictions,
    this.usedBy,
    this.metaData,
    this.links,
  });

  int? id;
  String? code;
  String? amount;
  String? status;
  String? dateCreated;
  String? dateCreatedGmt;
  String? dateModified;
  String? dateModifiedGmt;
  String? discountType;
  String? description;
  String? dateExpires;
  String? dateExpiresGmt;
  int? usageCount;
  bool? individualUse;
  List<int>? productIds;
  List<dynamic>? excludedProductIds;
  dynamic usageLimit;
  dynamic usageLimitPerUser;
  dynamic limitUsageToXItems;
  bool? freeShipping;
  List<dynamic>? productCategories;
  List<dynamic>? excludedProductCategories;
  bool? excludeSaleItems;
  String? minimumAmount;
  String? maximumAmount;
  List<dynamic>? emailRestrictions;
  List<String>? usedBy;
  List<MetaDatum>? metaData;
  Links? links;

  factory RetrieveCoupon.fromJson(Map<String, dynamic> json) => RetrieveCoupon(
        id: json["id"],
        code: json["code"],
        amount: json["amount"],
        status: json["status"],
        dateCreated: json["date_created"],
        dateCreatedGmt: json["date_created_gmt"],
        dateModified: json["date_modified"],
        dateModifiedGmt: json["date_modified_gmt"],
        discountType: json["discount_type"],
        description: json["description"],
        dateExpires: json["date_expires"],
        dateExpiresGmt: json["date_expires_gmt"],
        usageCount: json["usage_count"],
        individualUse: json["individual_use"],
        productIds: List<int>.from(json["product_ids"].map((x) => x)),
        excludedProductIds:
            List<dynamic>.from(json["excluded_product_ids"].map((x) => x)),
        usageLimit: json["usage_limit"],
        usageLimitPerUser: json["usage_limit_per_user"],
        limitUsageToXItems: json["limit_usage_to_x_items"],
        freeShipping: json["free_shipping"],
        productCategories:
            List<dynamic>.from(json["product_categories"].map((x) => x)),
        excludedProductCategories: List<dynamic>.from(
            json["excluded_product_categories"].map((x) => x)),
        excludeSaleItems: json["exclude_sale_items"],
        minimumAmount: json["minimum_amount"],
        maximumAmount: json["maximum_amount"],
        emailRestrictions:
            List<dynamic>.from(json["email_restrictions"].map((x) => x)),
        usedBy: List<String>.from(json["used_by"].map((x) => x)),
        metaData: List<MetaDatum>.from(
            json["meta_data"].map((x) => MetaDatum.fromJson(x))),
        links: Links.fromJson(json["_links"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "amount": amount,
        "status": status,
        "date_created": dateCreated,
        "date_created_gmt": dateCreatedGmt,
        "date_modified": dateModified,
        "date_modified_gmt": dateModifiedGmt,
        "discount_type": discountType,
        "description": description,
        "date_expires": dateExpires,
        "date_expires_gmt": dateExpiresGmt,
        "usage_count": usageCount,
        "individual_use": individualUse,
        "product_ids": List<dynamic>.from(productIds!.map((x) => x)),
        "excluded_product_ids":
            List<dynamic>.from(excludedProductIds!.map((x) => x)),
        "usage_limit": usageLimit,
        "usage_limit_per_user": usageLimitPerUser,
        "limit_usage_to_x_items": limitUsageToXItems,
        "free_shipping": freeShipping,
        "product_categories":
            List<dynamic>.from(productCategories!.map((x) => x)),
        "excluded_product_categories":
            List<dynamic>.from(excludedProductCategories!.map((x) => x)),
        "exclude_sale_items": excludeSaleItems,
        "minimum_amount": minimumAmount,
        "maximum_amount": maximumAmount,
        "email_restrictions":
            List<dynamic>.from(emailRestrictions!.map((x) => x)),
        "used_by": List<dynamic>.from(usedBy!.map((x) => x)),
        "meta_data": List<dynamic>.from(metaData!.map((x) => x.toJson())),
        "_links": links!.toJson(),
      };
}

class Links {
  Links({
    this.self,
    this.collection,
  });

  List<Collection>? self;
  List<Collection>? collection;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        self: List<Collection>.from(
            json["self"].map((x) => Collection.fromJson(x))),
        collection: List<Collection>.from(
            json["collection"].map((x) => Collection.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "self": List<dynamic>.from(self!.map((x) => x.toJson())),
        "collection": List<dynamic>.from(collection!.map((x) => x.toJson())),
      };
}

class Collection {
  Collection({
    this.href,
  });

  String? href;

  factory Collection.fromJson(Map<String, dynamic> json) => Collection(
        href: json["href"],
      );

  Map<String, dynamic> toJson() => {
        "href": href,
      };
}

class MetaDatum {
  MetaDatum({
    this.id,
    this.key,
    this.value,
  });

  int? id;
  String? key;
  String? value;

  factory MetaDatum.fromJson(Map<String, dynamic> json) => MetaDatum(
        id: json["id"],
        key: json["key"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "key": key,
        "value": value,
      };
}

// class RetrieveCoupon {
//   RetrieveCoupon({
//       this.id,
//       this.code,
//       this.amount,
//       this.status,
//       this.dateCreated,
//       this.dateCreatedGmt,
//       this.dateModified,
//       this.dateModifiedGmt,
//       this.discountType,
//       this.description,
//       this.dateExpires,
//       this.dateExpiresGmt,
//       this.usageCount,
//       this.individualUse,
//       this.productIds,
//       this.excludedProductIds,
//       this.usageLimit,
//       this.usageLimitPerUser,
//       this.limitUsageToXItems,
//       this.freeShipping,
//       this.productCategories,
//       this.excludedProductCategories,
//       this.excludeSaleItems,
//       this.minimumAmount,
//       this.maximumAmount,
//       this.emailRestrictions,
//       this.usedBy,
//       this.metaData,
//       this.links,});
//
//   RetrieveCoupon.fromJson(dynamic json) {
//     id = json['id'];
//     code = json['code'];
//     amount = json['amount'];
//     status = json['status'];
//     dateCreated = json['date_created'];
//     dateCreatedGmt = json['date_created_gmt'];
//     dateModified = json['date_modified'];
//     dateModifiedGmt = json['date_modified_gmt'];
//     discountType = json['discount_type'];
//     description = json['description'];
//     dateExpires = json['date_expires'];
//     dateExpiresGmt = json['date_expires_gmt'];
//     usageCount = json['usage_count'];
//     individualUse = json['individual_use'];
//     usageLimit = json['usage_limit'];
//     usageLimitPerUser = json['usage_limit_per_user'];
//     limitUsageToXItems = json['limit_usage_to_x_items'];
//     freeShipping = json['free_shipping'];
//     excludeSaleItems = json['exclude_sale_items'];
//     minimumAmount = json['minimum_amount'];
//     maximumAmount = json['maximum_amount'];
//     links = json['_links'] != null ? Links.fromJson(json['_links']) : null;
//   }
//   int? id;
//   String? code;
//   String? amount;
//   String? status;
//   String? dateCreated;
//   String? dateCreatedGmt;
//   String? dateModified;
//   String? dateModifiedGmt;
//   String? discountType;
//   String? description;
//   String? dateExpires;
//   String? dateExpiresGmt;
//   int? usageCount;
//   bool? individualUse;
//   List<int>? productIds;
//   List<dynamic>? excludedProductIds;
//   dynamic usageLimit;
//   dynamic usageLimitPerUser;
//   dynamic limitUsageToXItems;
//   bool? freeShipping;
//   List<dynamic>? productCategories;
//   List<dynamic>? excludedProductCategories;
//   bool? excludeSaleItems;
//   String? minimumAmount;
//   String? maximumAmount;
//   List<dynamic>? emailRestrictions;
//   List<dynamic>? usedBy;
//   List<dynamic>? metaData;
//   Links? links;
// RetrieveCoupon copyWith({  int? id,
//   String? code,
//   String? amount,
//   String? status,
//   String? dateCreated,
//   String? dateCreatedGmt,
//   String? dateModified,
//   String? dateModifiedGmt,
//   String? discountType,
//   String? description,
//   String? dateExpires,
//   String? dateExpiresGmt,
//   int? usageCount,
//   bool? individualUse,
//   List<int>? productIds,
//   List<dynamic>? excludedProductIds,
//   dynamic usageLimit,
//   dynamic usageLimitPerUser,
//   dynamic limitUsageToXItems,
//   bool? freeShipping,
//   List<dynamic>? productCategories,
//   List<dynamic>? excludedProductCategories,
//   bool? excludeSaleItems,
//   String? minimumAmount,
//   String? maximumAmount,
//   List<dynamic>? emailRestrictions,
//   List<dynamic>? usedBy,
//   List<dynamic>? metaData,
//   Links? links,
// }) => RetrieveCoupon(  id: id ?? this.id,
//   code: code ?? this.code,
//   amount: amount ?? this.amount,
//   status: status ?? this.status,
//   dateCreated: dateCreated ?? this.dateCreated,
//   dateCreatedGmt: dateCreatedGmt ?? this.dateCreatedGmt,
//   dateModified: dateModified ?? this.dateModified,
//   dateModifiedGmt: dateModifiedGmt ?? this.dateModifiedGmt,
//   discountType: discountType ?? this.discountType,
//   description: description ?? this.description,
//   dateExpires: dateExpires ?? this.dateExpires,
//   dateExpiresGmt: dateExpiresGmt ?? this.dateExpiresGmt,
//   usageCount: usageCount ?? this.usageCount,
//   individualUse: individualUse ?? this.individualUse,
//   productIds: productIds ?? this.productIds,
//   excludedProductIds: excludedProductIds ?? this.excludedProductIds,
//   usageLimit: usageLimit ?? this.usageLimit,
//   usageLimitPerUser: usageLimitPerUser ?? this.usageLimitPerUser,
//   limitUsageToXItems: limitUsageToXItems ?? this.limitUsageToXItems,
//   freeShipping: freeShipping ?? this.freeShipping,
//   productCategories: productCategories ?? this.productCategories,
//   excludedProductCategories: excludedProductCategories ?? this.excludedProductCategories,
//   excludeSaleItems: excludeSaleItems ?? this.excludeSaleItems,
//   minimumAmount: minimumAmount ?? this.minimumAmount,
//   maximumAmount: maximumAmount ?? this.maximumAmount,
//   emailRestrictions: emailRestrictions ?? this.emailRestrictions,
//   usedBy: usedBy ?? this.usedBy,
//   metaData: metaData ?? this.metaData,
//   links: links ?? this.links,
// );
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = id;
//     map['code'] = code;
//     map['amount'] = amount;
//     map['status'] = status;
//     map['date_created'] = dateCreated;
//     map['date_created_gmt'] = dateCreatedGmt;
//     map['date_modified'] = dateModified;
//     map['date_modified_gmt'] = dateModifiedGmt;
//     map['discount_type'] = discountType;
//     map['description'] = description;
//     map['date_expires'] = dateExpires;
//     map['date_expires_gmt'] = dateExpiresGmt;
//     map['usage_count'] = usageCount;
//     map['individual_use'] = individualUse;
//     if (productIds != null) {
//       map['product_ids'] = productIds?.map((v) => v.toJson()).toList();
//     }
//     if (excludedProductIds != null) {
//       map['excluded_product_ids'] = excludedProductIds?.map((v) => v.toJson()).toList();
//     }
//     map['usage_limit'] = usageLimit;
//     map['usage_limit_per_user'] = usageLimitPerUser;
//     map['limit_usage_to_x_items'] = limitUsageToXItems;
//     map['free_shipping'] = freeShipping;
//     if (productCategories != null) {
//       map['product_categories'] = productCategories?.map((v) => v.toJson()).toList();
//     }
//     if (excludedProductCategories != null) {
//       map['excluded_product_categories'] = excludedProductCategories?.map((v) => v.toJson()).toList();
//     }
//     map['exclude_sale_items'] = excludeSaleItems;
//     map['minimum_amount'] = minimumAmount;
//     map['maximum_amount'] = maximumAmount;
//     if (emailRestrictions != null) {
//       map['email_restrictions'] = emailRestrictions?.map((v) => v.toJson()).toList();
//     }
//     if (usedBy != null) {
//       map['used_by'] = usedBy?.map((v) => v.toJson()).toList();
//     }
//     if (metaData != null) {
//       map['meta_data'] = metaData?.map((v) => v.toJson()).toList();
//     }
//     if (links != null) {
//       map['_links'] = links?.toJson();
//     }
//     return map;
//   }
//
// }
//
// /// self : [{"href":"https://moda.maantheme.com/fashion/wp-json/wc/v3/coupons/7018"}]
// /// collection : [{"href":"https://moda.maantheme.com/fashion/wp-json/wc/v3/coupons"}]
//
// class Links {
//   Links({
//       this.self,
//       this.collection,});
//
//   Links.fromJson(dynamic json) {
//     if (json['self'] != null) {
//       self = [];
//       json['self'].forEach((v) {
//         self?.add(Self.fromJson(v));
//       });
//     }
//     if (json['collection'] != null) {
//       collection = [];
//       json['collection'].forEach((v) {
//         collection?.add(Collection.fromJson(v));
//       });
//     }
//   }
//   List<Self>? self;
//   List<Collection>? collection;
// Links copyWith({  List<Self>? self,
//   List<Collection>? collection,
// }) => Links(  self: self ?? this.self,
//   collection: collection ?? this.collection,
// );
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     if (self != null) {
//       map['self'] = self?.map((v) => v.toJson()).toList();
//     }
//     if (collection != null) {
//       map['collection'] = collection?.map((v) => v.toJson()).toList();
//     }
//     return map;
//   }
//
// }
//
// /// href : "https://moda.maantheme.com/fashion/wp-json/wc/v3/coupons"
//
// class Collection {
//   Collection({
//       this.href,});
//
//   Collection.fromJson(dynamic json) {
//     href = json['href'];
//   }
//   String? href;
// Collection copyWith({  String? href,
// }) => Collection(  href: href ?? this.href,
// );
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['href'] = href;
//     return map;
//   }
//
// }
//
// /// href : "https://moda.maantheme.com/fashion/wp-json/wc/v3/coupons/7018"
//
// class Self {
//   Self({
//       this.href,});
//
//   Self.fromJson(dynamic json) {
//     href = json['href'];
//   }
//   String? href;
// Self copyWith({  String? href,
// }) => Self(  href: href ?? this.href,
// );
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['href'] = href;
//     return map;
//   }
//
// }
