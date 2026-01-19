// To parse this JSON data, do
//
//     final allDonorsModel = allDonorsModelFromJson(jsonString);

import 'dart:convert';

AllDonorsModel allDonorsModelFromJson(String str) =>
    AllDonorsModel.fromJson(json.decode(str));

String allDonorsModelToJson(AllDonorsModel data) => json.encode(data.toJson());

class AllDonorsModel {
  int? status;
  bool? success;
  List<DonorData>? data;

  AllDonorsModel({
    this.status,
    this.success,
    this.data,
  });

  factory AllDonorsModel.fromJson(Map<String, dynamic> json) => AllDonorsModel(
        status: json["status"],
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<DonorData>.from(
                json["data"]!.map((x) => DonorData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "success": success,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class DonorData {
  String? id;
  String? username;
  String? name;
  String? dateOfBirth;
  String? gmail;
  String? gender;
  String? image;
  String? bloodGroup;
  String? lastDonate;
  String? mobileNumber;
  String? address;
  String? country;
  String? state;
  String? city;
  String? pinCode;
  String? latitude;
  String? longitude;
  String? otp;
  String? otpStatus;
  String? fcmKey;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  DonorData({
    this.id,
    this.username,
    this.name,
    this.dateOfBirth,
    this.gmail,
    this.gender,
    this.image,
    this.bloodGroup,
    this.lastDonate,
    this.mobileNumber,
    this.address,
    this.country,
    this.state,
    this.city,
    this.pinCode,
    this.latitude,
    this.longitude,
    this.otp,
    this.otpStatus,
    this.fcmKey,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory DonorData.fromJson(Map<String, dynamic> json) => DonorData(
        id: json["id"],
        username: json["username"],
        name: json["name"],
        dateOfBirth: json["date_of_birth"],
        gmail: json["gmail"],
        gender: json["gender"],
        image: json["image"],
        bloodGroup: json["blood_group"],
        lastDonate: json["last_donate"],
        mobileNumber: json["mobile_number"],
        address: json["address"],
        country: json["country"],
        state: json["state"],
        city: json["city"],
        pinCode: json["pin_code"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        otp: json["otp"],
        otpStatus: json["otp_status"],
        fcmKey: json["fcm_key"],
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
        "username": username,
        "name": name,
        "date_of_birth": dateOfBirth,
        "gmail": gmail,
        "gender": gender,
        "image": image,
        "blood_group": bloodGroup,
        "last_donate": lastDonate,
        "mobile_number": mobileNumber,
        "address": address,
        "country": country,
        "state": state,
        "city": city,
        "pin_code": pinCode,
        "latitude": latitude,
        "longitude": longitude,
        "otp": otp,
        "otp_status": otpStatus,
        "fcm_key": fcmKey,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
