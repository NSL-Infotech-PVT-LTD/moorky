import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:moorky/dashboardscreen/messagescreen/new_chat_screen.dart';
import 'package:moorky/main.dart';
import 'package:moorky/premiumscreen/view/premiumscreen.dart';
import 'package:moorky/profilecreate/model/profileDetailsmodel.dart';
import 'package:moorky/profilecreate/repository/profileRepository.dart';
import 'package:moorky/profiledetailscreen/view/matchprofiledetail.dart';
import 'package:moorky/profiledetailscreen/view/profiledetailscreen.dart';
import 'package:moorky/zegocloud/peer/peer_chat_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../dashboardscreen/messagescreen/view/messagescreen.dart';
import '../../dashboardscreen/view/dashboardscreen.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static void initialize() {
    const InitializationSettings initializationSettings =
    InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: IOSInitializationSettings(),
    );
    _notificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (val) {
        });
  }

  static void display(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
       NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          "Moorky",
          "pushnotificationappchannel",
          icon: '@mipmap/ic_launcher',
          importance: Importance.max,
          priority: Priority.high,
          playSound: true,
        ),
        iOS: IOSNotificationDetails(presentAlert: true,presentSound: true)
      );
if(notifitypeScreen=="ChatScreen"&&message.data['type']=="messages"){}

      else{
  await _notificationsPlugin.show(
    id,
    message.notification!.title,
    message.notification!.body,
    notificationDetails,
    payload: message.notification!.title!,
  );
}
      const InitializationSettings initializationSettings =
      InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: IOSInitializationSettings(),
      );
      _notificationsPlugin.initialize(initializationSettings,
          onSelectNotification: (val) async{
        print("val payload is");
        print(val);
        if(val == "New profile visitor"){
          SharedPreferences preferences = await SharedPreferences.getInstance();
          ProfileDetailModel? profiledetails;
          if (preferences.getString("accesstoken") != null) {
            profiledetails = await ProfileRepository.profileDetails(preferences.getString("accesstoken").toString());
          }
          if(profiledetails != null)
          {
            // Get.to(ProfileDetailScreen(user_id: message.data['id'], isSelf: false, isLike: true, isSearch: false,
            //   startheigh: profiledetails.data!.userfilterdata!.start_tall_are_you.toString(),
            //   endheigh: profiledetails.data!.userfilterdata!.end_tall_are_you.toString(),
            //   startag: profiledetails.data!.userfilterdata!.age_from.toString(),
            //   endag: profiledetails.data!.userfilterdata!.age_to.toString(),
            //   religion: profiledetails.data!.userfilterdata!.religion.toString(),
            //   search: "",
            //   star_sign: profiledetails.data!.userfilterdata!.star_sign.toString(),
            //   sexual_orientation: profiledetails.data!.userfilterdata!.sexual_orientation.toString(),
            //   refresh: "",
            //   feel_about_kids: profiledetails.data!.userfilterdata!.feel_about_kids.toString(),
            //   do_you_smoke: profiledetails.data!.userfilterdata!.do_you_smoke.toString(),
            //   do_you_drink: profiledetails.data!.userfilterdata!.do_you_drink.toString(),
            //   directchatcount:0,
            //   datewith: profiledetails.data!.userfilterdata!.date_with.toString(),
            //   education: profiledetails.data!.userfilterdata!.education.toString(),
            //   have_pets: profiledetails.data!.userfilterdata!.have_pets.toString(),
            //   isPremium: "",
            //   introvert_or_extrovert: profiledetails.data!.userfilterdata!.introvert_or_extrovert.toString(),
            //   looking_fors: profiledetails.data!.userfilterdata!.looking_fors.toString(),
            //   languages: profiledetails.data!.userfilterdata!.languages.toString(),
            //   languageList: profiledetails.data!.userfilterdata!.languages.toString().replaceAll("[", "").replaceAll("]", ""),
            //   maritals: profiledetails.data!.userfilterdata!.maritals.toString(),
            //   profileimage: "",
            //   type: "all",
            //   usertype: profiledetails.data!.user_type,
            //   userIndex: "",));
            Get.to(MatchProfileDetailScreen(user_id: message.data['id']));
          }
        }
            if (message.notification != null) {
              print(message.notification!.title);
              print(message.notification!.body);
              // print("${message.data['_id']}");

              if(message.data['type']=="likes_you")
              {
                Get.to(MessageScreen(index: 1,showIcon: true,));
              }
              if(message.data['type']=="profile_visitors"){
                SharedPreferences preferences = await SharedPreferences.getInstance();
                ProfileDetailModel? profiledetails;
                if (preferences.getString("accesstoken") != null) {
                  profiledetails = await ProfileRepository.profileDetails(preferences.getString("accesstoken").toString());
                }
                if(profiledetails != null)
                {
                  // Get.to(ProfileDetailScreen(user_id: message.data['id'], isSelf: false, isLike: true, isSearch: false,
                  //   startheigh: profiledetails.data!.userfilterdata!.start_tall_are_you.toString(),
                  //   endheigh: profiledetails.data!.userfilterdata!.end_tall_are_you.toString(),
                  //   startag: profiledetails.data!.userfilterdata!.age_from.toString(),
                  //   endag: profiledetails.data!.userfilterdata!.age_to.toString(),
                  //   religion: profiledetails.data!.userfilterdata!.religion.toString(),
                  //   search: "",
                  //   star_sign: profiledetails.data!.userfilterdata!.star_sign.toString(),
                  //   sexual_orientation: profiledetails.data!.userfilterdata!.sexual_orientation.toString(),
                  //   refresh: "",
                  //   feel_about_kids: profiledetails.data!.userfilterdata!.feel_about_kids.toString(),
                  //   do_you_smoke: profiledetails.data!.userfilterdata!.do_you_smoke.toString(),
                  //   do_you_drink: profiledetails.data!.userfilterdata!.do_you_drink.toString(),
                  //   directchatcount:0,
                  //   datewith: profiledetails.data!.userfilterdata!.date_with.toString(),
                  //   education: profiledetails.data!.userfilterdata!.education.toString(),
                  //   have_pets: profiledetails.data!.userfilterdata!.have_pets.toString(),
                  //   isPremium: "",
                  //   introvert_or_extrovert: profiledetails.data!.userfilterdata!.introvert_or_extrovert.toString(),
                  //   looking_fors: profiledetails.data!.userfilterdata!.looking_fors.toString(),
                  //   languages: profiledetails.data!.userfilterdata!.languages.toString(),
                  //   languageList: profiledetails.data!.userfilterdata!.languages.toString().replaceAll("[", "").replaceAll("]", ""),
                  //   maritals: profiledetails.data!.userfilterdata!.maritals.toString(),
                  //   profileimage: "",
                  //   type: "all",
                  //   usertype: profiledetails.data!.user_type,
                  //   userIndex: "",));

                  Get.to(MatchProfileDetailScreen(user_id: message.data['id']));
                }
              }
              if(message.data['type']=="matches"){
                Get.to(MessageScreen(index: 0,showIcon: true,));
              }
              if(message.data['type']=="messages"){
                SharedPreferences preferences = await SharedPreferences.getInstance();
                ProfileDetailModel? profiledetails;
                if (preferences.getString("accesstoken") != null) {
                  profiledetails = await ProfileRepository.profileDetails(preferences.getString("accesstoken").toString());
                }

                if(profiledetails != null)
                {
                  if(profiledetails.data!.user_type != "normal")
                  {
                    if(profiledetails.data!.active_monogamy!)
                    {
                      Get.to(ChatPage(
                          arguments: ChatPageArguments(
                            conversationName: preferences.getString("lang").toString()=="tr"?message.notification!.body
                                .toString().split("'")[0]:message.notification!.body.toString().replaceAll("You received a new message from ","").toString(),
                            // peerId: docId,
                            //  otherUserId: (dataProvider
                            //      .userChatListModel!.data!
                            //      .elementAt(index)
                            //      .user!
                            //      .id),
                            peerAvatar: profiledetails.data!.profile_image,
                            peerNickname:  message.data['room_data'].toString().split(",")[1], otherUserId: int.parse(message.data['id'].toString()), peerId: message.data['room_data'].toString().split(",")[1],
                          )));
                      //Get.to(PeerChatPage(conversationID: message.data['id'], conversationName: message.notification!.body.toString().replaceAll("You received a new message from ","").toString(), conversationImage: message.data['image'], senderImage: profiledetails.data!.profile_image));
                      // Get.to(MessageScreen(index: 0,));
                    }
                    else{
                      Get.to(ChatPage(
                          arguments: ChatPageArguments(
                            conversationName:preferences.getString("lang").toString()=="tr"?message.notification!.body
                                .toString().split("'")[0]: message.notification!.body.toString().replaceAll("You received a new message from ","").toString(),
                            // peerId: docId,
                            //  otherUserId: (dataProvider
                            //      .userChatListModel!.data!
                            //      .elementAt(index)
                            //      .user!
                            //      .id),
                            peerAvatar: profiledetails.data!.profile_image,
                            peerNickname:  message.data['room_data'].toString().split(",")[1], otherUserId: int.parse(message.data['id'].toString()), peerId: message.data['room_data'].toString().split(",")[1],
                          )));
                    }
                  }
                  else{
                     Get.to(Premium_Screen());

                  }
                }


              }
            }
          });

    } on Exception catch (e) {
      print(e);
    }
  }
}
