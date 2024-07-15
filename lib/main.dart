import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:moorky/app_config.dart';
import 'package:moorky/dashboardscreen/messagescreen/new_chat_screen.dart';
import 'package:moorky/dashboardscreen/messagescreen/view/messagescreen.dart';
import 'package:moorky/dashboardscreen/provider/dashboardprovider.dart';
import 'package:moorky/dashboardscreen/view/dashboardscreen.dart';
import 'package:moorky/firebase_dynamic_link.dart';
import 'package:moorky/l10n/l10n.dart';
import 'package:moorky/lang/provider/locale_provider.dart';
import 'package:moorky/premiumscreen/view/premiumscreen.dart';
import 'package:moorky/profilecreate/model/profileDetailsmodel.dart';
import 'package:moorky/profilecreate/provider/profileprovider.dart';
import 'package:moorky/profilecreate/view/imagesscreen.dart';
import 'package:moorky/profiledetailscreen/view/matchprofiledetail.dart';
import 'package:moorky/profiledetailscreen/view/profiledetailscreen.dart';
import 'package:moorky/quizscreens/quizprovider/QuizProvider.dart';
import 'package:moorky/routes.dart';
import 'package:moorky/settingscreen/provider/notificationservice.dart';
import 'package:moorky/settingscreen/provider/setting_provider.dart';
import 'package:moorky/splashscreen/view/splashScreen.dart';
import 'package:moorky/zegocloud/model/user_model.dart';
import 'package:moorky/zegocloud/peer/peer_chat_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dashboardscreen/provider/chat_provider.dart';
import 'firebase_options.dart';
import 'auth/provider/authprovider.dart';
import 'constant/color.dart';
import 'profilecreate/repository/profileRepository.dart';

