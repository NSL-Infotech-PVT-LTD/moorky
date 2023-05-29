

import 'package:flutter/material.dart';
import 'package:moorky/zegocloud/items/msg_items/downloading_progress_model.dart';
import 'package:zego_zim/zego_zim.dart';


import '../bubble/image_bubble.dart';

class ReceiveImageMsgCell extends StatefulWidget {
  ZIMImageMessage message;
  double? progress;
  String reciverImage="";
  String time="";
  DownloadingProgressModel? downloadingProgressModel;
  ZIMMediaDownloadingProgress? downloadingProgress;

  ReceiveImageMsgCell(
      {required this.message,
      required this.downloadingProgress,
      required this.downloadingProgressModel,required this.reciverImage,required this.time}) {}

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
  State<StatefulWidget> createState() => ReceiveImageMsgCellState();
}

class ReceiveImageMsgCellState extends State<ReceiveImageMsgCell> {
   checkIsdownload() async {
    if (widget.message.fileLocalPath == '') {
      ZIMMediaDownloadedResult result = await ZIM
          .getInstance()
          !.downloadMediaFile(widget.message, ZIMMediaFileType.originalFile,
              (message, currentFileSize, totalFileSize) {});
      setState(() {
        widget.message = result.message as ZIMImageMessage;
      });
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    checkIsdownload();
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          profileImage(context, widget.reciverImage),
          SizedBox(width: 5,),
          ImageBubble(filelocalPath: widget.message.fileLocalPath,time: widget.time,),
        ],
      ),
    );
  }
  Widget profileImage(context,image) {
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
