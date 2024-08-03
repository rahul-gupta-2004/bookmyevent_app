import 'package:flutter/material.dart';
import 'package:seproject/events/events.dart';
import 'package:seproject/home/home_page.dart';
import 'package:seproject/search.dart';
import 'package:seproject/settings/settings.dart';
import 'package:seproject/settings/user_profile.dart';
import 'package:seproject/other/color_palette.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({Key? key}) : super(key: key);

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int selectedPage = 0;
  final pages = [
    HomePage(),
    Events(),
    SearchSection(),
    SettingsPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Color(background_darkgrey),
        body: pages[selectedPage],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          backgroundColor: Color(background_darkgrey),
          unselectedItemColor: Color(background_darkgrey),
          unselectedIconTheme: IconThemeData(color: Color(background_darkgrey)),
          selectedItemColor: Color(selected_maroon),
          selectedIconTheme: IconThemeData(color: Color(selected_maroon)),
          showUnselectedLabels: false,
          useLegacyColorScheme: false,
          // fixedColor: Color(background_darkgrey),
          elevation: 5.0,
          currentIndex: selectedPage,
          onTap: (int index) {
            setState(() {
              selectedPage = index;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: "Home",
                backgroundColor: Color(golden_yellow)),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.event,
                ),
                label: "Events",
                backgroundColor: Color(golden_yellow)),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.search,
                ),
                label: "Search",
                backgroundColor: Color(golden_yellow)),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,
                ),
                label: "Settings",
                backgroundColor: Color(golden_yellow)),
          ],
        ),

      ),
    );
  }
}
