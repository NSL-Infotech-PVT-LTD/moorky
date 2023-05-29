import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:moorky/commanWidget/commanwidget.dart';
import 'package:moorky/constant/color.dart';
import 'package:moorky/dashboardscreen/messagescreen/view/chat_screen.dart';
import 'package:moorky/dashboardscreen/view/dashboardscreen.dart';
import 'package:moorky/eventscreen/view/eventscreen.dart';
import 'package:moorky/profilecreate/provider/profileprovider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class HurraySuperMatch_Screen extends StatefulWidget {

  @override
  State<HurraySuperMatch_Screen> createState() => _HurraySuperMatch_ScreenState();
}

class _HurraySuperMatch_ScreenState extends State<HurraySuperMatch_Screen> {
  String profileImage="";
  String anotheruserImage="";
  String anotheruserId="";
  String anotherusername="";
  @override
  void initState() {
    var profileprovider = Provider.of<ProfileProvider>(context, listen: false);
    print("hurreeee");
    print(profileprovider.profileImage);
    setState(() {
      profileImage=profileprovider.profileImage;
      anotheruserImage=profileprovider.anotheruserImage;
      anotheruserId=profileprovider.anotheruserID;
      anotherusername=profileprovider.anotheruserName;
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 170.h,
        alignment: Alignment.bottomCenter,
        margin: EdgeInsets.only(bottom: 15.h),
        child: Column(
          children: [
            GestureDetector(
              onTap: (){
                print(anotherusername);
                print("anotherusername");
                Get.to(Chat(anotherUserId: anotherUserId, username: anotherusername,userimage: profileImage,secondaryUserimage: anotheruserImage,));
              },
                child: SvgPicture.asset("assets/images/superchat.svg",fit: BoxFit.scaleDown,height: 100.h,width: 100.w,)),
            GestureDetector(
              onTap: (){
                Get.off(DashBoardScreen(pageIndex: 1,isNotification: false,));
              },
                child: addRegularText(AppLocalizations.of(context)!.keepswiping, 16, Colorss.mainColor)),
            SizedBox(height: 20.h,),
            Container(
              height: 8.h,width: 140.w,decoration: BoxDecoration(color: Colorss.mainColor,borderRadius: BorderRadius.circular(25.r)),),
          ],
        ),
      ),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          margin: EdgeInsets.all(30),
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 40.h,),
                    addBoldText(AppLocalizations.of(context)!.hurray, 20, Colorss.mainColor),
                    SizedBox(height: 10.h,),
                    addRegularText(AppLocalizations.of(context)!.itsasupermatch, 16, Colorss.mainColor),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                  height: 170.h,
                  width: 170.w,
                      margin: EdgeInsets.only(top: 160.h),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(profileImage),
                        backgroundColor: Colors.white,
                      ),
                    ),
                    Container(
                      height: 170.h,
                      width: 170.w,
                      margin: EdgeInsets.only(top:80.h,bottom: 80.h),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(anotheruserImage),
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 200.h,
                  width: 120.w,
                  margin: EdgeInsets.only(top: 50.h),
                  child: Image.asset("assets/images/superlike.png"),
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}
