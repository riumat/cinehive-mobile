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
          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 15),
        ShaderMask(
          shaderCallback: (Rect bounds) {
            return LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Colors.white,
                Colors.white,
                Colors.transparent,
              ],
              stops: const [0.0, 0.80, 1.0], // regola 0.85 per la larghezza della dissolvenza
            ).createShader(bounds);
          },
          blendMode: BlendMode.dstIn,
          child: child,
        ),
      ],
    );
  }
}