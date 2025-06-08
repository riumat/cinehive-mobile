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

class MovieHome {
  final int id;
  final String title;
  final String overview;
  final String releaseDate;
  final String posterPath;
  final String backdropPath;
  final List<Genre> genres;
  final List<SpokenLanguage> spokenLanguages;
  final String status;
  final double runtime;
  final int budget;
  final int revenue;
  final Credits credits;
  final ExternalIds externalIds;
  final List<ProductionCompany> productionCompanies;
  final List<ProductionCountry> productionCountries;
  final List<Recommendation> recommendations;
  final double voteAverage;
  final int voteCount;

  MovieHome({
    required this.id,
    required this.title,
    required this.overview,
    required this.releaseDate,
    required this.posterPath,
    required this.backdropPath,
    required this.genres,
    required this.spokenLanguages,
    required this.status,
    required this.runtime,
    required this.budget,
    required this.revenue,
    required this.credits,
    required this.externalIds,
    required this.productionCompanies,
    required this.productionCountries,
    required this.recommendations,
    required this.voteAverage,
    required this.voteCount,
  });

  factory MovieHome.fromJson(Map<String, dynamic> json) {
    print(json["genres"].runtimeType);
    return MovieHome(
      id: json['id'] as int,
      title: json['title'] as String,
      overview: json['overview'] as String,
      releaseDate: json['release_date'] as String,
      posterPath: json['poster_path'] as String? ?? '',
      backdropPath: json['backdrop_path'] as String? ?? '',
      genres:
          (json['genres'] as List)
              .map((g) => Genre(id: g['id'], name: g['name']))
              .toList(),
      spokenLanguages:
          (json['spoken_languages'] as List)
              .map(
                (s) => SpokenLanguage(
                  iso6391: s['iso_639_1'],
                  name: s['name'],
                  englishName: s['english_name'],
                ),
              )
              .toList(),
      status: json['status'] as String,
      runtime: (json['runtime'] ?? 0).toDouble(),
      budget: (json['budget'] ?? 0),
      revenue: (json['revenue'] ?? 0),
      credits: Credits(
        cast:
            (json['credits']['cast'] as List)
                .map(
                  (c) => Cast(
                    id: c['id'],
                    name: c['name'],
                    character: c['character'],
                    profilePath: c['profile_path'] ?? '',
                  ),
                )
                .toList(),
        crew:
            (json['credits']['crew'] as List)
                .map(
                  (c) => Crew(
                    id: c['id'],
                    name: c['name'],
                    job: c['job'],
                    profilePath: c['profile_path'] ?? '',
                  ),
                )
                .toList(),
      ),
      externalIds: ExternalIds(
        facebookId: json['external_ids']['facebook_id'] ?? '',
        instagramId: json['external_ids']['instagram_id'] ?? '',
        twitterId: json['external_ids']['twitter_id'] ?? '',
      ),
      productionCompanies:
          (json['production_companies'] as List)
              .map(
                (p) => ProductionCompany(
                  id: p['id'],
                  name: p['name'],
                  logoPath: p['logo_path'] ?? '',
                ),
              )
              .toList(),
      productionCountries:
          (json['production_countries'] as List)
              .map(
                (p) => ProductionCountry(
                  iso31661: p['iso_3166_1'],
                  name: p['name'],
                ),
              )
              .toList(),
      recommendations:
          (json['recommendations'] as List)
              .map(
                (r) => Recommendation(
                  id: r['id'],
                  title: r['title'] ?? r['name'] ?? '',
                  posterPath: r['poster_path'] ?? '',
                  backdropPath: r['backdrop_path'] ?? '',
                  genreIds: (r['genre_ids'] as List).map((e) => int.tryParse(e.toString()) ?? 0).toList(),
                ),
              )
              .toList(),
      voteAverage: (json['vote_average'] ?? 0).toDouble(),
      voteCount: json['vote_count'] as int? ?? 0,
    );
  }
}
