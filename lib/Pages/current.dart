import 'package:flutter/material.dart';
import 'package:namer_app/Pages/home.dart';
import 'package:namer_app/Pages/postcreator.dart';
import 'package:namer_app/Pages/profile.dart';
import 'package:namer_app/Pages/search.dart';
import 'package:namer_app/Pages/settings.dart';

class CurrentPage extends StatefulWidget {

  @override
  State<CurrentPage> createState() => _CurrentPageState();
}

class _CurrentPageState extends State<CurrentPage> {
  int selectedIndex = 0;
  Widget currentPage = HomePage();

  final pages = [
    HomePage(),
    SearchPage(),
    PostCreatorPage(),
    ProfilePage(),
    SettingsPage(),
  ];

  void navigateBottomBar(index) {
    setState(() {
      selectedIndex = index;
      currentPage = pages[selectedIndex];
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentPage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: navigateBottomBar, 
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: "Post"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
        ],
      ),
    );
  }
}