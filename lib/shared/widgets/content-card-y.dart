import 'package:flutter/material.dart';

class ContentCardX extends StatelessWidget {
  final String title;
  final String imagePath; // Percorso locale o URL
  final double voteAverage;
  final String year;

  const ContentCardX({
    super.key,
    required this.title,
    required this.imagePath,
    required this.voteAverage,
    required this.year,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.surface.withValues(
              alpha: 0.1,
            ),
            Theme.of(context).colorScheme.surface.withValues(
              alpha: 0.3,
            ),
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Immagine locale
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
            child: Image.asset(
              imagePath,
              width: 140,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          // Info
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      voteAverage.toStringAsFixed(1),
                      style: TextStyle(
                        color: Colors.amber[300],
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(width: 2),
                    const Icon(Icons.star, size: 14, color: Colors.amber),
                    const SizedBox(width: 8),
                    Text(
                      year,
                      style: TextStyle(
                        color: Colors.grey[300],
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}