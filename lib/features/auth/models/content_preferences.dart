class UserPreferences {
  final bool watched;
  final bool watchlisted;
  final int rating;

  UserPreferences({
    required this.watched,
    required this.watchlisted,
    required this.rating,
  });

  factory UserPreferences.fromJson(Map<String, dynamic> json) {
    return UserPreferences(
      watched: json['watch'] ?? false,
      watchlisted: json['watchlist'] ?? false,
      rating: json['rating'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'watch': watched,
    'watchlist': watchlisted,
    'rating': rating,
  };
}

abstract class MediaContent {
  int get id;
  String get title;
  String? get backdropPath;
  String? get posterPath;
  String? get releaseDate;
  String? get firstAirDate;
  double? get runtime;
  List<double> get genres;
}