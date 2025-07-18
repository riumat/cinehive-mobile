import 'package:cinehive_mobile/features/search/models/discover.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';

final searchDiscoverProvider = FutureProvider.family<List<MediaDiscover>, String>((
  ref,
  query,
) async {
  final baseUrl = dotenv.env["BACKEND_URL"];
  final response = await Dio().get('$baseUrl/api/v1/search?query=$query');
  
  final List<dynamic> dataList = response.data["data"] as List;
  return dataList.map((json) => MediaDiscover.fromJson(json)).toList();
});