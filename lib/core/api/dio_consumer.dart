
import 'package:dio/dio.dart';
import 'package:ebn_el_hytham/core/api/api_consumer.dart';
import 'package:ebn_el_hytham/core/errors/server_exception.dart';

class DioConsumer extends ApiConsumer {
  Dio dio;
  DioConsumer({required this.dio, required String baseUrl}) {
    dio.options.baseUrl = baseUrl;
    
    dio.options.contentType = Headers.jsonContentType;
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
  }

  @override
  Future get(String url, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await dio.get(url, queryParameters: queryParameters);
      return response.data;
    } on DioException catch (e) {
      errorHandler(e);
    }
  }

  @override
  Future<dynamic> delete(
    String path, {
    Object? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.delete(
        path,
        queryParameters: queryParameters,
        data: body,
      );
      return response.data;
    } on DioException catch (e) {
      errorHandler(e);
    }
  }

  @override
  Future<dynamic> post(
    String path, {
    Object? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.post(
        path,
        queryParameters: queryParameters,
        data: body,
      );
      return response.data;
    } on DioException catch (e) {
      errorHandler(e);
    }
  }

  @override
  Future<dynamic> put(
    String path, {
    Object? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.put(
        path,
        queryParameters: queryParameters,
        data: body,
      );
      return response.data;
    } on DioException catch (e) {
      errorHandler(e);
    }
  }

  void errorHandler(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        throw ServerException('Connection timeout with Api server');
      case DioExceptionType.sendTimeout:
        throw ServerException('Send timeout with Api server');
      case DioExceptionType.receiveTimeout:
        throw ServerException('Receive timeout with Api server');
      case DioExceptionType.badCertificate:
        throw ServerException('Bad certificate with Api server');
      case DioExceptionType.badResponse:
        throw ServerException('Bad response with Api server');
      case DioExceptionType.cancel:
        throw ServerException('Request to Api server was canceled');
      case DioExceptionType.connectionError:
        throw ServerException('Connection error with Api server');
      case DioExceptionType.unknown:
        throw ServerException('Unexpected error occurred');
    }
  }
}
