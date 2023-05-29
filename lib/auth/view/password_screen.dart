import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moorky/accountcreatedscreen/view/accountcreatedscreen.dart';
import 'package:moorky/auth/provider/authprovider.dart';
import 'package:moorky/auth/view/password_screen.dart';
import 'package:moorky/auth/view/phonelogin_screen.dart';
import 'package:moorky/commanWidget/commanwidget.dart';
import 'package:moorky/constant/color.dart';
import 'package:moorky/dashboardscreen/view/dashboardscreen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_screen.dart';
class PasswordScreen extends StatefulWidget {
  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  bool _obscureText = true;
  String password="";
  var _formKey = GlobalKey<FormState>();
  var _scaKey = GlobalKey<ScaffoldState>();
  bool isTrue=false;
  bool isLoad=false;
  TextEditingController passwordController=new TextEditingController();
  SharedPreferences? preferences;
  @override
  void initState() {
    Init();
    super.initState();
  }
  void Init()async{
    preferences=await SharedPreferences.getInstance();
  }
  bool validatePassword(String value)
  {
    String pattern =
        ''r'^(?=.*?[A-Za-z])(?=.*?[0-9]).{8,}$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;

  }
  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);
    return Scaffold(
      key: _scaKey,
      backgroundColor: Colors.white,
      appBar: AppBar(title:  addMediumText(AppLocalizations.of(context)!.password, 18, Colorss.mainColor,),centerTitle: true,backgroundColor: Colors.transparent,elevation: 0,leading: InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
        onTap: (){
          Navigator.of(context).pop();
        },
          child: SvgPicture.asset("assets/images/arrowback.svg",fit: BoxFit.scaleDown,))),
      body: Form(
        key: _formKey,
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 120.h,),
                    Container(
                      padding: EdgeInsets.only(left: 20.w,right: 60.w),
                      child: addLightText(AppLocalizations.of(context)!.setapassword, 12, Color(0xFF15294B))
                    ),
                    SizedBox(height: 20.h,),
                    Container(
                      padding: EdgeInsets.only(left: 20.w),
                      child: TextFormField(
                        controller: passwordController,
                        style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 16)),
                        textCapitalization: TextCapitalization.sentences,
                        maxLength: 32,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(top: 25.h),
                          isDense: true,
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFC2A3DD)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFC2A3DD)),
                          ),
                          hintText: AppLocalizations.of(context)!.passwordeight,
                          hintStyle: GoogleFonts.poppins(textStyle: TextStyle(color: Color(0xFFC2A3DD),fontSize: 14)),
                          suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                              child: Padding(
                                padding: EdgeInsets.only(top: 15),
                                child: Icon(_obscureText ? Icons.visibility : Icons.visibility_off,color: Colors.grey,),
                              )
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
                            password=value;

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
                Column(
                  children: [
                    isTrue?!isLoad?InkWell(
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
                          if(role=="email")
                            {
                              var passwordmodel=await auth.emailsignup(preferences!.getString("email").toString(), password,"signup");
                              if(passwordmodel.statusCode==200)
                              {
                                setState(() {
                                  isLoad=false;
                                });
                                preferences!.setString("accesstoken",passwordmodel.data!.accessToken!);
                                if(passwordmodel.alreadyRegister!)
                                  {
                                    preferences!.setString("realphoto","realphoto");
                                    Navigator.push(context,
                                        MaterialPageRoute(builder:
                                            (context) =>
                                            DashBoardScreen(pageIndex: 1,isNotification: false,)
                                        )
                                    );
                                  }
                                else{
                                  Navigator.push(context,
                                      MaterialPageRoute(builder:
                                          (context) =>
                                          PhoneLogin_Screen()
                                      )
                                  );
                                }

                              }
                              else if(passwordmodel.statusCode==422){
                                setState(() {
                                  isLoad=false;
                                });
                                showSnakbar(passwordmodel.message!, context);
                              }
                              else {
                                setState(() {
                                  isLoad=false;
                                });
                                showSnakbar(passwordmodel.message!, context);
                              }

                            }
                          else{
                            print("jkfkjdasgfasdf");
                            var passwordmodel=await auth.updatePassword(password, preferences!.getString("accesstoken").toString());
                            if(passwordmodel.statusCode==200)
                            {
                              setState(() {
                                isLoad=false;
                              });
                              if(socialrole=="social")
                              {
                                Navigator.push(context,
                                    MaterialPageRoute(builder:
                                        (context) =>
                                        PhoneLogin_Screen()
                                    )
                                );
                              }
                              else{
                                preferences!.setBool("accountcreated", true);
                                Navigator.push(context,
                                    MaterialPageRoute(builder:
                                        (context) =>
                                        AccountCreatedScreen()
                                    )
                                );
                              }
                            }
                            else if(passwordmodel.statusCode==422){
                              setState(() {
                                isLoad=false;
                              });
                              showSnakbar(passwordmodel.message!, context);
                            }
                            else {
                              setState(() {
                                isLoad=false;
                              });
                              showSnakbar(passwordmodel.message!, context);
                            }
                          }
                        }
                      },
                      child: Container(
                        height: 70.h,
                        margin: EdgeInsets.only(left: 25.w,right: 25.w,bottom: 15.h),
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
                        child: addMediumText(AppLocalizations.of(context)!.continues, 14,Color(0xFFFFFFFF) )
                      ),
                    ):Container(child: CircularProgressIndicator(),alignment: Alignment.topCenter,):Container(
                      height: 70.h,
                      margin: EdgeInsets.only(top: 90.h,left: 25.w,right: 25.w,bottom: 15.h),
                      decoration: BoxDecoration(
                          border: Border.all(color: Color(0xFFC2A3DD),width: 1.0),

                          borderRadius: BorderRadius.circular(50.r)),
                      alignment: Alignment.center,
                      child: addMediumText(AppLocalizations.of(context)!.continues, 14, Color(0xFFC2A3DD))
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 15.h),
                      child: Container(
                        height: 8.h,width: 140.w,decoration: BoxDecoration(color: Colors.black,borderRadius: BorderRadius.circular(25.r)),),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
