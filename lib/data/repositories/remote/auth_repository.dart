import 'package:tb_clinic/core/services/api_service.dart';
import 'package:tb_clinic/data/models/data_model/data.dart';
import 'package:tb_clinic/utils/config/api_endpoint.dart';

class AuthRepository {
  final ApiService _apiService = ApiService();

  Future<Data?> login(Map<String, dynamic> body) async {
    final response = await _apiService.post(ApiEndpoint().login, body);
    if (response?.statusCode == 200) {
      return Data.fromJson(response?.data);
    } else {
      throw Exception('Failed to login');
    }
  }
}
