import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@module
abstract class RegisterModule {
  @Named('baseUrl')
  String get baseUrl => 'https://dummyapi.io/data/v1/';

  @lazySingleton
  Dio dio(@Named('baseUrl') String baseUrl) {
    final Dio _dio = Dio();
    final BaseOptions options = BaseOptions(
      connectTimeout: 120000,
      receiveTimeout: 60000,
      sendTimeout: 60000,
      baseUrl: baseUrl,
    );
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback = (X509Certificate cert, String host, int port) {
        return baseUrl.contains(host);
      };
      return client;
    };
    // options.
    _dio.options = options;

    return _dio;
  }
}
