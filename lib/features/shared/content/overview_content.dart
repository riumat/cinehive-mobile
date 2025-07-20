import 'package:flutter/material.dart';

class OverviewContent extends StatelessWidget {
  final String overview;

  const OverviewContent({super.key, required this.overview});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(255, 23, 0, 12),
              const Color.fromARGB(255, 52, 0, 28),
            ],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            stops: const [0.0, 0.9],
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Overview",
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            Text(
              overview,
              textAlign: TextAlign.start,
              style: const TextStyle(fontSize: 14, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
