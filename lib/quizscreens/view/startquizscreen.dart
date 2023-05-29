import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:moorky/commanWidget/commanwidget.dart';
import 'package:moorky/constant/color.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:moorky/dashboardscreen/messagescreen/view/ghostmode_screen.dart';
import 'package:moorky/dashboardscreen/view/dashboardscreen.dart';
import 'package:moorky/profilecreate/repository/profileRepository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../profilecreate/view/datesscreen.dart';
import 'sexualorientationscreen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class StartQuizScreen extends StatefulWidget {
  bool isGhostMode=false;
  StartQuizScreen({required this.isGhostMode});
  @override
  State<StartQuizScreen> createState() => _StartQuizScreenState();
}
class _StartQuizScreenState extends State<StartQuizScreen> {
  SharedPreferences? preferences;
  @override
  void initState() {
    Init();
    super.initState();
  }

  void Init() async {
    preferences = await SharedPreferences.getInstance();
  }
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
  @override
  Widget build(BuildContext context) {

    return WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,

        children: [
          InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: (){
              Navigator.push(context,
                  MaterialPageRoute(builder:
                      (context) =>
                      SexualOrientation(isEdit: false,sexualtext: "",back: false,)
                  )
              );
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: Container(
                height: 70.h,
                margin: EdgeInsets.only(left: 25.w,right: 25.w),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: <Color>[
                        Color(0xFF570084),
                        Color(0xFFA33BE5)
                      ],
                    ),
                    borderRadius: BorderRadius.circular(50.r)),
                alignment: Alignment.center,
                child: addMediumText(AppLocalizations.of(context)!.startquiz, 14, Color(0xFFFFFFFF))
              ),
            ),
          ),
          SizedBox(height: 10.h,),
          GestureDetector(
            onTap: ()async{
              if(widget.isGhostMode)
                {
                  String usertype="";
                  if(preferences!.getString("usertype") != null)
                    {
                      usertype=preferences!.getString("usertype")!.toString();
                      print("usertype");
                      print(usertype);
                    }
                  if(usertype=="basic"||usertype=="premium")
                    {
                      print("usertype====");
                      print(usertype);
                      Navigator.push(context,
                          MaterialPageRoute(builder:
                              (context) =>
                              GhostMode_Screen(isskip: true,usertype: usertype,)
                          )
                      );
                    }
                  else{
                    var ghostprofile=await ProfileRepository.updateProfile("1", "ghost_profile", preferences!.getString("accesstoken")!);
                    if(ghostprofile.statusCode==200)
                    {
                      preferences!.setString("realphoto", "realphoto");
                      Get.to(DashBoardScreen(pageIndex: 1,isNotification: false,));
                    }
                  }
                }
              else{
                preferences!.setString("realphoto","realphoto");
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder:
                        (context) =>
                        DashBoardScreen(pageIndex: 1,isNotification: false,)
                    )
                );
              }


            },
            child: addLightText(AppLocalizations.of(context)!.maybelater, 14, Color(0xFF000000))
          ),
          Container(
            alignment: Alignment.bottomCenter,
            margin: EdgeInsets.only(bottom: 15.h,top: 30.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset("assets/images/moorky2.png",height: 45.h,width: 150.w,),
                SizedBox(height: 5.h,),
                Container(
                  height: 8.h,width: 140.w,decoration: BoxDecoration(color: Color(0xFF751ACD),borderRadius: BorderRadius.circular(25.r)),),
              ],
            ),
          ),
        ],
      ),
      appBar: AppBar(backgroundColor: Colors.transparent,elevation: 0),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20.h,),
              addSemiBoldCenterText(AppLocalizations.of(context)!.wouldgivemoredetails, 18, Colorss.mainColor),
              SizedBox(height: 20.h,),
              SizedBox(
                height: 320.h,
                child: SvgPicture.asset("assets/images/loveprinter.svg",fit: BoxFit.scaleDown,),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
