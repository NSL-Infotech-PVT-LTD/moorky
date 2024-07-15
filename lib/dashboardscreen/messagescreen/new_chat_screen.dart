import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';

import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:moorky/auth/provider/authprovider.dart';
import 'package:moorky/auth/view/login_screen.dart';
import 'package:moorky/commanWidget/commanwidget.dart';
import 'package:moorky/constant/color.dart';
import 'package:moorky/dashboardscreen/messagescreen/color_constants.dart';
import 'package:moorky/dashboardscreen/messagescreen/full_photo.dart';
import 'package:moorky/dashboardscreen/model/message_chat.dart';
import 'package:moorky/dashboardscreen/provider/chat_provider.dart';
import 'package:moorky/dashboardscreen/provider/dashboardprovider.dart';
import 'package:moorky/dashboardscreen/repository/dashboardrepository.dart';
import 'package:moorky/main.dart';
import 'package:moorky/profilecreate/provider/profileprovider.dart';
import 'package:moorky/profiledetailscreen/view/matchprofiledetail.dart';
import 'package:moorky/zegocloud/items/msg_items/send_items/send_text_msg_cell.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zego_zim/zego_zim.dart';

import '../../zegocloud/model/user_model.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({required this.arguments});

  final ChatPageArguments arguments;

  @override
  ChatPageState createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> {
  String currentUserId = "";

  List<QueryDocumentSnapshot> listMessage = [];
  int _limit = 20;
  int _limitIncrement = 20;
  String groupChatId = "";

  File? imageFile;
  bool isLoading = false;
  bool isShowSticker = false;
  String imageUrl = "";

  final TextEditingController textEditingController = TextEditingController();
  final ScrollController listScrollController = ScrollController();
  final FocusNode focusNode = FocusNode();

  ChatProvider ?chatProvider ;
  late final AuthProvider authProvider = context.read<AuthProvider>();
  late StreamSubscription<bool> keyboardSubscription;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 100),(){
      chatProvider=Provider.of<ChatProvider>(context,listen: false);
      isChatEnableOrNot();

      readLocal();
      readMessage();
    });
   focusNode.addListener(onFocusChange);
    listScrollController.addListener(_scrollListener);


  }
  @override
  void dispose() {
    keyboardSubscription.cancel();
    super.dispose();
  }
  bool chat=true;
  readMessage() async {
    Future.delayed(Duration(milliseconds: 100), () {
      var dashboardprovider =
          Provider.of<DashboardProvider>(context, listen: false);
      DashboardRepository.readChat(
        userId: widget.arguments.otherUserId.toString(),
        accesstoken: preferences!.getString("accesstoken").toString(),
      );

    });

    var keyboardVisibilityController = KeyboardVisibilityController();
    // Query
    print('Keyboard visibility direct query: ${keyboardVisibilityController.isVisible}');

    // Subscribe
    keyboardSubscription = keyboardVisibilityController.onChange.listen((bool visible) {
      print('Keyboard visibility update. Is visible: $visible');
      if(visible==false){
        // chatProvider?.sendTypingEvent(false,userId: widget.arguments.peerId);

      }
      else{
        // chatProvider?.sendTypingEvent(true,userId: widget.arguments.peerId);
      }



    });
  }
