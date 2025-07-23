import 'package:cinehive_mobile/features/shared/models/content.dart';

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
                  genreIds:
                      (r['genre_ids'] as List)
                          .map((e) => int.tryParse(e.toString()) ?? 0)
                          .toList(),
                ),
              )
              .toList(),
      voteAverage: (json['vote_average'] ?? 0).toDouble(),
      voteCount: json['vote_count'] as int? ?? 0,
    );
  }
}



