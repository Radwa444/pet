// To parse this JSON data, do
//
//     final modelReviewProduct = modelReviewProductFromJson(jsonString);

import 'dart:convert';

List<ModelReviewProduct> modelReviewProductFromJson(String str) =>
    List<ModelReviewProduct>.from(
        json.decode(str).map((x) => ModelReviewProduct.fromJson(x)));

String modelReviewProductToJson(List<ModelReviewProduct> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelReviewProduct {
  ModelReviewProduct({
    this.id,
    this.dateCreated,
    this.dateCreatedGmt,
    this.productId,
    this.productName,
    this.productPermalink,
    this.status,
    this.reviewer,
    this.reviewerEmail,
    this.review,
    this.rating,
    this.verified,
    this.reviewerAvatarUrls,
    this.links,
  });

  int? id;
  String? dateCreated;
  String? dateCreatedGmt;
  int? productId;
  String? productName;
  String? productPermalink;
  String? status;
  String? reviewer;
  String? reviewerEmail;
  String? review;
  int? rating;
  bool? verified;
  Map<String, String>? reviewerAvatarUrls;
  Links? links;

  factory ModelReviewProduct.fromJson(Map<String, dynamic> json) =>
      ModelReviewProduct(
        id: json["id"],
        dateCreated: json["date_created"],
        dateCreatedGmt: json["date_created_gmt"],
        productId: json["product_id"],
        productName: json["product_name"],
        productPermalink: json["product_permalink"],
        status: json["status"],
        reviewer: json["reviewer"],
        reviewerEmail: json["reviewer_email"],
        review: json["review"],
        rating: json["rating"],
        verified: json["verified"],
        reviewerAvatarUrls: Map.from(json["reviewer_avatar_urls"])
            .map((k, v) => MapEntry<String, String>(k, v)),
        links: Links.fromJson(json["_links"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date_created": dateCreated,
        "date_created_gmt": dateCreatedGmt,
        "product_id": productId,
        "product_name": productName,
        "product_permalink": productPermalink,
        "status": status,
        "reviewer": reviewer,
        "reviewer_email": reviewerEmail,
        "review": review,
        "rating": rating,
        "verified": verified,
        "reviewer_avatar_urls": Map.from(reviewerAvatarUrls!)
            .map((k, v) => MapEntry<String, dynamic>(k, v)),
        "_links": links!.toJson(),
      };
}

class Links {
  Links({
    this.self,
    this.collection,
    this.up,
  });

  List<Collection>? self;
  List<Collection>? collection;
  List<Collection>? up;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        self: List<Collection>.from(
            json["self"].map((x) => Collection.fromJson(x))),
        collection: List<Collection>.from(
            json["collection"].map((x) => Collection.fromJson(x))),
        up: List<Collection>.from(
            json["up"].map((x) => Collection.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "self": List<dynamic>.from(self!.map((x) => x.toJson())),
        "collection": List<dynamic>.from(collection!.map((x) => x.toJson())),
        "up": List<dynamic>.from(up!.map((x) => x.toJson())),
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

// class WooProductReview {
//   int? id;
//   String? dateCreated;
//   String? dateCreatedGmt;
//   int? productId;
//   String? status;
//   String? reviewer;
//   String? reviewerEmail;
//   String? review;
//   int? rating;
//   bool? verified;
//   Map<String, dynamic>? reviewerAvatarUrls;
//   WooProductReviewLinks? links;
//
//   WooProductReview(
//       {required int this.id,
//       this.dateCreated,
//       this.dateCreatedGmt,
//       this.productId,
//       this.status,
//       this.reviewer,
//       this.reviewerEmail,
//       this.review,
//       this.rating,
//       this.verified,
//       this.reviewerAvatarUrls,
//       this.links});
//
//   WooProductReview.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     dateCreated = json['date_created'];
//     dateCreatedGmt = json['date_created_gmt'];
//     productId = json['product_id'];
//     status = json['status'];
//     reviewer = json['reviewer'];
//     reviewerEmail = json['reviewer_email'];
//     review = json['review'];
//     rating = json['rating'];
//     verified = json['verified'];
//     reviewerAvatarUrls = json['reviewer_avatar_urls'] != null
//         ? (json['reviewer_avatar_urls'])
//         : null;
//     links = json['_links'] != null
//         ? new WooProductReviewLinks.fromJson(json['_links'])
//         : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['date_created'] = this.dateCreated;
//     data['date_created_gmt'] = this.dateCreatedGmt;
//     data['product_id'] = this.productId;
//     data['status'] = this.status;
//     data['reviewer'] = this.reviewer;
//     data['reviewer_email'] = this.reviewerEmail;
//     data['review'] = this.review;
//     data['rating'] = this.rating;
//     data['verified'] = this.verified;
//     if (this.reviewerAvatarUrls != null) {
//       data['reviewer_avatar_urls'] = this.reviewerAvatarUrls.toString();
//     }
//     if (this.links != null) {
//       data['_links'] = this.links!.toJson();
//     }
//     return data;
//   }
//
//   @override
//   toString() => this.toJson().toString();
// }
//
// class WooProductReviewLinks {
//   List<WooProductReviewSelf>? self;
//   List<WooProductReviewCollection>? collection;
//   List<WooProductReviewUp>? up;
//
//   WooProductReviewLinks({this.self, this.collection, this.up});
//
//   WooProductReviewLinks.fromJson(Map<String, dynamic> json) {
//     if (json['self'] != null) {
//       self = [];
//       json['self'].forEach((v) {
//         self!.add(new WooProductReviewSelf.fromJson(v));
//       });
//     }
//     if (json['collection'] != null) {
//       collection = [];
//       json['collection'].forEach((v) {
//         collection!.add(new WooProductReviewCollection.fromJson(v));
//       });
//     }
//     if (json['up'] != null) {
//       up = [];
//       json['up'].forEach((v) {
//         up!.add(new WooProductReviewUp.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.self != null) {
//       data['self'] = this.self!.map((v) => v.toJson()).toList();
//     }
//     if (this.collection != null) {
//       data['collection'] = this.collection!.map((v) => v.toJson()).toList();
//     }
//     if (this.up != null) {
//       data['up'] = this.up!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class WooProductReviewSelf {
//   String? href;
//
//   WooProductReviewSelf({this.href});
//
//   WooProductReviewSelf.fromJson(Map<String, dynamic> json) {
//     href = json['href'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['href'] = this.href;
//     return data;
//   }
// }
//
// class WooProductReviewCollection {
//   String? href;
//
//   WooProductReviewCollection({this.href});
//
//   WooProductReviewCollection.fromJson(Map<String, dynamic> json) {
//     href = json['href'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['href'] = this.href;
//     return data;
//   }
// }
//
// class WooProductReviewUp {
//   String? href;
//
//   WooProductReviewUp({this.href});
//
//   WooProductReviewUp.fromJson(Map<String, dynamic> json) {
//     href = json['href'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['href'] = this.href;
//     return data;
//   }
// }
