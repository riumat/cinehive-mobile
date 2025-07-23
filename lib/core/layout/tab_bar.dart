import 'package:cinehive_mobile/features/home/presentation/home_page.dart';
import 'package:cinehive_mobile/features/profile/presentation/profile_page.dart';
import 'package:cinehive_mobile/core/layout/main_layout.dart';
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
      height: 55,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: Icon(Icons.home_outlined, size: 30, color: Colors.white),
            onPressed:
                () => {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (c) => MainLayout(body: HomePage()),
                    ),
                  ),
                },
          ),
         
          IconButton(
            icon: Icon(Icons.person_outline, size: 30, color: Colors.white),
            onPressed:
                () => {
                  Navigator.pushReplacement(
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
