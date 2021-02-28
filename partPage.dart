import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

void main() {
  runApp(
    MaterialApp(
      home: ProductPage(),
    ),
  );
}

//ignore: must_be_immutable
class ProductPage extends StatelessWidget {
  String jmenoApp = 'Aplikace'; //Jméno aplikace
  String nadpis = 'Kolo'; //nadpis produktu
  String info = 'testovací informace'; //informace o produktu
  int cena = 12345; //cena produktu
  var image = 'assets/images/img.jpg';
  List images = [
    'assets/images/img.jpg',
    'assets/images/img2.jpg',
    'assets/images/img3.jpg'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(jmenoApp),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back_outlined),
              onPressed: () {}, //vrácení zpět do menu (DODĚLAT)
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
                //začátek scrollu
                itemBuilder: (BuildContext context, int index) {
                  return new Image.asset(images[index]);
                },
                itemCount: images.length,
                pagination: new SwiperPagination(),
                control: new SwiperControl(),
              ),
              width: MediaQuery.of(context).size.width,
              height: 400,
            ),
            //konec scrollu
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
                          '$nadpis', //nadpis
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          '\n$info $info $info \n$info\n$info \n$info \n$info \n$info \n$info \n$info \n$info \n$info \n$info \n$info \n$info \n$info ',
                          style: TextStyle(fontSize: 20),
                        ), //informace o kole
                        //Cena
                        Container(
                          child: Align(
                            alignment: Alignment(0.20, 1.00),
                            child: Text(
                              '$cena Kč',
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
      //tlačítko na zprávy
      floatingActionButton: FloatingActionButton(
        onPressed: () {}, //DODĚLAT ONPRESSED
        child: const Icon(Icons.chat),
      ),
    );
  }
}
