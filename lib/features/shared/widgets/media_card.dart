import 'package:cinehive_mobile/features/movie/presentation/movie_home_page.dart';
import 'package:cinehive_mobile/features/search/models/discover.dart';
import 'package:cinehive_mobile/core/layout/detail_layout.dart';
import 'package:cinehive_mobile/utils/formatters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final imageUrl= dotenv.env['IMAGES_URL'];

Widget mediaCard(MediaDiscover media, BuildContext context) {
  final posterUrl =
      media.posterPath != null
          ? '$imageUrl/w154${media.posterPath}'
          : 'https://via.placeholder.com/150x225?text=No+Image';

  String subtitle = '';
  if (media is Person) {
    subtitle = media.knownForDepartment ?? 'Unknown Department';
  } else if (media is Movie) {
    subtitle = media.releaseDate!= null ? Formatters.formatYear(media.releaseDate!): 'Unknown Release Date';
  } else if (media is TvShow) {
    subtitle = media.firstAirDate!= null ? Formatters.formatYear(media.firstAirDate!): 'Unknown Release Date';
  }

  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (c) => DetailLayout(body: MovieHomePage(id: media.id.toString())),
        ),
      );
    },
    child: Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [Colors.black, Colors.grey[900]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              bottomLeft: Radius.circular(8),
            ),
            child: Image.network(
              posterUrl,
              width: 90,
              height: 130,
              fit: BoxFit.cover,
              errorBuilder:
                  (context, error, stackTrace) => Container(
                    width: 100,
                    height: 150,
                    color: Colors.grey[800],
                    child: const Icon(
                      Icons.broken_image,
                      color: Colors.grey,
                      size: 40,
                    ),
                  ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    media.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    subtitle,
                    style: TextStyle(color: Colors.grey[400], fontSize: 14),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.white, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        media.voteAverage.toStringAsFixed(1),
                        style: TextStyle(color: Colors.grey[400], fontSize: 12),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey[700],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          media.mediaType.toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
