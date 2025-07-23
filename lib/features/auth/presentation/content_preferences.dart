import 'package:cinehive_mobile/features/auth/services/content_preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class UserContentPreferences extends StatefulWidget {
  final int contentId;
  final String title;
  final String backdropPath;
  final String posterPath;
  final String releaseDate;
  final List<int> genres;
  final double? duration;
  final String mediaType; 

  const UserContentPreferences({
    super.key,
    required this.contentId,
    required this.title,
    required this.backdropPath,
    required this.posterPath,
    required this.releaseDate,
    required this.genres,
    required this.mediaType,
    this.duration,
  });

  @override
  State<UserContentPreferences> createState() => _UserContentPreferencesState();
}

class _UserContentPreferencesState extends State<UserContentPreferences> {
  bool isWatched = false;
  bool isWatchlisted = false;
  int userRating = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserPreferences();
  }

  Future<void> _loadUserPreferences() async {
    try {
      final prefs = await UserPreferencesService.getPreferences(
        widget.mediaType,
        widget.contentId.toString(),
      );

      if (mounted) {
        setState(() {
          isWatched = prefs.watched;
          isWatchlisted = prefs.watchlisted;
          userRating = prefs.rating;
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error loading user preferences: $e');
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<void> _toggleWatched() async {
    if (isLoading) return;

    final newWatchedState = !isWatched;
    final oldRating = userRating;

    setState(() {
      isWatched = newWatchedState;
      if (!newWatchedState) {
        userRating = 0;
      }
    });

    try {
      await UserPreferencesService.updateWatchedStatus(
        widget.mediaType,
        widget.contentId,
        widget.title,
        widget.backdropPath,
        widget.posterPath,
        widget.releaseDate,
        widget.genres,
        widget.duration,
        newWatchedState,
      );

      

      if (!newWatchedState && oldRating > 0) {
        await UserPreferencesService.updateRating(
          widget.mediaType,
          widget.contentId.toString(),
          0,
        );
      }
    } catch (e) {
      setState(() {
        isWatched = !newWatchedState;
        userRating = oldRating;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update watched status: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _toggleWatchlisted() async {
    if (isLoading) return;

    final newWatchlistState = !isWatchlisted;

    setState(() {
      isWatchlisted = newWatchlistState;
    });

    try {
      await UserPreferencesService.updateWatchlistStatus(
        widget.mediaType,
        widget.contentId,
        widget.title,
        widget.backdropPath,
        widget.posterPath,
        widget.releaseDate,
        widget.genres,
        widget.duration,
        newWatchlistState,
      );
    } catch (e) {
      setState(() {
        isWatchlisted = !newWatchlistState;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update watchlist: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _updateRating(int rating) async {
    if (isLoading || !isWatched) return;

    final oldRating = userRating;

    setState(() {
      userRating = rating;
    });

    try {
      await UserPreferencesService.updateRating(
        widget.mediaType,
        widget.contentId.toString(),
        rating,
      );
    } catch (e) {
      setState(() {
        userRating = oldRating;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update rating: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showRatingModal() {
    if (!isWatched) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'You need to mark this content as watched before rating it',
          ),
          backgroundColor: Colors.white,
          duration: Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
        ),
      );
      return;
    }

    int tempRating = userRating;

    showMaterialModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder:
          (context) => Container(
            height: 320,
            decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: StatefulBuilder(
              builder:
                  (context, setModalState) => Column(
                    children: [
                      // Handle bar
                      Container(
                        margin: const EdgeInsets.only(top: 12),
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey[600],
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Title
                      const Text(
                        'Rate this content',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        tempRating > 0
                            ? '$tempRating/5 stars'
                            : 'Tap a star to rate',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),

                      const SizedBox(height: 32),

                      // Large stars
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(5, (index) {
                          return GestureDetector(
                            onTap: () {
                              setModalState(() {
                                tempRating = index + 1;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              child: Icon(
                                index < tempRating
                                    ? Icons.star
                                    : Icons.star_border,
                                color:
                                    index < tempRating
                                        ? Colors.purple.shade100
                                        : Colors.grey,
                                size: 40,
                              ),
                            ),
                          );
                        }),
                      ),

                      const SizedBox(height: 32),

                      // Action buttons
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Row(
                          children: [
                            // Clear rating button
                            if (tempRating > 0)
                              Expanded(
                                child: TextButton(
                                  onPressed: () {
                                    setModalState(() {
                                      tempRating = 0;
                                    });
                                  },
                                  style: TextButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16,
                                    ),
                                  ),
                                  child: const Text(
                                    'Clear Rating',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),

                            if (tempRating > 0) const SizedBox(width: 16),

                            // Save button
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  _updateRating(tempRating);
                                  Navigator.pop(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.purple.shade100,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: Text(
                                  tempRating > 0
                                      ? 'Save Rating'
                                      : 'Remove Rating',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: Colors.purple, strokeWidth: 2),
          ],
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Watched toggle
          GestureDetector(
            onTap: _toggleWatched,
            child: Column(
              children: [
                Icon(
                  isWatched
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color:
                      isWatched ? Colors.purple.shade50 : Colors.grey.shade600,
                  size: 28,
                ),
                const SizedBox(height: 4),
                Text(
                  'Watched',
                  style: TextStyle(
                    color:
                        isWatched
                            ? Colors.purple.shade50
                            : Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          // Watchlist toggle
          GestureDetector(
            onTap: _toggleWatchlisted,
            child: Column(
              children: [
                Icon(
                  isWatchlisted ? Icons.bookmark : Icons.bookmark_border,
                  color:
                      isWatchlisted
                          ? Colors.purple.shade50
                          : Colors.grey.shade600,
                  size: 28,
                ),
                const SizedBox(height: 4),
                Text(
                  'Watchlist',
                  style: TextStyle(
                    color:
                        isWatchlisted
                            ? Colors.purple.shade50
                            : Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          GestureDetector(
            onTap:
                isWatched
                    ? _showRatingModal
                    : _showRatingModal, 
            child: Opacity(
              opacity: isWatched ? 1.0 : 0.5,
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(5, (index) {
                      return Icon(
                        index < userRating ? Icons.star : Icons.star_border,
                        color:
                            index < userRating
                                ? Colors.purple.shade100
                                : (isWatched
                                    ? Colors.grey
                                    : Colors.grey.shade700),
                        size: 20,
                      );
                    }),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Rating',
                    style: TextStyle(
                      color:
                          isWatched
                              ? (userRating > 0
                                  ? Colors.purple.shade50
                                  : Colors.grey.shade600)
                              : Colors.grey.shade700,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
