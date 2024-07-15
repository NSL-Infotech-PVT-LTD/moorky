import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:moorky/commanWidget/commanwidget.dart';
import 'package:moorky/dashboardscreen/messagescreen/new_chat_screen.dart';
import 'package:moorky/dashboardscreen/messagescreen/view/chat_screen.dart';
import 'package:moorky/dashboardscreen/messagescreen/view/hurraysupermatch_screen.dart';
import 'package:moorky/dashboardscreen/model/message_chat.dart';
import 'package:moorky/dashboardscreen/provider/dashboardprovider.dart';
import 'package:moorky/dashboardscreen/repository/dashboardrepository.dart';
import 'package:moorky/profilecreate/provider/profileprovider.dart';
import 'package:moorky/profiledetailscreen/view/matchprofiledetail.dart';
import 'package:moorky/zegocloud/peer/peer_chat_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import '../../../constant/color.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../provider/chat_provider.dart';

class UserMessage_Screen extends StatefulWidget {
   UserMessage_Screen({Key? key}) : super(key: key);

  @override
  State<UserMessage_Screen> createState() => _UserMessage_ScreenState();
}

class _UserMessage_ScreenState extends State<UserMessage_Screen> {
  int page = 1;

  SharedPreferences? preferences;
  @override
  void initState() {
    Init();
    super.initState();
  }

