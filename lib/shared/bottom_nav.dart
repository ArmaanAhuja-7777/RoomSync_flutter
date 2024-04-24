import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.topic,
            size: 20,
          ),
          label: 'Topics',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.bolt,
            size: 20,
          ),
          label: 'About',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.supervised_user_circle,
            size: 20,
          ),
          label: 'Profile',
        ),
      ],
      fixedColor: Colors.deepPurple[200],
      onTap: (int idx) {
        switch (idx) {
          case 0:
            // do nothing
            break;
          case 1:
            Navigator.pushNamed(context, '/about');
            break;
          case 2:
            Navigator.pushNamed(context, '/giveInitialData');
            break;
        }
      },
    );
  }
}
