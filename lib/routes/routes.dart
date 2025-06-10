import 'package:cinehive_mobile/features/home/presentation/home_page.dart';
import 'package:cinehive_mobile/features/movie/presentation/movie_home_page.dart';
import 'package:cinehive_mobile/features/shared/main_layout.dart';
import 'package:cinehive_mobile/features/tv/presentation/tv_home_page.dart';
import 'package:flutter/material.dart';

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  final uri = Uri.parse(settings.name ?? '/');

  Widget page;
  if (uri.pathSegments.length == 2) {
    final type = uri.pathSegments[0];
    final id = uri.pathSegments[1];
    if (type == 'movie') {
      page = MovieHomePage(id: id);
    } else if (type == 'tv') {
      page = TvHomePage(id: id);
    } else if (type == 'person') {
      page = const Center(child: Text('TODO Person Page'));
    } else {
      page = const HomePage();
    }
  } else {
    page = const HomePage();
  }

  return MaterialPageRoute(builder: (context) => MainLayout(body: page));
}
