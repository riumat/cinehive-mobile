import 'package:cinehive_mobile/features/home/models/content.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';

final homeContentProvider = FutureProvider<Map<String, List<HomeContentItem>>>((
  ref,
) async {
  final baseUrl = dotenv.env["BACKEND_URL"];
  final response = await Dio().get('$baseUrl/api/v1/trending');
  final data = response.data["data"] as Map<String, dynamic>;
  return {
    "trending_movies":
        (data["trending_movies"] as List)
            .map((e) => HomeContentItem.fromJson(e as Map<String, dynamic>))
            .toList(),
    "trending_tv":
        (data["trending_tv"] as List)
            .map((e) => HomeContentItem.fromJson(e as Map<String, dynamic>))
            .toList(),
    "top_rated_movies":
        (data["top_rated_movies"] as List)
            .map((e) => HomeContentItem.fromJson(e as Map<String, dynamic>))
            .toList(),
    "top_rated_tv":
        (data["top_rated_tv"] as List)
            .map((e) => HomeContentItem.fromJson(e as Map<String, dynamic>))
            .toList(),
  };
});
