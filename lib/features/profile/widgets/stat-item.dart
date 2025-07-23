import 'package:flutter/material.dart';

class StatItem extends StatelessWidget {
  final String label;
  final String value;
  final bool isClickable;

  const StatItem({
    super.key,
    required this.label,
    required this.value,
    required this.isClickable,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isClickable ? Colors.pink.shade300.withAlpha(40) : Colors.grey[900],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      elevation: isClickable ? 4 : 2,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          border:
              isClickable
                  ? Border.all(color: Colors.purple.withOpacity(0.3), width: 1)
                  : null,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 16),
          child: Column(
            children: [
              if (isClickable) const SizedBox(height: 8),
              Text(
                value,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isClickable ? Colors.purple.shade50 : Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color:
                      isClickable ? Colors.purple.shade50 : Colors.grey[400],
                ),
              ),
              if (isClickable) ...[
                const SizedBox(height: 4),
                Text(
                  'Tap to view',
                  style: TextStyle(
                    color: Colors.purple.shade100,
                    fontSize: 10,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}