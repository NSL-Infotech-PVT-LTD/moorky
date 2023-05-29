import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:moorky/commanWidget/commanwidget.dart';
import 'package:moorky/constant/color.dart';
import 'package:moorky/dashboardscreen/provider/dashboardprovider.dart';
import 'package:moorky/dashboardscreen/repository/dashboardrepository.dart';
import 'package:moorky/zegocloud/items/msg_items/downloading_progress_model.dart';
import 'package:moorky/zegocloud/items/msg_items/msg_bottom_box/msg_bottom_model.dart';
import 'package:moorky/zegocloud/items/msg_items/msg_bottom_box/msg_normal_bottom_box.dart';
import 'package:moorky/zegocloud/items/msg_items/msg_converter.dart';
import 'package:moorky/zegocloud/items/msg_items/msg_list.dart';
import 'package:moorky/zegocloud/items/msg_items/receive_items/receive_image_msg_cell.dart';
import 'package:moorky/zegocloud/items/msg_items/receive_items/receive_text_msg_cell.dart';
import 'package:moorky/zegocloud/items/msg_items/receive_items/receive_video_msg_cell.dart';
import 'package:moorky/zegocloud/items/msg_items/send_items/send_text_msg_cell.dart';
import 'package:moorky/zegocloud/items/msg_items/uploading_progress_model.dart';
import 'package:moorky/zegocloud/model/user_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zego_zim/zego_zim.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PeerChatPage extends StatefulWidget {
  PeerChatPage(
      {required this.conversationID,
      required this.conversationName,
      required this.conversationImage,
      required this.senderImage}) {
    ZIM.getInstance()!.clearConversationUnreadMessageCount(
        conversationID, ZIMConversationType.peer);
    clearUnReadMessage();
  }
  String conversationID;
  String conversationName;
  String conversationImage;
  String senderImage;
  double sendTextFieldBottomMargin = 40;
  bool emojiShowing = false;
  List<ZIMMessage> _historyZIMMessageList = <ZIMMessage>[];
  List<Widget> _historyMessageWidgetList = <Widget>[];
  String type = "";

  double progress = 0.0;

  bool queryHistoryMsgComplete = false;

  clearUnReadMessage() {
    ZIM.getInstance()!.clearConversationUnreadMessageCount(
        conversationID, ZIMConversationType.peer);
  }

  @override
  State<StatefulWidget> createState() => _MyPageState();
}

class _MyPageState extends State<PeerChatPage> {
  String get appBarTitleValue {
    if (widget.conversationName != '') {
      return widget.conversationName;
    } else {
      return widget.conversationID;
    }
  }

  bool isdontask = false;
  SharedPreferences? preferences;
  TextEditingController converionid = TextEditingController();
  String userID = "";
  int count = 0;
  int anotherusercount = 0;

  @override
  void initState() {
    Init();
    registerZIMEvent();
    if (widget._historyZIMMessageList.isEmpty) {
      queryMoreHistoryMessageWidgetList();
    }
    super.initState();
  }

  void Init() async {
    preferences = await SharedPreferences.getInstance();

    if (preferences!.getString("userID") != null) {
      setState(() {
        converionid.text = widget.conversationID;
        userID = preferences!.getString("userID")!;
      });
    }
  }

