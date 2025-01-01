import 'package:hospital_management_app/core/services/api_service.dart';
import 'package:hospital_management_app/data/models/data_model/data.dart';
import 'package:hospital_management_app/utils/config/env.dart';

class AuthRepository {
  final ApiService apiService;

  AuthRepository({required this.apiService});

  Future<Data>? login(Map<String, dynamic> body) async {
    dynamic json;
    try {
      json = await apiService.callApi("POST", Uri.parse('${Env().apiBaseUrl}/auth/login'),
          {'Content-Type': 'application/json'}, body);
      if (json == null) throw Exception('Bad Response');
    } catch (error) {
      throw Exception(error.toString());
    } finally {
      return Data.fromJson(json);
    }
  }
}
