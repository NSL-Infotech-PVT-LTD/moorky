import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moorky/auth/view/password_screen.dart';
import 'package:moorky/commanWidget/commanwidget.dart';
import 'package:moorky/lang/provider/locale_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'martialstatusscreen.dart';
import 'photoscreen.dart';
import 'package:moorky/constant/color.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class DatesScreen extends StatefulWidget {
  @override
  State<DatesScreen> createState() => _DatesScreenState();
}

class _DatesScreenState extends State<DatesScreen> {
  bool ismen=false;
  bool iswomen=false;
  bool iseveryone=false;
  SharedPreferences? preferences;
  @override
  void initState() {
    Init();
    super.initState();
  }
  void Init()async{
    preferences=await SharedPreferences.getInstance();
    var localprovider=Provider.of<LocaleProvider>(context,listen: false);
    localprovider.getLocaleFromSettings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(title: addMediumText(AppLocalizations.of(context)!.datewith, 18, Colorss.mainColor),centerTitle: true,backgroundColor: Colors.transparent,elevation: 0,leading:
      InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: (){
            Navigator.of(context).pop();
          },
          child: SvgPicture.asset("assets/images/arrowback.svg",fit: BoxFit.scaleDown,))),
      bottomNavigationBar: Container(
        height: 180.h,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: Column(
            children: [
              (ismen||iswomen||iseveryone)?InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: (){
                  if(ismen)
                  {
                    preferences!.setString("datewith","Man");
                    preferences!.setString("datewithid","0");
                    Navigator.push(context,
                        MaterialPageRoute(builder:
                            (context) =>
                                MaritalStatus(isEdit: false,maritalStatus: "",)
                        )
                    );
                  }
                  else if(iswomen)
                  {
                    preferences!.setString("datewith","Woman");
                    preferences!.setString("datewithid","1");
                    Navigator.push(context,
                        MaterialPageRoute(builder:
                            (context) =>
                                MaritalStatus(isEdit: false,maritalStatus: "",)
                        )
                    );
                  }
                  else if(iseveryone)
                  {
                    preferences!.setString("datewith","Everyone");
                    preferences!.setString("datewithid","2");
                    Navigator.push(context,
                        MaterialPageRoute(builder:
                            (context) =>
                                MaritalStatus(isEdit: false,maritalStatus: "",)
                        )
                    );
                  }
                },
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
                  child: addMediumText(AppLocalizations.of(context)!.continues, 14, Color(0xFFFFFFFF))
                ),
              ):Container(
                height: 70.h,
                margin: EdgeInsets.only(left: 25.w,right: 25.w),
                decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFFC2A3DD),width: 1.0),

                    borderRadius: BorderRadius.circular(50.r)),
                alignment: Alignment.center,
                child: addMediumText(AppLocalizations.of(context)!.continues, 14, Color(0xFFC2A3DD))
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
                      height: 8.h,width: 140.w,),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 25.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 100.h,),
            Row(
              children: [
                Expanded(child: Stack(
                  children: [
                    InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: (){
                        setState(() {
                          ismen=true;
                          iswomen=false;
                          iseveryone=false;
                        });
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width*0.30,
                        color: Colors.white,
                        height: 110,child: Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),

                        elevation: 0.5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset("assets/images/men.svg"),
                            SizedBox(height: 10.h,),
                            addLightText(AppLocalizations.of(context)!.man, 12, Color(0xFF3B4C68))
                          ],
                        ),
                      ),),
                    ),
                    ismen?Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: EdgeInsets.only(top: 10,right: 10),
                        child: Container(
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(40.r),color: Color(0xFFFF7869),),
                          child: Icon(Icons.check,color: Color(0xFFFFFFFF),size: 12,),
                        ),
                      ),
                    ):Container()
                  ],
                ),flex: 1,),
                Expanded(child: Stack(
                  children: [
                    InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: (){
                        setState(() {
                          ismen=false;
                          iswomen=true;
                          iseveryone=false;
                        });
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width*0.30,
                        color: Colors.white,
                        height: 110,child: Card(
                        color: Color(0xFFF4F8FC),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        elevation: 0.5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset("assets/images/women.svg"),
                            SizedBox(height: 10.h,),
                            addLightText(AppLocalizations.of(context)!.woman, 12, Color(0xFF3B4C68))
                          ],
                        ),
                      ),),
                    ),
                    iswomen?Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: EdgeInsets.only(top: 10,right: 10),
                        child: Container(
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(40.r),color: Color(0xFFFF7869),),
                          child: Icon(Icons.check,color: Color(0xFFFFFFFF),size: 12,),
                        ),
                      ),
                    ):Container()
                  ],
                ),flex: 1,),
                Expanded(child: Stack(
                  children: [
                    InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: (){
                        setState(() {
                          ismen=false;
                          iswomen=false;
                          iseveryone=true;
                        });
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width*0.30,
                        color: Colors.white,
                        height: 110,child: Card(
                        color: Color(0xFFF4F8FC),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        elevation: 0.5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset("assets/images/everyone.svg"),
                            SizedBox(height: 10.h,),
                            addLightText(AppLocalizations.of(context)!.everyone, 12, Color(0xFF3B4C68))
                          ],
                        ),
                      ),),
                    ),
                    iseveryone?Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: EdgeInsets.only(top: 10,right: 10),
                        child: Container(
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(40.r),color: Color(0xFFFF7869),),
                          child: Icon(Icons.check,color: Color(0xFFFFFFFF),size: 12,),
                        ),
                      ),
                    ):Container()
                  ],
                ),flex: 1,),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
