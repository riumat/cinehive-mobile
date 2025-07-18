import 'package:cinehive_mobile/features/shared/models/content.dart';
import 'package:cinehive_mobile/utils/formatters.dart';
import 'package:flutter/material.dart';

class InfoContent extends StatelessWidget {
  final String title;
  final String releaseDate;
  final double? runtime;
  final double rating;
  final List<Genre> genres;
  final String? status;
  final String dateLabel; // "Release Date" o "First Air Date"

  const InfoContent({
    super.key,
    required this.title,
    required this.releaseDate,
    this.runtime,
    this.status,
    required this.rating,
    required this.genres,
    this.dateLabel = "Release Date",
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 150.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            textAlign: TextAlign.start,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 10),

          Wrap(
            spacing: 16,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              if (releaseDate.isNotEmpty)
                Text(
                  Formatters.formatDate(releaseDate),
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),
              if (runtime != null)
                Text(
                  Formatters.formatDuration(runtime!.toInt()),
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),
                 if (status != null)
                Text(
                  status!,
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),

                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.star, color: Colors.white, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      rating.toStringAsFixed(1),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          if (genres.isNotEmpty)
            Wrap(
              alignment: WrapAlignment.start,
              spacing: 8,
              runSpacing: 8,
              children:
                  genres
                      .map(
                        (genre) => Chip(
                          label: Text(
                            genre.name,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                          backgroundColor: Colors.pink.shade300.withAlpha(3),
                          side: BorderSide(
                            color: Colors.pink.shade100.withValues(alpha: 0.2),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                        ),
                      )
                      .toList(),
            ),
        ],
      ),
    );
  }
}
