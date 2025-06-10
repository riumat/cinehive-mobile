import 'package:cinehive_mobile/features/home/presentation/home_page.dart';
import 'package:cinehive_mobile/features/profile/presentation/profile_page.dart';
import 'package:cinehive_mobile/features/search/presentation/search_page.dart';
import 'package:cinehive_mobile/features/shared/main_layout.dart';
import 'package:flutter/material.dart';

class CustomTabBar extends StatefulWidget {
  const CustomTabBar({super.key});

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  int selectedIndex = 0;

  void _onItemTapped(int index, BuildContext context) {
    setState(() {
      selectedIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (c) => MainLayout(body: HomePage())),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (c) => MainLayout(body: SearchPage())),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (c) => MainLayout(body: ProfilePage())),
        );
        break;
    }
  }

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
            icon: Icon(
              Icons.home,
              size: 30,
              color: selectedIndex == 0 ? Colors.white : Colors.grey,
            ),
            onPressed: () => _onItemTapped(0, context),
          ),
          IconButton(
            icon: Icon(
              Icons.search,
              size: 30,
              color: selectedIndex == 1 ? Colors.white : Colors.grey,
            ),
            onPressed: () => _onItemTapped(1, context),
          ),
          IconButton(
            icon: Icon(
              Icons.person,
              size: 30,
              color: selectedIndex == 2 ? Colors.white : Colors.grey,
            ),
            onPressed: () => _onItemTapped(2, context),
          ),
        ],
      ),
    );
  }
}
