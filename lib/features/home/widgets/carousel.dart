import 'package:cinehive_mobile/features/home/models/content.dart';
import 'package:flutter/material.dart';

class HomeCarousel extends StatelessWidget {
  final List<HomeContentItem> items;

  const HomeCarousel({required this.items,super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final item = items[index];
          final imageUrl = 'https://image.tmdb.org/t/p/w500${item.posterPath}';

          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/${item.mediaType}/${item.id}');
            },
            child: Container(
              width: 100,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  imageUrl,
                  width: 100,
                  fit: BoxFit.cover,
                  errorBuilder:
                      (context, error, stackTrace) =>
                          const Icon(Icons.broken_image),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
