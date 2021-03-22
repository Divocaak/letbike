import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:letbike/chat/chatScreen.dart';
import 'homePage.dart';
import '../general/widgets.dart';
import '../general/dbServices.dart';

class ItemPage extends StatefulWidget {
  @override
  _ItemPageState createState() => _ItemPageState();
  static const routeName = "/itemPage";
}

class _ItemPageState extends State<ItemPage>
    with SingleTickerProviderStateMixin {
  Future<List<Chat>> chats;
  ItemInfo itemInfo;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    itemInfo = ModalRoute.of(context).settings.arguments;
    chats = DatabaseServices.getChats(itemInfo.item.id);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("delete me l8r"),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back_outlined),
              onPressed: () {
                Navigator.of(context).pop();
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
                          itemInfo.item.name,
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          itemInfo.item.description,
                          style: TextStyle(fontSize: 20),
                        ),
                        Container(
                          child: Align(
                            alignment: Alignment(0.20, 1.00),
                            child: Text(
                              itemInfo.item.price.toString() + " Kč",
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
        onPressed: () {
          if (itemInfo.item.sellerId != itemInfo.me.id) {
            Navigator.of(context)
                .pushNamed(ChatScreen.routeName, arguments: itemInfo);
          } else {
            AlertBox.showAlertBox(
                context,
                "Vyberte chat",
                Container(
                    height: 500,
                    width: 500,
                    child: FutureBuilder<List<Chat>>(
                      future: chats,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, i) {
                                return _buildCard(snapshot.data[i], context);
                              });
                        } else if (snapshot.hasError) {
                          return Text('Sorry there is an error');
                        }
                        return Center(child: CircularProgressIndicator());
                      },
                    )));
          }
        },
        child: const Icon(Icons.chat),
      ),
    );
  }

  Widget _buildCard(Chat chat, context) {
    if (chat.username == "0") {
      return Text("Žádné chaty");
    }
    {
      return TextButton(
          onPressed: () {
            Navigator.of(context)
                .pushNamed(ChatScreen.routeName, arguments: itemInfo);
          },
          child: Text(chat.email + " (" + chat.username + ")"));
    }
  }
}
