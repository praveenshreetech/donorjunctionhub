// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

NotificationModel notificationModelFromJson(String str) =>
    NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) =>
    json.encode(data.toJson());

class NotificationModel {
  int? status;
  bool? success;
  List<NotificationList>? data;

  NotificationModel({
    this.status,
    this.success,
    this.data,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        status: json["status"],
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<NotificationList>.from(
                json["data"]!.map((x) => NotificationList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "success": success,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class NotificationList {
  String? id;
  String? hId;
  String? dId;
  String? postId;
  String? content;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  NotificationList({
    this.id,
    this.hId,
    this.dId,
    this.postId,
    this.content,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory NotificationList.fromJson(Map<String, dynamic> json) =>
      NotificationList(
        id: json["id"],
        hId: json["h_id"],
        dId: json["d_id"],
        postId: json["post_id"],
        content: json["content"],
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
        "h_id": hId,
        "d_id": dId,
        "post_id": postId,
        "content": content,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
