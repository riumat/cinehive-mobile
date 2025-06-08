import 'package:cinehive_mobile/features/movie/data/movie_home_provider.dart';
import 'package:cinehive_mobile/features/movie/models/movie.dart';
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
          final genres = movie.genres.map((g) => g.name).join(', ');
          final duration =
              movie.runtime > 0 ? '${movie.runtime.toInt()} min' : '';
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                  child: Text(
                    movie.title,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                // Info principali
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      if (movie.releaseDate.isNotEmpty)
                        Text(
                          movie.releaseDate,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                      if (duration.isNotEmpty) ...[
                        const SizedBox(width: 12),
                        Text(
                          duration,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                      ],
                      const SizedBox(width: 12),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.white, size: 18),
                          const SizedBox(width: 4),
                          Text(
                            movie.voteAverage.toStringAsFixed(1),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                // Generi
                if (genres.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      genres,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ),
                const SizedBox(height: 16),
                // Overview
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    movie.overview,
                    style: const TextStyle(fontSize: 14,color: Colors.grey),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          );
        },
      ),
    );
  }
}
