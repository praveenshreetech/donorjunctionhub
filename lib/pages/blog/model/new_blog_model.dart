// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

class NewBlogModel {
  final String h_id;
  final String category;
  final String title;
  final String date;
  final String contact_number;
  final String lat;
  final String long;
  final String description;
  File? images;

  NewBlogModel(
      {required this.h_id,
      required this.category,
      required this.title,
      required this.date,
      required this.contact_number,
      required this.lat,
      required this.long,
      required this.description,
      this.images});

  Future<Map<String, dynamic>> tomap() async {
    return <String, dynamic>{
      'h_id': h_id,
      'category': category,
      'title': title,
      'date': date,
      'contact_number': contact_number,
      'lat': lat,
      'long': long,
      'description': description,
      'images': images == null
          ? ''
          : await MultipartFile.fromFile(images!.path.toString(),
              contentType: MediaType('image', 'png')),
    };
  }
}
