// To parse this JSON data, do
//
//     final messageLIstModel = messageLIstModelFromJson(jsonString);

import 'dart:convert';

MessageLIstModel messageLIstModelFromJson(String str) =>
    MessageLIstModel.fromJson(json.decode(str));

String messageLIstModelToJson(MessageLIstModel data) =>
    json.encode(data.toJson());

class MessageLIstModel {
  int? status;
  List<MessagesList>? data;

  MessageLIstModel({
    this.status,
    this.data,
  });

  factory MessageLIstModel.fromJson(Map<String, dynamic> json) =>
      MessageLIstModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<MessagesList>.from(
                json["data"]!.map((x) => MessagesList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class MessagesList {
  String? id;
  String? hid;
  String? receiverType;
  String? senderId;
  String? receiverId;
  String? message;
  String? senderType;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  MessagesList({
    this.id,
    this.hid,
    this.receiverType,
    this.senderId,
    this.receiverId,
    this.message,
    this.senderType,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory MessagesList.fromJson(Map<String, dynamic> json) => MessagesList(
        id: json["id"],
        hid: json["hid"],
        receiverType: json["receiver_type"],
        senderId: json["sender_id"],
        receiverId: json["receiver_id"],
        message: json["message"],
        senderType: json["sender_type"],
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
        "hid": hid,
        "receiver_type": receiverType,
        "sender_id": senderId,
        "receiver_id": receiverId,
        "message": message,
        "sender_type": senderType,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
