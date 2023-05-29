import 'dart:io';

import 'package:flutter/material.dart';
import 'package:moorky/zegocloud/items/msg_items/bubble/video_bubble.dart';
import 'package:video_player/video_player.dart';
import 'package:zego_zim/zego_zim.dart';


import '../bubble/image_bubble.dart';
import '../uploading_progress_model.dart';

class SendVideoMsgCell extends StatefulWidget {
  ZIMVideoMessage message;
  double? progress;
  String senderimage="";
  String time="";

  SendVideoMsgCell(
      {required this.message, required this.uploadingprogressModel,required this.senderimage,required this.time});

  UploadingprogressModel? uploadingprogressModel;
  get isUpLoading {
    if (message.sentStatus == ZIMMessageSentStatus.sending) {
      return true;
    } else {
      return false;
    }
  }

  get isUpLoadFailed {
    if (message.sentStatus == ZIMMessageSentStatus.failed) {
      return true;
    } else {
      return false;
    }
  }

  @override
  State<StatefulWidget> createState() => _SendVideoMsgCellState();
}

class _SendVideoMsgCellState extends State<SendVideoMsgCell> {

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Container()),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    margin: const EdgeInsets.only(right: 10),
                    child: Offstage(
                      offstage: !widget.isUpLoading,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.0,
                        backgroundColor: Colors.grey,
                        valueColor: AlwaysStoppedAnimation(Colors.blue),
                        value: widget.progress,
                      ),
                    ),
                  ),
                  Container(
                    width: 20,
                    height: 20,
                    margin: const EdgeInsets.only(right: 10),
                    child: Offstage(
                        offstage: !widget.isUpLoadFailed,
                        child: Icon(
                          Icons.error_outline,
                          color: Colors.red,
                        )),
                  ),
                  VideoBubble(filelocalPath: widget.message.fileLocalPath,time: widget.time,),
                  SizedBox(width: 5,),
                  profileImage(context, widget.senderimage)
                ],
              )
            ],
          ),
          //profileImage(context, widget.senderimage)
        ],
      ),
    );
  }
  Widget profileImage(context,image) {
    print("image");
    print(image);
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.width / 100),
      child: ClipRRect(
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
      ),
    );
  }
}
