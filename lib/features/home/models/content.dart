class HomeContentItem {
  final int id;
  final String title;
  final String posterPath;
  final String mediaType;

  HomeContentItem({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.mediaType,
  });

  factory HomeContentItem.fromJson(Map<String, dynamic> json) {
    return HomeContentItem(
      id: json['id'] as int,
      title: json['title'] ?? json['name'] ?? '',
      posterPath: json['poster_path'] ?? '',
      mediaType: json['media_type'] ?? '',
    );
  }
}