// To parse this JSON data, do
//
//     final donatReqModel = donatReqModelFromJson(jsonString);

import 'dart:convert';

DonatReqModel donatReqModelFromJson(String str) =>
    DonatReqModel.fromJson(json.decode(str));

String donatReqModelToJson(DonatReqModel data) => json.encode(data.toJson());

class DonatReqModel {
  int? status;
  bool? success;
  List<PostRequest>? data;

  DonatReqModel({
    this.status,
    this.success,
    this.data,
  });

  factory DonatReqModel.fromJson(Map<String, dynamic> json) => DonatReqModel(
        status: json["status"],
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<PostRequest>.from(
                json["data"]!.map((x) => PostRequest.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "success": success,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class PostRequest {
  String? id;
  String? postId;
  String? donorId;
  String? bloodGroup;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  PostRequest({
    this.id,
    this.postId,
    this.donorId,
    this.bloodGroup,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory PostRequest.fromJson(Map<String, dynamic> json) => PostRequest(
        id: json["id"],
        postId: json["post_id"],
        donorId: json["donor_id"],
        bloodGroup: json["blood_group"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "post_id": postId,
        "donor_id": donorId,
        "blood_group": bloodGroup,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
