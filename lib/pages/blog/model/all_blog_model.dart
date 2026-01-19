// To parse this JSON data, do
//
//     final allBlogModel = allBlogModelFromJson(jsonString);

import 'dart:convert';

AllBlogModel allBlogModelFromJson(String str) =>
    AllBlogModel.fromJson(json.decode(str));

String allBlogModelToJson(AllBlogModel data) => json.encode(data.toJson());

class AllBlogModel {
  int? status;
  bool? success;
  List<BlogData>? data;

  AllBlogModel({
    this.status,
    this.success,
    this.data,
  });

  factory AllBlogModel.fromJson(Map<String, dynamic> json) => AllBlogModel(
        status: json["status"],
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<BlogData>.from(
                json["data"]!.map((x) => BlogData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "success": success,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class BlogData {
  String? id;
  dynamic postType;
  String? hospitalId;
  String? contactNo;
  String? campDate;
  String? category;
  String? image;
  String? title;
  String? description;
  dynamic validDate;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  BlogData({
    this.id,
    this.postType,
    this.hospitalId,
    this.contactNo,
    this.campDate,
    this.category,
    this.image,
    this.title,
    this.description,
    this.validDate,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory BlogData.fromJson(Map<String, dynamic> json) => BlogData(
        id: json["id"],
        postType: json["post_type"],
        hospitalId: json["hospital_id"],
        contactNo: json["contact_no"],
        campDate: json["camp_date"],
        category: json["category"],
        image: json["image"],
        title: json["title"],
        description: json["description"],
        validDate: json["valid_date"],
        status: json["status"].toString(),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "post_type": postType,
        "hospital_id": hospitalId,
        "contact_no": contactNo,
        "camp_date": campDate,
        "category": category,
        "image": image,
        "title": title,
        "description": description,
        "valid_date": validDate,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
