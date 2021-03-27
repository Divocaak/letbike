import 'package:flutter/material.dart';
import '../../app/itemPage.dart';
import '../general.dart';

class ItemCard {
  static Widget buildCard(context, Item item, User loggedUser) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      color: Colors.black,
      margin: const EdgeInsets.fromLTRB(5, 0, 5, 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Ink.image(
            image: NetworkImage(
                'http://www.hybrid.cz/i/auto/samorost-plzen-drevo-horske-kolo.jpeg'),
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(ItemPage.routeName,
                    arguments: new ItemInfo(item, loggedUser));
              },
            ),
            height: 240,
            fit: BoxFit.cover,
            padding: const EdgeInsets.all(50),
          ),
          Positioned(
            left: 16,
            bottom: 32,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    item.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 32,
                      shadows: [
                        Shadow(
                          color: Colors.black,
                          offset: Offset(4, 1),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    item.description,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 18,
                      shadows: [
                        Shadow(
                          color: Colors.black,
                          offset: Offset(4, 1),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 16,
            bottom: 32,
            child: Container(
              child: Text(
                item.price.toString() + "Kč",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 32,
                  fontFamily: "Montserrat",
                  shadows: [
                    Shadow(
                      color: Colors.black,
                      offset: Offset(4, 1),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
