class HomeContentItem {
  final int id;
  final String title;
  final String posterPath;
  //final String backdropPath;
  //final double voteAverage;
  //final String releaseDate;
  final String mediaType;

  HomeContentItem({
    required this.id,
    required this.title,
    required this.posterPath,
   // required this.backdropPath,
   // required this.voteAverage,
    //required this.releaseDate,
    required this.mediaType,
  });

  factory HomeContentItem.fromJson(Map<String, dynamic> json) {
    return HomeContentItem(
      id: json['id'] as int,
      title: json['title'] ?? json['name'] ?? '',
      posterPath: json['poster_path'] ?? '',
    //  backdropPath: json['backdrop_path'] ?? '',
      //voteAverage: (json['vote_average'] ?? 0).toDouble(),
      //releaseDate: json['release_date'] ?? '',
      mediaType: json['media_type'] ?? '',
    );
  }
}