bool notiisnotification = false;
String notifitype = "";
String notifitypeid = "";
String notifitypeimage = "";
String notifitypename = "";
String notifitypeRoomData = "";
String notifitypeScreen = "";

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("FirebaseMessaging.instance.getInitialMessage");
  if (message.notification != null) {
    print(message.notification!.title);
    print(message.notification!.body);
    // print("${message.data['_id']}");

    if (message.data['type'] == "likes_you") {
      Get.to(MessageScreen(index: 1,showIcon: true,));
    }
    if (message.data['type'] == "profile_visitors") {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      ProfileDetailModel? profiledetails;
      if (preferences.getString("accesstoken") != null) {
        profiledetails = await ProfileRepository.profileDetails(
            preferences.getString("accesstoken").toString());
      }
      if (profiledetails != null) {
        // Get.to(ProfileDetailScreen(
        //   user_id: message.data['id'],
        //   isSelf: false,
        //   isLike: true,
        //   isSearch: false,
        //   startheigh: profiledetails.data!.userfilterdata!.start_tall_are_you
        //       .toString(),
        //   endheigh:
        //       profiledetails.data!.userfilterdata!.end_tall_are_you.toString(),
        //   startag: profiledetails.data!.userfilterdata!.age_from.toString(),
        //   endag: profiledetails.data!.userfilterdata!.age_to.toString(),
        //   religion: profiledetails.data!.userfilterdata!.religion.toString(),
        //   search: "",
        //   star_sign: profiledetails.data!.userfilterdata!.star_sign.toString(),
        //   sexual_orientation: profiledetails
        //       .data!.userfilterdata!.sexual_orientation
        //       .toString(),
        //   refresh: "",
        //   feel_about_kids:
        //       profiledetails.data!.userfilterdata!.feel_about_kids.toString(),
        //   do_you_smoke:
        //       profiledetails.data!.userfilterdata!.do_you_smoke.toString(),
        //   do_you_drink:
        //       profiledetails.data!.userfilterdata!.do_you_drink.toString(),
        //   directchatcount: 0,
        //   datewith: profiledetails.data!.userfilterdata!.date_with.toString(),
        //   education: profiledetails.data!.userfilterdata!.education.toString(),
        //   have_pets: profiledetails.data!.userfilterdata!.have_pets.toString(),
        //   isPremium: "",
        //   introvert_or_extrovert: profiledetails
        //       .data!.userfilterdata!.introvert_or_extrovert
        //       .toString(),
        //   looking_fors:
        //       profiledetails.data!.userfilterdata!.looking_fors.toString(),
        //   languages: profiledetails.data!.userfilterdata!.languages.toString(),
        //   languageList:
        //       profiledetails.data!.userfilterdata!.languages.toString(),
        //   maritals: profiledetails.data!.userfilterdata!.maritals.toString(),
        //   profileimage: "",
        //   type: "all",
        //   usertype: profiledetails.data!.user_type,
        //   userIndex: "",
        // ));
        Get.to(MatchProfileDetailScreen(user_id: message.data['id']));
      }
    }
    if (message.data['type'] == "matches") {
      Get.to(MessageScreen(index: 0,showIcon: true,));
    }
    if (message.data['type'] == "messages") {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      ProfileDetailModel? profiledetails;
      if (preferences.getString("accesstoken") != null) {
        profiledetails = await ProfileRepository.profileDetails(
            preferences.getString("accesstoken").toString());
      }

      if (profiledetails != null) {
        if (profiledetails.data!.user_type != "normal"||profiledetails.data!.user_type == "normal") {
          if (profiledetails.data!.active_monogamy!) {
            // Get.to(MessageScreen(index: 0));
            Get.to(ChatPage(
                arguments: ChatPageArguments(
              conversationName:  preferences.getString("lang").toString()=="tr"?message.notification!.body
                  .toString().split("'")[0]:  message.notification!.body
                  .toString()
                  .replaceAll("You received a new message from ", "")
                  .toString(),
              // peerId: docId,
              //  otherUserId: (dataProvider
              //      .userChatListModel!.data!
              //      .elementAt(index)
              //      .user!
              //      .id),
              peerAvatar: profiledetails.data!.profile_image,
              peerNickname: message.data['room_data'].toString().split(",")[1],
              otherUserId: int.parse(message.data['id'].toString()),
              peerId: message.data['room_data'].toString().split(",")[1],
            )));
            //Get.to(PeerChatPage(conversationID: message.data['id'], conversationName:  profiledetails.data!.active_monogamy_user_name, conversationImage: message.data['image'], senderImage: profiledetails.data!.profile_image));
          }
          else {
            Get.to(ChatPage(
                arguments: ChatPageArguments(
              conversationName:  preferences.getString("lang").toString()=="tr"?message.notification!.body
                  .toString().split("'")[0]:  message.notification!.body
                  .toString()
                  .replaceAll("You received a new message from ", "")
                  .toString(),
              // peerId: docId,
              //  otherUserId: (dataProvider
              //      .userChatListModel!.data!
              //      .elementAt(index)
              //      .user!
              //      .id),
              peerAvatar: profiledetails.data!.profile_image,
              peerNickname: message.data['room_data'].toString().split(",")[1],
              otherUserId: int.parse(message.data['id'].toString()),
              peerId: message.data['room_data'].toString().split(",")[1],
            )));
          }
        }
        else {
          Get.to(Premium_Screen());
        }
      }
    }
  }
}

