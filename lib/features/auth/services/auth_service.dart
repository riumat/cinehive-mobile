import 'package:cinehive_mobile/core/services/token_storage.dart';
import 'package:cinehive_mobile/features/auth/models/auth.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthService {
  static final baseUrl = dotenv.env['BACKEND_URL']!;

  static Future<AuthResponse> login(LoginRequest request) async {
    try {
      final dio = Dio(); 
      final response = await dio.post(
        '$baseUrl/api/v1/auth/signin',
        data: request.toJson(),
      );

      if (response.statusCode == 200) {
        final data = response.data['data'];
        final authResponse = AuthResponse.fromJson(data);

        await TokenStorage.saveTokens(
          accessToken: authResponse.accessToken,
          refreshToken: authResponse.refreshToken,
        );

        return authResponse;
      } else {
        throw _handleError(response);
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Exception('An unexpected error occurred. Please try again.');
    }
  }

  static Future<AuthResponse> signup(SignupRequest request) async {
    try {
      final dio = Dio();
      final response = await dio.post(
        '$baseUrl/api/v1/auth/signup',
        data: {
          'email': request.email,
          'password': request.password,
          'username': request.username,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data['data'];
        final authResponse = AuthResponse.fromJson(data);

        await TokenStorage.saveTokens(
          accessToken: authResponse.accessToken,
          refreshToken: authResponse.refreshToken,
        );

        return authResponse;
      } else {
        throw _handleError(response);
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Exception('An unexpected error occurred. Please try again.');
    }
  }

  static Future<String> refreshToken() async {
    final refreshToken = await TokenStorage.getRefreshToken();
    if (refreshToken == null) throw Exception('No refresh token available');

    try {
      final dio = Dio(); 
      final response = await dio.post(
        '$baseUrl/api/v1/auth/refresh',
        data: {'refresh_token': refreshToken},
      );

      if (response.statusCode == 200) {
        final data = response.data['data'];
        final newAccessToken = data['access_token'];

        await TokenStorage.saveTokens(
          accessToken: newAccessToken,
          refreshToken: refreshToken,
        );

        return newAccessToken;
      } else {
        await TokenStorage.clearTokens();
        throw Exception('Token refresh failed');
      }
    } on DioException catch (e) {
      await TokenStorage.clearTokens();
      throw Exception('Token refresh failed: ${e.message}');
    }
  }

  static Future<void> logout() async {
    await TokenStorage.clearTokens();
    
  }

  static Future<bool> isLoggedIn() async {
    return await TokenStorage.hasValidToken();
  }


  static Exception _handleError(Response response) {
    final data = response.data;
    
    if (data is Map<String, dynamic>) {
      final message = data['message'] ?? data['error'] ?? 'Unknown error occurred';
      return Exception(message);
    }
    
    switch (response.statusCode) {
      case 400:
        return Exception('Invalid request. Please check your input.');
      case 401:
        return Exception('Invalid email or password.');
      case 403:
        return Exception('Access denied.');
      case 409:
        return Exception('An account with this email already exists.');
      case 422:
        return Exception('Invalid data provided. Please check your input.');
      case 500:
        return Exception('Server error. Please try again later.');
      default:
        return Exception('Something went wrong. Please try again.');
    }
  }

  static Exception _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return Exception('Connection timeout. Please check your internet connection.');
      
      case DioExceptionType.connectionError:
        return Exception('No internet connection. Please check your network.');
      
      case DioExceptionType.badResponse:
        if (e.response != null) {
          return _handleError(e.response!);
        }
        return Exception('Server error. Please try again later.');
      
      case DioExceptionType.cancel:
        return Exception('Request was cancelled.');
      
      case DioExceptionType.unknown:
        if (e.message?.contains('SocketException') == true) {
          return Exception('No internet connection. Please check your network.');
        }
        return Exception('An unexpected error occurred. Please try again.');
      
      default:
        return Exception('Something went wrong. Please try again.');
    }
  }
}



