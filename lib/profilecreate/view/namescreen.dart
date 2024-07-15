import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moorky/commanWidget/commanwidget.dart';
import 'package:moorky/profilecreate/repository/profileRepository.dart';
import 'package:moorky/profilecreate/view/dateofbirthscreen.dart';
import 'package:moorky/auth/view/password_screen.dart';
import 'package:moorky/constant/color.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../auth/provider/authprovider.dart';
import '../provider/profileprovider.dart';
class NameScreen extends StatefulWidget {
  bool isEdit=false;
  String name="";
  bool isGhost=false;
  NameScreen({required this.name,required this.isEdit,required this.isGhost});
  @override
  State<NameScreen> createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {

  var _formKey = GlobalKey<FormState>();
  var _scaKey = GlobalKey<ScaffoldState>();
  bool isTrue=false;
  TextEditingController nameController=new TextEditingController();
  SharedPreferences? preferences;
  @override
  void initState() {
    Init();
    super.initState();
  }
  void Init()async{
    nameController.text=widget.name;
    preferences=await SharedPreferences.getInstance();
  }
  bool isLoad=false;
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
        key: _scaKey,
        backgroundColor: Colors.white,
        appBar: AppBar(title: addMediumText(AppLocalizations.of(context)!.name,18,Colorss.mainColor),centerTitle: true,backgroundColor: Colors.transparent,elevation: 0,leading:
        InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
        onTap: ()async{
              if(widget.isGhost)
                {
                  var model = await ProfileRepository.updateGhost(
                      '0', "is_ghost", preferences!.getString("accesstoken")!);
                  if (model.statusCode == 200) {
                    var provider = await Provider.of<ProfileProvider>(context,
                        listen: false);
                    provider.resetStreams();
                    provider.adddetails(model);
                    preferences!.setBool("ghostactivate", false);
                    Navigator.pop(context);
                  } else if (model.statusCode == 422) {
                    showSnakbar(model.message!, context);
                  } else {
                    showSnakbar(model.message!, context);
                  }
                }
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
                    child: addRegularText(AppLocalizations.of(context)!.wewantmeetyou, 12, Colorss.mainColor)
                  ),
                  SizedBox(height: 20.h,),
                  Container(
                    padding: EdgeInsets.only(left: 20.w),
                    child: TextFormField(
                      controller: nameController,
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
                          hintText: AppLocalizations.of(context)!.enteraname,
                          hintStyle: GoogleFonts.poppins(textStyle: TextStyle(color: Color(0xFFC2A3DD),fontSize: 14))
                      ),
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value){
                        widget.name=value;
                        setState(() {
                          if(value.isEmpty)
                          {
                            isTrue=false;
                          }
                          else if(value.length>2){
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
                          return AppLocalizations.of(context)!.pleaseentername;
                        }
                        else if(value.length>20)
                        {
                          return AppLocalizations.of(context)!.pleaseenter20chrcter;
                        }
                        return null;
                      },

                    ),
                  ),
                  SizedBox(height: 5.h,),
                  Container(
                    padding: EdgeInsets.only(left: 20.w,right: 60.w),
                    child: widget.name.isNotEmpty?
                        addLightText("${widget.name}, ${AppLocalizations.of(context)!.whatabeauti}", 12, Color(0xFF15294B)):Container(),
                  ),
                ],
              ),
              Column(
                children: [
                  !widget.isEdit?isTrue?InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: ()async{
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        preferences!.setString("name", nameController.text);
                          Navigator.push(context,
                              MaterialPageRoute(builder:
                                  (context) =>
                                      DateofBirthScreen()
                              )
                          );
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
                  ):Container(
                    height: 70.h,
                    margin: EdgeInsets.only(top: 90.h,left: 25.w,right: 25.w,bottom: 15.h),
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFFC2A3DD),width: 1.0),

                        borderRadius: BorderRadius.circular(50.r)),
                    alignment: Alignment.center,
                    child: addMediumText(AppLocalizations.of(context)!.continues, 14, Color(0xFFC2A3DD))
                  ):!isLoad?InkWell(
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
                        preferences!.setString("name", nameController.text);
                        var model=await ProfileRepository.updateProfile(widget.name, "name", preferences!.getString("accesstoken")!);
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
                      child: addMediumText("UPDATE", 14, Color(0xFFC2A3DD))
                    ),
                  ):Container(child: CircularProgressIndicator(),alignment: Alignment.topCenter,),
                  // Container(
                  //   margin: EdgeInsets.only(bottom: 15.h),
                  //   child: Container(
                  //     height: 8.h,width: 140.w,decoration: BoxDecoration(color: Colors.black,borderRadius: BorderRadius.circular(25.r)),),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
        ),
      ),
    );
  }
}
