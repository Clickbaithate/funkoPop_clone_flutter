// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print
import 'package:flutter/material.dart';
import 'package:funko_collection/screen/home.dart';
import 'package:funko_collection/screen/owned.dart';
import 'package:funko_collection/screen/wishlist.dart';
import 'colors.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

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
            BottomNavigationBarItem(icon: Icon(Icons.home, color: primaryColor), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_cart, color: Colors.blue), label: "Wishlist")
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
