import 'package:flutter/material.dart';
import '../dbServices.dart';
import '../widgets.dart';
import '../pallete.dart';
import '../general.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class ChatInputField extends StatefulWidget {
  final ItemInfo itemInfo;
  const ChatInputField(this.itemInfo);

  @override
  _ChatInputFieldState createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  List<Asset> images = [];

  Widget buildGridView() {
    if (images != null)
      return GridView.count(
        crossAxisCount: 3,
        children: List.generate(images.length, (index) {
          Asset asset = images[index];
          return AssetThumb(
            asset: asset,
            width: 300,
            height: 300,
          );
        }),
      );
    else
      return Container(color: Colors.white);
  }

  Future<void> loadAssets() async {
    setState(() {
      images = [];
    });

    List<Asset> resultList;
    String error;

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 1,
        enableCamera: true,
      );
    } on Exception catch (e) {
      error = e.toString();
    }
    if (!mounted) return;

    setState(() {
      images = resultList;
      if (error != null) AlertBox.showAlertBox(context, "Error", Text("Error"));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding / 2,
      ),

      //Barva dolní části
      decoration: BoxDecoration(
        color: Color(0xFF1E1F1D),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 32,
            color: Color(0xFF087949).withOpacity(0.08),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            SizedBox(width: kDefaultPadding),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: kDefaultPadding * 0.75,
                ),
                decoration: BoxDecoration(
                  //Barva Input Okna
                  color: Color(0xFF424040).withOpacity(1),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.sentiment_satisfied_alt_outlined,
                      color: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .color
                          .withOpacity(0.64),
                    ),
                    SizedBox(width: kDefaultPadding / 4),
                    Expanded(
                      child: TextField(
                          decoration: InputDecoration(
                            hintText: "Type message",
                            border: InputBorder.none,
                          ),
                          onSubmitted: (String message) {
                            setState(() {
                              if (message.length > 3) {
                                DatabaseServices.sendMessage(
                                    widget.itemInfo.me.id,
                                    widget.itemInfo.item.sellerId,
                                    widget.itemInfo.item.id,
                                    message);
                              } else {
                                AlertBox.showAlertBox(
                                    context,
                                    "Upozornění",
                                    Text(
                                        "Zpráva musí obsahovat minimálně 4 znaky."));
                              }
                            });
                          }),
                    ),
                    Container(
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Column(
                          children: [
                            Container(
                              child: TextButton(
                                child: Icon(Icons.attach_file),
                                onPressed: loadAssets,
                              ),
                            ),
                            Expanded(
                              child: buildGridView(),
                            )
                          ],
                        ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
