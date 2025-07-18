import 'package:cinehive_mobile/features/home/presentation/home_page.dart';
import 'package:cinehive_mobile/features/profile/presentation/profile_page.dart';
import 'package:cinehive_mobile/features/search/presentation/search_page.dart';
import 'package:cinehive_mobile/features/shared/main_layout.dart';
import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey.shade900, width: 0.5),
        ),
      ),
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: Icon(Icons.home, size: 30, color: Colors.white),
            onPressed:
                () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (c) => MainLayout(body: HomePage()),
                    ),
                  ),
                },
          ),
          IconButton(
            icon: Icon(Icons.search, size: 30, color: Colors.white),
            onPressed:
                () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (c) => MainLayout(body: SearchPage(query: "")),
                    ),
                  ),
                },
          ),
          IconButton(
            icon: Icon(Icons.person, size: 30, color: Colors.white),
            onPressed:
                () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (c) => MainLayout(body: ProfilePage()),
                    ),
                  ),
                },
          ),
        ],
      ),
    );
  }
}
