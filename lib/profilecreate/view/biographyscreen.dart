import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:moorky/commanWidget/commanwidget.dart';
import 'package:moorky/constant/color.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moorky/profilecreate/provider/profileprovider.dart';
import 'package:moorky/profilecreate/repository/profileRepository.dart';
import 'package:moorky/profilecreate/view/interestedscreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'datesscreen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class BiographyScreen extends StatefulWidget {
  bool isEdit=false;
  String biographytext="";
  BiographyScreen({required this.isEdit,required this.biographytext});

  @override
  State<BiographyScreen> createState() => _BiographyScreenState();
}
class _BiographyScreenState extends State<BiographyScreen> {
  TextEditingController biographyController=new TextEditingController();
  SharedPreferences? preferences;
  var _scaKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    biographyController.text=widget.biographytext;
    Init();
    super.initState();
  }
  void Init()async{
    preferences=await SharedPreferences.getInstance();
  }
  bool isLoad=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaKey,
      backgroundColor: Colors.white,
      appBar: AppBar(title: addMediumText(AppLocalizations.of(context)!.biography, 18, Colorss.mainColor),
     centerTitle: true,backgroundColor: Colors.transparent,elevation: 0,leading:
      InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: (){
            Navigator.of(context).pop();
          },
          child: SvgPicture.asset("assets/images/arrowback.svg",fit: BoxFit.scaleDown,)),actions: [
        !widget.isEdit?IconButton(
          iconSize: 60,
          onPressed: () {
            preferences!.setString("biography","");
            Navigator.push(context,
                MaterialPageRoute(builder:
                    (context) =>
                    InterstedScreen(isEdit: false,intrestlist: [],)
                )
            );
          },
          icon: addSemiBoldText(AppLocalizations.of(context)!.skip, 16, Color(0xFFADADAD)),
        ):Container(),
      ],),
      bottomNavigationBar: Container(
        height: 190.h,
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
                    preferences!.setString("biography", widget.biographytext);
                    var model=await ProfileRepository.updateProfile(widget.biographytext, "biography", preferences!.getString("accesstoken")!);
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
              ):Container(child: CircularProgressIndicator(),alignment: Alignment.topCenter,):InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: (){
                  preferences!.setString("biography",biographyController.text);
                  Navigator.push(context,
                      MaterialPageRoute(builder:
                          (context) =>
                          InterstedScreen(isEdit: false,intrestlist: [],)
                      )
                  );
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
                  child: addMediumText(AppLocalizations.of(context)!.continues, 14, Color(0xFFffffff))
                ),
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
            SizedBox(height: 20.h,),
            addBoldText(AppLocalizations.of(context)!.talkabout, 15, Colorss.mainColor),
            SizedBox(height: 20.h,),
            TextFormField(
              maxLines: 12,
              textInputAction: TextInputAction.done,
              controller: biographyController,
              onChanged: (value){
                setState(() {
                  widget.biographytext=value;
                });
              },
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0.r),
                    borderSide: BorderSide(
                        color: Colorss.mainColor,
                      width: 1.0
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0.r),
                    borderSide: BorderSide(
                        color: Colorss.mainColor,
                        width: 1.0
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0.r),
                    borderSide: BorderSide(
                        color: Colorss.mainColor,
                        width: 1.0
                    ),
                  ),
                  filled: true,
                  hintStyle: GoogleFonts.poppins(textStyle: TextStyle(color: Colors.grey[600])),
                  hintText: AppLocalizations.of(context)!.enteryourself,
                  fillColor: Colors.white70),
            )
          ],
        ),
      ),
    );
  }
}
