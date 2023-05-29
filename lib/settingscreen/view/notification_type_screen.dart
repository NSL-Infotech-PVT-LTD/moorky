
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:moorky/commanWidget/commanwidget.dart';
import 'package:moorky/constant/color.dart';
import 'package:moorky/dashboardscreen/provider/dashboardprovider.dart';
import 'package:moorky/dashboardscreen/view/dashboardscreen.dart';
import 'package:moorky/premiumscreen/view/premiumscreen.dart';
import 'package:moorky/settingscreen/model/notificationextenstion.dart';
import 'package:moorky/settingscreen/provider/setting_provider.dart';
import 'package:moorky/settingscreen/repository/setting_repository.dart';
import 'package:moorky/settingscreen/view/notification_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Notification_Type_Screen extends StatefulWidget {
  const Notification_Type_Screen({Key? key}) : super(key: key);

  @override
  State<Notification_Type_Screen> createState() => _Notification_Type_ScreenState();
}

class _Notification_Type_ScreenState extends State<Notification_Type_Screen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: addMediumText(AppLocalizations.of(context)!.notificatin, 18, Colorss.mainColor),
        centerTitle: true,
        backgroundColor: Color(0xFFFAFAFA),
        elevation: 0.0,
        leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: SvgPicture.asset(
              "assets/images/arrowback.svg",
              fit: BoxFit.scaleDown,
              color: Colorss.mainColor,
            )),

      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.all(20.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(color: Color(0xFFF3F3F3),height: 1,thickness: 1.5,),
              InkWell(
                onTap: (){
                  var profileprovider=Provider.of<SettingProvider>(context,listen: false);
                  profileprovider.resetStreams();
                  Get.to(Notification_Screen(notificationtype: "messages",));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        addLightText(AppLocalizations.of(context)!.message, 19.sp, Colorss.mainColor),
                        Container(
                          width: MediaQuery.of(context).size.width*0.70,
                          child: addMediumText(AppLocalizations.of(context)!.getupdatenewmessage, 15.sp, Color(0xFFB6B6B6)),
                        )
                      ],
                    ),
                    Icon(Icons.arrow_forward_ios,size: 16,color: Colorss.mainColor,)
                  ],
                ),
              ),
              SizedBox(height: 5,),
              Divider(color: Color(0xFFF3F3F3),height: 1,thickness: 1.5,),
              SizedBox(height:15),
              InkWell(
                onTap: (){
                  var profileprovider=Provider.of<SettingProvider>(context,listen: false);
                  profileprovider.resetStreams();
                  Get.to(Notification_Screen(notificationtype: "matches",));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        addLightText(AppLocalizations.of(context)!.matches, 19.sp, Colorss.mainColor),
                        Container(
                          width: MediaQuery.of(context).size.width*0.70,
                          child: addMediumText(AppLocalizations.of(context)!.getupdatematch, 15.sp, Color(0xFFB6B6B6)),
                        )
                      ],
                    ),
                    Icon(Icons.arrow_forward_ios,size: 16,color: Colorss.mainColor,)
                  ],
                ),
              ),
              SizedBox(height: 5,),
              Divider(color: Color(0xFFF3F3F3),height: 1,thickness: 1.5,),
              SizedBox(height:15),
              InkWell(
                onTap: (){
                  var profileprovider=Provider.of<SettingProvider>(context,listen: false);
                  profileprovider.resetStreams();
                  Get.to(Notification_Screen(notificationtype: "likes_you",));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        addLightText(AppLocalizations.of(context)!.likedyou, 19.sp, Colorss.mainColor),
                        Container(
                          width: MediaQuery.of(context).size.width*0.70,
                          child: addMediumText(AppLocalizations.of(context)!.getupdatesaboutlikeyou, 15.sp, Color(0xFFB6B6B6)),
                        )
                      ],
                    ),
                    Icon(Icons.arrow_forward_ios,size: 16,color: Colorss.mainColor,)
                  ],
                ),
              ),
              SizedBox(height: 5,),
              Divider(color: Color(0xFFF3F3F3),height: 1,thickness: 1.5,),
              SizedBox(height:15),
              InkWell(
                onTap: (){
                  var profileprovider=Provider.of<SettingProvider>(context,listen: false);
                  profileprovider.resetStreams();
                  Get.to(Notification_Screen(notificationtype: "profile_visitors",));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        addLightText(AppLocalizations.of(context)!.profilevisitor, 19.sp, Colorss.mainColor),
                        Container(
                          width: MediaQuery.of(context).size.width*0.70,
                          child: addMediumText(AppLocalizations.of(context)!.getuodatevisityourprofile, 15.sp, Color(0xFFB6B6B6)),
                        )
                      ],
                    ),
                    Icon(Icons.arrow_forward_ios,size: 16,color: Colorss.mainColor,)
                  ],
                ),
              ),
              // SizedBox(height: 5,),
              // Divider(color: Color(0xFFF3F3F3),height: 1,thickness: 1.5,),
              // SizedBox(height:15),
              // InkWell(
              //   onTap: (){
              //     var profileprovider=Provider.of<SettingProvider>(context,listen: false);
              //     profileprovider.resetStreams();
              //     Get.to(Notification_Screen(notificationtype: "profile_tips_promos",));
              //   },
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           addLightText("Profile tips, promos", 19.sp, Colorss.mainColor),
              //           Container(
              //             width: MediaQuery.of(context).size.width*0.70,
              //             child: addMediumText("Get profile tips and updates about promos", 15.sp, Color(0xFFB6B6B6)),
              //           )
              //         ],
              //       ),
              //       Icon(Icons.arrow_forward_ios,size: 16,color: Colorss.mainColor,)
              //     ],
              //   ),
              // ),
              // SizedBox(height: 5,),
              // Divider(color: Color(0xFFF3F3F3),height: 1,thickness: 1.5,),
              // SizedBox(height:15),
              // InkWell(
              //   onTap: (){
              //     var profileprovider=Provider.of<SettingProvider>(context,listen: false);
              //     profileprovider.resetStreams();
              //     Get.to(Notification_Screen(notificationtype: "research_and_surveys",));
              //   },
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           addLightText("Research and surveys", 19.sp, Colorss.mainColor),
              //           Container(
              //             width: MediaQuery.of(context).size.width*0.70,
              //             child: addMediumText("Keep up to date with paid and non-paid research opportunities and share your opinions on how to improve", 15.sp, Color(0xFFB6B6B6)),
              //           )
              //         ],
              //       ),
              //       Icon(Icons.arrow_forward_ios,size: 16,color: Colorss.mainColor,)
              //     ],
              //   ),
              // ),
              SizedBox(height: 5,),
              Divider(color: Color(0xFFF3F3F3),height: 1,thickness: 1.5,),
              SizedBox(height:15),
            ],
          ),
        ),
      ),
    );
  }
}
