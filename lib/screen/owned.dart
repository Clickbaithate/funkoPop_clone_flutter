// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:funko_collection/assets/colors.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {

  late TextEditingController controller;
  String textString = "";

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(12),
            child: TextField(
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              controller: controller,
              onSubmitted: (String value) {
                setState(() {
                  textString = controller.text;
                });
              },
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.search),
                suffixIconColor: Colors.black,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  borderSide: BorderSide(width: 2)
                )
              ),
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              itemCount: 24,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2), 
              itemBuilder:(context, index) => GestureDetector(
                onTap: () {

                },
                child: Padding(
                  padding: EdgeInsets.all(4),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: secondaryColor,
                    ),
                    child: Column(
                      children: [
                        Expanded(flex: 5, child: Icon(Icons.person, size: 175)),
                        Expanded(flex: 1, child: Text((index+1).toString()))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}