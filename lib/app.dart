import 'package:cinehive_mobile/features/home/presentation/home_page.dart';
import 'package:cinehive_mobile/features/shared/main_layout.dart';
import 'package:flutter/material.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "CineHive",
      theme: ThemeData.dark(useMaterial3: true).copyWith(
       scaffoldBackgroundColor: Colors.black,
       pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android:CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS:CupertinoPageTransitionsBuilder(),
        }
       )
      ),
      debugShowCheckedModeBanner: false,
      home: MainLayout(body: HomePage()),
    );
  }
}
