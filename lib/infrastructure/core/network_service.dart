import 'dart:io';
import 'package:bloctesting/domain/core/i_network_service.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: INetworkService)
class NetworkService implements INetworkService {
  NetworkService(this._dio);
  final Dio _dio;

  @override
  Future<Response> dioResponse({
    required bool isGet,
    required String path,
    required Map<String, dynamic> parameter,
  }) async {
    final Map<String, dynamic> headers = {
      'content-type': ContentType.json.mimeType,
      'accept': ContentType.json.mimeType,
      'app-id': '64ccf449b323ca812847ad5f',
    };
    _dio.options.headers = headers;

    final Response response =
        isGet ? await _dio.get(path) : await _dio.post(path, data: parameter);

    return response;
  }
}
