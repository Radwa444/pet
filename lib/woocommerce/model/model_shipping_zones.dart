import 'dart:convert';

List<ModelShippingZone> modelShippingZoneFromJson(String str) =>
    List<ModelShippingZone>.from(
        json.decode(str).map((x) => ModelShippingZone.fromJson(x)));

String modelShippingZoneToJson(List<ModelShippingZone> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelShippingZone {
  ModelShippingZone({
    this.id,
    this.name,
    this.order,
    this.links,
  });

  int? id;
  String? name;
  int? order;
  Links? links;

  factory ModelShippingZone.fromJson(Map<String, dynamic> json) =>
      ModelShippingZone(
        id: json["id"],
        name: json["name"],
        order: json["order"],
        links: Links.fromJson(json["_links"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "order": order,
        "_links": links!.toJson(),
      };
}

class Links {
  Links({
    this.self,
    this.collection,
    this.describedby,
  });

  List<Collection>? self;
  List<Collection>? collection;
  List<Collection>? describedby;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        self: List<Collection>.from(
            json["self"].map((x) => Collection.fromJson(x))),
        collection: List<Collection>.from(
            json["collection"].map((x) => Collection.fromJson(x))),
        describedby: List<Collection>.from(
            json["describedby"].map((x) => Collection.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "self": List<dynamic>.from(self!.map((x) => x.toJson())),
        "collection": List<dynamic>.from(collection!.map((x) => x.toJson())),
        "describedby": List<dynamic>.from(describedby!.map((x) => x.toJson())),
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
