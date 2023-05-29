import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:moorky/zegocloud/items/msg_items/receive_items/receive_image_msg_cell.dart';
import 'package:moorky/zegocloud/items/msg_items/receive_items/receive_text_msg_cell.dart';
import 'package:moorky/zegocloud/items/msg_items/receive_items/receive_video_msg_cell.dart';
import 'package:moorky/zegocloud/items/msg_items/send_items/send_image_msg_cell.dart';
import 'package:moorky/zegocloud/items/msg_items/send_items/send_text_msg_cell.dart';
import 'package:moorky/zegocloud/items/msg_items/send_items/send_video_msg_cell.dart';
import 'package:moorky/zegocloud/items/msg_items/uploading_progress_model.dart';
import 'package:moorky/zegocloud/model/user_model.dart';
import 'package:zego_zim/zego_zim.dart';




class MsgConverter {
  static List<Widget> cnvMessageToWidget(List<ZIMMessage> messageList,String senderImage,String receverimage) {
    List<Widget> widgetList = [];

    for (ZIMMessage message in messageList) {
      var cell;
      var date = DateTime.fromMillisecondsSinceEpoch(message.timestamp);
      print("date");
      print(date);
      print("\t\t" + DateFormat.jm().format(date));
      switch (message.type) {
        case ZIMMessageType.text:
          if (message.senderUserID == UserModel.shared().userInfo!.userID) {
            cell = SendTextMsgCell(message: (message as ZIMTextMessage),senderimage: senderImage,time: "${"\t\t" + DateFormat.jm().format(date)}",);
          } else {
            cell = ReceiceTextMsgCell(message: (message as ZIMTextMessage),reciveimages: receverimage,time: "${"\t\t" + DateFormat.jm().format(date)}",);
          }
          break;
        case ZIMMessageType.image:
          if (message.senderUserID == UserModel.shared().userInfo!.userID) {
            cell = SendImageMsgCell(
              message: message as ZIMImageMessage,
              uploadingprogressModel: null,
              senderimage: senderImage,
              time: "${"\t\t" + DateFormat.jm().format(date)}",
            );
          } else {
            cell = ReceiveImageMsgCell(
                message: message as ZIMImageMessage,
                downloadingProgress: null,
                downloadingProgressModel: null,reciverImage: receverimage,time: "${"\t\t" + DateFormat.jm().format(date)}",);
          }
          break;
        case ZIMMessageType.video:
          if ((message as ZIMVideoMessage).fileLocalPath == '') {
            ZIM.getInstance()!.downloadMediaFile(
                message,
                ZIMMediaFileType.originalFile,
                (message, currentFileSize, totalFileSize) {});
          }
          if (message.senderUserID == UserModel.shared().userInfo!.userID) {
            cell = SendVideoMsgCell(
                message: message,
                uploadingprogressModel: null,senderimage: senderImage,time: "${"\t\t" + DateFormat.jm().format(date)}",);
          } else {
            cell = ReceiveVideoMsgCell(
                message: message,
                downloadingProgressModel: null,receiverImage: receverimage,time: "${"\t\t" + DateFormat.jm().format(date)}",);
          }
          break;
        default:
      }
      widgetList.add(cell);
    }
    return widgetList;
  }

  static ZIMMediaMessage mediaMessageFactory(
      String path, ZIMMessageType messageType) {
    ZIMMediaMessage mediaMessage;

    switch (messageType) {
      case ZIMMessageType.image:
        mediaMessage = ZIMImageMessage(path);
        break;
      case ZIMMessageType.video:
        mediaMessage = ZIMVideoMessage(path);
        break;
      case ZIMMessageType.audio:
        mediaMessage = ZIMAudioMessage(path);

        break;
      case ZIMMessageType.file:
        mediaMessage = ZIMFileMessage(path);
        break;
      default:
        {
          throw UnimplementedError();
        }
    }
    return mediaMessage;
  }

  static Widget sendMediaMessageCellFactory(
      ZIMMediaMessage message, UploadingprogressModel? uploadingprogressModel,String senderimage) {
    Widget cell;
    var date = DateTime.fromMillisecondsSinceEpoch(message.timestamp);
    print("date");
    print(date);
    print("\t\t" + DateFormat.jm().format(date));
    switch (message.type) {
      case ZIMMessageType.image:
        cell = SendImageMsgCell(
          message: message as ZIMImageMessage,
          uploadingprogressModel: uploadingprogressModel,
          senderimage: senderimage
            ,time: "${"\t\t" + DateFormat.jm().format(date)}",
        );
        break;
      case ZIMMessageType.video:
        cell = SendVideoMsgCell(
            message: message as ZIMVideoMessage,
            uploadingprogressModel: uploadingprogressModel,senderimage: senderimage,time: "${"\t\t" + DateFormat.jm().format(date)}",);
        break;
      default:
        {
          throw UnimplementedError();
        }
    }
    return cell;
  }

  // static Widget receiveMediaMessageCellFactory(ZIMMediaMessage message) {

  // }
}
