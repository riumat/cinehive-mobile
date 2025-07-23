import 'package:flutter/material.dart';

class DetailLayout extends StatelessWidget {
  final Widget body;

  const DetailLayout({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon:  Icon(Icons.chevron_left, size: 40, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
