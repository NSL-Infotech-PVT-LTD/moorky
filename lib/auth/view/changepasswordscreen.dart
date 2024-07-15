import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moorky/auth/provider/authprovider.dart';
import 'package:moorky/auth/view/login_screen.dart';
import 'package:moorky/commanWidget/commanwidget.dart';
import 'package:moorky/constant/color.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:moorky/dashboardscreen/homescreen/view/homescreen.dart';
import 'package:moorky/dashboardscreen/provider/dashboardprovider.dart';
import 'package:moorky/lang/provider/locale_provider.dart';
import 'package:moorky/profilecreate/provider/profileprovider.dart';
import 'package:moorky/quizscreens/quizprovider/QuizProvider.dart';
import 'package:moorky/settingscreen/provider/setting_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  var _formKey = GlobalKey<FormState>();
  var _scaKey = GlobalKey<ScaffoldState>();
  bool isTrue=false;
  bool isOldTrue=false;
  bool isConfirmTrue=false;
  bool _obscureText = true;
  bool _oldobscureText = true;
  bool _confirmobscureText = true;
  bool isLoad=false;
  bool validatePassword(String value)
  {
    String pattern =
        ''r'^(?=.*?[A-Za-z])(?=.*?[0-9]).{8,}$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;

  }
  TextEditingController newpasswordController=new TextEditingController();
  TextEditingController confirmpasswordController=new TextEditingController();
  TextEditingController oldpasswordController=new TextEditingController();
  SharedPreferences? preferences;
  String accesstoken="";

  @override
  void initState() {
    Init();
    super.initState();
  }
  prefrenceClear()async{
    await preferences!.clear();
  }

  void Init() async {
    preferences = await SharedPreferences.getInstance();
    if(preferences!.getString("accesstoken")!=null)
      {
        setState(() {
          accesstoken=preferences!.getString("accesstoken").toString();
        });
      }
  }
  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);
    return Scaffold(
      key: _scaKey,
      appBar: AppBar(title: addMediumText(AppLocalizations.of(context)!.changepassword, 18, Colorss.mainColor),centerTitle: true,backgroundColor: Colors.transparent,elevation: 0,leading:
      InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: (){
            Navigator.of(context).pop();
          },
          child: SvgPicture.asset("assets/images/cross.svg",fit: BoxFit.scaleDown,color: Color(0xFf000000),))),
      bottomNavigationBar: !isLoad?(isTrue && isConfirmTrue && isOldTrue)?InkWell(
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: ()async{
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            setState(() {
              isLoad=true;
            });
            if(newpasswordController.text == confirmpasswordController.text)
            {
              var model=await auth.changePassword(oldpasswordController.text,newpasswordController.text,confirmpasswordController.text,accesstoken);
              if(model.statusCode == 200)
              {
                setState(() {
                  isLoad=false;
                });
                showSnakbar(model.message!, context);
                var profileprovider=Provider.of<ProfileProvider>(context,listen: false);
                var settingprovider=Provider.of<SettingProvider>(context,listen: false);
                var quixprovider=Provider.of<QuizProvider>(context,listen: false);
                var dashboardprovider=Provider.of<DashboardProvider>(context,listen: false);
                var localprovider=Provider.of<LocaleProvider>(context,listen: false);

                profileprovider.resetallprofilelist();
                settingprovider.resetallsettinglist();
                dashboardprovider.resetalldashboardlist();
                quixprovider.resetAllquizlist();
                localprovider.changeLocaleSettings("");
                username="";
                prefrenceClear();
                DashboardProvider dashboardProvider=Provider.of<DashboardProvider>(context,listen: false);
              dashboardProvider.clearShowCase();
                Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route route) => false);
                setState(() {
                  role="";
                  socialrole="";
                });
              }
              else{
                setState(() {
                  isLoad=false;
                });
                showSnakbar(model.message!, context);
              }

            }
            else{
              setState(() {
                isLoad=false;
              });
              showSnakbar(AppLocalizations.of(context)!.passworddoesnotmathc, context);
            }

          }

        },
        child: Container(
            height: 70.h,
            margin: EdgeInsets.only(left: 25.w,right: 25.w,bottom: 120.h),
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
            child: addMediumText(AppLocalizations.of(context)!.submit, 14, Color(0xFFFFFFFF))
        ),
      ):
      Container(
          height: 70.h,
          margin: EdgeInsets.only(top: 90.h,left: 25.w,right: 25.w,bottom: 120.h),
          decoration: BoxDecoration(
              border: Border.all(color: Color(0xFFC2A3DD),width: 1.0),

              borderRadius: BorderRadius.circular(50.r)),
          alignment: Alignment.center,
          child: addMediumText(AppLocalizations.of(context)!.submit, 14, Color(0xFFC2A3DD))
      ):Container(
        height: 70.h,
        margin: EdgeInsets.only(top: 90.h,left: 25.w,right: 25.w,bottom: 120.h),
        child: CircularProgressIndicator(),alignment: Alignment.topCenter,),
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: Container(
            child: Column(
              children: [
                SizedBox(height: 30,),
                Container(
                  margin: EdgeInsets.only(bottom: 15.h,left: 25.w,right: 25.w),
                  height: 60.h,
                  decoration: BoxDecoration( borderRadius: BorderRadius.circular(10.0),border: Border.all(color: Color(0xFFEAE0F3),width: 0.5),
                      color: Color(0xFFC2A3DD).withOpacity(0.20)),
                  alignment: Alignment.center,
                  child: TextFormField(
                    controller: oldpasswordController,
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.oldpassword,
                      labelText: AppLocalizations.of(context)!.oldpassword,
                      contentPadding: EdgeInsets.only(left: 10.w),
                      hintStyle: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          color: Color(0xFFC2A3DD),
                          fontSize: 18.sp),
                      labelStyle: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          color: Color(0xFFC2A3DD),
                          fontSize: 18.sp),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Color(0xFFEAE0F3),width: 0.5)
                      ),
                      border: InputBorder.none,
                      suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _oldobscureText = !_oldobscureText;
                            });
                          },
                          child: Icon(_oldobscureText ? Icons.visibility : Icons.visibility_off,color: Color(0xFFAB60ED),size: 16,)
                      ),

                    ),
                    obscureText: _oldobscureText,
                    keyboardType: TextInputType.text,
                    onChanged: (value){
                      setState(() {
                        if(value.isEmpty)
                        {
                          isOldTrue=false;
                        }
                        else if(value.length>6){
                          isOldTrue=true;
                        }
                        else{
                          isOldTrue=false;
                        }
                      });
                    },
                    validator: (value){
                      if(value!.isEmpty)
                      {
                        return AppLocalizations.of(context)!.pleaseenterpassword;
                      }
                      else if(value.length<8)
                      {
                        return AppLocalizations.of(context)!.pleasemimi8digit;
                      }
                      else if(!validatePassword(value)){
                        return AppLocalizations.of(context)!.pleasepasswordshuould;
                      }
                      else if(value.length>32)
                      {
                        return AppLocalizations.of(context)!.pleasemaximum32;
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 15.h,left: 25.w,right: 25.w),
                  height: 60.h,
                  decoration: BoxDecoration( borderRadius: BorderRadius.circular(10.0),border: Border.all(color: Color(0xFFEAE0F3),width: 0.5),
                      color: Color(0xFFC2A3DD).withOpacity(0.20)),
                  alignment: Alignment.center,
                  child: TextFormField(
                    controller: newpasswordController,
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.newpassword,
                      labelText: AppLocalizations.of(context)!.newpassword,
                      contentPadding: EdgeInsets.only(left: 10.w),
                      hintStyle: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          color: Color(0xFFC2A3DD),
                          fontSize: 18.sp),
                      labelStyle: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          color: Color(0xFFC2A3DD),
                          fontSize: 18.sp),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Color(0xFFEAE0F3),width: 0.5)
                      ),
                      border: InputBorder.none,
                      suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                          child: Icon(_obscureText ? Icons.visibility : Icons.visibility_off,color: Color(0xFFAB60ED),size: 16,)
                      ),

                    ),
                    obscureText: _obscureText,
                    keyboardType: TextInputType.text,
                    onChanged: (value){
                      setState(() {
                        if(value.isEmpty)
                        {
                          isTrue=false;
                        }
                        else if(value.length>6){
                          isTrue=true;
                        }
                        else{
                          isTrue=false;
                        }
                      });
                    },
                    validator: (value){
                      if(value!.isEmpty)
                      {
                        return AppLocalizations.of(context)!.pleaseenterpassword;
                      }
                      else if(value.length<8)
                      {
                        return AppLocalizations.of(context)!.pleasemimi8digit;
                      }
                      else if(!validatePassword(value)){
                        return AppLocalizations.of(context)!.pleasepasswordshuould;
                      }
                      else if(value.length>32)
                      {
                        return AppLocalizations.of(context)!.pleasemaximum32;
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 15.h,left: 25.w,right: 25.w),
                  height: 60.h,
                  decoration: BoxDecoration( borderRadius: BorderRadius.circular(10.0),border: Border.all(color: Color(0xFFEAE0F3),width: 0.5),
                      color: Color(0xFFC2A3DD).withOpacity(0.20)),
                  alignment: Alignment.center,
                  child: TextFormField(
                    controller: confirmpasswordController,
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.newpasswordagain,
                      labelText: AppLocalizations.of(context)!.newpasswordagain,
                      contentPadding: EdgeInsets.only(left: 10.w),
                      labelStyle: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          color: Color(0xFFC2A3DD),
                          fontSize: 18.sp),
                      hintStyle: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          color: Color(0xFFC2A3DD),
                          fontSize: 18.sp),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Color(0xFFEAE0F3),width: 0.5)
                      ),
                      border: InputBorder.none,
                      suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _confirmobscureText = !_confirmobscureText;
                            });
                          },
                          child: Icon(_confirmobscureText ? Icons.visibility : Icons.visibility_off,color: Color(0xFFAB60ED),size: 16,)
                      ),
                    ),
                    obscureText: _confirmobscureText,
                    keyboardType: TextInputType.text,
                    onChanged: (value){
                      setState(() {
                        if(value.isEmpty)
                        {
                          isConfirmTrue=false;
                        }
                        else if(value.length>6){
                          isConfirmTrue=true;
                        }
                        else{
                          isConfirmTrue=false;
                        }
                      });
                    },
                    validator: (value){
                      if(value!.isEmpty)
                      {
                        return AppLocalizations.of(context)!.pleaseenterpassword;
                      }
                      else if(value.length<8)
                      {
                        return AppLocalizations.of(context)!.pleasemimi8digit;
                      }
                      else if(!validatePassword(value)){
                        return AppLocalizations.of(context)!.pleasepasswordshuould;
                      }
                      else if(value.length>32)
                      {
                        return AppLocalizations.of(context)!.pleasemaximum32;
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
