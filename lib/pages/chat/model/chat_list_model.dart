// To parse this JSON data, do
//
//     final chatListModel = chatListModelFromJson(jsonString);

import 'dart:convert';

ChatListModel chatListModelFromJson(String str) =>
    ChatListModel.fromJson(json.decode(str));

String chatListModelToJson(ChatListModel data) => json.encode(data.toJson());

class ChatListModel {
  int? status;
  List<ChatListData>? data;

  ChatListModel({
    this.status,
    this.data,
  });

  factory ChatListModel.fromJson(Map<String, dynamic> json) => ChatListModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<ChatListData>.from(
                json["data"]!.map((x) => ChatListData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ChatListData {
  String? receiverId;

  ChatListData({
    this.receiverId,
  });

  factory ChatListData.fromJson(Map<String, dynamic> json) => ChatListData(
        receiverId: json["receiver_id"],
      );

  Map<String, dynamic> toJson() => {
        "receiver_id": receiverId,
      };
}
