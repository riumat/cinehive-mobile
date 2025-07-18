import 'package:cinehive_mobile/features/home/models/content.dart';
import 'package:cinehive_mobile/features/home/widgets/carousel.dart';
import 'package:cinehive_mobile/features/home/widgets/carousel_section.dart';
import 'package:cinehive_mobile/features/movie/data/movie_home_provider.dart';
import 'package:cinehive_mobile/features/movie/models/movie.dart';
import 'package:cinehive_mobile/features/movie/presentation/movie_cast_page.dart';
import 'package:cinehive_mobile/features/movie/presentation/movie_crew_page.dart';
import 'package:cinehive_mobile/features/movie/widgets/money_info.dart';
import 'package:cinehive_mobile/features/shared/content/info_content.dart';
import 'package:cinehive_mobile/features/shared/content/overview_content.dart';
import 'package:cinehive_mobile/features/shared/detail_layout.dart';
import 'package:cinehive_mobile/features/shared/content/header_content.dart';
import 'package:cinehive_mobile/features/shared/content/top_list_content.dart';
import 'package:cinehive_mobile/features/shared/models/content.dart';
import 'package:cinehive_mobile/utils/media_urls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieHomePage extends ConsumerWidget {
  final String id;
  const MovieHomePage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncMovieData = ref.watch(movieHomeProvider(id));
    return Scaffold(
      body: asyncMovieData.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Errore: $err')),
        data: (MovieHome movie) {
          final backdropUrl = MediaImageUrls.backdropMd(movie.backdropPath);
          final posterUrl = MediaImageUrls.posterSm(movie.posterPath);

         /*  final directors = movie.credits.crew.where(
            (c) => c.job
                .split(',')
                .map((job) => job.trim())
                .any((job) => job == "Director"),
          ); */
          final topCast =
              movie.credits.cast
                  .take(3)
                  .map(
                    (cast) =>
                        Person(name: cast.name, profilePath: cast.profilePath),
                  )
                  .toList();

          final topCrew =
              movie.credits.crew
                  .take(3)
                  .map(
                    (crew) =>
                        Person(name: crew.name, profilePath: crew.profilePath),
                  )
                  .toList();

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderContent(backdropUrl: backdropUrl, posterUrl: posterUrl),

                const SizedBox(height: 25),

                InfoContent(
                  title: movie.title,
                  releaseDate: movie.releaseDate,
                  rating: movie.voteAverage,
                  genres: movie.genres,
                  runtime: movie.runtime,
                  dateLabel: "Release Date",
                ),

                const SizedBox(height: 40),

                OverviewContent(overview: movie.overview),

                const SizedBox(height: 30),

                if (topCast.isNotEmpty)
                  TopListContent(
                    people: topCast,
                    title: "Top cast",
                    buttonText: "See all cast",
                    mediaId: movie.id,
                    onShowAllPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (c) => DetailLayout(
                                body: MovieCastPage(cast: movie.credits.cast),
                              ),
                        ),
                      );
                    },
                  ),
                const SizedBox(height: 30),

                if (topCrew.isNotEmpty)
                  TopListContent(
                    people: topCrew,
                    title: "Top crew",
                    mediaId: movie.id,
                    buttonText: "See all crew",
                    onShowAllPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (c) => DetailLayout(
                                body: MovieCrewPage(crew: movie.credits.crew),
                              ),
                        ),
                      );
                    },
                  ),

                const SizedBox(height: 30),

                MoneyInfo(budget: movie.budget, revenue: movie.revenue),

                const SizedBox(height: 30),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CarouselSection(
                    key: const Key('movies_recommended'),
                    title: 'Recommendations',
                    child: HomeCarousel(
                      items:
                          movie.recommendations
                              .map(
                                (rec) => HomeContentItem(
                                  id: rec.id,
                                  title: rec.title,
                                  posterPath: rec.posterPath,
                                  mediaType: "movie",
                                ),
                              )
                              .toList(),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          );
        },
      ),
    );
  }
}
