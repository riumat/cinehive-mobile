import 'package:cinehive_mobile/features/profile/models/profile.dart';
import 'package:cinehive_mobile/features/profile/widgets/stat-item.dart';
import 'package:flutter/material.dart';

class StatsSection extends StatelessWidget {
  final UserStats userStats;

  const StatsSection({super.key, required this.userStats});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Stats',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(color: Colors.white),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Watched Stats - con navigazione
              GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar( //todo
                    const SnackBar(
                      content: Text('Coming soon!'),
                      backgroundColor: Colors.white,
                      padding: EdgeInsets.all(16),
                    ),
                  );
                },
                child: StatItem(
                  label: 'Watched',
                  value: userStats.totalWatched.toString(),
                  isClickable: true,
                ),
              ),
              // Watchlist Stats - con navigazione
              GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar( //todo
                    const SnackBar(
                      content: Text('Coming soon!'),
                      backgroundColor: Colors.white,
                      padding: EdgeInsets.all(16),
                    ),
                  );
                },
                child: StatItem(
                  label: 'Watchlist',
                  value: userStats.totalWatchlist.toString(),
                  isClickable: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}