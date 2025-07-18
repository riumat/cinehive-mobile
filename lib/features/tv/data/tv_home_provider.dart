import 'package:cinehive_mobile/features/tv/models/tv.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';

final tvHomeProvider = FutureProvider.family<TvHome, String>((
  ref,
  id,
) async {
  final baseUrl = dotenv.env["BACKEND_URL"];
  final response = await Dio().get('$baseUrl/api/v1/tv/$id');
  return TvHome.fromJson(response.data["data"]);
});
