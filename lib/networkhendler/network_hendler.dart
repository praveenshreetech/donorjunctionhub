import 'dart:convert';

import 'package:dio/dio.dart';

class NetworkHandler {
  static final Dio dio = Dio();

  static Future<Map<String, dynamic>> post(var body, String endponit) async {
    FormData data = FormData.fromMap(body);
    var response = await dio.post(buildUrl(endponit),
        data: data,
        options: Options(headers: {
          'Content-type': 'multipart/form-data',
          'Accept': 'application/json',
        }));

    return jsonDecode(response.data);
  }

  static Future<dynamic> get(String endponit) async {
    var response = await dio.get(buildUrl(endponit),
        options: Options(headers: {
          'Content-type': 'multipart/form-data',
          'Accept': 'application/json',
        }));
    return jsonDecode(response.data);
  }

  static String buildUrl(String endpoint) {
    String host = "";
    final apipath = host + endpoint;

    return apipath;
  }

  static String buildImageUrl(String endpoint) {
    String host =
        "http://isrdconnects.org/demosite/donorjunction/assets/uploads/";
    final apipath = host + endpoint;

    return apipath;
  }
}
