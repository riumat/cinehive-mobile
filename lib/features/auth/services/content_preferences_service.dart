import 'package:cinehive_mobile/core/services/api_client.dart';
import 'package:cinehive_mobile/features/auth/models/content_preferences.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class UserPreferencesService {
  static final baseUrl = dotenv.env['BACKEND_URL']!;

 

  static Future<UserPreferences> getPreferences(
    String mediaType,
    String contentId,
  ) async {
    try {
      final response = await ApiClient.get(
        '$baseUrl/api/v1/user/$mediaType/$contentId',
      );

      if (response.statusCode == 200) {
        final responseData = response.data['data'] ?? response.data;
        return UserPreferences.fromJson(responseData);
      } else {
        throw Exception('Failed to load user preferences');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return UserPreferences(watched: false, watchlisted: false, rating: 0);
      }
      throw Exception('Failed to load user preferences: ${e.message}');
    }
  }

  static Future<void> updateWatchedStatus(
    String mediaType,
    int contentId,
    String title,
    String backdropPath,
    String posterPath,
    String releaseDate,
    List<int> genres,
    double? duration,
    bool watched,
  ) async {
    try {
      if (watched) {
        await ApiClient.post(
          '$baseUrl/api/v1/user/$mediaType/$contentId',
          data: {
            'title': title,
            'backdrop_path': backdropPath,
            'poster_path': posterPath,
            'release_date': releaseDate,
            'duration': duration,
            'genres': genres,
          },
        );
      } else {
        await ApiClient.delete('$baseUrl/api/v1/user/$mediaType/$contentId');
      }
    } on DioException catch (e) {
      throw Exception('Failed to update watched status: ${e.message}');
    }
  }

  static Future<void> updateWatchlistStatus(
    String mediaType,
    int contentId,
    String title,
    String backdropPath,
    String posterPath,
    String releaseDate,
    List<int> genres,
    double? duration,
    bool watchlisted,
  ) async {
    try {
      if (watchlisted) {
        await ApiClient.post(
          '$baseUrl/api/v1/user/watchlist/$mediaType/$contentId',
          data: {
            'title': title,
            'backdrop_path': backdropPath,
            'poster_path': posterPath,
            'release_date': releaseDate,
            'duration': duration,
            'genres': genres,
          },
        );
      } else {
        await ApiClient.delete(
          '$baseUrl/api/v1/user/watchlist/$mediaType/$contentId',
        );
      }
    } on DioException catch (e) {
      throw Exception('Failed to update watched status: ${e.message}');
    }
  }

  static Future<void> updateRating(
    String mediaType,
    String mediaId,
    int rating,
  ) async {
    try {
      await ApiClient.patch(
        '$baseUrl/api/v1/user/$mediaType/$mediaId',
        data: {'rating': rating},
      );
    } on DioException catch (e) {
      throw Exception('Failed to update rating: ${e.message}');
    }
  }
}
