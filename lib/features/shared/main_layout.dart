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
        body: Stack(
          children: [
            body,
            Positioned(
              top: 10,
              left: 16,
              child: Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Builder(
                  builder:
                      (context) => IconButton(
                        padding: EdgeInsets.zero,
                        icon: const Icon(Icons.menu,size: 30, color: Colors.white),
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                      ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: CustomTabBar(),
      ),
    );
  }
}
