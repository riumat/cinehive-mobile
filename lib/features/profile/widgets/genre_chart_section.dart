import 'package:cinehive_mobile/features/profile/models/profile.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class GenreChartSection extends StatelessWidget {
  final List<TopGenre> topGenres;

  const GenreChartSection({super.key, required this.topGenres});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Top 5 Genres',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(color: Colors.white),
          ),
          const SizedBox(height: 50),
          topGenres.isEmpty
              ? const Center(
                child: Text(
                  'No genre data available',
                  style: TextStyle(color: Colors.grey),
                ),
              )
              : Column(
                children: [
                  SizedBox(
                    height: 200,
                    child: PieChart(
                      PieChartData(
                        sections:
                            topGenres.asMap().entries.map((entry) {
                              final index = entry.key;
                              final genre = entry.value;
                              final genreData = GenreData.fromGenreStats(
                                genre,
                                index,
                              );

                              return PieChartSectionData(
                                color: genreData.color,
                                value: genre.percentage,
                                title: '${genre.percentage.round()}%',
                                radius: 80,
                                titleStyle: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              );
                            }).toList(),
                        centerSpaceRadius: 40,
                        sectionsSpace: 2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children:
                        topGenres.asMap().entries.map((entry) {
                          final index = entry.key;
                          final genre = entry.value;
                          final genreData = GenreData.fromGenreStats(
                            genre,
                            index,
                          );

                          return _GenreLegendItem(
                            color: genreData.color,
                            label: genre.name,
                          );
                        }).toList(),
                  ),
                ],
              ),
        ],
      ),
    );
  }
}

class _GenreLegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const _GenreLegendItem({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: Colors.white),
        ),
      ],
    );
  }
}
