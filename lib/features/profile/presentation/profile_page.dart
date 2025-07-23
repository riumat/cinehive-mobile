import 'package:cinehive_mobile/features/profile/data/profile_provider.dart';
import 'package:cinehive_mobile/features/profile/widgets/genre_chart_section.dart';
import 'package:cinehive_mobile/features/profile/widgets/info_section.dart';
import 'package:cinehive_mobile/features/profile/widgets/stats_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfileAsync = ref.watch(userProfileProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      body: userProfileAsync.when(
        data:
            (userProfile) => CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          Color.fromARGB(255, 72, 46, 71),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(12.0),
                        bottomRight: Radius.circular(12.0),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 70),
                        UserInfoSection(userProfile: userProfile),
                      ],
                    ),
                  ),
                ),
                // Content section
                SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        StatsSection(userStats: userProfile.stats),
                        const SizedBox(height: 24),
                        GenreChartSection(
                          topGenres: userProfile.stats.topGenres,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
        loading:
            () => const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: Colors.purple),
                  SizedBox(height: 16),
                  Text(
                    'Loading profile...',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
        error:
            (error, stack) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error, color: Colors.red, size: 50),
                  SizedBox(height: 16),
                  Text(
                    'Failed to load profile',
                    style: TextStyle(color: Colors.red.shade300),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => ref.invalidate(userProfileProvider),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                    ),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
      ),
    );
  }
}
