import 'package:dio/dio.dart';
import 'package:tb_clinic/utils/config/env.dart';

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: Env().apiBaseUrl,
      connectTimeout: Duration(seconds: Env().connectionTimeout),
      receiveTimeout: Duration(seconds: Env().connectionTimeout),
    ),
  );

  Future<Response> get(String endpoint, {Map<String, dynamic>? queryParams}) async {
    try {
      final response = await _dio.get(endpoint, queryParameters: queryParams);
      return response;
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'An error occurred');
    }
  }

  Future<Response?> post(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await _dio.post(endpoint, data: data);
      return response;
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'An error occurred');
    }
  }

  Future<Response> put(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await _dio.put(endpoint, data: data);
      return response;
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'An error occurred');
    }
  }

  Future<Response> patch(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await _dio.patch(endpoint, data: data);
      return response;
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'An error occurred');
    }
  }

  Future<Response> delete(String endpoint, {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.delete(endpoint, data: data);
      return response;
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'An error occurred');
    }
  }
}
