import 'dart:convert';

List<ModelShippingZoneLocations> modelShippingZoneLocationsFromJson(
        String str) =>
    List<ModelShippingZoneLocations>.from(
        json.decode(str).map((x) => ModelShippingZoneLocations.fromJson(x)));

String modelShippingZoneLocationsToJson(
        List<ModelShippingZoneLocations> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelShippingZoneLocations {
  ModelShippingZoneLocations({
    this.code,
    this.type,
    this.links,
  });

  String? code;
  String? type;
  Links? links;

  factory ModelShippingZoneLocations.fromJson(Map<String, dynamic> json) =>
      ModelShippingZoneLocations(
        code: json["code"],
        type: json["type"],
        links: Links.fromJson(json["_links"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "type": type,
        "_links": links!.toJson(),
      };
}

class Links {
  Links({
    this.collection,
    this.describes,
  });

  List<Collection>? collection;
  List<Collection>? describes;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        collection: List<Collection>.from(
            json["collection"].map((x) => Collection.fromJson(x))),
        describes: List<Collection>.from(
            json["describes"].map((x) => Collection.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "collection": List<dynamic>.from(collection!.map((x) => x.toJson())),
        "describes": List<dynamic>.from(describes!.map((x) => x.toJson())),
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
