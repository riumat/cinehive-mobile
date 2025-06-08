import 'package:cinehive_mobile/features/home/data/home_content_provider.dart';
import 'package:cinehive_mobile/features/home/widgets/carousel.dart';
import 'package:cinehive_mobile/features/home/widgets/carousel_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncHomeContent = ref.watch(homeContentProvider);
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10),
              Image.asset(
                'assets/images/logo-no-bg.png',
                width: 250,
                height: 250,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 10),
              asyncHomeContent.when(
                loading: () => const CircularProgressIndicator(),
                error: (err, _) => Text('Errore nel caricamento dei dati $err'),
                data: (data) {
                  debugPrint('Data received: $data');
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        CarouselSection(
                          key: const Key('trending_movies_section'),
                          title: 'Trending movies',
                          child: HomeCarousel(
                            items: data['trending_movies'] ?? [],
                          ),
                        ),
                        CarouselSection(
                          key: const Key('trending_tv_section'),
                          title: 'Trending tv shows',
                          child: HomeCarousel(
                            items: data['trending_tv'] ?? [],
                          ),
                        ),
                        CarouselSection(
                          key: const Key('top_rated_movies_section'),
                          title: 'Top rated movies',
                          child: HomeCarousel(
                            items: data['top_rated_movies'] ?? [],
                          ),
                        ),
                        CarouselSection(
                          key: const Key('top_rated_tv_section'),
                          title: 'Top rated shows',
                          child: HomeCarousel(
                            items: data['top_rated_tv'] ?? [],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

