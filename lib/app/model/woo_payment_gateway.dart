import 'dart:convert';

List<WooPaymentGateway> wooPaymentGatewayFromJson(String str) =>
    List<WooPaymentGateway>.from(
        json.decode(str).map((x) => WooPaymentGateway.fromJson(x)));

String wooPaymentGatewayToJson(List<WooPaymentGateway> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WooPaymentGateway {
  WooPaymentGateway({
    this.id,
    this.title,
    this.description,
    this.order,
    this.enabled,
    this.methodTitle,
    this.methodDescription,
    this.methodSupports,
    // this.settings,
    this.links,
  });

  String? id;
  String? title;
  String? description;
  int? order;
  bool? enabled;
  String? methodTitle;
  String? methodDescription;
  List<String>? methodSupports;

  // Map<String, Setting>? settings;
  Links? links;

  factory WooPaymentGateway.fromJson(Map<String, dynamic> json) =>
      WooPaymentGateway(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        order: (json["order"].toString().isEmpty) ? null : json["order"],
        enabled: json["enabled"],
        methodTitle: json["method_title"],
        methodDescription: json["method_description"],
        methodSupports:
            List<String>.from(json["method_supports"].map((x) => x)),
        // settings: Map.from(json["settings"]).map((k, v) => MapEntry<String, Setting>(k, Setting.fromJson(v))),
        links: Links.fromJson(json["_links"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "order": order,
        "enabled": enabled,
        "method_title": methodTitle,
        "method_description": methodDescription,
        "method_supports": List<dynamic>.from(methodSupports!.map((x) => x)),
        // "settings": Map.from(settings!).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
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

class Setting {
  Setting({
    this.id,
    // this.label,
    // this.description,
    // this.type,
    // this.value,
    // this.settingDefault,
    // this.tip,
    // this.placeholder,
    // this.options,
  });

  String? id;

  // String? label;
  // String? description;
  // String? type;
  // String? value;
  // String? settingDefault;
  // String? tip;
  // String? placeholder;
  // Options? options;

  factory Setting.fromJson(Map<String, dynamic> json) => Setting(
        id: json["id"],
        // label: json["label"],
        // description: json["description"],
        // type: json["type"],
        // value: json["value"],
        // settingDefault: json["default"],
        // tip: json["tip"],
        // placeholder: json["placeholder"],
        // options: json["options"] == null ? null : Options.fromJson(json["options"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        // "label": label,
        // "description": description,
        // "type": type,
        // "value": value,
        // "default": settingDefault,
        // "tip": tip,
        // "placeholder": placeholder,
        // "options": options == null ? null : options!.toJson(),
      };
}

class Options {
  Options({
    this.flatRate,
    this.freeShipping,
    this.localPickup,
    this.sale,
    this.authorization,
  });

  String? flatRate;
  String? freeShipping;
  String? localPickup;
  String? sale;
  String? authorization;

  factory Options.fromJson(Map<String, dynamic> json) => Options(
        flatRate: json["flat_rate"] == null ? null : json["flat_rate"],
        freeShipping:
            json["free_shipping"] == null ? null : json["free_shipping"],
        localPickup: json["local_pickup"] == null ? null : json["local_pickup"],
        sale: json["sale"] == null ? null : json["sale"],
        authorization:
            json["authorization"] == null ? null : json["authorization"],
      );

  Map<String, dynamic> toJson() => {
        "flat_rate": flatRate == null ? null : flatRate,
        "free_shipping": freeShipping == null ? null : freeShipping,
        "local_pickup": localPickup == null ? null : localPickup,
        "sale": sale == null ? null : sale,
        "authorization": authorization == null ? null : authorization,
      };
}

// enum Placeholder { EMPTY, OPTIONAL, YOU_YOUREMAIL_COM }

// final placeholderValues = EnumValues({
//   "": Placeholder.EMPTY,
//   "Optional": Placeholder.OPTIONAL,
//   "you@youremail.com": Placeholder.YOU_YOUREMAIL_COM
// });
//
// class EnumValues<T> {
//   Map<String, T> map;
//   Map<T, String> reverseMap;
//
//   EnumValues(this.map);
//
//   Map<T, String> get reverse {
//     if (reverseMap == null) {
//       reverseMap = map.map((k, v) => new MapEntry(v, k));
//     }
//     return reverseMap;
//   }
// }
