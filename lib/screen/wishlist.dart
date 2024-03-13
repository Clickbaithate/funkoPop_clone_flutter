// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:funko_collection/funko_pop.dart';
import 'package:funko_collection/screen/home.dart';
import '/colors.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {

  List<FunkoPop> wishlistFunkos = [];
  List<FunkoPop> filteredFunkos = [];

  late TextEditingController controller;
  String textString = "";

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    fetchWishlistFunkos();
    filteredFunkos = wishlistFunkos;
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
              onChanged: (String value) {
                setState(() {
                  textString = controller.text;
                  filterFunkos(value);
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
              itemCount: filteredFunkos.length,
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
                                  if (!filteredFunkos[index].liked) {
                                    filteredFunkos.removeAt(index);
                                  }
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
                                  if (!filteredFunkos[index].wishlist) {
                                    filteredFunkos.removeAt(index);
                                  }
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

  void fetchWishlistFunkos() {
    for (var funko in allFunkos) {
      if (funko.wishlist) {
        wishlistFunkos.add(funko);
      }
    }
  }

  void filterFunkos(String query) {
    setState(() {
      if (query.trim().isEmpty) {
        filteredFunkos = List.from(wishlistFunkos); // Show all wishlist items when the query is empty
      } else {
        // Split the search query into individual words
        final List<String> keywords = query.trim().toLowerCase().split(' ').where((keyword) => keyword.isNotEmpty).toList();

        filteredFunkos = wishlistFunkos.where((funko) {
          final handle = funko.name.toString().toLowerCase();
          // Check if any keyword is present in the handle
          return keywords.any((keyword) => handle.contains(keyword));
        }).toList();
      }
    });
  }

}