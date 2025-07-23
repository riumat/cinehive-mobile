import 'package:cinehive_mobile/core/services/token_storage.dart';
import 'package:cinehive_mobile/features/auth/services/auth_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiClient {
  static late Dio _dio;
  static bool _initialized = false;
  static bool _isRefreshing = false;

  static void _initialize() {
    if (_initialized) return;

    _dio = Dio(BaseOptions(
      baseUrl: dotenv.env['BACKEND_URL']!,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 60),
      sendTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
      },
    ));

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        if (await TokenStorage.isTokenExpired()) {
          final refreshToken = await TokenStorage.getRefreshToken();
          if (refreshToken != null) {
            try {
              await _refreshTokenIfNeeded();
            } catch (e) {
              await TokenStorage.clearTokens();
              handler.reject(DioException(
                requestOptions: options,
                error: 'Token expired and refresh failed',
                type: DioExceptionType.unknown,
              ));
              return;
            }
          }
        }

        final accessToken = await TokenStorage.getAccessToken();
        if (accessToken != null) {
          options.headers['Authorization'] = 'Bearer $accessToken';
        }
        handler.next(options);
      },
      
      onError: (error, handler) async {
        if (error.response?.statusCode == 401) {
          final originalRequest = error.requestOptions;
          
          try {
            await _refreshTokenIfNeeded();
            final newAccessToken = await TokenStorage.getAccessToken();
            if (newAccessToken != null) {
              originalRequest.headers['Authorization'] = 'Bearer $newAccessToken';
            }

            final retryDio = Dio(BaseOptions( //render cold start
                baseUrl: _dio.options.baseUrl,
                connectTimeout: const Duration(seconds: 45),
                receiveTimeout: const Duration(seconds: 90),
                sendTimeout: const Duration(seconds: 45),
              ));
            
            final response = await retryDio.fetch(originalRequest);
            handler.resolve(response);
          } catch (e) {
            await TokenStorage.clearTokens();
            handler.reject(DioException(
              requestOptions: originalRequest,
              error: 'Authentication failed',
              type: DioExceptionType.unknown,
            ));
          }
        } else {
          handler.next(error);
        }
      },
    ));

    _initialized = true;
  }

  static Future<void> _refreshTokenIfNeeded() async {
    if (_isRefreshing) {
      while (_isRefreshing) {
        await Future.delayed(const Duration(milliseconds: 100));
      }
      return;
    }

    _isRefreshing = true;
    try {
      await AuthService.refreshToken();
    } finally {
      _isRefreshing = false;
    }
  }

  static Dio get dio {
    _initialize();
    return _dio;
  }

  static Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) async {
    _initialize();
    return await _dio.get(path, queryParameters: queryParameters);
  }

  static Future<Response> post(String path, {dynamic data, Map<String, dynamic>? queryParameters}) async {
    _initialize();
    return await _dio.post(path, data: data, queryParameters: queryParameters);
  }

  static Future<Response> put(String path, {dynamic data, Map<String, dynamic>? queryParameters}) async {
    _initialize();
    return await _dio.put(path, data: data, queryParameters: queryParameters);
  }

  static Future<Response> delete(String path, {Map<String, dynamic>? queryParameters}) async {
    _initialize();
    return await _dio.delete(path, queryParameters: queryParameters);
  }

  static Future<Response> patch(String path, {dynamic data, Map<String, dynamic>? queryParameters}) async {
    _initialize();
    return await _dio.patch(path, data: data, queryParameters: queryParameters);
  }
}