import 'package:cinehive_mobile/features/home/models/content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HomeCarousel extends StatelessWidget {
  final List<HomeContentItem> items;

  const HomeCarousel({required this.items, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final baseUrl = dotenv.env["IMAGES_URL"];
          final item = items[index];
          final imageUrl = '$baseUrl/w500${item.posterPath}';

          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/${item.mediaType}/${item.id}');
            },
            child: Container(
              width: 130,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  imageUrl,
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
