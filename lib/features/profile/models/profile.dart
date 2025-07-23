import 'package:flutter/material.dart';

class UserProfileResponse {
  final UserProfile profile;
  final UserStats stats;

  UserProfileResponse({
    required this.profile,
    required this.stats,
  });

  factory UserProfileResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>;
    
    return UserProfileResponse(
      profile: UserProfile.fromJson(data['profile'] as Map<String, dynamic>),
      stats: UserStats.fromApiResponse(data['stats'] as Map<String, dynamic>),
    );
  }
}


class UserProfile {
  final String username;

  UserProfile({required this.username});

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      username: json['username'] as String,
    );
  }
}

class UserStats {
  final int totalWatched;
  final int totalWatchlist;
  final List<TopGenre> topGenres;

  UserStats({
    required this.totalWatched,
    required this.totalWatchlist,
    required this.topGenres,
  });

  // Factory method specifico per la risposta API del profilo
  factory UserStats.fromApiResponse(Map<String, dynamic> json) {
    return UserStats(
      totalWatched: json['total_watched'] as int? ?? 0,
      totalWatchlist: json['total_watchlist'] as int? ?? 0,
      topGenres: (json['top_genres'] as List<dynamic>?)
          ?.map((genre) => TopGenre.fromJson(genre as Map<String, dynamic>))
          .toList() ?? [],
    );
  }
}


class TopGenre {
  final int id;
  final String name;
  final int count;
  final double percentage;

  TopGenre({
    required this.id,
    required this.name,
    required this.count,
    required this.percentage,
  });

  factory TopGenre.fromJson(Map<String, dynamic> json) {
    return TopGenre(
      id: json['id'] as int,
      name: json['name'] as String,
      count: json['count'] as int,
      percentage: (json['percentage'] as num).toDouble(),
    );
  }
}

class UserWatchResponse {
  final List<WatchItem> data;
  final int page;
  final int totalPages;

  UserWatchResponse({
    required this.data,
    required this.page,
    required this.totalPages,
  });

  factory UserWatchResponse.fromJson(Map<String, dynamic> json) {
    return UserWatchResponse(
      data:
          (json['data'] as List)
              .map((item) => WatchItem.fromJson(item))
              .toList(),
      page: json['page'] as int? ?? 1,
      totalPages: json['total_pages'] as int? ?? 1,
    );
  }
}

class WatchItem {
  final int id;
  final String title;
  final String mediaType;
  final String? posterPath;
  final String? backdropPath;
  final String releaseDate;
  final List<Genre> genres;
  final double? userRating;

  WatchItem({
    required this.id,
    required this.title,
    required this.genres,
    this.posterPath,
    this.backdropPath,
    required this.mediaType,
    required this.releaseDate,
    this.userRating,
  });

  factory WatchItem.fromJson(Map<String, dynamic> json) {
    return WatchItem(
      id: json['id'] as int,
      posterPath: json['poster_path'] as String?,
      backdropPath: json['backdrop_path'] as String?,
      mediaType: json['media_type'] as String,
      releaseDate: json['release_date'] ?? json['first_air_date'] as String,
      title: json['title'] ?? json['name'] as String,
      genres:
          (json['genres'] as List)
              .map((genre) => Genre.fromJson(genre))
              .toList(),
      userRating: (json['user_rating'] as num?)?.toDouble(),
    );
  }
}

class Genre {
  final int id;
  final String name;

  Genre({required this.id, required this.name});

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(id: json['id'] as int, name: json['name'] as String);
  }
}

class GenreCount {
  final int id;
  final String name;
  final int count;

  GenreCount({required this.id, required this.name, required this.count});
}



class GenreStats {
  final String name;
  final int count;
  final double percentage;

  GenreStats({
    required this.name,
    required this.count,
    required this.percentage,
  });

  factory GenreStats.fromJson(Map<String, dynamic> json) {
    return GenreStats(
      name: json['name'] as String,
      count: json['count'] as int,
      percentage: (json['percentage'] as num).toDouble(),
    );
  }
}

class GenreData {
  final String name;
  final int percentage;
  final Color color;

  GenreData(this.name, this.percentage, this.color);

  static const List<Color> genreColors = [
    Color.fromARGB(255, 59, 14, 71), 
    Color.fromARGB(255, 19, 129, 197), 
    Color(0xFF4456BC), 
    Color.fromARGB(255, 88, 60, 143), 
    Color.fromARGB(255, 131, 66, 166), 
  ];

  static GenreData fromGenreStats(TopGenre stats, int index) {
    return GenreData(
      stats.name,
      stats.percentage.round(),
      genreColors[index % genreColors.length],
    );
  }
}
