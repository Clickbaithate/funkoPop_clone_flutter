// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:funko_collection/funko_pop.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import '/colors.dart';

List<FunkoPop> allFunkos = [];
bool alreadyFetched = false;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<FunkoPop> filteredFunkos = allFunkos;
  late TextEditingController controller;
  String textString = "";

  @override
  void initState() {
    super.initState();
    if (alreadyFetched == false) {
      fetchFunkos();
    }
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
              onChanged: (value) {
                setState(() {
                  textString = controller.text;
                  filterFunkos(value);
                });
              },
              decoration: InputDecoration(
                hintText: 'Search',
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
              itemCount: filteredFunkos.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2), 
              itemBuilder:(context, index) => GestureDetector(
                onTap: () {
                  print("NAME: ${filteredFunkos[index].name} | INDEX: $index");
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
                        Expanded(
                          flex: 8, 
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(18),
                              child: CachedNetworkImage(
                                imageUrl: filteredFunkos[index].image,
                                placeholder: (context, url) => AspectRatio(
                                  aspectRatio: 1, 
                                  child: RefreshProgressIndicator(
                                    backgroundColor: secondaryColor,
                                    color: Colors.black,
                                  )
                                ),
                                errorWidget: (context, url, error) => Image.asset('assets/images/placeholder.jpg')
                              ),
                            ),
                          )
                        ),
                        Expanded(
                          flex: 1, 
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(0),
                              child: Text(
                                filteredFunkos[index].name,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            )
                          )
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  filteredFunkos[index].liked = !filteredFunkos[index].liked;
                                });
                              },
                              icon: Icon(
                                filteredFunkos[index].liked ? Icons.favorite : Icons.favorite_border_outlined,
                                color: Colors.red[500]
                              )
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  filteredFunkos[index].wishlist = !filteredFunkos[index].wishlist;
                                });
                              }, 
                              icon: Icon(
                                filteredFunkos[index].wishlist ? Icons.shopping_bag : Icons.shopping_bag_outlined, 
                                color: Colors.blue[500]
                              )
                            )
                          ],
                        )
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

  void fetchFunkos() async {
    print("STARTING FETCH");

    const url = "https://raw.githubusercontent.com/kennymkchan/funko-pop-data/master/funko_pop.json";
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body) as List<dynamic>;

    

    setState(() {
      for (var funko in json) {
        final funkoPop = FunkoPop(funko["title"].toString(), funko["series"].toString(), funko["imageName"].toString(), false, false);
        allFunkos.add(funkoPop);
      }
    });
    alreadyFetched = true;
    print("FETCH ENDED");
  }

  void filterFunkos(String query) {
    setState(() {
      if (query.trim().isEmpty) {
        filteredFunkos = List.from(allFunkos);
      } else {
        // Split the search query into individual words
        final List<String> keywords = query.trim().toLowerCase().split(' ').where((keyword) => keyword.isNotEmpty).toList();

        filteredFunkos = allFunkos.where((funko) {
          final handle = funko.name.toString().toLowerCase();
          // Check if any keyword is present in the handle
          return keywords.any((keyword) => handle.contains(keyword));
        }).toList();
      }
    });
  }
 
}

