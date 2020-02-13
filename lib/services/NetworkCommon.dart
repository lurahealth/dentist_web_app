// Dio singleton in Dart: https://proandroiddev.com/moving-to-flutter-first-app-experiment-e845e5704c03

import 'dart:convert';
import 'package:dio/dio.dart';

class NetworkCommon {
  static final NetworkCommon _singleton = new NetworkCommon._internal();

  factory NetworkCommon() {
    return _singleton;
  }

  NetworkCommon._internal();

  final JsonDecoder _decoder = new JsonDecoder();

  dynamic decodeResp(d) {
    var response = d as Response;
    final dynamic jsonBody = response.data;
    final statusCode = response.statusCode;

    if (statusCode < 200 || statusCode >= 300 || jsonBody == null) {
      throw new Exception("statusCode: $statusCode");
    }

    if (jsonBody is String) {
      return _decoder.convert(jsonBody);
    } else {
      return jsonBody;
    }
  }

  Dio get dio {
    Dio dio = new Dio();
    // handle timeouts
    dio.options.connectTimeout = 20000; //5s
    dio.options.receiveTimeout = 20000;
    return dio;
  }
}