  @override
  void dispose() {
    unregisterZIMEvent();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: addBoldText(appBarTitleValue, 16, Colorss.mainColor),
        backgroundColor: Colors.white70,
        shadowColor: Colors.white,
        leading: Builder(
          builder: (context) {
            return IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
              color: Colorss.mainColor,
            );
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: GestureDetector(
                onTap: (() {
                  print("asd");
                  setState(() {
                    MsgBottomModel.nonselfOnTapResponse();
                  });
                }),
                child: Container(
                  color: Color(0xFFF2E7FA),
                  alignment: Alignment.topCenter,
                  child: MsgList(
                    widget._historyMessageWidgetList,
                    loadMoreHistoryMsg: () {
                      queryMoreHistoryMessageWidgetList();
                    },
                  ),
                )),
          ),
          MsgNormalBottomBox(
            sendTextFieldonSubmitted: (message) async {
              if (widget._historyMessageWidgetList.length == 0) {
                var issend = await DashboardRepository.chatcreate(
                    preferences!.getString("accesstoken").toString(),
                    widget.conversationID,
                    "text",
                    message);
                if (issend.statusCode == 200) {
                  print("chat create first");
                  sendTextMessage(message);
                }
              } else {
                for (int i = 0; i < widget._historyZIMMessageList.length; i++) {
                  if (widget._historyZIMMessageList.elementAt(i).senderUserID ==
                      userID) {
                    setState(() {
                      count++;
                    });
                  } else {
                    setState(() {
                      anotherusercount++;
                    });
                  }
                }
                print("count");
                print(count);
                if (count == 0) {
                  if (anotherusercount > 0) {
                    showDialog(
                        context: context,
                        builder: (context) => StatefulBuilder(
                            builder: (BuildContext context,
                                    StateSetter stateSetter) =>
                                Material(
                                  color: Colors.transparent,
                                  child: Container(
                                    alignment: Alignment.center,
                                    color: Colors.transparent,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.80,
                                      margin: EdgeInsets.only(bottom: 30),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20.w)),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          SizedBox(
                                            height: 20.h,
                                          ),
                                          addBoldText(
                                              AppLocalizations.of(context)!
                                                  .areyousure,
                                              12,
                                              Color(0xFF4D4D4D)),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 20),
                                              child: addCenterRegularText(
                                                  AppLocalizations.of(context)!
                                                      .ifypoureplythis,
                                                  10,
                                                  Color(0xFF4D4D4D))),
                                          SizedBox(
                                            height: 30.h,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Container(
                                                  height: 40,
                                                  alignment: Alignment.center,
                                                  width: 110,
                                                  child: addRegularText(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .cancel,
                                                      12,
                                                      Color(0xFF4D4D4D)),
                                                  decoration: BoxDecoration(
                                                      color: Color(0xFFF5F5F5),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () async {
                                                  var issend =
                                                      await DashboardRepository
                                                          .chatcreate(
                                                              preferences!
                                                                  .getString(
                                                                      "accesstoken")
                                                                  .toString(),
                                                              widget
                                                                  .conversationID,
                                                              "text",
                                                              message);
                                                  if (issend.statusCode ==
                                                      200) {
                                                    print("chat create first");
                                                    sendTextMessage(message);
                                                    Navigator.of(context).pop();
                                                  }
                                                },
                                                child: Container(
                                                  height: 40,
                                                  alignment: Alignment.center,
                                                  width: 110,
                                                  child: addRegularText(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .send,
                                                      12,
                                                      Color(0xFFFFFFFF)),
                                                  decoration: BoxDecoration(
                                                      color: Color(0xFF007AFF),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Checkbox(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  5.0.r))),
                                                  activeColor:
                                                      Colorss.mainColor,
                                                  side: MaterialStateBorderSide
                                                      .resolveWith(
                                                    (states) => BorderSide(
                                                        width: 0.w,
                                                        color: Colors.grey),
                                                  ),
                                                  value: isdontask,
                                                  onChanged: (value) {
                                                    stateSetter(() {
                                                      isdontask = value!;
                                                    });
                                                  }),
                                              SizedBox(
                                                width: 2,
                                              ),
                                              addRegularText(
                                                  AppLocalizations.of(context)!
                                                      .dontaskagain,
                                                  12,
                                                  Color(0xFF4D4D4D))
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )));
                  } else {
                    var issend = await DashboardRepository.chatcreate(
                        preferences!.getString("accesstoken").toString(),
                        widget.conversationID,
                        "text",
                        message);
                    if (issend.statusCode == 200) {
                      print("chat create first");
                      sendTextMessage(message);
                      Navigator.of(context).pop();
                    }
                  }
                } else {
                  var issend = await DashboardRepository.chatcreate(
                      preferences!.getString("accesstoken").toString(),
                      widget.conversationID,
                      "text",
                      message);
                  if (issend.statusCode == 200) {
                    print("chat create first");
                    sendTextMessage(message);
                  }
                }
              }
            },
            onCameraIconButtonOnPressed: (path) async {
              if (widget._historyMessageWidgetList.length == 0) {
                var issend = await DashboardRepository.chatcreate(
                    preferences!.getString("accesstoken").toString(),
                    widget.conversationID,
                    "text",
                    "Photo");
                if (issend.statusCode == 200) {
                  print("chat create first");
                  sendMediaMessage(path, ZIMMessageType.image);
                }
              } else {
                for (int i = 0; i < widget._historyZIMMessageList.length; i++) {
                  if (widget._historyZIMMessageList.elementAt(i).senderUserID ==
                      userID) {
                    setState(() {
                      count++;
                    });
                  } else {
                    setState(() {
                      anotherusercount++;
                    });
                  }
                }
                print("count");
                print(count);
                if (count == 0) {
                  if (anotherusercount > 0) {
                    showDialog(
                        context: context,
                        builder: (context) => StatefulBuilder(
                            builder: (BuildContext context,
                                    StateSetter stateSetter) =>
                                Material(
                                  color: Colors.transparent,
                                  child: Container(
                                    alignment: Alignment.center,
                                    color: Colors.transparent,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.80,
                                      margin: EdgeInsets.only(bottom: 30),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20.w)),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          SizedBox(
                                            height: 20.h,
                                          ),
                                          addBoldText(
                                              AppLocalizations.of(context)!
                                                  .areyousure,
                                              12,
                                              Color(0xFF4D4D4D)),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 20),
                                              child: addCenterRegularText(
                                                  AppLocalizations.of(context)!
                                                      .ifypoureplythis,
                                                  10,
                                                  Color(0xFF4D4D4D))),
                                          SizedBox(
                                            height: 30.h,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Container(
                                                  height: 40,
                                                  alignment: Alignment.center,
                                                  width: 110,
                                                  child: addRegularText(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .cancel,
                                                      12,
                                                      Color(0xFF4D4D4D)),
                                                  decoration: BoxDecoration(
                                                      color: Color(0xFFF5F5F5),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () async {
                                                  var issend =
                                                      await DashboardRepository
                                                          .chatcreate(
                                                              preferences!
                                                                  .getString(
                                                                      "accesstoken")
                                                                  .toString(),
                                                              widget
                                                                  .conversationID,
                                                              "text",
                                                              "Photo");
                                                  if (issend.statusCode ==
                                                      200) {
                                                    print("chat create first");
                                                    sendTextMessage("Photo");
                                                    Navigator.of(context).pop();
                                                  }
                                                },
                                                child: Container(
                                                  height: 40,
                                                  alignment: Alignment.center,
                                                  width: 110,
                                                  child: addRegularText(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .send,
                                                      12,
                                                      Color(0xFFFFFFFF)),
                                                  decoration: BoxDecoration(
                                                      color: Color(0xFF007AFF),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Checkbox(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  5.0.r))),
                                                  activeColor:
                                                      Colorss.mainColor,
                                                  side: MaterialStateBorderSide
                                                      .resolveWith(
                                                    (states) => BorderSide(
                                                        width: 0.w,
                                                        color: Colors.grey),
                                                  ),
                                                  value: isdontask,
                                                  onChanged: (value) {
                                                    stateSetter(() {
                                                      isdontask = value!;
                                                    });
                                                  }),
                                              SizedBox(
                                                width: 2,
                                              ),
                                              addRegularText(
                                                  AppLocalizations.of(context)!
                                                      .dontaskagain,
                                                  12,
                                                  Color(0xFF4D4D4D))
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )));
                  } else {
                    var issend = await DashboardRepository.chatcreate(
                        preferences!.getString("accesstoken").toString(),
                        widget.conversationID,
                        "text",
                        "Photo");
                    if (issend.statusCode == 200) {
                      print("chat create first");
                      sendMediaMessage(path, ZIMMessageType.image);
                    }
                  }
                } else {
                  var issend = await DashboardRepository.chatcreate(
                      preferences!.getString("accesstoken").toString(),
                      widget.conversationID,
                      "text",
                      "Photo");
                  if (issend.statusCode == 200) {
                    print("chat create first");
                    sendMediaMessage(path, ZIMMessageType.image);
                  }
                }
              }
            },
            onImageIconButtonOnPressed: (path) async {
              if (widget._historyMessageWidgetList.length == 0) {
                var issend = await DashboardRepository.chatcreate(
                    preferences!.getString("accesstoken").toString(),
                    widget.conversationID,
                    "text",
                    "Photo");
                if (issend.statusCode == 200) {
                  print("chat create first");
                  sendMediaMessage(path, ZIMMessageType.image);
                }
              } else {
                for (int i = 0; i < widget._historyZIMMessageList.length; i++) {
                  if (widget._historyZIMMessageList.elementAt(i).senderUserID ==
                      userID) {
                    setState(() {
                      count++;
                    });
                  } else {
                    setState(() {
                      anotherusercount++;
                    });
                  }
                }
                print("count");
                print(count);
                if (count == 0) {
                  if (anotherusercount > 0) {
                    showDialog(
                        context: context,
                        builder: (context) => StatefulBuilder(
                            builder: (BuildContext context,
                                    StateSetter stateSetter) =>
                                Material(
                                  color: Colors.transparent,
                                  child: Container(
                                    alignment: Alignment.center,
                                    color: Colors.transparent,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.80,
                                      margin: EdgeInsets.only(bottom: 30),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20.w)),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          SizedBox(
                                            height: 20.h,
                                          ),
                                          addBoldText(
                                              AppLocalizations.of(context)!
                                                  .areyousure,
                                              12,
                                              Color(0xFF4D4D4D)),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 20),
                                              child: addCenterRegularText(
                                                  AppLocalizations.of(context)!
                                                      .ifypoureplythis,
                                                  10,
                                                  Color(0xFF4D4D4D))),
                                          SizedBox(
                                            height: 30.h,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Container(
                                                  height: 40,
                                                  alignment: Alignment.center,
                                                  width: 110,
                                                  child: addRegularText(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .cancel,
                                                      12,
                                                      Color(0xFF4D4D4D)),
                                                  decoration: BoxDecoration(
                                                      color: Color(0xFFF5F5F5),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () async {
                                                  var issend =
                                                      await DashboardRepository
                                                          .chatcreate(
                                                              preferences!
                                                                  .getString(
                                                                      "accesstoken")
                                                                  .toString(),
                                                              widget
                                                                  .conversationID,
                                                              "text",
                                                              "Photo");
                                                  if (issend.statusCode ==
                                                      200) {
                                                    print("chat create first");
                                                    sendTextMessage("Photo");
                                                    Navigator.of(context).pop();
                                                  }
                                                },
                                                child: Container(
                                                  height: 40,
                                                  alignment: Alignment.center,
                                                  width: 110,
                                                  child: addRegularText(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .send,
                                                      12,
                                                      Color(0xFFFFFFFF)),
                                                  decoration: BoxDecoration(
                                                      color: Color(0xFF007AFF),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Checkbox(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  5.0.r))),
                                                  activeColor:
                                                      Colorss.mainColor,
                                                  side: MaterialStateBorderSide
                                                      .resolveWith(
                                                    (states) => BorderSide(
                                                        width: 0.w,
                                                        color: Colors.grey),
                                                  ),
                                                  value: isdontask,
                                                  onChanged: (value) {
                                                    stateSetter(() {
                                                      isdontask = value!;
                                                    });
                                                  }),
                                              SizedBox(
                                                width: 2,
                                              ),
                                              addRegularText(
                                                  AppLocalizations.of(context)!
                                                      .dontaskagain,
                                                  12,
                                                  Color(0xFF4D4D4D))
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )));
                  } else {
                    var issend = await DashboardRepository.chatcreate(
                        preferences!.getString("accesstoken").toString(),
                        widget.conversationID,
                        "text",
                        "Photo");
                    if (issend.statusCode == 200) {
                      print("chat create first");
                      sendMediaMessage(path, ZIMMessageType.image);
                    }
                  }
                } else {
                  var issend = await DashboardRepository.chatcreate(
                      preferences!.getString("accesstoken").toString(),
                      widget.conversationID,
                      "text",
                      "Photo");
                  if (issend.statusCode == 200) {
                    print("chat create first");
                    sendMediaMessage(path, ZIMMessageType.image);
                  }
                }
              }
            },
            onVideoIconButtonOnPressed: (path) async {
              if (widget._historyMessageWidgetList.length == 0) {
                var issend = await DashboardRepository.chatcreate(
                    preferences!.getString("accesstoken").toString(),
                    widget.conversationID,
                    "text",
                    "Video");
                if (issend.statusCode == 200) {
                  print("chat create first");
                  sendMediaMessage(path, ZIMMessageType.video);
                }
              } else {
                for (int i = 0; i < widget._historyZIMMessageList.length; i++) {
                  if (widget._historyZIMMessageList.elementAt(i).senderUserID ==
                      userID) {
                    setState(() {
                      count++;
                    });
                  } else {
                    setState(() {
                      anotherusercount++;
                    });
                  }
                }
                print("count");
                print(count);
                if (count == 0) {
                  if (anotherusercount > 0) {
                    showDialog(
                        context: context,
                        builder: (context) => StatefulBuilder(
                            builder: (BuildContext context,
                                    StateSetter stateSetter) =>
                                Material(
                                  color: Colors.transparent,
                                  child: Container(
                                    alignment: Alignment.center,
                                    color: Colors.transparent,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.80,
                                      margin: EdgeInsets.only(bottom: 30),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20.w)),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          SizedBox(
                                            height: 20.h,
                                          ),
                                          addBoldText(
                                              AppLocalizations.of(context)!
                                                  .areyousure,
                                              12,
                                              Color(0xFF4D4D4D)),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 20),
                                              child: addCenterRegularText(
                                                  AppLocalizations.of(context)!
                                                      .ifypoureplythis,
                                                  10,
                                                  Color(0xFF4D4D4D))),
                                          SizedBox(
                                            height: 30.h,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Container(
                                                  height: 40,
                                                  alignment: Alignment.center,
                                                  width: 110,
                                                  child: addRegularText(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .cancel,
                                                      12,
                                                      Color(0xFF4D4D4D)),
                                                  decoration: BoxDecoration(
                                                      color: Color(0xFFF5F5F5),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () async {
                                                  var issend =
                                                      await DashboardRepository
                                                          .chatcreate(
                                                              preferences!
                                                                  .getString(
                                                                      "accesstoken")
                                                                  .toString(),
                                                              widget
                                                                  .conversationID,
                                                              "text",
                                                              "Video");
                                                  if (issend.statusCode ==
                                                      200) {
                                                    print("chat create first");
                                                    sendTextMessage("Video");
                                                    Navigator.of(context).pop();
                                                  }
                                                },
                                                child: Container(
                                                  height: 40,
                                                  alignment: Alignment.center,
                                                  width: 110,
                                                  child: addRegularText(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .send,
                                                      12,
                                                      Color(0xFFFFFFFF)),
                                                  decoration: BoxDecoration(
                                                      color: Color(0xFF007AFF),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Checkbox(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  5.0.r))),
                                                  activeColor:
                                                      Colorss.mainColor,
                                                  side: MaterialStateBorderSide
                                                      .resolveWith(
                                                    (states) => BorderSide(
                                                        width: 0.w,
                                                        color: Colors.grey),
                                                  ),
                                                  value: isdontask,
                                                  onChanged: (value) {
                                                    stateSetter(() {
                                                      isdontask = value!;
                                                    });
                                                  }),
                                              SizedBox(
                                                width: 2,
                                              ),
                                              addRegularText(
                                                  AppLocalizations.of(context)!
                                                      .dontaskagain,
                                                  12,
                                                  Color(0xFF4D4D4D))
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )));
                  } else {
                    var issend = await DashboardRepository.chatcreate(
                        preferences!.getString("accesstoken").toString(),
                        widget.conversationID,
                        "text",
                        "Video");
                    if (issend.statusCode == 200) {
                      print("chat create first");
                      sendMediaMessage(path, ZIMMessageType.video);
                    }
                  }
                } else {
                  var issend = await DashboardRepository.chatcreate(
                      preferences!.getString("accesstoken").toString(),
                      widget.conversationID,
                      "text",
                      "Video");
                  if (issend.statusCode == 200) {
                    print("chat create first");
                    sendMediaMessage(path, ZIMMessageType.video);
                  }
                }
              }
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
    );
  }

  // Widget callButton(bool isVideoCall) {
  //
  //   return ValueListenableBuilder<TextEditingValue>(
  //     valueListenable: converionid,
  //     builder: (context, inviteeUserID, _) {
  //       return ZegoSendCallInvitationButton(
  //         isVideoCall: isVideoCall,
  //         invitees: [
  //           ZegoUIKitUser(
  //             id: converionid.text,
  //             name: widget.conversationName,
  //           )
  //         ],
  //         iconSize: const Size(30, 30),
  //         buttonSize: const Size(40, 40),
  //       );
  //     },
  //   );
  // }
  sendTextMessage(String message) async {
    ZIMTextMessage textMessage = ZIMTextMessage(message: message);
    print("textMessage.timestamp===");
    print(textMessage.timestamp);
    textMessage.senderUserID = UserModel.shared().userInfo!.userID;
    ZIMMessageSendConfig sendConfig = ZIMMessageSendConfig();
    var date = DateTime.fromMillisecondsSinceEpoch(textMessage.timestamp);
    print("date");
    print(date);
    print("\t\t" + DateFormat.jm().format(date));
    widget._historyZIMMessageList.add(textMessage);
    SendTextMsgCell cell = SendTextMsgCell(
      message: textMessage,
      senderimage: widget.senderImage,
      time: "${"\t\t" + DateFormat.jm().format(date)}",
    );
    setState(() {
      widget._historyMessageWidgetList.add(cell);
    });
    try {
      ZIMMessageSentResult result = await ZIM
          .getInstance()!
          .sendPeerMessage(textMessage, widget.conversationID, sendConfig);
      print("result.message.timestamp===");
      print(result.message.timestamp);
      var date = DateTime.fromMillisecondsSinceEpoch(result.message.timestamp);
      print("date");
      print(date);
      print("\t\t" + DateFormat.jm().format(date));
      int index = widget._historyZIMMessageList
          .lastIndexWhere((element) => element == textMessage);
      widget._historyZIMMessageList[index] = result.message;
      SendTextMsgCell cell = SendTextMsgCell(
        message: (result.message as ZIMTextMessage),
        senderimage: widget.senderImage,
        time: "${"\t\t" + DateFormat.jm().format(date)}",
      );

      setState(() {
        widget._historyMessageWidgetList[index] = cell;
      });
    } on PlatformException catch (onError) {
      log('send error,code:' + onError.code + 'message:' + onError.message!);
      setState(() {
        int index = widget._historyZIMMessageList
            .lastIndexWhere((element) => element == textMessage);
        widget._historyZIMMessageList[index].sentStatus =
            ZIMMessageSentStatus.failed;
        var date = DateTime.fromMillisecondsSinceEpoch(
            widget._historyZIMMessageList[index].timestamp);
        print("date");
        print(date);
        print("\t\t" + DateFormat.jm().format(date));
        SendTextMsgCell cell = SendTextMsgCell(
          message: (widget._historyZIMMessageList[index] as ZIMTextMessage),
          senderimage: widget.senderImage,
          time: "\t\t" + DateFormat.jm().format(date),
        );
        widget._historyMessageWidgetList[index] = cell;
      });
    }
  }

  sendMediaMessage(String? path, ZIMMessageType messageType) async {
    if (path == null) return;
    ZIMMediaMessage mediaMessage =
        MsgConverter.mediaMessageFactory(path, messageType);
    print("textMessage.timestamp===ghg");
    print(mediaMessage.timestamp);
    mediaMessage.senderUserID = UserModel.shared().userInfo!.userID;
    UploadingprogressModel uploadingprogressModel = UploadingprogressModel();
    Widget sendMsgCell = MsgConverter.sendMediaMessageCellFactory(
        mediaMessage, uploadingprogressModel, widget.senderImage);

    setState(() {
      widget._historyZIMMessageList.add(mediaMessage);
      widget._historyMessageWidgetList.add(sendMsgCell);
    });
    try {
      log(mediaMessage.fileLocalPath);
      ZIMMessageSentResult result = await ZIM.getInstance()!.sendMediaMessage(
          mediaMessage,
          widget.conversationID,
          ZIMConversationType.peer,
          ZIMMessageSendConfig(), (message, currentFileSize, totalFileSize) {
        uploadingprogressModel.uploadingprogress!(
            message, currentFileSize, totalFileSize);
      } as ZIMMediaMessageSendNotification?);
      int index = widget._historyZIMMessageList
          .lastIndexWhere((element) => element == mediaMessage);
      Widget resultCell = MsgConverter.sendMediaMessageCellFactory(
          result.message as ZIMMediaMessage, null, widget.senderImage);
      setState(() {
        widget._historyMessageWidgetList[index] = resultCell;
      });
    } on PlatformException catch (onError) {
      int index = widget._historyZIMMessageList
          .lastIndexWhere((element) => element == mediaMessage);
      widget._historyZIMMessageList[index].sentStatus =
          ZIMMessageSentStatus.failed;
      Widget failedCell = MsgConverter.sendMediaMessageCellFactory(
          widget._historyZIMMessageList[index] as ZIMMediaMessage,
          null,
          widget.senderImage);
      setState(() {
        widget._historyMessageWidgetList[index] = failedCell;
      });
    }
  }

  queryMoreHistoryMessageWidgetList() async {
    if (widget.queryHistoryMsgComplete) {
      return;
    }

    ZIMMessageQueryConfig queryConfig = ZIMMessageQueryConfig();
    queryConfig.count = 20;
    queryConfig.reverse = true;
    try {
      queryConfig.nextMessage = widget._historyZIMMessageList.first;
    } catch (onerror) {
      queryConfig.nextMessage = null;
    }
    try {
      ZIMMessageQueriedResult result = await ZIM
          .getInstance()!
          .queryHistoryMessage(
              widget.conversationID, ZIMConversationType.peer, queryConfig);
      if (result.messageList.length < 20) {
        widget.queryHistoryMsgComplete = true;
      }
      List<Widget> oldMessageWidgetList = MsgConverter.cnvMessageToWidget(
          result.messageList, widget.senderImage, widget.conversationImage);
      result.messageList.addAll(widget._historyZIMMessageList);
      widget._historyZIMMessageList = result.messageList;

      oldMessageWidgetList.addAll(widget._historyMessageWidgetList);
      widget._historyMessageWidgetList = oldMessageWidgetList;

      setState(() {});
    } on PlatformException catch (onError) {
      //log(onError.code);
    }
  }

  registerZIMEvent() {
    ZIMEventHandler.onReceivePeerMessage = (zim, messageList, fromUserID) {
      if (fromUserID != widget.conversationID) {
        return;
      }
      widget.clearUnReadMessage();
      widget._historyZIMMessageList.addAll(messageList);
      for (ZIMMessage message in messageList) {
        var date = DateTime.fromMillisecondsSinceEpoch(message.timestamp);
        print("date");
        print(date);
        print("\t\t" + DateFormat.jm().format(date));
        switch (message.type) {
          case ZIMMessageType.text:
            ReceiceTextMsgCell cell = ReceiceTextMsgCell(
              message: (message as ZIMTextMessage),
              reciveimages: widget.conversationImage,
              time: "${"\t\t" + DateFormat.jm().format(date)}",
            );
            widget._historyMessageWidgetList.add(cell);
            break;
          case ZIMMessageType.image:
            if ((message as ZIMImageMessage).fileLocalPath == "") {
              DownloadingProgressModel downloadingProgressModel =
                  DownloadingProgressModel();

              ReceiveImageMsgCell resultCell;
              ZIM
                  .getInstance()!
                  .downloadMediaFile(message, ZIMMediaFileType.originalFile,
                      (message, currentFileSize, totalFileSize) {})
                  .then((value) => {
                        resultCell = ReceiveImageMsgCell(
                          message: (value.message as ZIMImageMessage),
                          downloadingProgress: null,
                          downloadingProgressModel: downloadingProgressModel,
                          reciverImage: widget.conversationImage,
                          time: "${"\t\t" + DateFormat.jm().format(date)}",
                        ),
                        widget._historyMessageWidgetList.add(resultCell),
                        setState(() {})
                      });
            } else {
              ReceiveImageMsgCell resultCell = ReceiveImageMsgCell(
                message: message,
                downloadingProgress: null,
                downloadingProgressModel: null,
                reciverImage: widget.conversationImage,
                time: "${"\t\t" + DateFormat.jm().format(date)}",
              );
              widget._historyMessageWidgetList.add(resultCell);
            }

            break;
          case ZIMMessageType.video:
            if ((message as ZIMVideoMessage).fileLocalPath == "") {
              ReceiveVideoMsgCell resultCell;
              ZIM
                  .getInstance()!
                  .downloadMediaFile(message, ZIMMediaFileType.originalFile,
                      (message, currentFileSize, totalFileSize) {})
                  .then((value) => {
                        resultCell = ReceiveVideoMsgCell(
                          message: value.message as ZIMVideoMessage,
                          downloadingProgressModel: null,
                          receiverImage: widget.conversationImage,
                          time: "${"\t\t" + DateFormat.jm().format(date)}",
                        ),
                        widget._historyMessageWidgetList.add(resultCell),
                        setState(() {})
                      });
            } else {
              ReceiveVideoMsgCell resultCell = ReceiveVideoMsgCell(
                message: message,
                downloadingProgressModel: null,
                receiverImage: widget.conversationImage,
                time: "${"\t\t" + DateFormat.jm().format(date)}",
              );
              widget._historyMessageWidgetList.add(resultCell);
              setState(() {});
            }
            break;
          default:
        }
      }
      setState(() {});
    };
  }

  unregisterZIMEvent() {
    ZIMEventHandler.onReceivePeerMessage = null;
  }
}
