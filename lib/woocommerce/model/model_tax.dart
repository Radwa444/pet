import 'dart:convert';

List<ModelTax> modelTaxFromJson(String str) =>
    List<ModelTax>.from(json.decode(str).map((x) => ModelTax.fromJson(x)));

String modelTaxToJson(List<ModelTax> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelTax {
  ModelTax({
    this.id,
    this.country,
    this.state,
    this.postcode,
    this.city,
    this.rate,
    this.name,
    this.priority,
    this.compound,
    this.shipping,
    this.order,
    this.modelTaxClass,
    this.postcodes,
    this.cities,
    this.links,
  });

  int? id;
  String? country;
  String? state;
  String? postcode;
  String? city;
  String? rate;
  String? name;
  int? priority;
  bool? compound;
  bool? shipping;
  int? order;
  String? modelTaxClass;
  List<String>? postcodes;
  List<String>? cities;
  Links? links;

  factory ModelTax.fromJson(Map<String, dynamic> json) => ModelTax(
        id: json["id"],
        country: json["country"],
        state: json["state"],
        postcode: json["postcode"],
        city: json["city"],
        rate: json["rate"],
        name: json["name"],
        priority: json["priority"],
        compound: json["compound"],
        shipping: json["shipping"],
        order: json["order"],
        modelTaxClass: json["class"],
        postcodes: List<String>.from(json["postcodes"].map((x) => x)),
        cities: List<String>.from(json["cities"].map((x) => x)),
        links: Links.fromJson(json["_links"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "country": country,
        "state": state,
        "postcode": postcode,
        "city": city,
        "rate": rate,
        "name": name,
        "priority": priority,
        "compound": compound,
        "shipping": shipping,
        "order": order,
        "class": modelTaxClass,
        "postcodes": List<dynamic>.from(postcodes!.map((x) => x)),
        "cities": List<dynamic>.from(cities!.map((x) => x)),
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
