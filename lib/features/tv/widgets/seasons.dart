import 'package:cinehive_mobile/features/tv/models/tv.dart';
import 'package:cinehive_mobile/utils/media_urls.dart';
import 'package:flutter/material.dart';

class SeasonsBox extends StatelessWidget {
  final List<Season> seasons;
  final VoidCallback onSeeAllPressed;

  const SeasonsBox({
    super.key,
    required this.seasons,
    required this.onSeeAllPressed,
  });

  @override
  Widget build(BuildContext context) {
    if (seasons.isEmpty) return const SizedBox.shrink();

    final seasonsWithPosters =
        seasons.where((season) => season.posterPath.isNotEmpty).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(240),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.pink[100]!),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${seasons.length} season${seasons.length > 1 ? 's' : ''}',
                          style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 12),

                        SizedBox(
                          width: double.infinity,
                          height: 150,
                          child: _buildStackedPosters(seasonsWithPosters),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: onSeeAllPressed,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.pink[800]!),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'See all',
                            style: TextStyle(
                              color: Colors.pink[800],
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Icon(
                            Icons.chevron_right,
                            color: Colors.pink[800],
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStackedPosters(List<Season> seasonsWithPosters) {
    if (seasonsWithPosters.isEmpty) {
      return Container(
        width: 85, 
        height: 130,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Icon(Icons.tv, color: Colors.grey, size: 40),
      );
    }

    final postersToShow = seasonsWithPosters.take(3).toList();

    return Stack(
      children: [
        if (postersToShow.length >= 3)
          Positioned(
            left: 110,
            top: 20,
            child: _buildPosterCard(postersToShow[2], 0.80),
          ),

        if (postersToShow.length >= 2)
          Positioned(
            left: 55,
            top: 10,
            child: _buildPosterCard(postersToShow[1], 0.95),
          ),

        Positioned(
          left: 0,
          top: 0,
          child: _buildPosterCard(postersToShow[0], 1.0),
        ),
      ],
    );
  }

  Widget _buildPosterCard(Season season, double opacity) {
    return Opacity(
      opacity: opacity,
      child: Container(
        width: 85, 
        height: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            MediaImageUrls.posterSm(season.posterPath),
            fit: BoxFit.cover,
            errorBuilder:
                (context, error, stackTrace) => Container(
                  color: Colors.grey[300],
                  child: const Icon(Icons.tv, color: Colors.grey, size: 30),
                ),
          ),
        ),
      ),
    );
  }
}
