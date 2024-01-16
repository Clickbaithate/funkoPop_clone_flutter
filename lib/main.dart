// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:funko_collection/screen/home.dart';
import 'package:funko_collection/screen/owned.dart';
import 'package:funko_collection/screen/wishlist.dart';
import 'package:funko_collection/assets/colors.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  var currentIndex = 1;
  List pages = [MenuScreen(), HomeScreen(), WishlistScreen()];
  List screenTitle = ["Owned", "Home", "Wishlist"];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          title: Center(child: Text(screenTitle[currentIndex])), backgroundColor: primaryColor,
        ),
        body: pages[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: accentColor,
          unselectedFontSize: 14,
          unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w800, fontStyle: FontStyle.italic),
          selectedItemColor: Colors.black,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          selectedFontSize: 16,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.favorite, color: Colors.pink), label: "Owned"),
            BottomNavigationBarItem(icon: Icon(Icons.home, color: Colors.indigo), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_cart, color: Colors.teal), label: "Wishlist")
          ],
          currentIndex: currentIndex,
          onTap: (int index) {
            setState(() {
              currentIndex = index;
            });
          },
        )
      ),
    );
  }
}
