import 'package:flutter/material.dart';

class HeaderContent extends StatelessWidget {
  final String backdropUrl;
  final String posterUrl;
  final double posterWidth;
  final double posterHeight;
  final double posterBottomOffset;

  const HeaderContent({
    super.key,
    required this.backdropUrl,
    required this.posterUrl,
    this.posterWidth = 120,
    this.posterHeight = 180,
    this.posterBottomOffset = -120,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        AspectRatio(
          aspectRatio: 16 / 9,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
            child: Image.network(
              backdropUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              errorBuilder: (context, error, stackTrace) =>
                  Container(color: Colors.grey[800]),
            ),
          ),
        ),
        Positioned(
          right: 16,
          bottom: posterBottomOffset,
          child: Container(
            width: posterWidth,
            height: posterHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(100),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                posterUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.grey[800],
                  child: const Icon(
                    Icons.broken_image,
                    color: Colors.grey,
                    size: 40,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}