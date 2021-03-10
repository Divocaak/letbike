import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import "../dbServices.dart";

//ignore: must_be_immutable
class ProductPage extends StatelessWidget {
  final Item item;

  ProductPage({Key key, @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("delete me l8r"),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back_outlined),
              onPressed: () {
                Navigator.pop(context);
              },
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return Icon(Icons.error); //new Image.asset("");
                },
                itemCount: 1, //images.length,
                pagination: new SwiperPagination(),
                control: new SwiperControl(),
              ),
              width: MediaQuery.of(context).size.width,
              height: 400,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(),
                ),
                Expanded(
                  flex: 25,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          item.name,
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          item.description,
                          style: TextStyle(fontSize: 20),
                        ),
                        Container(
                          child: Align(
                            alignment: Alignment(0.20, 1.00),
                            child: Text(
                              item.price.toString() + " Kč",
                              style: TextStyle(
                                  fontSize: 40, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ]),
                ),
                Expanded(
                  flex: 1,
                  child: Container(),
                ),
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.chat),
      ),
    );
  }
}
