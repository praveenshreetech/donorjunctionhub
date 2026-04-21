import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:donorjunctionhub/values/strings.dart';

class NetworkHandler {
  static final Dio dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
      sendTimeout: const Duration(seconds: 20),
      responseType: ResponseType.plain,
      followRedirects: true,
      validateStatus: (status) => status != null && status >= 200 && status < 500,
      headers: const {
        'Content-type': 'multipart/form-data',
        'Accept': 'application/json',
      },
    ),
  );

  static Future<Map<String, dynamic>> post(
      Map<String, dynamic> body, String endpoint) async {
    try {
      final response = await dio.post(
        buildUrl(endpoint),
        data: FormData.fromMap(body),
      );
      return _parseResponse(response.data, response.statusCode);
    } on DioException catch (e) {
      return _networkErrorResponse(e);
    } catch (e) {
      return _unexpectedErrorResponse(e);
    }
  }

  static Future<Map<String, dynamic>> get(String endpoint) async {
    try {
      final response = await dio.get(buildUrl(endpoint));
      return _parseResponse(response.data, response.statusCode);
    } on DioException catch (e) {
      return _networkErrorResponse(e);
    } catch (e) {
      return _unexpectedErrorResponse(e);
    }
  }

  static String buildUrl(String endpoint) {
    final value = endpoint.trim();
    if (value.isEmpty) {
      return value;
    }

    final uri = Uri.tryParse(value);
    if (uri != null && uri.hasScheme) {
      return uri.toString();
    }

    return _joinUrl(AppString.baseUrl, value);
  }

  static String buildImageUrl(String endpoint) {
    final value = endpoint.trim();
    if (value.isEmpty || value == 'null') {
      return '';
    }

    final uri = Uri.tryParse(value);
    if (uri != null && uri.hasScheme) {
      return uri.toString();
    }

    return _joinUrl(AppString.imgUrl, value);
  }

  static String _joinUrl(String base, String path) {
    final normalizedBase = base.endsWith('/') ? base.substring(0, base.length - 1) : base;
    final normalizedPath = path.startsWith('/') ? path.substring(1) : path;
    return '$normalizedBase/$normalizedPath';
  }

  static Map<String, dynamic> _parseResponse(dynamic data, int? statusCode) {
    final parsed = _normalizeResponseBody(data);
    if (parsed != null) {
      return parsed;
    }

    return {
      'success': false,
      'status': statusCode ?? 0,
      'message': 'Invalid server response',
      'data': data,
    };
  }

  static Map<String, dynamic>? _normalizeResponseBody(dynamic data) {
    if (data is Map<String, dynamic>) {
      return data;
    }

    if (data is Map) {
      return Map<String, dynamic>.from(data);
    }

    if (data is String) {
      final trimmed = data.trim();
      if (trimmed.isEmpty) {
        return {
          'success': false,
          'message': 'Empty server response',
        };
      }

      try {
        final decoded = jsonDecode(trimmed);
        if (decoded is Map<String, dynamic>) {
          return decoded;
        }
        if (decoded is Map) {
          return Map<String, dynamic>.from(decoded);
        }
        return {
          'success': false,
          'message': 'Unexpected server response',
          'data': decoded,
        };
      } catch (_) {
        return {
          'success': false,
          'message': 'Server returned a non-JSON response',
          'data': trimmed,
        };
      }
    }

    return null;
  }

  static Map<String, dynamic> _networkErrorResponse(DioException error) {
    return {
      'success': false,
      'message': error.message ?? 'Network request failed',
      'data': error.response?.data,
      'status': error.response?.statusCode ?? 0,
    };
  }

  static Map<String, dynamic> _unexpectedErrorResponse(Object error) {
    return {
      'success': false,
      'message': error.toString(),
      'status': 0,
    };
  }
}



// import 'dart:convert';
// import 'package:dio/dio.dart';

// class NetworkHandler {
//   static final Dio dio = Dio(
//     BaseOptions(
//       connectTimeout: const Duration(seconds: 10), // ✅ fix timeout
//       receiveTimeout: const Duration(seconds: 10), // ✅ fix timeout
//       sendTimeout: const Duration(seconds: 10),    // ✅ fix timeout
//     ),
//   );

//   static Future<Map<String, dynamic>> post(var body, String endponit) async {
//     try {
//       FormData data = FormData.fromMap(body);
//       var response = await dio.post(
//         buildUrl(endponit),
//         data: data,
//         options: Options(headers: {
//           'Content-type': 'multipart/form-data',
//           'Accept': 'application/json',
//         }),
//       );
//       return jsonDecode(response.data);
//     } on DioException catch (e) {
//       throw Exception('Network error: ${e.message}');
//     } catch (e) {
//       throw Exception('Unexpected error: $e');
//     }
//   }

//   static Future<dynamic> get(String endponit) async {
//     try {
//       var response = await dio.get(
//         buildUrl(endponit),
//         options: Options(headers: {
//           'Content-type': 'multipart/form-data',
//           'Accept': 'application/json',
//         }),
//       );
//       return jsonDecode(response.data);
//     } on DioException catch (e) {
//       throw Exception('Network error: ${e.message}');
//     } catch (e) {
//       throw Exception('Unexpected error: $e');
//     }
//   }

//   static String buildUrl(String endpoint) {
//     String host = "http://192.168.1.49/donorjunction_api/";
//     return host + endpoint;
//   }

//   static String buildImageUrl(String endpoint) {
//     // ✅ handle null endpoint
//     if (endpoint == 'null' || endpoint.isEmpty) return '';
//     String host = "http://192.168.1.49/donorjunction_api/assets/uploads/";
//     return host + endpoint;
//   }
// }
