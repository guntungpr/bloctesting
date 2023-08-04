import 'package:dio/dio.dart';

abstract class INetworkService {
  Future<Response> dioResponse({
    required bool isGet,
    required String path,
    required Map<String, dynamic> parameter,
  });
}
