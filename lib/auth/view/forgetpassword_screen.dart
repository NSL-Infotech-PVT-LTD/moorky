import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moorky/auth/provider/authprovider.dart';
import 'package:moorky/commanWidget/commanwidget.dart';
import 'package:moorky/constant/color.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class ForgetPassword_Screen extends StatefulWidget {
  const ForgetPassword_Screen({Key? key}) : super(key: key);

  @override
  State<ForgetPassword_Screen> createState() => _ForgetPassword_ScreenState();
}

class _ForgetPassword_ScreenState extends State<ForgetPassword_Screen> {
  var _formKey = GlobalKey<FormState>();
  var _scaKey = GlobalKey<ScaffoldState>();
  bool isTrue=false;
  bool isLoad=false;
  TextEditingController emailController=new TextEditingController();
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
      appBar: AppBar(title: addMediumText(AppLocalizations.of(context)!.forgetpassword, 18, Colorss.mainColor),centerTitle: true,backgroundColor: Colors.transparent,elevation: 0,leading:
      InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: (){
            Navigator.of(context).pop();
          },
          child: SvgPicture.asset("assets/images/cross.svg",fit: BoxFit.scaleDown,color: Color(0xFf000000),))),
      bottomNavigationBar: !isLoad ? isTrue?InkWell(
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
            var isSendSuccess=await auth.forgetPassword(emailController.text);
            if(isSendSuccess)
              {
                setState(() {
                  isLoad=false;
                });
                showSnakbar(AppLocalizations.of(context)!.sentresetlink, context);
              }
            else{
              setState(() {
                isLoad=false;
              });
              showSnakbar(AppLocalizations.of(context)!.emailinvalid, context);
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
          child: addMediumText(AppLocalizations.of(context)!.resetpassword, 14, Color(0xFFFFFFFF))
        ),
      ):Container(
        height: 70.h,
        margin: EdgeInsets.only(top: 90.h,bottom: 120.h,left: 25.w,right: 25.w),
        decoration: BoxDecoration(
            border: Border.all(color: Color(0xFFC2A3DD),width: 1.0),

            borderRadius: BorderRadius.circular(50.r)),
        alignment: Alignment.center,
        child: addMediumText(AppLocalizations.of(context)!.resetpassword, 14, Color(0xFFC2A3DD))
      ):Container(height:100,child: CircularProgressIndicator(),alignment: Alignment.bottomCenter,),
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            margin: EdgeInsets.only(bottom: 15.h,left: 25.w,right: 25.w),
            child: Column(
              children: [
                SizedBox(height: 20,),
                Container(
                  margin: EdgeInsets.only(bottom: 25.h,right: 15.w),
                  child:
                      addRegularText(AppLocalizations.of(context)!.enterfornewpassword, 11, Colors.black.withOpacity(0.59))
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 15.h,),
                  height: 60.h,
                  decoration: BoxDecoration( borderRadius: BorderRadius.circular(10.0),border: Border.all(color: Color(0xFFEAE0F3),width: 0.5),
                      color: Color(0xFFC2A3DD).withOpacity(0.20)),
                  alignment: Alignment.center,
                  child: TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.email,
                        labelText: AppLocalizations.of(context)!.email,
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
          ),
        ),
      ),
    );
  }
}
