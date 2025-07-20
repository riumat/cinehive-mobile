import 'package:cinehive_mobile/features/search/data/search_discover_provider.dart';
import 'package:cinehive_mobile/shared/widgets/search_media_card.dart';
import 'package:cinehive_mobile/shared/widgets/searchbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchPage extends ConsumerStatefulWidget {
  final String query;
  const SearchPage({super.key, required this.query});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _searchQuery = widget.query;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                right: 16,
                top: 12,
                left: 90,
                bottom: 12,
              ),
              child: CustomSearchbar(
                defaultQuery: widget.query,
                onSearch: (query) {
                  setState(() {
                    _searchQuery = query;
                  });
                },
              ),
            ),
            Expanded(
              child: _searchQuery.isEmpty
                  ? const Center(
                      child: Text(
                        'Inserisci un termine di ricerca',
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  : _buildSearchResults(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResults() {
    final searchResults = ref.watch(searchDiscoverProvider(_searchQuery));

    return searchResults.when(
      data: (mediaList) {
        if (mediaList.isEmpty) {
          return const Center(
            child: Text(
              'Nessun risultato trovato',
              style: TextStyle(color: Colors.grey),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: mediaList.length,
          itemBuilder: (context, index) {
            final media = mediaList[index];
            return searchMediaCard(media, context);
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
            child: Text(
              'Errore: $error',
              style: const TextStyle(color: Colors.red),
            ),
          ),
    );
  }
}