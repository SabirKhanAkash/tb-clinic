import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tb_clinic/utils/config/api_endpoint.dart';
import 'package:tb_clinic/utils/config/app_key.dart';
import 'package:tb_clinic/utils/config/env.dart';

class ApiService {
  final Dio _dio;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  ApiService()
      : _dio = Dio(
          BaseOptions(
            baseUrl: Env().apiBaseUrl,
            connectTimeout: Duration(seconds: Env().connectionTimeout),
            receiveTimeout: Duration(seconds: Env().connectionTimeout),
          ),
        ) {
    _dio.interceptors.add(LogInterceptor(
      responseBody: true,
      requestBody: true,
      requestHeader: true,
      responseHeader: false,
      request: true,
    ));
    Future<String> refreshToken() async {
      try {
        String? refreshToken = await _secureStorage.read(key: AppKey().refreshToken);

        if (refreshToken == null) {
          throw Exception('Refresh token not found');
        }

        final response = await _dio.post(
          ApiEndpoint().refreshAccessToken,
          options: Options(headers: {"refresh": refreshToken}),
          data: {'refreshToken': refreshToken},
        );

        if (response.statusCode == 200) {
          String newAccessToken = response.data['accessToken'];
          String newRefreshToken = response.data['refreshToken'];

          await _secureStorage.write(key: AppKey().accessToken, value: newAccessToken);
          await _secureStorage.write(key: AppKey().refreshToken, value: newRefreshToken);

          return newAccessToken;
        } else {
          throw Exception('Failed to refresh token');
        }
      } catch (e) {
        throw Exception('Token refresh error: $e');
      }
    }

    // _dio.options.headers['Authorization'] = 'Bearer YOUR_TOKEN';
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          print('Request: ${options.method} ${options.path}');
          return handler.next(options); // Continue request
        },
        onResponse: (response, handler) {
          print('Response: ${response.data}');
          return handler.next(response); // Continue response
        },
        onError: (DioException e, handler) async {
          if (e.response?.statusCode == 401) {
            String newToken = await refreshToken();
            _dio.options.headers['Authorization'] = 'Bearer $newToken';

            final opts = e.requestOptions;
            final retryResponse = await _dio.fetch(opts);
            return handler.resolve(retryResponse);
          }
          return handler.next(e);
        },
      ),
    );
    _dio.options.headers['Content-Type'] = 'application/json';
  }

  Future<Response?> get(String endpoint, {Map<String, dynamic>? queryParams}) async {
    try {
      String? accessToken = await _secureStorage.read(key: AppKey().accessToken);
      _dio.options.headers['Authorization'] = 'Bearer ${accessToken ?? ""}';
      final response = await _dio.get(endpoint, queryParameters: queryParams);
      return response;
    } on DioException catch (e) {
      processErrorAndThrowException(e);
    }
  }

  Future<Response?> post(
    String endpoint,
    Map<String, dynamic> data,
  ) async {
    try {
      String? accessToken = await _secureStorage.read(key: AppKey().accessToken);
      _dio.options.headers['Authorization'] = 'Bearer ${accessToken}';
      final response = await _dio.post(endpoint, data: data);
      return response;
    } on DioException catch (e) {
      processErrorAndThrowException(e);
    }
  }

  Future<Response?> put(
    String endpoint,
    Map<String, dynamic> data,
  ) async {
    try {
      String? accessToken = await _secureStorage.read(key: AppKey().accessToken);
      _dio.options.headers['Authorization'] = 'Bearer ${accessToken ?? ""}';
      final response = await _dio.put(endpoint, data: data);
      return response;
    } on DioException catch (e) {
      processErrorAndThrowException(e);
    }
  }

  Future<Response?> patch(
    String endpoint,
    Map<String, dynamic> data,
  ) async {
    try {
      String? accessToken = await _secureStorage.read(key: AppKey().accessToken);
      _dio.options.headers['Authorization'] = 'Bearer ${accessToken ?? ""}';
      final response = await _dio.patch(endpoint, data: data);
      return response;
    } on DioException catch (e) {
      processErrorAndThrowException(e);
    }
  }

  Future<Response?> delete(
    String endpoint, {
    Map<String, dynamic>? data,
  }) async {
    try {
      String? accessToken = await _secureStorage.read(key: AppKey().accessToken);
      _dio.options.headers['Authorization'] = 'Bearer ${accessToken ?? ""}';
      final response = await _dio.delete(endpoint, data: data);
      return response;
    } on DioException catch (e) {
      processErrorAndThrowException(e);
    }
  }
}

void processErrorAndThrowException(DioException e) {
  switch (e.type) {
    case "Exception: DioExceptionType.connectionTimeout":
      throw Exception(e.response?.data['message'] ?? 'Connection timed out');
    case "Exception: DioExceptionType.sendTimeout":
      throw Exception(e.response?.data['message'] ?? 'Client side timed out');
    case "Exception: DioExceptionType.receiveTimeout":
      throw Exception(e.response?.data['message'] ?? 'Server side timed out');
    case "Exception: DioExceptionType.badCertificate":
      throw Exception(e.response?.data['message'] ?? 'Certificate error');
    case "Exception: DioExceptionType.badResponse":
      throw Exception(e.response?.data['message'] ?? 'Bad Response');
    case "Exception: DioExceptionType.cancel":
      throw Exception(e.response?.data['message'] ?? 'Cancelled from client');
    case "Exception: DioExceptionType.connectionError":
      throw Exception(e.response?.data['message'] ?? 'Internet is not available');
    default:
      throw Exception(e.response?.data['message'] ?? 'An unknown error occurred');
  }
}
