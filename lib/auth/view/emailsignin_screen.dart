import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moorky/auth/provider/authprovider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:moorky/auth/view/forgetpassword_screen.dart';
import 'package:moorky/auth/view/phonelogin_screen.dart';
import 'package:moorky/commanWidget/commanwidget.dart';
import 'package:moorky/constant/color.dart';
import 'package:moorky/dashboardscreen/view/dashboardscreen.dart';
import 'package:moorky/profilecreate/repository/profileRepository.dart';
import 'package:moorky/zegocloud/model/user_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zego_zim/zego_zim.dart';

class EmailSignIn_Screen extends StatefulWidget {
  const EmailSignIn_Screen({Key? key}) : super(key: key);

  @override
  State<EmailSignIn_Screen> createState() => _EmailSignIn_ScreenState();
}

class _EmailSignIn_ScreenState extends State<EmailSignIn_Screen> {
  var _formKey = GlobalKey<FormState>();
  var _scaKey = GlobalKey<ScaffoldState>();
  bool isTrue=false;
  bool isPassword=false;
  bool ispasswordmatch=false;
  bool iseyevisible=false;
  bool isLoad=false;
  bool validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }
  bool validatePassword(String value)
  {
    String pattern =
        ''r'^(?=.*?[A-Za-z])(?=.*?[0-9]).{8,}$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;

  }
  bool _obscureText = true;
  String email="";
  String password="";
  TextEditingController emailController=new TextEditingController();
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
  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);
    return Scaffold(
      key: _scaKey,
      bottomNavigationBar: Container(
        height: 200.h,
        child:  Column(
          children: [
            (isTrue&&isPassword)?!isLoad?InkWell(
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
                  var passwordmodel=await auth.emailsignup(email, password,"signin");
                  if(passwordmodel.statusCode==200)
                  {
                    setState(() {
                      isLoad=false;
                    });
                    preferences!.setString("accesstoken",passwordmodel.data!.accessToken!);
                    String? token = await FirebaseMessaging.instance.getToken();
                    print("my device token");
                    print(token);
                    print("preferences!.getString(""accesstoken"")!");
                    print(preferences!.getString("accesstoken")!);
                   var model=await ProfileRepository.updateProfile(token.toString(),"device_token", preferences!.getString("accesstoken")!);
                    if(model.statusCode==200)
                      {
                        print("dsadsdas${passwordmodel.alreadyRegister}");
                        if(passwordmodel.alreadyRegister!)
                        {
                          try {
                            ZIMUserInfo userInfo = ZIMUserInfo();
                            userInfo.userID=model.data!.id.toString();
                            userInfo.userName=model.data!.name.toString();
                            await ZIM.getInstance()!.login(userInfo);
                            Navigator.of(context).pop;
                            print('success');
                            UserModel.shared().userInfo = userInfo;
                            final prefs = await SharedPreferences.getInstance();
                            await prefs.setString('userID', model.data!.id.toString());
                            await prefs.setString('userName', model.data!.name.toString());
                            preferences!.setString("realphoto","realphoto");
                            Navigator.push(context,
                                MaterialPageRoute(builder:
                                    (context) =>
                                    DashBoardScreen(pageIndex: 1,isNotification: false,)
                                )
                            );

                          } on PlatformException catch (onError) {
                            Navigator.of(context).pop();
                          }

                        }
                        else{
                          Navigator.push(context,
                              MaterialPageRoute(builder:
                                  (context) =>
                                  PhoneLogin_Screen()
                              )
                          );
                          print("asdjasdhvasd");
                          showSnakbar(passwordmodel.message!, context);
                        }
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
              },
              child: Container(
                  height: 70.h,
                  margin: EdgeInsets.only(top: 20.h,left: 25.w,right: 25.w),
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
                  child: addMediumText(AppLocalizations.of(context)!.signin,14,Color(0xFFFFFFFF))
              ),
            ):Container(child: CircularProgressIndicator(),alignment: Alignment.topCenter,):Container(
                height: 70.h,
                margin: EdgeInsets.only(top: 20.h,left: 25.w,right: 25.w),
                decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFFC2A3DD),width: 1.0),

                    borderRadius: BorderRadius.circular(50.r)),
                alignment: Alignment.center,
                child: addMediumText(AppLocalizations.of(context)!.signin,14,Color(0xFFC2A3DD))
            ),
            SizedBox(height: 10.h,),
            GestureDetector(
              onTap: (){
                Get.to(ForgetPassword_Screen());
              },
              child: Text(
                AppLocalizations.of(context)!.forgetpassword,textScaleFactor: 1.0,
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.w700,
                      fontSize: 15.sp,
                      color: Color(0xFF6B18C3)),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width:  MediaQuery.of(context).size.width,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(height: 30,),
                  Container(
                    margin: EdgeInsets.only(bottom: 15.h,left: 25.w,right: 25.w),
                    height: 60.h,
                    decoration: BoxDecoration( borderRadius: BorderRadius.circular(10.0),border: Border.all(color: Color(0xFFEAE0F3),width: 0.5),
                        color: Color(0xFFC2A3DD).withOpacity(0.20)),
                    alignment: Alignment.center,
                    child: TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!.youremail,
                          labelText: AppLocalizations.of(context)!.youremail,
                          labelStyle: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              color: Color(0xFFC2A3DD),
                              fontSize: 18.sp),
                          contentPadding: EdgeInsets.only(left: 10.w),
                          hintStyle: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              color: Color(0xFFC2A3DD),
                              fontSize: 18.sp),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Color(0xFFEAE0F3),width: 0.5)
                          ),
                          border: InputBorder.none
                      ),
                      keyboardType: TextInputType.emailAddress,
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
                          email=value;
                        });
                      },
                      validator: (value){
                        if(value!.isEmpty)
                        {
                          return AppLocalizations.of(context)!.pleaseenteremail;
                        }
                        else if(!validateEmail(value)){
                          return AppLocalizations.of(context)!.plesecorectemail;
                        }
                        else if(value.length>31)
                        {
                          return AppLocalizations.of(context)!.pleaseentermaxium30;
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
                      controller: passwordController,
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!.passwordeight,
                          labelText: AppLocalizations.of(context)!.password,
                          alignLabelWithHint: true,
                          labelStyle: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              color: Color(0xFFC2A3DD),
                              fontSize: 18.sp),
                          hintStyle: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              color: Color(0xFFC2A3DD),
                              fontSize: 18.sp),
                          contentPadding: EdgeInsets.only(left: 10.w),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Color(0xFFEAE0F3),width: 0.5)
                          ),
                          border: InputBorder.none,
                          suffixIcon: Container(
                            width: 60.w,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                isPassword?ispasswordmatch?Container(width:20,height:20,child: SvgPicture.asset("assets/images/passwordchecked.svg",height: 15.h,width: 15.w,fit: BoxFit.scaleDown,)):Container(width:20,height:20,child: SvgPicture.asset("assets/images/passwordalert.svg",height: 20.h,width: 20.w,fit: BoxFit.scaleDown,)):Container(height: 20.h,width: 20.w,),
                                iseyevisible?GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _obscureText = !_obscureText;
                                      });
                                    },
                                    child: Icon(_obscureText ? Icons.visibility : Icons.visibility_off,color: Color(0xFFAB60ED),size: 16,)
                                ):Container(),
                              ],
                            ),
                          )
                      ),
                      keyboardType: TextInputType.text,

                      onChanged: (value){
                        setState(() {
                          if(value.isNotEmpty)
                          {
                            iseyevisible=true;
                          }
                          if(value.isEmpty)
                          {
                            isPassword=false;
                          }
                          else if(value.length>6){
                            isPassword=true;
                          }

                          else{
                            isPassword=false;
                          }
                          if(validatePassword(value)){
                            ispasswordmatch=true;
                          }
                          else{
                            ispasswordmatch=false;
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
            ],
          ),
        ),
      ),
    );
  }
}

