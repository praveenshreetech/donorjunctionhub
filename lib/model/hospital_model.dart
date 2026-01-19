// To parse this JSON data, do
//
//     final hospitalModel = hospitalModelFromJson(jsonString);

import 'dart:convert';

HospitalModel hospitalModelFromJson(String str) =>
    HospitalModel.fromJson(json.decode(str));

String hospitalModelToJson(HospitalModel data) => json.encode(data.toJson());

class HospitalModel {
  int? status;
  bool? success;
  HospitalDetails? data;

  HospitalModel({
    this.status,
    this.success,
    this.data,
  });

  factory HospitalModel.fromJson(Map<String, dynamic> json) => HospitalModel(
        status: json["status"],
        success: json["success"],
        data: json["data"] == null
            ? null
            : HospitalDetails.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "success": success,
        "data": data?.toJson(),
      };
}

class HospitalDetails {
  String? id;
  String? hospitalId;
  String? category;
  String? hospitalName;
  String? hospitalEmail;
  String? licenseNo;
  String? licenseImg;
  String? mobileNo;
  String? otp;
  String? latitude;
  String? longitude;
  String? address;
  String? city;
  String? state;
  String? country;
  String? hospitalImages;
  String? pincode;
  String? otpStatus;
  String? fcmKey;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  HospitalDetails({
    this.id,
    this.hospitalId,
    this.category,
    this.hospitalName,
    this.hospitalEmail,
    this.licenseNo,
    this.licenseImg,
    this.mobileNo,
    this.otp,
    this.latitude,
    this.longitude,
    this.address,
    this.city,
    this.state,
    this.country,
    this.hospitalImages,
    this.pincode,
    this.otpStatus,
    this.fcmKey,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory HospitalDetails.fromJson(Map<String, dynamic> json) =>
      HospitalDetails(
        id: json["id"],
        hospitalId: json["hospital_id"],
        category: json["category"],
        hospitalName: json["hospital_name"],
        hospitalEmail: json["hospital_email"],
        licenseNo: json["license_no"],
        licenseImg: json["license_img"],
        mobileNo: json["mobile_no"],
        otp: json["otp"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        address: json["address"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        hospitalImages: json["hospital_images"],
        pincode: json["pincode"],
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
        "hospital_id": hospitalId,
        "category": category,
        "hospital_name": hospitalName,
        "hospital_email": hospitalEmail,
        "license_no": licenseNo,
        "license_img": licenseImg,
        "mobile_no": mobileNo,
        "otp": otp,
        "latitude": latitude,
        "longitude": longitude,
        "address": address,
        "city": city,
        "state": state,
        "country": country,
        "hospital_images": hospitalImages,
        "pincode": pincode,
        "otp_status": otpStatus,
        "fcm_key": fcmKey,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
