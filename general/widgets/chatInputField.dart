import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../dbServices.dart';
import '../widgets.dart';
import '../pallete.dart';

class ChatInputField extends StatefulWidget {
  final ItemInfo itemInfo;
  const ChatInputField(this.itemInfo);

  @override
  _ChatInputFieldState createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(
      source: source,
    );
    setState(() {
      _imageFile = pickedFile;
      Navigator.of(context).pop();
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
                    GestureDetector(
                      child: Icon(
                        Icons.attach_file,
                        color: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .color
                            .withOpacity(0.64),
                      ),
                      onTap: () {
                        takePhoto(ImageSource.gallery);
                      },
                    ),
                    SizedBox(width: kDefaultPadding / 4),
                    GestureDetector(
                      child: Icon(
                        Icons.camera_alt_outlined,
                        color: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .color
                            .withOpacity(0.64),
                      ),
                      onTap: () {
                        takePhoto(ImageSource.camera);
                      },
                    ),
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
