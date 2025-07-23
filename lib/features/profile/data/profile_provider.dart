import 'package:cinehive_mobile/features/profile/models/profile.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinehive_mobile/features/profile/services/profile_service.dart';

final userProfileProvider = FutureProvider.autoDispose<UserProfileResponse>((ref) async {
  final response= await ProfileService.getCurrentUser();
  return response;
});

final userWatch = FutureProvider<UserWatchResponse>((ref) async {
  return await ProfileService.getUserWatch();
});

final userWatchlist = FutureProvider<UserWatchResponse>((ref) async {
  return await ProfileService.getUserWatchlist();
});


