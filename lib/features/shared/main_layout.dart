import 'package:cinehive_mobile/features/shared/side_bar.dart';
import 'package:cinehive_mobile/features/shared/tab_bar.dart';
import 'package:flutter/material.dart';

class MainLayout extends StatelessWidget {
  final Widget body;

  const MainLayout({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: Sidebar(),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.black,
          surfaceTintColor: Colors.black,
        ),
        body: body,
        bottomNavigationBar: CustomTabBar(),
      ),
    );
  }
}
