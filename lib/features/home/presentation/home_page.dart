import 'package:cinehive_mobile/features/home/data/home_content_provider.dart';
import 'package:cinehive_mobile/features/shared/widgets/carousel.dart';
import 'package:cinehive_mobile/features/shared/widgets/carousel_section.dart';
import 'package:cinehive_mobile/features/search/presentation/search_page.dart';
import 'package:cinehive_mobile/core/layout/detail_layout.dart';
import 'package:cinehive_mobile/features/shared/widgets/searchbar.dart';
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
              Image.asset(
                'assets/images/logo-no-bg.png',
                width: 250,
                height: 250,
                fit: BoxFit.contain,
              ),
              asyncHomeContent.when(
                loading: () => const CircularProgressIndicator(),
                error: (err, _) => Text('Errore nel caricamento dei dati $err'),
                data: (data) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: CustomSearchbar(
                            defaultQuery: '',
                            onSearch: (query) {
                              if (query.isNotEmpty) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (c) => DetailLayout(
                                          body: SearchPage(query: query),
                                        ),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                        const SizedBox(height: 16),
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
                          child: HomeCarousel(items: data['trending_tv'] ?? []),
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
