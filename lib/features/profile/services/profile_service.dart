import 'package:cinehive_mobile/core/services/api_client.dart';
import 'package:cinehive_mobile/features/profile/models/profile.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final baseUrl = dotenv.env['BACKEND_URL'];

class ProfileService {
  static Future<UserProfileResponse> getCurrentUser() async {
    try {
      final response = await ApiClient.dio.get('$baseUrl/api/v1/auth/me');
      return UserProfileResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Failed to load user profile: ${e.message}');
    }
  }

  static Future<UserWatchResponse> getUserWatch() async {
    //todo da implementare
    try {
      final response = await ApiClient.dio.get('$baseUrl/api/v1/user/watch');
      return UserWatchResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Failed to load user watch: ${e.message}');
    }
  }

  static Future<UserWatchResponse> getUserWatchlist() async {
    //todo da implementare
    try {
      final response = await ApiClient.dio.get(
        '$baseUrl/api/v1/user/watchlist',
      );
      return UserWatchResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Failed to load user watchlist: ${e.message}');
    }
  }
}
