import 'dart:convert';

ModelResetPassRequest modelResetPassRequestFromJson(String str) =>
    ModelResetPassRequest.fromJson(json.decode(str));

String modelResetPassRequestToJson(ModelResetPassRequest data) =>
    json.encode(data.toJson());

class ModelResetPassRequest {
  ModelResetPassRequest({
    this.data,
    this.message,
  });

  Data? data;
  String? message;

  factory ModelResetPassRequest.fromJson(Map<String, dynamic> json) =>
      ModelResetPassRequest(
        data: Data.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
        "message": message,
      };
}

class Data {
  Data({
    this.status,
  });

  int? status;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
      };
}
