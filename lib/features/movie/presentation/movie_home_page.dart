import 'package:cinehive_mobile/features/movie/data/movie_home_provider.dart';
import 'package:cinehive_mobile/features/movie/models/movie.dart';
import 'package:cinehive_mobile/utils/formatters.dart';
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
          final backdropUrl =
              'https://image.tmdb.org/t/p/w780${movie.backdropPath}';
          final duration =
              movie.runtime > 0 ? '${movie.runtime.toInt()} min' : '';
          final directors = movie.credits.crew.where(
            (c) => c.job
                .split(',')
                .map((job) => job.trim())
                .any((job) => job == "Director"),
          );
          final topCast = movie.credits.cast.take(3).toList();
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Backdrop
                Stack(
                  children: [
                    AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Image.network(
                        backdropUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        errorBuilder:
                            (context, error, stackTrace) =>
                                Container(color: Colors.grey[800]),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Titolo
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Center(
                    child: Text(
                      movie.title,
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.w800),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Info principali
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (movie.releaseDate.isNotEmpty)
                        Text(
                          Formatters.formatDate(movie.releaseDate),
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                          ),
                        ),
                      if (duration.isNotEmpty) ...[
                        const SizedBox(width: 20),
                        Text(
                          Formatters.formatDuration(movie.runtime.toInt()),
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                          ),
                        ),
                      ],
                      const SizedBox(width: 20),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.white70,
                            size: 18,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            movie.voteAverage.toStringAsFixed(1),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Generi
                if (movie.genres.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 8,
                      runSpacing: 8,
                      children:
                          movie.genres
                              .map(
                                (genre) => Chip(
                                  label: Text(
                                    genre.name,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                  ),
                                  backgroundColor: Colors.black45,
                                  side: const BorderSide(color: Colors.white30),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 4.0,
                                  ),
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                              )
                              .toList(),
                    ),
                  ),
                const SizedBox(height: 25),
                // Overview
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Overview",
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        movie.overview,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                if (directors.isNotEmpty)
                  Column(
                    children: [
                      Text(
                        'Directed by',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          for (final director in directors)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 120,
                                  height: 120,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Image.network(
                                      directors.first.profilePath != ""
                                          ? 'https://image.tmdb.org/t/p/w500${director.profilePath}'
                                          : 'https://via.placeholder.com/150',
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              const Icon(Icons.broken_image),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  director.name,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                const SizedBox(height: 10),
                              ],
                            ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Explore crew members",
                            style: TextStyle(
                              color: Colors.blue[300],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 14,
                            color: Colors.blue,
                          ),
                        ],
                      ),
                    ],
                  ),
                const SizedBox(height: 45),
                if (topCast.isNotEmpty)
                  Column(
                    children: [
                      Text(
                        'Top cast',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          for (final actor in topCast)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 120,
                                  height: 120,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Image.network(
                                      directors.first.profilePath != ""
                                          ? 'https://image.tmdb.org/t/p/w500${actor.profilePath}'
                                          : 'https://via.placeholder.com/150',
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              const Icon(Icons.broken_image),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  actor.name,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                const SizedBox(height: 10),
                              ],
                            ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Explore cast members",
                            style: TextStyle(
                              color: Colors.blue[300],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 14,
                            color: Colors.blue,
                          ),
                        ],
                      ),
                    ],
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
