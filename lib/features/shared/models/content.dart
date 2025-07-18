class Genre {
  final int id;
  final String name;

  Genre({required this.id, required this.name});
}

class SpokenLanguage {
  final String iso6391;
  final String name;
  final String englishName;

  SpokenLanguage({
    required this.iso6391,
    required this.name,
    required this.englishName,
  });
}

class Person {
  final String name;
  final String profilePath;

  Person({
    required this.name,
    required this.profilePath,
  });
}

class Cast {
  final int id;
  final String name;
  final String character;
  final String profilePath;

  Cast({
    required this.id,
    required this.name,
    required this.character,
    required this.profilePath,
  });
}

class Crew {
  final int id;
  final String name;
  final String job;
  final String profilePath;

  Crew({
    required this.id,
    required this.name,
    required this.job,
    required this.profilePath,
  });
}

class Credits {
  final List<Cast> cast;
  final List<Crew> crew;

  Credits({required this.cast, required this.crew});
}

class ExternalIds {
  final String facebookId;
  final String instagramId;
  final String twitterId;

  ExternalIds({
    required this.facebookId,
    required this.instagramId,
    required this.twitterId,
  });
}

class ProductionCompany {
  final int id;
  final String name;
  final String logoPath;

  ProductionCompany({
    required this.id,
    required this.name,
    required this.logoPath,
  });
}

class ProductionCountry {
  final String iso31661;
  final String name;

  ProductionCountry({required this.iso31661, required this.name});
}

class Recommendation {
  final int id;
  final String title;
  final String posterPath;
  final String backdropPath;
  final List<int> genreIds;

  Recommendation({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.backdropPath,
    required this.genreIds,
  });
}
