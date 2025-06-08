import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TvHomePage extends ConsumerWidget {
  final String id;
  const TvHomePage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // This is where you would implement the TV home page logic
    return Scaffold(body: Center(child: Text('TV Home Page for ID: $id')));
  }
}
