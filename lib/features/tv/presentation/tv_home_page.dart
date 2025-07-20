import 'package:cinehive_mobile/features/home/models/content.dart';
import 'package:cinehive_mobile/features/home/widgets/carousel.dart';
import 'package:cinehive_mobile/features/home/widgets/carousel_section.dart';
import 'package:cinehive_mobile/features/shared/content/info_content.dart';
import 'package:cinehive_mobile/features/shared/content/overview_content.dart';
import 'package:cinehive_mobile/features/shared/detail_layout.dart';
import 'package:cinehive_mobile/features/shared/content/header_content.dart';
import 'package:cinehive_mobile/features/shared/content/top_list_content.dart';
import 'package:cinehive_mobile/features/shared/models/content.dart';
import 'package:cinehive_mobile/features/tv/data/tv_home_provider.dart';
import 'package:cinehive_mobile/features/tv/models/tv.dart';
import 'package:cinehive_mobile/features/tv/presentation/tv_cast_page.dart';
import 'package:cinehive_mobile/features/tv/presentation/tv_crew_page.dart';
import 'package:cinehive_mobile/features/tv/presentation/tv_seasons_page.dart';
import 'package:cinehive_mobile/features/tv/widgets/featured_episode.dart';
import 'package:cinehive_mobile/features/tv/widgets/seasons.dart';
import 'package:cinehive_mobile/utils/formatters.dart';
import 'package:cinehive_mobile/utils/media_urls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TvHomePage extends ConsumerWidget {
  final String id;
  const TvHomePage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncMovieData = ref.watch(tvHomeProvider(id));
    return Scaffold(
      body: asyncMovieData.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Errore: $err')),
        data: (TvHome tv) {
          final backdropUrl = MediaImageUrls.backdropMd(tv.backdropPath);
          final posterUrl = MediaImageUrls.posterSm(tv.posterPath);

          /*   final directors = tv.credits.crew.where(
            (c) => c.job
                .split(',')
                .map((job) => job.trim())
                .any((job) => job == "Director"),
          ); */
          final topCast =
              tv.credits.cast
                  .take(3)
                  .map(
                    (cast) =>
                        Person(name: cast.name, profilePath: cast.profilePath),
                  )
                  .toList();

          final topCrew =
              tv.credits.crew
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
                  title: tv.title,
                  releaseDate: tv.releaseDate,
                  rating: tv.voteAverage,
                  status: tv.status,
                  genres: tv.genres,
                ),

                const SizedBox(height: 40),

                if (tv.nextEpisode != null)
                  FeaturedEpisodeBox(
                    label: "Next Episode",
                    title: tv.nextEpisode!.title,
                    airDate: Formatters.formatDate(tv.nextEpisode!.airDate),
                  )
                else if (tv.lastEpisode != null)
                  FeaturedEpisodeBox(
                    label: "Last Episode",
                    title: tv.lastEpisode!.title,
                    airDate: Formatters.formatDate(tv.lastEpisode!.airDate),
                  ),

                const SizedBox(height: 30),

                OverviewContent(overview: tv.overview),

                const SizedBox(height: 30),

                if (topCast.isNotEmpty)
                  TopListContent(
                    people: topCast,
                    title: "Top cast",
                    buttonText: "See all cast",
                    mediaId: tv.id,
                    onShowAllPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (c) => DetailLayout(
                                body: TvCastPage(cast: tv.credits.cast),
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
                    mediaId: tv.id,
                    buttonText: "See all crew",
                    onShowAllPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (c) => DetailLayout(
                                body: TvCrewPage(crew: tv.credits.crew),
                              ),
                        ),
                      );
                    },
                  ),

                const SizedBox(height: 30),

                SeasonsBox(seasons: tv.seasons, onSeeAllPressed:() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (c) => DetailLayout(
                        body: TvSeasonsPage(seasons: tv.seasons,), //todo
                      ),
                    ),
                  );
                }),


                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CarouselSection(
                    key: const Key('tvs_recommended'),
                    title: 'Recommendations',
                    child: HomeCarousel(
                      items:
                          tv.recommendations
                              .map(
                                (rec) => HomeContentItem(
                                  id: rec.id,
                                  title: rec.title,
                                  posterPath: rec.posterPath,
                                  mediaType: "tv",
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
