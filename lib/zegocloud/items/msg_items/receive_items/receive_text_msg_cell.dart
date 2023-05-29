import 'package:flutter/material.dart';
import 'package:zego_zim/zego_zim.dart';

import '../bubble/text_bubble.dart';

class ReceiceTextMsgCell extends StatefulWidget {
  ZIMTextMessage message;
  String reciveimages="";
  String time="";

  ReceiceTextMsgCell({required this.message,required this.reciveimages,required this.time});

  @override
  State<StatefulWidget> createState() => _MyCellState();
}

class _MyCellState extends State<ReceiceTextMsgCell> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            profileImage(context, widget.reciveimages),
            SizedBox(width: 5,),
            TextBubble(
                widget.message.message,
                Colors.white,
                Colors.black,
                5,
                5,false,widget.time),
          ],
        ));
  }
  Widget profileImage(context,image) {
    print("image");
    print(image);
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: image.isNotEmpty
          ? Image.network(
        image,
        fit: BoxFit.cover,
        height: MediaQuery.of(context).size.width / 12,
        width: MediaQuery.of(context).size.width / 12,
      )
          : Image.asset(
        "assets/images/girl.jpg",
        fit: BoxFit.cover,
        height: MediaQuery.of(context).size.width / 12,
        width: MediaQuery.of(context).size.width / 12,
      ),
    );
  }
}
