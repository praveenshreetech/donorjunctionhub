// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

class RegistraModel {
  final String h_id;
  final String hospital_name;
  final String category;
  final String hospital_email;
  final String address;
  final String license_no;
  final String city;
  final String country;
  final String state;
  final String latitude;
  final String longitude;
  final String pincode;
  final File license_img;
  final File profile_img;

  RegistraModel({
    required this.h_id,
    required this.hospital_name,
    required this.category,
    required this.hospital_email,
    required this.address,
    required this.license_no,
    required this.city,
    required this.country,
    required this.state,
    required this.latitude,
    required this.longitude,
    required this.pincode,
    required this.license_img,
    required this.profile_img,
  });

  Future<Map<String, dynamic>> tomap() async {
    return <String, dynamic>{
      'h_id': h_id,
      'hospital_name': hospital_name,
      'category': category,
      'profile_img': await MultipartFile.fromFile(profile_img.path.toString(),
          contentType: MediaType('image', 'png')),
      'license_img': await MultipartFile.fromFile(license_img.path.toString(),
          contentType: MediaType('image', 'png')),
      'hospital_license': license_no,
      'hospital_email': hospital_email,
      'address': address,
      'license_no': license_no,
      'city': city,
      'country': country,
      'state': state,
      'latitude': latitude,
      "longitude": longitude,
      'pincode': pincode
    };
  }
}
