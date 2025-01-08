import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medcall_pro/screens/profile/profile_screen.dart';

import '../screens/home/home_screen.dart';
import '../screens/statistics/statistics_screen.dart';
import '../utils/color_screen.dart';
class NavBarScreen extends StatefulWidget {
  @override
  _NavBarScreenState createState() => _NavBarScreenState();
}

class _NavBarScreenState extends State<NavBarScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    StatisticsScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: ScreenColor.white,
        selectedItemColor: ScreenColor.color6,
        unselectedItemColor: ScreenColor.color2,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Iconsax.home),
            label: 'Главная',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.status),
            label: 'Cтатистика',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.user),
            label: 'Профиль',
          ),
        ],
      ),
    );
  }
}