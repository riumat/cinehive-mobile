

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieHomePage extends ConsumerWidget{
  final String id;
  const MovieHomePage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Text('Movie Home Page for ID: $id'),
      ),
    );
  }
}