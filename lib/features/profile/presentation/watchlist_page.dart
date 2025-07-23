import 'package:cinehive_mobile/features/profile/models/profile.dart';
import 'package:cinehive_mobile/features/search/models/discover.dart';
import 'package:cinehive_mobile/features/shared/widgets/media_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WatchlistPage extends ConsumerStatefulWidget {
  final List<WatchItem> watchlistItems;
  
  const WatchlistPage({
    super.key,
    required this.watchlistItems,
  });

  @override
  ConsumerState<WatchlistPage> createState() => _WatchlistPageState();
}

class _WatchlistPageState extends ConsumerState<WatchlistPage> {
  String _searchQuery = '';
  List<WatchItem> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _filteredItems = widget.watchlistItems;
  }

  void _filterItems(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _filteredItems = widget.watchlistItems;
      } else {
        _filteredItems = widget.watchlistItems
            .where((item) =>
                item.title.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            'Watchlist',
            style: TextStyle(color: Colors.white),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                onChanged: _filterItems,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Search in watchlist...',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                  filled: true,
                  fillColor: Colors.grey[900],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            Expanded(
              child: _filteredItems.isEmpty
                  ? Center(
                      child: Text(
                        _searchQuery.isEmpty
                            ? 'No items in watchlist'
                            : 'No results found for "$_searchQuery"',
                        style: const TextStyle(color: Colors.grey),
                      ),
                    )
                  : _buildWatchlistList(),
            ),
          ],
        ),
      ),
    );
  }

   Widget _buildWatchlistList() {
  return ListView.builder(
    padding: const EdgeInsets.all(16),
    itemCount: _filteredItems.length,
    itemBuilder: (context, index) {
      final item = _filteredItems[index];
      
      final MediaDiscover mediaDiscover;
      
      if (item.mediaType == "movie") {
        mediaDiscover = Movie(
          id: item.id,
          title: item.title,
          posterPath: item.posterPath ?? '',
          releaseDate: item.releaseDate, 
          voteAverage: item.userRating ?? 0.0,
          mediaType: 'movie',
        );
      } else {
        mediaDiscover = TvShow(
          id: item.id,
          name: item.title,
          posterPath: item.posterPath ?? '',
          firstAirDate: item.releaseDate,
          voteAverage: item.userRating ?? 0.0,
          mediaType: 'tv',
        );
      }
      
      return mediaCard(mediaDiscover, context);
    },
  );
}
}