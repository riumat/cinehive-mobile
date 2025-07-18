import 'package:cinehive_mobile/features/shared/models/content.dart';
import 'package:flutter/material.dart';

class TopListContent extends StatelessWidget {
  final List<Person> people;
  final String title;
  final String buttonText;
  final int mediaId;
  final VoidCallback onShowAllPressed;

  const TopListContent({
    super.key,
    required this.people,
    required this.title,
    required this.buttonText,
    required this.mediaId,
    required this.onShowAllPressed,
  });

  @override
  Widget build(BuildContext context) {
    if (people.isEmpty) return const SizedBox.shrink();

    final topThree = people.take(3).toList();

    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Text(
                title,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: onShowAllPressed,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 12,
                ),
                decoration: BoxDecoration(),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      buttonText,
                      style: TextStyle(
                        color: Colors.pink.shade50.withAlpha(220),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 4),
                     Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      weight: 800,
                      color: Colors.pink.shade50.withAlpha(220),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (final person in topThree)
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 90,
                    height: 90,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(
                        person.profilePath.isNotEmpty
                            ? 'https://image.tmdb.org/t/p/w185${person.profilePath}'
                            : 'https://via.placeholder.com/150',
                        fit: BoxFit.cover,
                        errorBuilder:
                            (context, error, stackTrace) =>
                                Container(
                                  color: Colors.grey.shade800,
                                  child: const Icon(Icons.broken_image)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 100,
                    child: Text(
                      person.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
