import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:zego_zim/zego_zim.dart';

import '../bubble/text_bubble.dart';

class SendTextMsgCell extends StatefulWidget {
  ZIMTextMessage message;
  String senderimage="";
  String time="";

  SendTextMsgCell({required this.message,required this.senderimage,required this.time});
  @override
  State<StatefulWidget> createState() => _MyCellState();
}

class _MyCellState extends State<SendTextMsgCell> {
  get isSending {
    if (widget.message.sentStatus == ZIMMessageSentStatus.sending) {
      return true;
    } else {
      return false;
    }
  }

  get isSentFailed {
    if (widget.message.sentStatus == ZIMMessageSentStatus.failed) {
      return true;
    } else {
      return false;
    }
  }
  @override
  void initState() {
    print(widget.senderimage);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
               // Text(widget.message.senderUserID),
                Row(
                  children: [
                    Offstage(
                      offstage: !isSending,
                      child: Container(
                        width: 20,
                        height: 20,
                        margin: const EdgeInsets.only(right: 10),
                        child: const CircularProgressIndicator(
                          strokeWidth: 2.0,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Offstage(
                      offstage: !isSentFailed,
                      child: Container(
                          width: 20,
                          height: 20,
                          margin: const EdgeInsets.only(right: 10),
                          child: Icon(
                            Icons.error_outline,
                            color: Colors.red,
                          )),
                    ),
                    TextBubble(widget.message.message, Color(0xff6B00C3),
                        Colors.white, 5, 5,true,widget.time),
                    SizedBox(width: 5,),

                    profileImage(context, widget.senderimage)
                  ],
                )
              ],
            ),


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