isChatEnableOrNot()async{
    print('ddsismeeke');
    SharedPreferences preferences=await SharedPreferences.getInstance();
  ProfileProvider profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    isLoading=true;
    setState((){});
  chat = await profileProvider.userChatOrNot(
      userId: "",
      otherUserId:
      widget.arguments.otherUserId.toString(),
      accessToken:
      preferences!
          .getString(
          "accesstoken")!);

    isLoading=false;
    setState((){});
  print("fjffjffj$chat");
}
  _scrollListener() {
    if (!listScrollController.hasClients) return;
    if (listScrollController.offset >=
            listScrollController.position.maxScrollExtent &&
        !listScrollController.position.outOfRange &&
        _limit <= listMessage.length) {
      setState(() {
        _limit += _limitIncrement;
      });
    }
  }

  void onFocusChange() {
    if (focusNode.hasFocus) {
      // Hide sticker when keyboard appear
      setState(() {
        isShowSticker = false;
      });
    }
  }

  SharedPreferences? preferences;
  void readLocal() async {
    notifitypeScreen="ChatScreen";
    final db = FirebaseFirestore.instance;
    preferences = await SharedPreferences.getInstance();

    //if (authProvider.getUserFirebaseId()?.isNotEmpty == true) {
    Query userRef =
        db.collection("users").where((widget.arguments.peerNickname));

    QuerySnapshot userSnap = await userRef.get();
    for (int i = 0; i < userSnap.docs.length; i++) {
      if ((preferences!.getString('email')??"").toLowerCase() == userSnap.docs[i]['nickname'].toLowerCase()) {
        print("hjkjhgvjkojhk");
        currentUserId = userSnap.docs[i].id;

      }
    }
    print((preferences!.getString('email')));
    print("(preferences!.getString('email'))");
    setState(() {});
    // } else {

    //   Navigator.of(context).pushAndRemoveUntil(
    //     MaterialPageRoute(builder: (context) => Login_Screen()),
    //         (Route<dynamic> route) => false,
    //   );
    // }
    String peerId = widget.arguments.peerId;
    if (currentUserId.compareTo(peerId) > 0) {
      groupChatId = '$currentUserId-$peerId';
    } else {
      groupChatId = '$peerId-$currentUserId';
    }


    print("groupChatIpeerIdd$peerId");
    print("groupChatIpcurrentUserId$currentUserId");
    print(groupChatId);

   // chatProvider.getCurrentUserDetail(userId:currentUserId);
    setState(() {});
    if(currentUserId.isNotEmpty){
      chatProvider?.updateDataFirestore(
        FirestoreConstants.pathUserCollection,
        currentUserId,
        {FirestoreConstants.chattingWith: peerId},
      );
    }

  }

  // sendTextMessage(String message) async {
  //   ZIMTextMessage textMessage = ZIMTextMessage(message: message);
  //   print("textMessage.timestamp===");
  //   print(textMessage.timestamp);
  //   textMessage.senderUserID = UserModel.shared().userInfo!.userID;
  //   ZIMMessageSendConfig sendConfig = ZIMMessageSendConfig();
  //   var date = DateTime.fromMillisecondsSinceEpoch(textMessage.timestamp);
  //   print("date");
  //   print(date);
  //   print("\t\t" + DateFormat.jm().format(date));
  //   // widget._historyZIMMessageList.add(textMessage);textMessage
  //   SendTextMsgCell cell = SendTextMsgCell(
  //     message: textMessage,
  //     senderimage: widget.senderImage,
  //     time: "${"\t\t" + DateFormat.jm().format(date)}",
  //   );
  //   setState(() {
  //     widget._historyMessageWidgetList.add(cell);
  //   });
  //   try {
  //     ZIMMessageSentResult result = await ZIM
  //         .getInstance()!
  //         .sendPeerMessage(textMessage, widget.conversationID, sendConfig);
  //     print("result.message.timestamp===");
  //     print(result.message.timestamp);
  //     var date = DateTime.fromMillisecondsSinceEpoch(result.message.timestamp);
  //     print("date");
  //     print(date);
  //     print("\t\t" + DateFormat.jm().format(date));
  //     int index = widget._historyZIMMessageList
  //         .lastIndexWhere((element) => element == textMessage);
  //     widget._historyZIMMessageList[index] = result.message;
  //     SendTextMsgCell cell = SendTextMsgCell(
  //       message: (result.message as ZIMTextMessage),
  //       senderimage: widget.senderImage,
  //       time: "${"\t\t" + DateFormat.jm().format(date)}",
  //     );
  //
  //     setState(() {
  //       widget._historyMessageWidgetList[index] = cell;
  //     });
  //   } on PlatformException catch (onError) {
  //     log('send error,code:' + onError.code + 'message:' + onError.message!);
  //     setState(() {
  //       int index = widget._historyZIMMessageList
  //           .lastIndexWhere((element) => element == textMessage);
  //       widget._historyZIMMessageList[index].sentStatus =
  //           ZIMMessageSentStatus.failed;
  //       var date = DateTime.fromMillisecondsSinceEpoch(
  //           widget._historyZIMMessageList[index].timestamp);
  //       print("date");
  //       print(date);
  //       print("\t\t" + DateFormat.jm().format(date));
  //       SendTextMsgCell cell = SendTextMsgCell(
  //         message: (widget._historyZIMMessageList[index] as ZIMTextMessage),
  //         senderimage: widget.senderImage,
  //         time: "\t\t" + DateFormat.jm().format(date),
  //       );
  //       widget._historyMessageWidgetList[index] = cell;
  //     });
  //   }
  // }
  //
  // sendMediaMessage(String? path, ZIMMessageType messageType) async {
  //   if (path == null) return;
  //   ZIMMediaMessage mediaMessage =
  //   MsgConverter.mediaMessageFactory(path, messageType);
  //   print("textMessage.timestamp===ghg");
  //   print(mediaMessage.timestamp);
  //   mediaMessage.senderUserID = UserModel.shared().userInfo!.userID;
  //   UploadingprogressModel uploadingprogressModel = UploadingprogressModel();
  //   Widget sendMsgCell = MsgConverter.sendMediaMessageCellFactory(
  //       mediaMessage, uploadingprogressModel, widget.senderImage);
  //
  //   setState(() {
  //     widget._historyZIMMessageList.add(mediaMessage);
  //     widget._historyMessageWidgetList.add(sendMsgCell);
  //   });
  //   try {
  //     log(mediaMessage.fileLocalPath);
  //     ZIMMessageSentResult result = await ZIM.getInstance()!.sendMediaMessage(
  //         mediaMessage,
  //         widget.conversationID,
  //         ZIMConversationType.peer,
  //         ZIMMessageSendConfig(), (message, currentFileSize, totalFileSize) {
  //       uploadingprogressModel.uploadingprogress!(
  //           message, currentFileSize, totalFileSize);
  //     } as ZIMMediaMessageSendNotification?);
  //     int index = widget._historyZIMMessageList
  //         .lastIndexWhere((element) => element == mediaMessage);
  //     Widget resultCell = MsgConverter.sendMediaMessageCellFactory(
  //         result.message as ZIMMediaMessage, null, widget.senderImage);
  //     setState(() {
  //       widget._historyMessageWidgetList[index] = resultCell;
  //     });
  //   } on PlatformException catch (onError) {
  //     int index = widget._historyZIMMessageList
  //         .lastIndexWhere((element) => element == mediaMessage);
  //     widget._historyZIMMessageList[index].sentStatus =
  //         ZIMMessageSentStatus.failed;
  //     Widget failedCell = MsgConverter.sendMediaMessageCellFactory(
  //         widget._historyZIMMessageList[index] as ZIMMediaMessage,
  //         null,
  //         widget.senderImage);
  //     setState(() {
  //       widget._historyMessageWidgetList[index] = failedCell;
  //     });
  //   }
  // }
  Future getImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? pickedFile = await imagePicker
        .pickImage(source: ImageSource.gallery)
        .catchError((err) {


      return null;
    });
    if (pickedFile != null) {

      imageFile = File(pickedFile.path);
      if (imageFile != null) {
        setState(() {
          isLoading = true;
        });
        uploadFile();
      }
    }
  }

  void getSticker() {
    // Hide keyboard when sticker appear
    focusNode.unfocus();
    setState(() {
      isShowSticker = !isShowSticker;
    });
  }

  Future uploadFile() async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    UploadTask ?uploadTask = chatProvider?.uploadFile(imageFile!, fileName);
    try {
      TaskSnapshot ?snapshot = await uploadTask;
      imageUrl = await snapshot?.ref.getDownloadURL()??"";
      setState(() {
        isLoading = false;
        onSendMessage(imageUrl, TypeMessage.image);
      });
      var issend = await DashboardRepository.chatcreate(
          preferences!.getString("accesstoken").toString(),
          widget.arguments.otherUserId.toString(),
          "image",
          imageUrl,groupId: groupChatId);
    } on FirebaseException catch (e) {
      setState(() {
        isLoading = false;
      });
      // Fluttertoast.showToast(msg: e.message ?? e.toString());
    }
  }

  void onSendMessage(String content, int type) async {
    if (content.trim().isNotEmpty) {
      textEditingController.clear();
      chatProvider?.sendMessage(
          content, type, groupChatId, currentUserId, widget.arguments.peerId);
      if (listScrollController.hasClients) {
        listScrollController.animateTo(0,
            duration: Duration(milliseconds: 300), curve: Curves.easeOut);
      }
    } else {
      // Fluttertoast.showToast(msg: 'Nothing to send', backgroundColor: ColorConstants.greyColor);
    }
    var issend = await DashboardRepository.chatcreate(
        preferences!.getString("accesstoken").toString(),
        widget.arguments.otherUserId.toString(),
        "text",
        content,
        groupId: "${(preferences!.getString('email'))??""},$currentUserId");
  }

  Widget buildItem(int index, DocumentSnapshot? document) {
    if (document != null) {

      MessageChat messageChat = MessageChat.fromDocument(document);
      print("messageChat.toJson()");
      print(messageChat.toJson());
      var groupId=groupChatId.split("-");
      if ((messageChat.idFrom??"") == currentUserId) {

        // Right (my message)
        return groupId[0]==currentUserId?
        messageChat.isDelete!=1?Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            messageChat.type == TypeMessage.text
                // Text
                ? Container(
                    padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                    width: 200,
                    decoration: BoxDecoration(
                        color: ColorConstants.greyColor2,
                        borderRadius: BorderRadius.circular(8)),
                    margin: EdgeInsets.only(
                        bottom: isLastMessageRight(index) ? 20 : 10, right: 10),
                    child: Text(
                      messageChat.content,
                      style: TextStyle(color: ColorConstants.primaryColor),
                    ),
                  )
                : messageChat.type == TypeMessage.image
                    // Image
                    ? Container(
                        child: OutlinedButton(
                          child: Material(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            clipBehavior: Clip.hardEdge,
                            child: Image.network(
                              messageChat.content,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Container(
                                  decoration: BoxDecoration(
                                    color: ColorConstants.greyColor2,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                  ),
                                  width: 200,
                                  height: 200,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: ColorConstants.themeColor,
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                    ),
                                  ),
                                );
                              },
                              errorBuilder: (context, object, stackTrace) {
                                return Material(
                                  child: Image.asset(
                                    'images/img_not_available.jpeg',
                                    width: 200,
                                    height: 200,
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                  clipBehavior: Clip.hardEdge,
                                );
                              },
                              width: 200,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FullPhotoPage(
                                  url: messageChat.content,
                                ),
                              ),
                            );
                          },
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  EdgeInsets.all(0))),
                        ),
                        margin: EdgeInsets.only(
                            bottom: isLastMessageRight(index) ? 20 : 10,
                            right: 10),
                      )
                    // Sticker
                    : Container(
                        margin: EdgeInsets.only(
                            bottom: isLastMessageRight(index) ? 20 : 10,
                            right: 10),
                        child: Image.asset(
                          'images/${messageChat.content}.gif',
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
          ],
        ):
        SizedBox.shrink()

            :messageChat.isDeleteSecond!=1?
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            messageChat.type == TypeMessage.text
            // Text
                ? Container(
              padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
              width: 200,
              decoration: BoxDecoration(
                  color: ColorConstants.greyColor2,
                  borderRadius: BorderRadius.circular(8)),
              margin: EdgeInsets.only(
                  bottom: isLastMessageRight(index) ? 20 : 10, right: 10),
              child: Text(
                messageChat.content,
                style: TextStyle(color: ColorConstants.primaryColor),
              ),
            )
                : messageChat.type == TypeMessage.image
            // Image
                ? Container(
              margin: EdgeInsets.only(
                  bottom: isLastMessageRight(index) ? 20 : 10,
                  right: 10),
              child: OutlinedButton(
                child: Material(
                  child: Image.network(
                    messageChat.content,
                    loadingBuilder: (BuildContext context,
                        Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        decoration: BoxDecoration(
                          color: ColorConstants.greyColor2,
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        width: 200,
                        height: 200,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: ColorConstants.themeColor,
                            value:
                            loadingProgress.expectedTotalBytes !=
                                null
                                ? loadingProgress
                                .cumulativeBytesLoaded /
                                loadingProgress
                                    .expectedTotalBytes!
                                : null,
                          ),
                        ),
                      );
                    },
                    errorBuilder: (context, object, stackTrace) {
                      return Material(
                        child: Image.asset(
                          'images/img_not_available.jpeg',
                          width: 200,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                        clipBehavior: Clip.hardEdge,
                      );
                    },
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  clipBehavior: Clip.hardEdge,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FullPhotoPage(
                        url: messageChat.content,
                      ),
                    ),
                  );
                },
                style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.all(0))),
              ),
            )
            // Sticker
                : Container(
              margin: EdgeInsets.only(
                  bottom: isLastMessageRight(index) ? 20 : 10,
                  right: 10),
              child: Image.asset(
                'images/${messageChat.content}.gif',
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ):
        SizedBox.shrink();
      }
      else {
        // Left (peer message)
        return groupId[0]==currentUserId?messageChat.isDelete!=1?
        Container(
          margin: EdgeInsets.only(bottom: 10),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  isLastMessageLeft(index)
                      ? Material(
                          child: Image.network(
                            widget.arguments.peerAvatar,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  color: ColorConstants.themeColor,
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            },
                            errorBuilder: (context, object, stackTrace) {
                              return Icon(
                                Icons.account_circle,
                                size: 35,
                                color: ColorConstants.greyColor,
                              );
                            },
                            width: 35,
                            height: 35,
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(18),
                          ),
                          clipBehavior: Clip.hardEdge,
                        )
                      : Container(width: 35),
                  messageChat.type == TypeMessage.text
                      ? Container(
                          child: Text(
                            messageChat.content,
                            style: TextStyle(color: Colors.white),
                          ),
                          padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                          width: 200,
                          decoration: BoxDecoration(
                              color: ColorConstants.primaryColor,
                              borderRadius: BorderRadius.circular(8)),
                          margin: EdgeInsets.only(left: 10),
                        )
                      : messageChat.type == TypeMessage.image
                          ? Container(
                              child: TextButton(
                                child: Material(
                                  child: Image.network(
                                    messageChat.content,
                                    loadingBuilder: (BuildContext context,
                                        Widget child,
                                        ImageChunkEvent? loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Container(
                                        decoration: BoxDecoration(
                                          color: ColorConstants.greyColor2,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(8),
                                          ),
                                        ),
                                        width: 200,
                                        height: 200,
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            color: ColorConstants.themeColor,
                                            value: loadingProgress
                                                        .expectedTotalBytes !=
                                                    null
                                                ? loadingProgress
                                                        .cumulativeBytesLoaded /
                                                    loadingProgress
                                                        .expectedTotalBytes!
                                                : null,
                                          ),
                                        ),
                                      );
                                    },
                                    errorBuilder:
                                        (context, object, stackTrace) =>
                                            Material(
                                      child: Image.asset(
                                        'images/img_not_available.jpeg',
                                        width: 200,
                                        height: 200,
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(8),
                                      ),
                                      clipBehavior: Clip.hardEdge,
                                    ),
                                    width: 200,
                                    height: 200,
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  clipBehavior: Clip.hardEdge,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FullPhotoPage(
                                          url: messageChat.content),
                                    ),
                                  );
                                },
                                style: ButtonStyle(
                                    padding:
                                        MaterialStateProperty.all<EdgeInsets>(
                                            EdgeInsets.all(0))),
                              ),
                              margin: EdgeInsets.only(left: 10),
                            )
                          : Container(
                              child: Image.asset(
                                'images/${messageChat.content}.gif',
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                              margin: EdgeInsets.only(
                                  bottom: isLastMessageRight(index) ? 20 : 10,
                                  right: 10),
                            ),
                ],
              ),

              // Time
              isLastMessageLeft(index)
                  ? Container(
                      child: Text(
                        DateFormat('dd MMM kk:mm').format(
                            DateTime.fromMillisecondsSinceEpoch(
                                int.parse(messageChat.timestamp))),
                        style: TextStyle(
                            color: ColorConstants.greyColor,
                            fontSize: 12,
                            fontStyle: FontStyle.italic),
                      ),
                      margin: EdgeInsets.only(left: 50, top: 5, bottom: 5),
                    )
                  : SizedBox.shrink()
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
        ):SizedBox.shrink():messageChat.isDeleteSecond!=1?
        Container(
          margin: EdgeInsets.only(bottom: 10),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  isLastMessageLeft(index)
                      ? Material(
                    borderRadius: BorderRadius.all(
                      Radius.circular(18),
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: Image.network(
                      widget.arguments.peerAvatar,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            color: ColorConstants.themeColor,
                            value: loadingProgress.expectedTotalBytes !=
                                null
                                ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                      errorBuilder: (context, object, stackTrace) {
                        return Icon(
                          Icons.account_circle,
                          size: 35,
                          color: ColorConstants.greyColor,
                        );
                      },
                      width: 35,
                      height: 35,
                      fit: BoxFit.cover,
                    ),
                  )
                      : Container(width: 35),
                  messageChat.type == TypeMessage.text
                      ? Container(
                    padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                    width: 200,
                    decoration: BoxDecoration(
                        color: ColorConstants.primaryColor,
                        borderRadius: BorderRadius.circular(8)),
                    margin: EdgeInsets.only(left: 10),
                    child: Text(
                      messageChat.content,
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                      : messageChat.type == TypeMessage.image
                      ? Container(
                    child: TextButton(
                      child: Material(
                        child: Image.network(
                          messageChat.content,
                          loadingBuilder: (BuildContext context,
                              Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Container(
                              decoration: BoxDecoration(
                                color: ColorConstants.greyColor2,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                              ),
                              width: 200,
                              height: 200,
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: ColorConstants.themeColor,
                                  value: loadingProgress
                                      .expectedTotalBytes !=
                                      null
                                      ? loadingProgress
                                      .cumulativeBytesLoaded /
                                      loadingProgress
                                          .expectedTotalBytes!
                                      : null,
                                ),
                              ),
                            );
                          },
                          errorBuilder:
                              (context, object, stackTrace) =>
                              Material(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                                clipBehavior: Clip.hardEdge,
                                child: Image.asset(
                                  'images/img_not_available.jpeg',
                                  width: 200,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                              ),
                          width: 200,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                        borderRadius:
                        BorderRadius.all(Radius.circular(8)),
                        clipBehavior: Clip.hardEdge,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FullPhotoPage(
                                url: messageChat.content),
                          ),
                        );
                      },
                      style: ButtonStyle(
                          padding:
                          MaterialStateProperty.all<EdgeInsets>(
                              EdgeInsets.all(0))),
                    ),
                    margin: EdgeInsets.only(left: 10),
                  )
                      : Container(
                    margin: EdgeInsets.only(
                        bottom: isLastMessageRight(index) ? 20 : 10,
                        right: 10),
                    child: Image.asset(
                      'images/${messageChat.content}.gif',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),

              // Time
              isLastMessageLeft(index)
                  ? Container(
                margin: EdgeInsets.only(left: 50, top: 5, bottom: 5),
                child: Text(
                  DateFormat('dd MMM kk:mm').format(
                      DateTime.fromMillisecondsSinceEpoch(
                          int.parse(messageChat.timestamp))),
                  style: TextStyle(
                      color: ColorConstants.greyColor,
                      fontSize: 12,
                      fontStyle: FontStyle.italic),
                ),
              )
                  : SizedBox.shrink()
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
        ):SizedBox.shrink();
      }
    } else {
      return SizedBox.shrink();
    }
  }

  bool isLastMessageLeft(int index) {
    if ((index > 0 &&
            listMessage[index - 1].get(FirestoreConstants.idFrom) ==
                currentUserId) ||
        index == 0) {
      return true;
    } else {
      return false;
    }
  }

  bool isLastMessageRight(int index) {
    if ((index > 0 &&
            listMessage[index - 1].get(FirestoreConstants.idFrom) !=
                currentUserId) ||
        index == 0) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> onBackPress() {
    if (isShowSticker) {
      setState(() {
        isShowSticker = false;
      });
    } else {
      chatProvider?.updateDataFirestore(
        FirestoreConstants.pathUserCollection,
        currentUserId,
        {FirestoreConstants.chattingWith: null},
      );
      Navigator.pop(context);
    }

    return Future.value(false);
  }

  Init() async {
    notifitypeScreen="";
    setState((){});
    print("notifitypeScreen");
    print(notifitypeScreen);
    preferences = await SharedPreferences.getInstance();
    var dashboardprovider =
        Provider.of<DashboardProvider>(context, listen: false);
    dashboardprovider.resetLikeUserList();
    dashboardprovider.resetChatlist();
    if (preferences!.getString("accesstoken") != null) {
      dashboardprovider.fetchMatchesUserList(
          preferences!.getString("accesstoken").toString(), 1, 1000, "matches");
      dashboardprovider
          .fetchChatList(preferences!.getString("accesstoken").toString());
    }

  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Init();
        var profileprovider =
        Provider.of<ProfileProvider>(context,
            listen: false);
        profileprovider.UserProfileInit();
        Get.to(MatchProfileDetailScreen(
          user_id: widget.arguments.otherUserId.toString(),
        ));

        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: GestureDetector(
            onTap: (){
              var profileprovider =
                  Provider.of<ProfileProvider>(context,
                      listen: false);
              profileprovider.UserProfileInit();
              Get.to(MatchProfileDetailScreen(
                user_id: widget.arguments.otherUserId.toString(),
              ));
            },
            child: addBoldText(

                widget.arguments.conversationName.replaceAll(".", ""), 16, Colorss.mainColor),
          ),
          backgroundColor: Colors.white70,
          shadowColor: Colors.white,
          leading: Builder(
            builder: (context) {
              return IconButton(
                onPressed: () {
                  Init();
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
                color: Colorss.mainColor,
              );
            },
          ),
        ),
        body: SafeArea(
          child: WillPopScope(
            onWillPop: onBackPress,
            child: isLoading?Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 1.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const SizedBox(height: 60),
                  );
                },
              ),
            ): Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[

                    // List of messages
                    buildListMessage(),

                    // Sticker
                    isShowSticker ? buildSticker() : SizedBox.shrink(),
                    isLoading ? buildLoading() : SizedBox.shrink(),
                    if(currentUserId.isNotEmpty&&chat==true) buildTypingWidget(),
                    // Input content
                    if(chat)   buildInput(),
                  ],
                ),

                // Loading
              ],
            ),
          ),
        ),
      ),
    );
  }
 Widget buildTypingWidget(){
    return StreamBuilder<DocumentSnapshot>(
        stream: chatProvider?.userDetail(userId: currentUserId??""),
   builder: (BuildContext context,
   AsyncSnapshot<DocumentSnapshot> snapshot) {

   if (listMessage.isNotEmpty) {
      return snapshot.data!.get("isTyping")==true?Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(left: 10,bottom: 5),
          child: Text("${widget.arguments.conversationName} is Typing",style: TextStyle(color: Colors.black.withOpacity(0.3),fontSize: 12),)):SizedBox.shrink();

   }
        else{
          return SizedBox.shrink();
   }
        });
 }
  Widget buildSticker() {
    return Expanded(
      child: Container(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                TextButton(
                  onPressed: () => onSendMessage('mimi1', TypeMessage.sticker),
                  child: Image.asset(
                    'images/mimi1.gif',
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                TextButton(
                  onPressed: () => onSendMessage('mimi2', TypeMessage.sticker),
                  child: Image.asset(
                    'images/mimi2.gif',
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                TextButton(
                  onPressed: () => onSendMessage('mimi3', TypeMessage.sticker),
                  child: Image.asset(
                    'images/mimi3.gif',
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                TextButton(
                  onPressed: () => onSendMessage('mimi4', TypeMessage.sticker),
                  child: Image.asset(
                    'images/mimi4.gif',
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                TextButton(
                  onPressed: () => onSendMessage('mimi5', TypeMessage.sticker),
                  child: Image.asset(
                    'images/mimi5.gif',
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                TextButton(
                  onPressed: () => onSendMessage('mimi6', TypeMessage.sticker),
                  child: Image.asset(
                    'images/mimi6.gif',
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                TextButton(
                  onPressed: () => onSendMessage('mimi7', TypeMessage.sticker),
                  child: Image.asset(
                    'images/mimi7.gif',
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                TextButton(
                  onPressed: () => onSendMessage('mimi8', TypeMessage.sticker),
                  child: Image.asset(
                    'images/mimi8.gif',
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                TextButton(
                  onPressed: () => onSendMessage('mimi9', TypeMessage.sticker),
                  child: Image.asset(
                    'images/mimi9.gif',
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                )
              ],
            )
          ],
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        ),
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(color: ColorConstants.greyColor2, width: 0.5)),
            color: Colors.white),
        padding: EdgeInsets.all(5),
        height: 180,
      ),
    );
  }

  Widget buildLoading() {
    return Align(
      alignment: Alignment.centerRight,
      child: isLoading
          ? Container(
              height: 200,
              width: 200,
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              decoration: BoxDecoration(
                  border: Border.all(
                color: ColorConstants.greyColor2,
              )),
              child:Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 1.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const SizedBox(height: 60),
                    );
                  },
                ),
              ))
          : SizedBox.shrink(),
    );
  }

  Widget buildInput() {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
          border: Border(
              top: BorderSide(color: ColorConstants.greyColor2, width: 0.5)),
          color: Colors.white),
      child: Row(
        children: <Widget>[
          // Button send image
          Material(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 1),
              child: IconButton(
                icon: Container(
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colorss.mainColor),
                ),
                onPressed: getImage,
                color: ColorConstants.primaryColor,
              ),
            ),
            color: Colors.white,
          ),

          // Edit text
          Flexible(
            child: Container(
              child: TextField(
                onSubmitted: (value) {
                  if(listMessage.isEmpty){
                    showAlertDialog(context,textEditingController.text);
                  }
                  else{
                    onSendMessage(textEditingController.text, TypeMessage.text);
                  }


                },
                onChanged: (val){
                  chatProvider?.sendTypingEvent(true,userId: widget.arguments.peerId);
                  Future.delayed(Duration(seconds: 2),(){

                    chatProvider?.sendTypingEvent(false,userId: widget.arguments.peerId);
                  });
                },

                style:
                    TextStyle(color: ColorConstants.primaryColor, fontSize: 15),
                controller: textEditingController,
                decoration: InputDecoration.collapsed(
                  hintText: 'Type your message...',
                  hintStyle: TextStyle(color: ColorConstants.greyColor),
                ),
                focusNode: focusNode,
                autofocus: true,
              ),
            ),
          ),

          // Button send message
          Material(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              child: IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
    if(listMessage.isEmpty){
    showAlertDialog(context,textEditingController.text);
    }
    else{
    onSendMessage(textEditingController.text, TypeMessage.text);
    }
    },

                color: ColorConstants.primaryColor,
              ),
            ),
            color: Colors.white,
          ),
        ],
      ),
    );
  }
  showAlertDialog(BuildContext context,String text) {

    // set up the button
    Widget okButton = TextButton(
      child: Text("Send Message"),
      onPressed: () {
        Navigator.pop(context);
        onSendMessage(text, TypeMessage.text);
      },
    );
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
      Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Alert"),
      content: Text("If there is reply to your message super match will start"),
      actions: [
        cancelButton,
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  Widget buildListMessage() {
    return Flexible(
      child: groupChatId.isNotEmpty
          ? StreamBuilder<QuerySnapshot>(
              stream: chatProvider?.getChatStream(groupChatId, _limit),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  listMessage = snapshot.data!.docs;
                  if (listMessage.isNotEmpty) {
                    return ListView.builder(
                      padding: EdgeInsets.all(10),
                      itemBuilder: (context, index) =>
                          buildItem(index, snapshot.data?.docs[index]),
                      itemCount: snapshot.data?.docs.length,
                      reverse: true,
                      controller: listScrollController,
                    );
                  }
                  else {
                    print("=====listMessageEmoptuy$listMessage");
                    return Center(child: Text("No message here yet..."));
                  }
                }
                else if (!snapshot.hasData )  {

                  return Center(
                    child: Text("No message here yet..."),
                  );
                } else {
                  return Center(
                    child:
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 1.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const SizedBox(height: 60),
                          );
                        },
                      ),
                    )
                  );
                }
              },
            )

          : Center(
              child: Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 1.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const SizedBox(height: 60),
                    );
                  },
                ),
              )
            ),
    );
  }
}

class ChatPageArguments {
  final String peerId;
  final String conversationName;
  final String peerAvatar;
  final String peerNickname;
  final int otherUserId;
  final bool ?chatEnable;

  ChatPageArguments(
      {required this.otherUserId,
      required this.peerId,
      required this.peerAvatar,
      required this.peerNickname,
      required this.conversationName,
      this.chatEnable});
}
