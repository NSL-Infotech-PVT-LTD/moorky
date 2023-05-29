import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moorky/auth/view/forgetpassword_screen.dart';
import 'package:moorky/auth/view/resetpassword_screen.dart';
import 'package:moorky/constant/color.dart';
import 'package:moorky/dashboardscreen/messagescreen/view/hurraysupermatch_screen.dart';
import 'package:moorky/dashboardscreen/messagescreen/view/useractivity_screen.dart';
import 'package:moorky/dashboardscreen/messagescreen/view/usermessage_screen.dart';
import 'package:moorky/dashboardscreen/messagescreen/view/usersearchScreen.dart';
import 'package:moorky/dashboardscreen/provider/dashboardprovider.dart';
import 'package:moorky/dashboardscreen/repository/dashboardrepository.dart';
import 'package:moorky/dashboardscreen/view/dashboardscreen.dart';
import 'package:moorky/profilecreate/provider/profileprovider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class Debouncer {
  int? milliseconds;
  VoidCallback? action;
  Timer? timer;

  run(VoidCallback action) {
    if (null != timer) {
      timer!.cancel();
    }
    timer = Timer(
      Duration(milliseconds: Duration.millisecondsPerSecond),
      action,
    );
  }
}
class MessageScreen extends StatefulWidget {
  int index=0;
  MessageScreen({required this.index});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {

  SharedPreferences? preferences;
  // bool typing = false;
  // String searchuserchat="";
  @override
  void initState() {
    Init();
    super.initState();
  }

  void Init() async {
    preferences = await SharedPreferences.getInstance();
    var profileprovider = Provider.of<ProfileProvider>(context, listen: false);
    profileprovider.resetStreams();
    if (preferences!.getString("accesstoken") != null) {
      print("hello2");
      profileprovider.fetchProfileDetails(
          preferences!.getString("accesstoken").toString());
      print("hello25");
      print(profileprovider.profileImage);
    }
  }
  final _debouncer = Debouncer();


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: widget.index,
        length: 2,
        child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,elevation: 0,
          leadingWidth: 0,
          toolbarHeight: 0,
          // title: typing ? Container(
          //   alignment: Alignment.centerLeft,
          //   color: Colors.white,
          //   child: TextField(
          //     onChanged: (value){
          //       _debouncer.run(() {
          //         setState(() {
          //           searchuserchat=value;
          //           var dashboardprovider=Provider.of<DashboardProvider>(context,listen: false);
          //           dashboardprovider.resetSearchUser();
          //           dashboardprovider.fetchSearchUserList(preferences!.getString("accesstoken").toString(),searchuserchat,"all");
          //         });
          //       });
          //
          //     },
          //     onSubmitted: (value){
          //       setState(() {
          //         searchuserchat=value;
          //         var dashboardprovider=Provider.of<DashboardProvider>(context,listen: false);
          //         dashboardprovider.resetSearchUser();
          //         dashboardprovider.fetchSearchUserList(preferences!.getString("accesstoken").toString(),searchuserchat,"all");
          //       });
          //     },
          //     keyboardType: TextInputType.phone,
          //     decoration:
          //     InputDecoration(border: InputBorder.none, hintText: AppLocalizations.of(context)!.searchbyuserid),
          //   ),
          // ) : Text(""),
          bottom: TabBar(
            unselectedLabelColor: Color(0xFFAB60ED),
            indicatorColor: Color(0xFFAB60ED),
            labelColor: Color(0xFF6B18C3),
            labelStyle: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.w500)),
            labelPadding: EdgeInsets.zero,
            tabs: [
              //searchuserchat==""?Tab(text: AppLocalizations.of(context)!.message,):Tab(text: AppLocalizations.of(context)!.search,),
             Tab(text: AppLocalizations.of(context)!.message,),
              Tab(text: AppLocalizations.of(context)!.activity,),
            ],
          ),
          // actions: [
          //   IconButton(onPressed: (){
          //     var profilepro=Provider.of<ProfileProvider>(context,listen: false);
          //     if(!profilepro.activemonogomy)
          //       {
          //         setState(() {
          //           typing = !typing;
          //         });
          //       }
          //   },padding: EdgeInsets.only(right: 10.w), icon: SvgPicture.asset("assets/images/search.svg"))
          // ],
        ),
    body: GestureDetector(
      // onTap: (){
      //   if(typing)
      //     {
      //       if(searchuserchat=="")
      //         {
      //           setState(() {
      //             typing = !typing;
      //           });
      //         }
      //     }
      // },
      child: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        children: [
          //searchuserchat==""?UserMessage_Screen():UserSearch_Screen(),
          UserMessage_Screen(),
          UserActivity_Screen()
        ],
      ),
    ),
        )
    );
  }
}

