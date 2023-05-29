import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moorky/auth/view/login_screen.dart';
import 'package:moorky/auth/view/password_screen.dart';
import 'package:moorky/commanWidget/commanwidget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../provider/authprovider.dart';
import 'package:moorky/constant/color.dart';
class EmailScreen extends StatefulWidget {
  @override
  State<EmailScreen> createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {


  SharedPreferences? preferences;
  String email="";
  TextEditingController emailController=new TextEditingController();
  @override
  void initState() {
    Init();
    super.initState();
  }
  void Init()async{
    preferences=await SharedPreferences.getInstance();
  }
  var _formKey = GlobalKey<FormState>();
  var _scaKey = GlobalKey<ScaffoldState>();
  bool isTrue=false;
  bool isLoad=false;
  bool validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }
  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);
    return Scaffold(
      key: _scaKey,
      backgroundColor: Colors.white,
      appBar: AppBar(title:  addMediumText(AppLocalizations.of(context)!.email,18,Color(0xFF6B00C3)),centerTitle: true,backgroundColor: Colors.transparent,elevation: 0,leading: InkWell(
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
                      child: addLightText(AppLocalizations.of(context)!.dontloseemail, 12, Color(0xFF15294B))
                    ),
                    SizedBox(height: 20.h,),
                    Container(
                      padding: EdgeInsets.only(left: 20.w),
                      child: TextFormField(
                        controller: emailController,
                        style:  GoogleFonts.poppins(textStyle: TextStyle(fontSize: 16)),
                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration(contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 2),
                            isDense: true,
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFC2A3DD)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFC2A3DD)),
                          ),
                          hintText: AppLocalizations.of(context)!.youremail,
                          hintStyle: GoogleFonts.poppins(textStyle: TextStyle(color: Color(0xFFC2A3DD),fontSize: 14))
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
                              email=emailController.text;
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
                              setState(() {
                                isLoad=false;
                              });
                              preferences!.setString("email", email);
                              Get.to(PasswordScreen());
                            }
                          else{
                            var emailmodel=await auth.updateEmail(email, preferences!.getString("accesstoken").toString());
                            if(emailmodel.statusCode==200)
                            {
                              setState(() {
                                isLoad=false;
                              });
                              Get.to(PasswordScreen());
                            }
                            else if(emailmodel.statusCode==422){
                              setState(() {
                                isLoad=false;
                              });
                              showSnakbar(emailmodel.message!, context);
                            }
                            else {
                              setState(() {
                                isLoad=false;
                              });
                              showSnakbar(emailmodel.message!, context);
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
                        child: addMediumText(AppLocalizations.of(context)!.continues, 14, Color(0xFFFFFFFF))
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
