import 'package:cinehive_mobile/features/home/presentation/home_page.dart';
import 'package:cinehive_mobile/routes/routes.dart';
import 'package:flutter/material.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "CineHive",
      theme: ThemeData.dark(useMaterial3: true),
      home: SafeArea(child: const HomePage()),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: onGenerateRoute,
    );
  }
}
