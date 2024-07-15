import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moorky/commanWidget/commanwidget.dart';
import 'package:moorky/profilecreate/provider/profileprovider.dart';
import 'package:moorky/profilecreate/repository/profileRepository.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../lang/provider/locale_provider.dart';
import 'datesscreen.dart';
import 'namescreen.dart';
import 'package:moorky/constant/color.dart';
class GenderScreen extends StatefulWidget {
  String gender="";
  bool isEdit=false;
  bool showGender=false;
  GenderScreen({required this.gender,required this.isEdit,required this.showGender});
  @override
  State<GenderScreen> createState() => _GenderScreenState();
}

class _GenderScreenState extends State<GenderScreen> {
  bool ismen=false;
  bool iswomen=false;
  bool iseveryone=false;
  SharedPreferences? preferences;
  var _scaKey = GlobalKey<ScaffoldState>();
  bool isLoad=false;
  @override
  void initState() {
    Init();
    super.initState();
  }
  void Init()async{
    preferences=await SharedPreferences.getInstance();
    var localprovider=Provider.of<LocaleProvider>(context,listen: false);
    localprovider.getLocaleFromSettings();
    if(widget.gender=="Man")
      {
        setState(() {
          ismen=true;
        });
      }
    else if(widget.gender=="Woman")
      {
        setState(() {
          iswomen=true;
        });
      }
    else if(widget.gender=="Neutral"){
      setState(() {
        iseveryone=true;
      });
    }
    preferences!.setInt("showgender", 0);
  }

  @override
  Widget build(BuildContext context) {
    // print(ismen);
    // print(iswomen);
    // print(iseveryone);
    return Scaffold(
      key: _scaKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(title:addMediumText(AppLocalizations.of(context)!.gender, 18, Colorss.mainColor),centerTitle: true,backgroundColor: Colors.transparent,elevation: 0,leading:
      InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: (){
            Navigator.of(context).pop();
          },
          child: SvgPicture.asset("assets/images/arrowback.svg",fit: BoxFit.scaleDown,)),),
      bottomNavigationBar: Container(
        height: 180.h,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: Column(
            children: [
              widget.isEdit?!isLoad?InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: ()async{
                  setState(() {
                    isLoad=true;
                  });
                  if(ismen)
                  {
                    preferences!.setString("gender","Man");
                  }
                  else if(iswomen)
                  {
                    preferences!.setString("gender","Woman");
                  }
                  else if(iseveryone)
                  {
                    preferences!.setString("gender","Neutral");
                  }

                  var model=await ProfileRepository.updateProfile(preferences!.getString("gender").toString(), "gender", preferences!.getString("accesstoken")!);
                  if(model.statusCode==200)
                  {
                    setState(() {
                      isLoad=false;
                    });
                    var provider=await Provider.of<ProfileProvider>(context,listen: false);
                    provider.adddetails(model);
                    Navigator.of(context).pop();
                  }
                  else if(model.statusCode==422){
                    setState(() {
                      isLoad=false;
                    });
                     showSnakbar(model.message!, context);
                  }
                  else {
                    setState(() {
                      isLoad=false;
                    });
                     showSnakbar(model.message!, context);
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
                    child: addMediumText(AppLocalizations.of(context)!.update, 14, Color(0xFFffffff))
                ),
              ):Container(child: CircularProgressIndicator(),alignment: Alignment.topCenter,):(ismen||iswomen||iseveryone)?InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: (){
                  if(ismen)
                    {
                      preferences!.setString("gender","Man");
                      preferences!.setString("genderid","0");
                      Navigator.push(context,
                          MaterialPageRoute(builder:
                              (context) =>
                              DatesScreen()
                          )
                      );
                    }
                  else if(iswomen)
                    {
                      preferences!.setString("gender","Woman");
                      preferences!.setString("genderid","1");
                      Navigator.push(context,
                          MaterialPageRoute(builder:
                              (context) =>
                              DatesScreen()
                          )
                      );
                    }
                  else if(iseveryone)
                    {
                      preferences!.setString("gender","Neutral");
                      preferences!.setString("genderid","2");
                      Navigator.push(context,
                          MaterialPageRoute(builder:
                              (context) =>
                              DatesScreen()
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
                )):Container(
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
        padding: EdgeInsets.symmetric(horizontal: 25.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 35.h,),
            addBoldText(AppLocalizations.of(context)!.describeyourself, 14, Color(0xFF6B00C3)),
            SizedBox(height: 30.h,),
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
                          widget.gender="Man";
                        });
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width*0.30,
                        color: Colors.white,
                        height: 110,child: Card(
                        elevation: 0.5,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
                          widget.gender="Woman";
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
                          widget.gender="Neutral";
                        });
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width*0.30,
                        color: Colors.white,
                        height: 110,child: Card(
                        elevation: 0.5,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        color: Color(0xFFF4F8FC),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset("assets/images/everyone.svg"),
                            SizedBox(height: 10.h,),
                            addLightText(AppLocalizations.of(context)!.neutral, 12, Color(0xFF3B4C68))
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
            SizedBox(height: 45.h,),
            Row(
              children: [
                Container(
                  height: 20.h,
                  width: 20.w,
                  child: Checkbox(
                    tristate: false,
                    value: widget.showGender, onChanged: (bool? value) {
                      setState(() {
                        widget.showGender=value!;
                        if(widget.showGender)
                          {
                            preferences!.setInt("showgender", 1);
                          }
                        else{
                          preferences!.setInt("showgender", 0);
                        }
                      });
                  },
                  ),
                ),
                SizedBox(width: 15.w,),
                addLightText(AppLocalizations.of(context)!.showmygender, 12, Color(0xFF15294B))
              ],
            )
          ],
        ),
      ),
    );
  }
}