void _notifications() async {
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.instance.getInitialMessage().then(
    (message) async {
      print("FirebaseMessaging.instance.getInitialMessage");
      print("message");
      print(message);
      if (message != null) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.setBool("isnotification", true);
        await preferences.setString("notifitype", message.data['type']);
        await preferences.setString("notifitypeid", message.data['id']);
        await preferences.setString("notifitypeimage", message.data['image']);

        await preferences.setString(
            "notifitypename",
            preferences.getString("lang").toString()=="tr"?message.notification!.body
                .toString().split("'")[0]:  message.notification!.body
                .toString()
                .replaceAll("You received a new message from ", "")
                .toString());

        print("preferences.getBool(" "isnotification" ")");
        print(preferences.getBool("isnotification"));
        notiisnotification = true;
        notifitype = message.data['type'];
        notifitypeid = message.data['id'];
        notifitypeimage = message.data['image'];
        notifitypename =  preferences.getString("lang").toString()=="tr"?message.notification!.body
            .toString().split("'")[0]:  message.notification!.body
            .toString()
            .replaceAll("You received a new message from ", "")
            .toString();
        notifitypeRoomData = message.data['room_data'] ?? "";
        print(notifitype);
      }
    },
  );

  FirebaseMessaging.onMessage.listen(
    (message) async {
      print("FirebaseMessaging.onMessage.listen");
      if (message.notification != null) {
        print("message");
        print(message);
        print("message.data");
        print(jsonDecode(jsonEncode(message.data)).toString());
        print(message.data['type']);
        print("message.notification");
        print(message.notification);
        print("message.notification!.title");
        print(message.notification!.title);
        print("message.notification!.body");
        print(message.notification!.body);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        print(prefs.getString("lang").toString());
        String name = prefs.getString("lang").toString()=="tr"?message.notification!.body
            .toString().split("'")[0]:message.notification!.body
            .toString()
            .replaceAll("You received a new message from ", "")
            .toString();
        print("name");
        print(name);
        //print("${message.data}");
        NotificationService.display(message);
      }
    },
  );

  FirebaseMessaging.onMessageOpenedApp.listen(
    (message) async {
      print("FirebaseMessaging.onMessageOpenedApp.listen");
      if (message.notification != null) {
        print(message.notification!.title);
        print(message.notification!.body);
        // print("${message.data['_id']}");

        if (message != null) {
          if (message.notification != null) {
            print(message.notification!.title);
            print(message.notification!.body);
            // print("${message.data['_id']}");

            if (message.data['type'] == "likes_you") {
              Get.to(MessageScreen(index: 1,showIcon: true,));
            }
            if (message.data['type'] == "profile_visitors") {
              SharedPreferences preferences =
                  await SharedPreferences.getInstance();
              ProfileDetailModel? profiledetails;
              if (preferences.getString("accesstoken") != null) {
                profiledetails = await ProfileRepository.profileDetails(
                    preferences.getString("accesstoken").toString());
              }
              if (profiledetails != null) {
                // Get.to(ProfileDetailScreen(
                //   user_id: message.data['id'],
                //   isSelf: false,
                //   isLike: true,
                //   isSearch: false,
                //   startheigh: profiledetails
                //       .data!.userfilterdata!.start_tall_are_you
                //       .toString(),
                //   endheigh: profiledetails
                //       .data!.userfilterdata!.end_tall_are_you
                //       .toString(),
                //   startag:
                //       profiledetails.data!.userfilterdata!.age_from.toString(),
                //   endag: profiledetails.data!.userfilterdata!.age_to.toString(),
                //   religion:
                //       profiledetails.data!.userfilterdata!.religion.toString(),
                //   search: "",
                //   star_sign:
                //       profiledetails.data!.userfilterdata!.star_sign.toString(),
                //   sexual_orientation: profiledetails
                //       .data!.userfilterdata!.sexual_orientation
                //       .toString(),
                //   refresh: "",
                //   feel_about_kids: profiledetails
                //       .data!.userfilterdata!.feel_about_kids
                //       .toString(),
                //   do_you_smoke: profiledetails
                //       .data!.userfilterdata!.do_you_smoke
                //       .toString(),
                //   do_you_drink: profiledetails
                //       .data!.userfilterdata!.do_you_drink
                //       .toString(),
                //   directchatcount: 0,
                //   datewith:
                //       profiledetails.data!.userfilterdata!.date_with.toString(),
                //   education:
                //       profiledetails.data!.userfilterdata!.education.toString(),
                //   have_pets:
                //       profiledetails.data!.userfilterdata!.have_pets.toString(),
                //   isPremium: "",
                //   introvert_or_extrovert: profiledetails
                //       .data!.userfilterdata!.introvert_or_extrovert
                //       .toString(),
                //   looking_fors: profiledetails
                //       .data!.userfilterdata!.looking_fors
                //       .toString(),
                //   languages:
                //       profiledetails.data!.userfilterdata!.languages.toString(),
                //   languageList: profiledetails.data!.userfilterdata!.languages
                //       .toString()
                //       .replaceAll("[", "")
                //       .replaceAll("]", ""),
                //   maritals:
                //       profiledetails.data!.userfilterdata!.maritals.toString(),
                //   profileimage: "",
                //   type: "all",
                //   usertype: profiledetails.data!.user_type,
                //   userIndex: "",
                // ));
                Get.to(MatchProfileDetailScreen(user_id: message.data['id']));
              }
            }
            if (message.data['type'] == "matches") {
              Get.to(MessageScreen(index: 0,showIcon: true,));
            }
            if (message.data['type'] == "messages") {
              SharedPreferences preferences =
                  await SharedPreferences.getInstance();
              ProfileDetailModel? profiledetails;
              if (preferences.getString("accesstoken") != null) {
                profiledetails = await ProfileRepository.profileDetails(
                    preferences.getString("accesstoken").toString());
              }

              if (profiledetails != null) {
                if (profiledetails.data!.user_type != "normal"||profiledetails.data!.user_type == "normal") {
                  if (profiledetails.data!.active_monogamy!) {
                    Get.to(ChatPage(
                        arguments: ChatPageArguments(
                      conversationName: preferences.getString("lang").toString()=="tr"?message.notification!.body
                          .toString().split("'")[0]:   message.notification!.body
                          .toString()
                          .replaceAll("You received a new message from ", "")
                          .toString(),
                      // peerId: docId,
                      //  otherUserId: (dataProvider
                      //      .userChatListModel!.data!
                      //      .elementAt(index)
                      //      .user!
                      //      .id),
                      peerAvatar: profiledetails.data!.profile_image,
                      peerNickname:
                          message.data['room_data'].toString().split(",")[1],
                      otherUserId: int.parse(message.data['id'].toString()),
                      peerId:
                          message.data['room_data'].toString().split(",")[1],
                    )));
                    // Get.to(PeerChatPage(conversationID: message.data['id'], conversationName: profiledetails.data!.active_monogamy_user_name, conversationImage: message.data['image'], senderImage: profiledetails.data!.profile_image));
                  }
                  else {
                    Get.to(ChatPage(
                        arguments: ChatPageArguments(
                      conversationName: preferences.getString("lang").toString()=="tr"?message.notification!.body
                          .toString().split("'")[0]:   message.notification!.body
                          .toString()
                          .replaceAll("You received a new message from ", "")
                          .toString(),
                      // peerId: docId,
                      //  otherUserId: (dataProvider
                      //      .userChatListModel!.data!
                      //      .elementAt(index)
                      //      .user!
                      //      .id),
                      peerAvatar: profiledetails.data!.profile_image,
                      peerNickname:
                          message.data['room_data'].toString().split(",")[1],
                      otherUserId: int.parse(message.data['id'].toString()),
                      peerId:
                          message.data['room_data'].toString().split(",")[1],
                    )));
                  }
                } else {
                  Get.to(Premium_Screen());
                }
              }
            }
          }
        }
      }
    },
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  // iOS requires you run in release mode to test dynamic links ("flutter run --release").
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static Map<int, Color> color = {
    50: Colorss.mainColor.withOpacity(0.05),
    100: Colorss.mainColor.withOpacity(0.10),
    200: Colorss.mainColor.withOpacity(0.20),
    300: Colorss.mainColor.withOpacity(0.30),
    400: Colorss.mainColor.withOpacity(0.40),
    500: Colorss.mainColor.withOpacity(0.50),
    600: Colorss.mainColor.withOpacity(0.60),
    700: Colorss.mainColor.withOpacity(0.70),
    800: Colorss.mainColor.withOpacity(0.80),
    900: Colorss.mainColor.withOpacity(0.90),
  };
  MaterialColor primeColor = MaterialColor(0xFF6B00C3, color);
  SharedPreferences? preferences;
  String lang = "";
  Locale? locale;
  @override
  void initState() {
    FirebaseDynamiclink.initDynamicLink();
    super.initState();
    _notifications();
  }

  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(428, 926),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (_) => AuthProvider()),
                ChangeNotifierProvider(create: (_) => ProfileProvider()),
                ChangeNotifierProvider(create: (_) => QuizProvider()),
                ChangeNotifierProvider(create: (_) => DashboardProvider()),
                ChangeNotifierProvider(create: (_) => SettingProvider()),
                Provider<ChatProvider>(
                  create: (_) => ChatProvider(
                    firebaseFirestore: this.firebaseFirestore,
                    firebaseStorage: this.firebaseStorage,
                  ),
                ),
              ],
              child: ChangeNotifierProvider(
                  create: (context) => LocaleProvider(),
                  builder: (context, child) {
                    final provider = Provider.of<LocaleProvider>(context);
                    return GetMaterialApp(
                      title: 'Moorky',
                      routes: routes,
                      debugShowCheckedModeBanner: false,
                      key: AppConfig.materialKey,
                      theme: ThemeData(
                          primarySwatch: primeColor,
                          unselectedWidgetColor: primeColor),
                      localizationsDelegates: [
                        AppLocalizations.delegate,
                        GlobalMaterialLocalizations.delegate,
                        GlobalCupertinoLocalizations.delegate,
                        GlobalWidgetsLocalizations.delegate,
                      ],
                      supportedLocales: L10n.all,
                      locale: provider.locale,
                      navigatorObservers: [UserModel.shared().routeObserver],
                    );
                  }));
        });
  }
}
