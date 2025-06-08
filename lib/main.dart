import 'package:cinehive_mobile/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


Future<void> main() async{
  await dotenv.load(fileName: '.env');
  runApp(
    const ProviderScope(
      child: MainApp(),
    ),
  );
}


