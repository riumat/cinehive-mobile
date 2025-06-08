import 'package:cinehive_mobile/features/home/presentation/home_page.dart';
import 'package:cinehive_mobile/features/movie/presentation/movie_home_page.dart';
import 'package:cinehive_mobile/features/tv/presentation/tv_home_page.dart';
import 'package:flutter/material.dart';

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  final uri = Uri.parse(settings.name ?? '');
  if (uri.pathSegments.length == 2) {
    final type = uri.pathSegments[0];
    final id = uri.pathSegments[1];
    if (type == 'movie') {
      return MaterialPageRoute(builder: (context) => MovieHomePage(id: id));
    } else if (type == 'tv') {
      return MaterialPageRoute(builder: (context) => TvHomePage(id: id));
    }
  }
  // Fallback: home page
  return MaterialPageRoute(builder: (context) => const HomePage());
}
