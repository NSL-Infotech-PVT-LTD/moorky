import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:moorky/constant/color.dart';
import 'package:moorky/dashboardscreen/campignscreen/view/campignscreen.dart';
import 'package:moorky/dashboardscreen/homescreen/view/homescreen.dart';
import 'package:moorky/dashboardscreen/messagescreen/view/messagescreen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:moorky/eventscreen/view/eventscreen.dart';
import 'package:moorky/premiumscreen/view/premiumscreen.dart';
import 'package:moorky/profilecreate/model/profileDetailsmodel.dart';
import 'package:moorky/profilecreate/provider/profileprovider.dart';
import 'package:moorky/profilecreate/repository/profileRepository.dart';
import 'package:moorky/profiledetailscreen/view/profiledetailscreen.dart';
import 'package:moorky/zegocloud/peer/peer_chat_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';
bool isEvent=false;
bool isChat=false;
String anotherUserId="";
class DashBoardScreen extends StatefulWidget {
  int pageIndex;
  bool isNotification;
  DashBoardScreen({required this.pageIndex,required this.isNotification});
  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}
class _DashBoardScreenState extends State<DashBoardScreen> {
  int pageIndex = 1;
  String ever="";
  Future<bool> _onBackPressed() async{
    return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.areyousure),
          content: Text(AppLocalizations.of(context)!.doyouwantto),
          actions: <Widget>[
            GestureDetector(
              onTap: (){
                Navigator.of(context).pop(false);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(AppLocalizations.of(context)!.no,style: TextStyle(fontSize: 16),),
              ),
            ),
            GestureDetector(
              onTap: (){
                Navigator.of(context).pop(true);
                SystemNavigator.pop();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(AppLocalizations.of(context)!.yes,style: TextStyle(fontSize: 16),),
              ),
            ),
          ],
        );
      },
    );
  }
  final pages = [
    CampignScreen(),
    HomeScreen(),
    MessageScreen(index: 0,),
  ];
  final monogonomypages = [
    CampignScreen(),
    Event_Screen(),
    MessageScreen(index: 0,),
  ];
  SharedPreferences? preferences;

  @override
  void initState() {
    Init();
    super.initState();
  }

  Init() async {
    print("asdasdasd");
    preferences = await SharedPreferences.getInstance();
    var profileprovider = Provider.of<ProfileProvider>(context, listen: false);
    profileprovider.resetStreams();
    //bool isnotification=false;
    if(preferences!.getString("accesstoken")!=null)
    {
      await profileprovider.fetchProfileDetails(
          preferences!.getString("accesstoken").toString());
          if(notiisnotification)
            {
              if(notifitype=="likes_you")
              {
                setState(() {
                  notifitype="";
                  notiisnotification=false;
                });
                // preferences!.setString("notifitype","");
                // preferences!.setBool("isnotification",false);
                Get.to(MessageScreen(index: 1));
              }
              if(notifitype=="profile_visitors"){
                setState(() {
                  notifitype="";
                  notiisnotification=false;
                });
                // preferences!.setString("notifitype","");
                // preferences!.setBool("isnotification",false);
                // Get.to(ProfileDetailScreen(user_id: notifitypeid, isSelf: false, isLike: false, isSearch: false));


                SharedPreferences preferences = await SharedPreferences.getInstance();
                ProfileDetailModel? profiledetails;
                if (preferences.getString("accesstoken") != null) {
                  profiledetails = await ProfileRepository.profileDetails(preferences.getString("accesstoken").toString());
                }
                if(profiledetails != null)
                {
                  Get.to(ProfileDetailScreen(user_id: notifitypeid, isSelf: false, isLike: false, isSearch: false,
                    startheigh: profiledetails.data!.userfilterdata!.start_tall_are_you.toString(),
                    endheigh: profiledetails.data!.userfilterdata!.end_tall_are_you.toString(),
                    startag: profiledetails.data!.userfilterdata!.age_from.toString(),
                    endag: profiledetails.data!.userfilterdata!.age_to.toString(),
                    religion: profiledetails.data!.userfilterdata!.religion.toString(),
                    search: "",
                    star_sign: profiledetails.data!.userfilterdata!.star_sign.toString(),
                    sexual_orientation: profiledetails.data!.userfilterdata!.sexual_orientation.toString(),
                    refresh: "",
                    feel_about_kids: profiledetails.data!.userfilterdata!.feel_about_kids.toString(),
                    do_you_smoke: profiledetails.data!.userfilterdata!.do_you_smoke.toString(),
                    do_you_drink: profiledetails.data!.userfilterdata!.do_you_drink.toString(),
                    directchatcount:0,
                    datewith: profiledetails.data!.userfilterdata!.date_with.toString(),
                    education: profiledetails.data!.userfilterdata!.education.toString(),
                    have_pets: profiledetails.data!.userfilterdata!.have_pets.toString(),
                    isPremium: "",
                    introvert_or_extrovert: profiledetails.data!.userfilterdata!.introvert_or_extrovert.toString(),
                    looking_fors: profiledetails.data!.userfilterdata!.looking_fors.toString(),
                    languages: profiledetails.data!.userfilterdata!.languages.toString(),
                    languageList: profiledetails.data!.userfilterdata!.languages.toString().replaceAll("[", "").replaceAll("]", ""),
                    maritals: profiledetails.data!.userfilterdata!.maritals.toString(),
                    profileimage: "",
                    type: "all",
                    usertype: profiledetails.data!.user_type,
                    userIndex: "",));
                }
              }
              if(notifitype=="matches"){
                setState(() {
                  notifitype="";
                  notiisnotification=false;
                });
                // preferences!.setString("notifitype","");
                // preferences!.setBool("isnotification",false);
                Get.to(DashBoardScreen(pageIndex: 2, isNotification: false));
              }
              if(notifitype=="messages"){
                setState(() {
                  notifitype="";
                  notiisnotification=false;
                });
                // preferences!.setString("notifitype","");
                // preferences!.setBool("isnotification",false);
                if(profileprovider.profiledetails != null)
                {
                  if(profileprovider.profiledetails!.data!.user_type != "normal")
                  {
                    if(profileprovider.profiledetails!.data!.active_monogamy!)
                    {
                      Get.to(PeerChatPage(conversationID: notifitypeid, conversationName: notifitypename, conversationImage: notifitypeimage, senderImage: profileprovider.profiledetails!.data!.profile_image));
                    }
                    else{
                      Get.to(DashBoardScreen(pageIndex: 1,isNotification: false,));
                    }
                  }
                  else{
                    Get.to(Premium_Screen());
                  }
                }


              }
            }
       // }
    }
  }
  Initpre(String usertype)async{
    preferences =await SharedPreferences.getInstance();

    preferences!.setString("usertype", usertype.toString());
    print("preferences!.getString(""usertype"")");
    print(preferences!.getString("usertype"));
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Consumer<ProfileProvider>(
            builder: (context, profileprovider, child) {
              print("hrjhdkdkd${profileprovider.profiledetails?.data?.active_monogamy}");
              if(profileprovider.profiledetails != null)
                {
                  if(profileprovider.profiledetails!.data!.user_plan.toString() !="")
                    {
                      Initpre(profileprovider.profiledetails!.data!.user_plan.toString());
                    }
                  anotherUserId=profileprovider.profiledetails!.data!.active_monogamy_user_id.toString();
                  username=profileprovider.profiledetails!.data!.name.toString();
                }
              return profileprovider.profiledetails?.data != null ?
              !profileprovider.profiledetails!.data!.active_monogamy!
                  ? pages[pageIndex]
                  : monogonomypages[pageIndex] : Center(
                child: CircularProgressIndicator(),);
            }),
        bottomNavigationBar: Container(
          width: MediaQuery.of(context).size.width,
          height: 90.h,
          color: Colors.white.withOpacity(0),
          margin: EdgeInsets.symmetric(horizontal: 30.w,vertical: 10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(icon: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset("assets/images/campaings.svg",fit: BoxFit.scaleDown,height: 47.h,width: 47.w,),
                  pageIndex==0?SizedBox(height: 10.h,):Container(),
                  pageIndex==0?Container(height: 3.h,color: Colorss.mainColor,):Container()
                ],
              ),
                padding: EdgeInsets.zero,
                enableFeedback: false,
                iconSize: 60.r,
                onPressed: (){
                  setState(() {
                    pageIndex = 0;
                  });
              },),
              IconButton(icon: Column(
                children: [
                  Image.asset("assets/images/superlike.png",height: 47.h,width: 47.w,),
                  pageIndex==1?SizedBox(height: 10.h,):Container(),
                  pageIndex==1?Container(height: 3.h,color: Colorss.mainColor,):Container()
                ],
              ),
                enableFeedback: false,
                padding: EdgeInsets.zero,
                iconSize: 60.r,
                onPressed: (){
                  setState(() {
                    pageIndex = 1;
                  });
                },),
              IconButton(icon:
              Column(
                children: [
                  SvgPicture.asset("assets/images/message.svg",fit: BoxFit.scaleDown,height: 47.h,width: 47.w,),
                  pageIndex==2?SizedBox(height: 10.h,):Container(),
                  pageIndex==2?Container(height: 3.h,color: Colorss.mainColor,):Container()
                ],
              ),
                padding: EdgeInsets.zero,
                enableFeedback: false,
                iconSize: 60.r,
                onPressed: (){
                  setState(() {
                    pageIndex = 2;
                  });
                },),
            ],
          ),
        ),
      ),
    );
  }
}
