abstract class MediaDiscover {
  final int id;
  final String? posterPath;
  final double voteAverage;
  final String mediaType;

  MediaDiscover({
    required this.id,
    this.posterPath,
    required this.voteAverage,
    required this.mediaType,
  });

  String get title;
  String? get releaseDate;

  static MediaDiscover fromJson(Map<String, dynamic> json) {
    final mediaType = json['media_type'] ?? '';
    switch (mediaType) {
      case 'movie':
        return Movie.fromJson(json);
      case 'tv':
        return TvShow.fromJson(json);
      case 'person':
        return Person.fromJson(json);
      default:
        throw ArgumentError('Unknown media type: $mediaType');
    }
  }
}

class Movie extends MediaDiscover {
  final String _title;
  final String? _releaseDate;

  Movie({
    required super.id,
    required String title,
    super.posterPath,
    required super.voteAverage,
    String? releaseDate,
    required super.mediaType,
  })  : _title = title,
        _releaseDate = releaseDate;

  @override
  String get title => _title;

  @override
  String? get releaseDate => _releaseDate;

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      posterPath: json['poster_path'],
      voteAverage: (json['vote_average'] ?? 0.0).toDouble(),
      releaseDate: json['release_date'],
      mediaType: json['media_type'] ?? 'movie',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'poster_path': posterPath,
      'vote_average': voteAverage,
      'release_date': releaseDate,
      'media_type': mediaType,
    };
  }
}

class TvShow extends MediaDiscover {
  final String name;
  final String? firstAirDate;

  TvShow({
    required super.id,
    required this.name,
    super.posterPath,
    required super.voteAverage,
    this.firstAirDate,
    required super.mediaType,
  });

  @override
  String get title => name;

  @override
  String? get releaseDate => firstAirDate;

  factory TvShow.fromJson(Map<String, dynamic> json) {
    return TvShow(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      posterPath: json['poster_path'],
      voteAverage: (json['vote_average'] ?? 0.0).toDouble(),
      firstAirDate: json['first_air_date'],
      mediaType: json['media_type'] ?? 'tv',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'poster_path': posterPath,
      'vote_average': voteAverage,
      'first_air_date': firstAirDate,
      'media_type': mediaType,
    };
  }
}

class Person extends MediaDiscover {
  final String name;
  final String? knownForDepartment;
  final List<String>? knownFor;

  Person({
    required super.id,
    required this.name,
    String? profilePath,
    required super.voteAverage,
    required super.mediaType,
    this.knownForDepartment,
    this.knownFor,
  }) : super(
          posterPath: profilePath,
        );

  @override
  String get title => name;

  @override
  String? get releaseDate => null; 

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      profilePath: json['profile_path'],
      voteAverage: (json['popularity'] ?? 0.0).toDouble(), 
      mediaType: json['media_type'] ?? 'person',
      knownForDepartment: json['known_for_department'],
      knownFor: json['known_for']?.map<String>((item) => item['title'] ?? item['name'] ?? '').toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'profile_path': posterPath, 
      'popularity': voteAverage,
      'media_type': mediaType,
      'known_for_department': knownForDepartment,
      'known_for': knownFor,
    };
  }
}