  Init() async {
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

  late final ChatProvider chatProvider = context.read<ChatProvider>();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15.w, right: 15.w),
      child: Column(
        children: [
          SizedBox(
            height: 10.h,
          ),
          addMediumText(
              AppLocalizations.of(context)!.matches, 16, Color(0xFF000000)),
          SizedBox(
            height: 15.h,
          ),
          Container(
              height: 120.h,
              alignment: Alignment.topLeft,
              child: Consumer<DashboardProvider>(
                  builder: (context, dataProvider, child) {
               {
                  return
                    dataProvider.isMatchLoading==true?
                  ListView.builder(
                      itemCount: 4,
                      scrollDirection: Axis.horizontal,
                      itemBuilder:(context,index){
                    return   shimmerLoadingWidget();
                  })
                        :
                    (dataProvider.matchuserList??[]).isNotEmpty
                      ? ListView.builder(
                          itemCount: (dataProvider.matchuserList??[]).length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          physics: ScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () async {
                                // var profileprovider =
                                //     Provider.of<ProfileProvider>(context,
                                //         listen: false);
                                // profileprovider.UserProfileInit();
                                // Get.to(MatchProfileDetailScreen(
                                //   user_id: dataProvider.matchuserList!
                                //       .elementAt(index)
                                //       .id
                                //       .toString(),
                                // ));
                                List<int>userMonoIds=[];
                                print(dataProvider.matchuserList!.length);
                                for(int i=0;i<dataProvider.matchuserList!.length;i++){

                                  userMonoIds.add(dataProvider.matchuserList![i].id);

                                }
                                print(userMonoIds);
                                var profilepro = Provider.of<ProfileProvider>(
                                    context,
                                    listen: false);


                                print(profilepro.anotheruserID);


                                final db = FirebaseFirestore.instance;
                                var newIndex;
                                Query docRef = db
                                    .collection("users")
                                    .where(((dataProvider.matchuserList??[])
                                    .elementAt(index)

                                    .email));

                                QuerySnapshot docSnap =
                                    await docRef.get();
                                for (int i = 0;
                                i < docSnap.docs.length;
                                i++) {
                                  if ((dataProvider.matchuserList??[]).elementAt(index)!
                                      .email ==
                                      docSnap.docs[i]['nickname']) {
                                    newIndex = i;
                                  }
                                }

                                var groupChatId;
                                var docId;

                                print("jsjsjssjs");
                                if (newIndex == null) {
                                  print("heloo");
                                  createAccountWithEmail(
                                      (dataProvider.matchuserList??[])
                                          .elementAt(index)

                                          .email,
                                      "12345678").then((value) {
                                    print("value");
                                    print(value);
                                  })
                                      .whenComplete(() {
                                    for (int i = 0;
                                    i < docSnap.docs.length;
                                    i++) {

                                      if ((dataProvider.matchuserList??[])
                                          .elementAt(index)

                                          .email.toString().toLowerCase() ==
                                          docSnap.docs[i]
                                          ['nickname'].toString().toLowerCase()||(dataProvider.matchuserList??[])
                                          .elementAt(index)

                                          .email ==
                                          docSnap.docs[i]
                                          ['nickname'] ||
                                          (dataProvider.matchuserList??[])
                                              .elementAt(index)

                                              .email
                                              .toString()
                                              .toLowerCase() ==
                                              docSnap.docs[i]
                                              ['nickname']) {
                                        newIndex = i;
                                        print("ghvjjhj");
                                      }
                                    }
                                    docId = docSnap.docs[newIndex].id;
                                    setState(() {});
                                    print("ghvjjsddsdhj$docId");
                                    Get.to(ChatPage(
                                        arguments: ChatPageArguments(
                                            conversationName:(dataProvider.matchuserList??[])
                                                .elementAt(index)
                                                .name,
                                            peerId: docId,
                                            otherUserId: (dataProvider.matchuserList??[])
                                                .elementAt(index)

                                                .id,
                                            peerAvatar: ((dataProvider.matchuserList??[])
                                                .elementAt(index)
                                                .images?[0].image??""),
                                            peerNickname: ((dataProvider.matchuserList??[])
                                                .elementAt(index)

                                                .email),
                                            chatEnable:
                                            userMonoIds.contains((dataProvider.matchuserList??[])
                                                .elementAt(index)
                                                .id)?true:profilepro.activemonogomy==false?true:profilepro.activemonogomy&&profilepro.anotheruserID==(dataProvider.matchuserList??[])
                                                .elementAt(index)
                                                .id
                                        )));
                                  });
                                }
                                else {
                                  docId = docSnap.docs[newIndex].id;
                                  Get.to(ChatPage(
                                      arguments: ChatPageArguments(
                                          conversationName: (dataProvider.matchuserList??[])
                                              .elementAt(index)

                                              .name,
                                          peerId: docId,
                                          otherUserId: (dataProvider.matchuserList??[])
                                              .elementAt(index)

                                              .id,
                                          peerAvatar: ((dataProvider.matchuserList??[])
                                              .elementAt(index)

                                              .profile_image),
                                          peerNickname: ((dataProvider.matchuserList??[])
                                              .elementAt(index)

                                              .email),
                                          chatEnable:userMonoIds.contains((dataProvider.matchuserList??[])
                                              .elementAt(index)
                                              .id)?true:profilepro.activemonogomy==false?true:
                                          profilepro.activemonogomy&&profilepro.anotheruserID.toString()==(dataProvider.matchuserList??[])
                                              .elementAt(index)
                                              .id.toString()
                                      )));
                                }

                                var currentUserId;

                                setState(() {});



                                // if (profilepro.activemonogomy) {
                                //   if (profilepro.anotheruserID.toString() ==
                                //       dataProvider.userChatListModel!.data!
                                //           .elementAt(index)
                                //           .userId
                                //           .toString()) {
                                //     Get.to(PeerChatPage(
                                //       conversationID: dataProvider
                                //           .userChatListModel!.data!
                                //           .elementAt(index)
                                //           .userId
                                //           .toString(),
                                //       conversationName: dataProvider
                                //           .userChatListModel!.data!
                                //           .elementAt(index)
                                //           .user!
                                //           .name
                                //           .toString(),
                                //       conversationImage: dataProvider
                                //           .userChatListModel!.data!
                                //           .elementAt(index)
                                //           .user!
                                //           .profileImage
                                //           .toString(),
                                //       senderImage: profilepro.profileImage,
                                //     ));
                                //
                                //     //Get.to(Chat(anotherUserId: ,username: , userimage: profilepro.profileImage, secondaryUserimage: ,));
                                //   } else {
                                //     showSnakbar(
                                //         AppLocalizations.of(context)!
                                //             .senderrormessage,
                                //         context);
                                //   }
                                // } else {
                                //   if (dataProvider.userChatListModel!.data!
                                //       .elementAt(index)
                                //       .user!
                                //       .is_remove!) {
                                //     showSnakbar(
                                //         AppLocalizations.of(context)!
                                //             .senderrormessage,
                                //         context);
                                //   } else {
                                //     Get.to(PeerChatPage(
                                //       conversationID: dataProvider
                                //           .userChatListModel!.data!
                                //           .elementAt(index)
                                //           .userId
                                //           .toString(),
                                //       conversationName: dataProvider
                                //           .userChatListModel!.data!
                                //           .elementAt(index)
                                //           .user!
                                //           .name
                                //           .toString(),
                                //       conversationImage: dataProvider
                                //           .userChatListModel!.data!
                                //           .elementAt(index)
                                //           .user!
                                //           .profileImage
                                //           .toString(),
                                //       senderImage: profilepro.profileImage,
                                //     ));
                                //   }
                                //   // Get.to(Chat(anotherUserId: dataProvider.userChatListModel!.data!.elementAt(index).userId.toString(),username: dataProvider.userChatListModel!.data!.elementAt(index).user!.name.toString(), userimage: profilepro.profileImage, secondaryUserimage: dataProvider.userChatListModel!.data!.elementAt(index).user!.profileImage.toString(),));
                                // }
                                // Get.to(HurraySuperMatch_Screen(anotheruser: dataProvider.matchuserList!.elementAt(index).images!.elementAt(0).image,anotheruserId: dataProvider.matchuserList!.elementAt(index).id.toString(),));
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 20.w),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 85.w,
                                      height: 85.h,
                                      child: CircleAvatar(
                                          backgroundColor: Colors.white,
                                          child: SizedBox(
                                              height: 80.h,
                                              width: 80.w,
                                              child: CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                    dataProvider.matchuserList!
                                                        .elementAt(index)
                                                        .images!
                                                        .elementAt(0)
                                                        .image
                                                        .toString()),
                                                radius: 500,
                                                backgroundColor: Colors.white,
                                              ))),
                                    ),
                                    SizedBox(
                                      height: 8.h,
                                    ),
                                    addCenterRegularText(
                                        dataProvider.matchuserList!
                                            .elementAt(index)
                                            .name!
                                            .toString(),
                                        12,
                                        Colors.black)
                                  ],
                                ),
                              ),
                            );
                          },
                        )
                      :  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset("assets/images/nomatches.svg"),
                        SizedBox(
                          width: 30,
                        ),
                        Container(
                            child: addMediumText(
                                "${AppLocalizations.of(context)!.nomatches} 😔",
                                16.sp,
                                Colors.black)),
                      ],
                    ),
                  );


                }


              })),
          SizedBox(
            height: 15.h,
          ),
          Divider(
            color: Color(0xFFF2E7FA),
            thickness: 1.5,
          ),
          SizedBox(
            height: 15.h,
          ),
          Expanded(child: Consumer<DashboardProvider>(
              builder: (context, dataProvider, child) {
            if (dataProvider.userChatListModel?.data != null) {
              return dataProvider.userChatListModel!.data!.length > 0
                  ? ListView.builder(
                      itemCount: dataProvider.userChatListModel!.data!.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: ScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: EdgeInsets.only(bottom: 20.w, right: 10.w),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () async {
                                  List<int>userMonoIds=[];
                                  print(dataProvider.matchuserList!.length);
                                  for(int i=0;i<dataProvider.matchuserList!.length;i++){

                                    userMonoIds.add(dataProvider.matchuserList![i].id);

                                  }
                                  print(userMonoIds);
                                  var profilepro = Provider.of<ProfileProvider>(
                                      context,
                                      listen: false);


                                  print(profilepro.anotheruserID);


                                      final db = FirebaseFirestore.instance;
                                      var newIndex;
                                      Query docRef = db
                                          .collection("users")
                                          .where((dataProvider
                                              .userChatListModel!.data!
                                              .elementAt(index)
                                              .user!
                                              .email));

                                      QuerySnapshot docSnap =
                                          await docRef.get();
                                      for (int i = 0;
                                          i < docSnap.docs.length;
                                          i++) {
                                        if (dataProvider
                                                .userChatListModel!.data!
                                                .elementAt(index)
                                                .user!
                                                .email ==
                                            docSnap.docs[i]['nickname']) {
                                          newIndex = i;
                                        }
                                      }

                                      var groupChatId;
                                      var docId;
print(dataProvider.userChatListModel!
    .data!
    .elementAt(index)
    .user!
    .email.toString());
print("jsjsjssjs");
                                      if (newIndex == null) {
                                        print("heloo");
                                       createAccountWithEmail(
                                                dataProvider
                                                    .userChatListModel!.data!
                                                    .elementAt(index)
                                                    .user!
                                                    .email,
                                                "12345678").then((value) {
                                                  print("value");
                                                  print(value);
                                        })
                                            .whenComplete(() {
                                          for (int i = 0;
                                              i < docSnap.docs.length;
                                              i++) {
                                            print(docSnap.docs[i]
                                            ['nickname'].toString());
                                            print(docSnap.docs[i].data());
                                            print("=============");
                                            if (dataProvider.userChatListModel!
                                                .data!
                                                .elementAt(index)
                                                .user!
                                                .email.toString().toLowerCase() ==
                                                docSnap.docs[i]
                                                ['nickname'].toString().toLowerCase()||dataProvider.userChatListModel!
                                                        .data!
                                                        .elementAt(index)
                                                        .user!
                                                        .email ==
                                                    docSnap.docs[i]
                                                        ['nickname'] ||
                                                dataProvider.userChatListModel!
                                                        .data!
                                                        .elementAt(index)
                                                        .user!
                                                        .email
                                                        .toString()
                                                        .toLowerCase() ==
                                                    docSnap.docs[i]
                                                        ['nickname']) {
                                              newIndex = i;
                                              print("ghvjjhj");
                                            }
                                          }
                                          docId = docSnap.docs[newIndex].id;
                                          setState(() {});
                                          print("ghvjjsddsdhj$docId");
                                          Get.to(ChatPage(
                                              arguments: ChatPageArguments(
                                            conversationName: (dataProvider
                                                .userChatListModel!.data!
                                                .elementAt(index)
                                                .user!
                                                .name),
                                            peerId: docId,
                                            otherUserId: (dataProvider
                                                .userChatListModel!.data!
                                                .elementAt(index)
                                                .user!
                                                .id),
                                            peerAvatar: (dataProvider
                                                .userChatListModel!.data!
                                                .elementAt(index)
                                                .user!
                                                .profileImage),
                                            peerNickname: (dataProvider
                                                .userChatListModel!.data!
                                                .elementAt(index)
                                                .user!
                                                .email),
                                                chatEnable:
                                                userMonoIds.contains(dataProvider
                                                    .userChatListModel!.data!
                                                    .elementAt(index)
                                                    .user!.id)?true:profilepro.activemonogomy==false?true:profilepro.activemonogomy&&profilepro.anotheruserID==dataProvider
                                                    .userChatListModel!.data!
                                                    .elementAt(index)
                                                    .user!.id
                                          )));
                                        });
                                      }
                                      else {
                                        docId = docSnap.docs[newIndex].id;
                                        Get.to(ChatPage(
                                            arguments: ChatPageArguments(
                                          conversationName: (dataProvider
                                              .userChatListModel!.data!
                                              .elementAt(index)
                                              .user!
                                              .name),
                                          peerId: docId,
                                          otherUserId: (dataProvider
                                              .userChatListModel!.data!
                                              .elementAt(index)
                                              .user!
                                              .id),
                                          peerAvatar: (dataProvider
                                              .userChatListModel!.data!
                                              .elementAt(index)
                                              .user!
                                              .profileImage),
                                          peerNickname: (dataProvider
                                              .userChatListModel!.data!
                                              .elementAt(index)
                                              .user!
                                              .email),
                                                chatEnable:userMonoIds.contains(dataProvider
                                                    .userChatListModel!.data!
                                                    .elementAt(index)
                                                    .user!.id)?true:profilepro.activemonogomy==false?true:
                                                profilepro.activemonogomy&&profilepro.anotheruserID.toString()==dataProvider
                                                    .userChatListModel!.data!
                                                    .elementAt(index)
                                                    .user!.id.toString()
                                        )));
                                      }

                                      var currentUserId;

                                      setState(() {});



                                  // if (profilepro.activemonogomy) {
                                  //   if (profilepro.anotheruserID.toString() ==
                                  //       dataProvider.userChatListModel!.data!
                                  //           .elementAt(index)
                                  //           .userId
                                  //           .toString()) {
                                  //     Get.to(PeerChatPage(
                                  //       conversationID: dataProvider
                                  //           .userChatListModel!.data!
                                  //           .elementAt(index)
                                  //           .userId
                                  //           .toString(),
                                  //       conversationName: dataProvider
                                  //           .userChatListModel!.data!
                                  //           .elementAt(index)
                                  //           .user!
                                  //           .name
                                  //           .toString(),
                                  //       conversationImage: dataProvider
                                  //           .userChatListModel!.data!
                                  //           .elementAt(index)
                                  //           .user!
                                  //           .profileImage
                                  //           .toString(),
                                  //       senderImage: profilepro.profileImage,
                                  //     ));
                                  //
                                  //     //Get.to(Chat(anotherUserId: ,username: , userimage: profilepro.profileImage, secondaryUserimage: ,));
                                  //   } else {
                                  //     showSnakbar(
                                  //         AppLocalizations.of(context)!
                                  //             .senderrormessage,
                                  //         context);
                                  //   }
                                  // } else {
                                  //   if (dataProvider.userChatListModel!.data!
                                  //       .elementAt(index)
                                  //       .user!
                                  //       .is_remove!) {
                                  //     showSnakbar(
                                  //         AppLocalizations.of(context)!
                                  //             .senderrormessage,
                                  //         context);
                                  //   } else {
                                  //     Get.to(PeerChatPage(
                                  //       conversationID: dataProvider
                                  //           .userChatListModel!.data!
                                  //           .elementAt(index)
                                  //           .userId
                                  //           .toString(),
                                  //       conversationName: dataProvider
                                  //           .userChatListModel!.data!
                                  //           .elementAt(index)
                                  //           .user!
                                  //           .name
                                  //           .toString(),
                                  //       conversationImage: dataProvider
                                  //           .userChatListModel!.data!
                                  //           .elementAt(index)
                                  //           .user!
                                  //           .profileImage
                                  //           .toString(),
                                  //       senderImage: profilepro.profileImage,
                                  //     ));
                                  //   }
                                  //   // Get.to(Chat(anotherUserId: dataProvider.userChatListModel!.data!.elementAt(index).userId.toString(),username: dataProvider.userChatListModel!.data!.elementAt(index).user!.name.toString(), userimage: profilepro.profileImage, secondaryUserimage: dataProvider.userChatListModel!.data!.elementAt(index).user!.profileImage.toString(),));
                                  // }
                                },
                                child: SizedBox(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Stack(
                                        children: [
                                          SizedBox(
                                              height: 80.h,
                                              width: 80.w,
                                              child: CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                    dataProvider
                                                        .userChatListModel!
                                                        .data!
                                                        .elementAt(index)
                                                        .user!
                                                        .images!
                                                        .elementAt(0)
                                                        .image
                                                        .toString()),
                                                radius: 500,
                                                backgroundColor: Colors.white,
                                              )),
                                          dataProvider.userChatListModel!.data!
                                                      .elementAt(index)
                                                      .seenStaus !=
                                                  1
                                              ? Container(
                                                  height: 12,
                                                  width: 12,
                                                  margin: EdgeInsets.only(
                                                      left: 53, top: 5),
                                                  child: SvgPicture.asset(
                                                      "assets/images/onlinedot.svg"),
                                                )
                                              : Container(),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 15.w,
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.50,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            addBoldText(
                                                dataProvider
                                                    .userChatListModel!.data!
                                                    .elementAt(index)
                                                    .user!
                                                    .name,
                                                12,
                                                Colors.black),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            addRegularText(
                                                dataProvider.userChatListModel!
                                                        .data!
                                                        .elementAt(index)
                                                        .user!
                                                        .latestMessage
                                                        .contains(
                                                            "https://firebasestorage.googleapis.com")
                                                    ? "Media"
                                                    : "${dataProvider.userChatListModel!.data!.elementAt(index).user!.latestMessage}",
                                                10,
                                                Colors.black)
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  width:
                                      MediaQuery.of(context).size.width * 0.83,
                                ),
                              ),
                              !dataProvider.userChatListModel!.data!
                                      .elementAt(index)
                                      .isDeleteChat
                                  ? GestureDetector(
                                      onTap: () async {
                                        setState(() {
                                          dataProvider.userChatListModel!.data!
                                              .elementAt(index)
                                              .isDeleteChat = true;
                                        });

                                        var profilepro =
                                            Provider.of<ProfileProvider>(
                                                context,
                                                listen: false);

                                        final db = FirebaseFirestore.instance;
                                        var newIndex;
                                        Query docRef = db
                                            .collection("users")
                                            .where((dataProvider
                                                .userChatListModel!.data!
                                                .elementAt(index)
                                                .user!
                                                .email));

                                        QuerySnapshot docSnap =
                                            await docRef.get();
                                        for (int i = 0;
                                            i < docSnap.docs.length;
                                            i++) {
                                          if (dataProvider
                                                  .userChatListModel!.data!
                                                  .elementAt(index)
                                                  .user!
                                                  .email ==
                                              docSnap.docs[i]['nickname']) {
                                            newIndex = i;
                                          }
                                        }

                                        var groupChatId;
                                        var docId;
                                        print("======>>>>>>$newIndex");
                                        print(
                                            "heloo ${dataProvider.userChatListModel!.data!.elementAt(index).user!.email}");
                                        if (newIndex == null) {
                                          print("heloo");
                                          createAccountWithEmail(
                                                  dataProvider
                                                      .userChatListModel!.data!
                                                      .elementAt(index)
                                                      .user!
                                                      .email,
                                                  "12345678")
                                              .whenComplete(() {
                                            for (int i = 0;
                                                i < docSnap.docs.length;
                                                i++) {
                                              if (dataProvider
                                                          .userChatListModel!
                                                          .data!
                                                          .elementAt(index)
                                                          .user!
                                                          .email ==
                                                      docSnap.docs[i]
                                                          ['nickname'] ||
                                                  dataProvider
                                                          .userChatListModel!
                                                          .data!
                                                          .elementAt(index)
                                                          .user!
                                                          .email
                                                          .toString()
                                                          .toLowerCase() ==
                                                      docSnap.docs[i]
                                                          ['nickname']) {
                                                newIndex = i;
                                                print("ghvjjhj");
                                              }
                                            }
                                            docId = docSnap.docs[newIndex].id;
                                            setState(() {});
                                            print("ghvjjsddsdhj$docId");
                                            // Get.to(ChatPage(
                                            //     arguments: ChatPageArguments(
                                            //       conversationName: (dataProvider.userChatListModel!.data!
                                            //           .elementAt(index)
                                            //           .user!
                                            //           .name),
                                            //       peerId:docId,
                                            //       otherUserId:(dataProvider.userChatListModel!.data!
                                            //           .elementAt(index)
                                            //           .user!.id),
                                            //       peerAvatar:(dataProvider.userChatListModel!.data!
                                            //           .elementAt(index)
                                            //           .user!.profileImage),
                                            //       peerNickname:(dataProvider.userChatListModel!.data!
                                            //           .elementAt(index)
                                            //           .user!
                                            //           .email
                                            //       ),
                                            //     )));
                                          });
                                        } else {
                                          docId = docSnap.docs[newIndex].id;
                                          // Get.to(ChatPage(
                                          //     arguments: ChatPageArguments(
                                          //       conversationName: (dataProvider.userChatListModel!.data!
                                          //           .elementAt(index)
                                          //           .user!
                                          //           .name),
                                          //       peerId:docId,
                                          //       otherUserId:(dataProvider.userChatListModel!.data!
                                          //           .elementAt(index)
                                          //           .user!.id),
                                          //       peerAvatar:(dataProvider.userChatListModel!.data!
                                          //           .elementAt(index)
                                          //           .user!.profileImage),
                                          //       peerNickname:(dataProvider.userChatListModel!.data!
                                          //           .elementAt(index)
                                          //           .user!
                                          //           .email
                                          //       ),
                                          //     )));
                                        }

                                        var currentUserId;

                                        setState(() {});
                                        print(docId);

                                        print(groupChatId);

                                        var newesr;
                                        Query docRefs = db
                                            .collection("users")
                                            .where((dataProvider
                                                .userChatListModel!.data!
                                                .elementAt(index)
                                                .user!
                                                .email));

                                        QuerySnapshot docSnaps =
                                            await docRefs.get();
                                        for (int i = 0;
                                            i < docSnaps.docs.length;
                                            i++) {
                                          if (dataProvider
                                                  .userChatListModel!.data!
                                                  .elementAt(index)
                                                  .user!
                                                  .email ==
                                              docSnaps.docs[i]['nickname']) {
                                            newesr = i;
                                          }
                                        }

                                        var groupChatIds;
                                        var docIds;
                                        // print("======>>>>>>$newIndex");

                                        if (newesr == null) {
                                          print("heloo");
                                          createAccountWithEmail(
                                                  dataProvider
                                                      .userChatListModel!.data!
                                                      .elementAt(index)
                                                      .user!
                                                      .email,
                                                  "12345678")
                                              .whenComplete(() {
                                            for (int i = 0;
                                                i < docSnaps.docs.length;
                                                i++) {
                                              if (dataProvider
                                                          .userChatListModel!
                                                          .data!
                                                          .elementAt(index)
                                                          .user!
                                                          .email ==
                                                      docSnaps.docs[i]
                                                          ['nickname'] ||
                                                  dataProvider
                                                          .userChatListModel!
                                                          .data!
                                                          .elementAt(index)
                                                          .user!
                                                          .email
                                                          .toString()
                                                          .toLowerCase() ==
                                                      docSnaps.docs[i]
                                                          ['nickname']) {
                                                newesr = i;
                                                print("ghvjjhj");
                                              }
                                            }
                                            docId = docSnaps.docs[newesr].id;
                                            setState(() {});
                                            print("ghvjjsddsdhj$docId");
                                          });
                                        } else {
                                          docId = docSnap.docs[newIndex].id;
                                        }

                                        setState(() {});
                                        print(docId);

                                        print(groupChatId);

                                        String currentUserIdz = '';
                                        String groupChatIdz = '';

                                        preferences = await SharedPreferences
                                            .getInstance();

                                        Query userRef = db
                                            .collection("users")
                                            .where(((dataProvider
                                                .userChatListModel!.data!
                                                .elementAt(index)
                                                .user!
                                                .email)));

                                        QuerySnapshot userSnap =
                                            await userRef.get();
                                        for (int i = 0;
                                            i < userSnap.docs.length;
                                            i++) {
                                          if ((preferences!
                                                  .getString('email')) ==
                                              userSnap.docs[i]['nickname']) {
                                            print("hjkjhgvjkojhk");
                                            currentUserId = userSnap.docs[i].id;
                                          }
                                        }
                                        String peerId = docId;
                                        if (currentUserId.compareTo(peerId) >
                                            0) {
                                          groupChatId =
                                              '$currentUserId-$peerId';
                                        } else {
                                          groupChatId =
                                              '$peerId-$currentUserId';
                                        }
                                        print("==================");
                                        print("==================$groupChatId");

                                        chatProvider.getCHatList(
                                            groupChatId: groupChatId,
                                            localId: currentUserId);
                                        var isChatDelete =
                                            await DashboardRepository
                                                .userChatDelete(
                                                    preferences!
                                                        .getString(
                                                            "accesstoken")
                                                        .toString(),
                                                    dataProvider
                                                        .userChatListModel!
                                                        .data!
                                                        .elementAt(index)
                                                        .userId
                                                        .toString());
                                        if (isChatDelete) {
                                          setState(() {
                                            dataProvider
                                                .userChatListModel!.data!
                                                .elementAt(index)
                                                .isDeleteChat = false;
                                            dataProvider
                                                .userChatListModel!.data!
                                                .removeAt(index);
                                          });
                                        } else {
                                          setState(() {
                                            dataProvider
                                                .userChatListModel!.data!
                                                .elementAt(index)
                                                .isDeleteChat = false;
                                          });
                                        }
                                      },
                                      child: SvgPicture.asset(
                                        "assets/images/notificationdelete.svg",
                                        height: 24.h,
                                        width: 24.w,
                                      ))
                                  : CircularProgressIndicator(),
                            ],
                          ),
                        );
                      },
                    )
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset("assets/images/nomessage.svg"),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                              child: addMediumText(
                                  "${AppLocalizations.of(context)!.nomessage} 😔",
                                  16.sp,
                                  Colors.black)),
                        ],
                      ),
                    );
            }
            // return Center(
            //   child: CircularProgressIndicator(),
            // );
                return  Shimmer.fromColors(
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
                );
          })),
        ],
      ),
    );
  }

  Future<String?> createAccountWithEmail(String email, String password) async {
    String errorMessage;
    User? user;
    FirebaseFirestore firebasStorage = FirebaseFirestore.instance;
    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      user = userCredential.user;
      if (user!.uid.isNotEmpty) {
      firebasStorage.collection('users').doc(user.uid).set(
            {'nickname': email, 'photoUrl': user.photoURL, 'id': user.uid,"isTyping":false});

        return 'Success';
      }
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case "EMAIL_ALREADY_IN_USE":
        case "email-already-in-use":
          errorMessage = "Email already used. Go to login page.";
          break;
        default:
          errorMessage = "Login failed. Please try again.";
          break;
      }

      return errorMessage;
    }

    return null;
  }


}
shimmerLoadingWidget(){
  return Shimmer.fromColors(
    baseColor: Colors.grey.shade300,
    highlightColor: Colors.grey.shade100,
    enabled: true,
    child:   Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: CircleAvatar(
        radius: 40,
      ),
    ),);
}