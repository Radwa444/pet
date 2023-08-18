import 'dart:convert';

List<ModelShippingZoneCountryLocations> modelShippingZoneLocationsFromJson(
        String str) =>
    List<ModelShippingZoneCountryLocations>.from(json
        .decode(str)
        .map((x) => ModelShippingZoneCountryLocations.fromJson(x)));

String modelShippingZoneCountryLocationsToJson(
        List<ModelShippingZoneCountryLocations> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelShippingZoneCountryLocations {
  ModelShippingZoneCountryLocations({
    this.code,
  });

  String? code;

  factory ModelShippingZoneCountryLocations.fromJson(
          Map<String, dynamic> json) =>
      ModelShippingZoneCountryLocations(
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
      };
}
