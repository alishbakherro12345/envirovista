import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'profile_page.dart';
import 'foot_print_page.dart';
import 'learn_page.dart';
import 'reduce_page.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;

  CustomBottomNavBar({required this.selectedIndex});

  void _onTabTapped(BuildContext context, int index) {
    Widget selectedPage;
    switch (index) {
      case 0:
        selectedPage = ProfilePage();
        break;
      case 1:
        selectedPage = FootprintPage();
        break;
      case 2:
        selectedPage = LearnPage();
        break;
      case 3:
        selectedPage = ReducePage();
        break;
      default:
        selectedPage = ProfilePage();
    }

    if (selectedPage.runtimeType != context.widget.runtimeType) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => selectedPage),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
          borderRadius: BorderRadius.circular(18),
          color: const Color(0xff2A3C24),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          child: GNav(
            gap: 8,
            backgroundColor: const Color(0xff2A3C24),
            color: Colors.white,
            activeColor: Colors.white,
            padding: const EdgeInsets.all(16),
            tabs: List.generate(4, (index) {
              return GButton(
                icon: _getIcon(index),
                text: _getText(index),
                textStyle: TextStyle(
                  fontSize: 12,
                  color: selectedIndex == index ? Colors.white : Colors.white.withOpacity(0.6),
                ),
                iconActiveColor: Colors.white,
                iconColor: Colors.white.withOpacity(0.6), // Adjust opacity for non-selected icons
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                border: selectedIndex == index
                    ? Border.all(color: Colors.white, width: 1)
                    : Border.all(color: Colors.transparent, width: 1),
                onPressed: () {
                  _onTabTapped(context, index);
                },
              );
            }),
            selectedIndex: selectedIndex,
            onTabChange: (index) {
              _onTabTapped(context, index);
            },
          ),
        ),
      ),
    );
  }

  IconData _getIcon(int index) {
    switch (index) {
      case 0:
        return Icons.person;
      case 1:
        return Icons.stacked_bar_chart;
      case 2:
        return Icons.lightbulb;
      case 3:
        return Icons.recycling;
      default:
        return Icons.person;
    }
  }

  String _getText(int index) {
    switch (index) {
      case 0:
        return 'Profile';
      case 1:
        return 'Footprint';
      case 2:
        return 'Learn';
      case 3:
        return 'Reduce';
      default:
        return 'Profile';
    }
  }
}