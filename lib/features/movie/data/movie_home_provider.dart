import 'package:cinehive_mobile/features/movie/models/movie.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';

final movieHomeProvider = FutureProvider.family<MovieHome, String>((
  ref,
  id,
) async {
  final baseUrl = dotenv.env["BACKEND_URL"];
  final response = await Dio().get('$baseUrl/api/v1/movie/$id');
  return MovieHome.fromJson(response.data["data"]);
});
