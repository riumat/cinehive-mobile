import 'package:flutter/material.dart';

class CarouselSection extends StatelessWidget {
  final String title;
  final Widget child;

  const CarouselSection({
    required this.title,
    required this.child,
    required super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 25),
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        child,
      ],
    );
  }
}
