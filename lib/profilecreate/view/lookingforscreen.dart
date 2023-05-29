import 'dart:io';
import 'package:moorky/commanWidget/commanwidget.dart';
import 'package:moorky/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moorky/profilecreate/repository/profileRepository.dart';
import 'package:moorky/profilecreate/view/biographyscreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../provider/profileprovider.dart';
import 'datesscreen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LookingForScreen extends StatefulWidget {
  bool isEdit=false;
  String lookingfor="";
  LookingForScreen({required this.isEdit,required this.lookingfor});
  @override
  State<LookingForScreen> createState() => _LookingForScreenState();
}

class _LookingForScreenState extends State<LookingForScreen> {
  int looking_id=0;
  SharedPreferences? preferences;
  @override
  void initState() {
    Init();
    super.initState();
  }
  void Init()async{
    preferences=await SharedPreferences.getInstance();
    var profileprovider=Provider.of<ProfileProvider>(context,listen: false);
    if(preferences!.getString("accesstoken")!=null)
    {
      print("in sharedprefernce");
      profileprovider.fetchLookingforList(preferences!.getString("accesstoken").toString());
    }
  }
  var _scaKey = GlobalKey<ScaffoldState>();
  bool isLoad=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(title:  addMediumText(AppLocalizations.of(context)!.lookingfor, 18, Colorss.mainColor),centerTitle: true,backgroundColor: Colors.transparent,elevation: 0,leading:
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
            preferences!.setString("lookingfor","");
            Navigator.push(context,
                MaterialPageRoute(builder:
                    (context) =>
                    BiographyScreen(isEdit: false,biographytext: "",)
                )
            );
          },
          icon: Container(
              child: addSemiElipsBoldText(AppLocalizations.of(context)!.skip, 16, Color(0xFFADADAD)),padding: EdgeInsets.only(right: 8),)
        ):Container(),
      ],),
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
                  preferences!.setString("lookingfor", looking_id.toString());
                  var model=await ProfileRepository.updateProfile(looking_id.toString(), "looking_for", preferences!.getString("accesstoken")!);
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
                  print(widget.lookingfor);
                  preferences!.setString("lookingfor",looking_id.toString());
                  Navigator.push(context,
                      MaterialPageRoute(builder:
                          (context) =>
                          BiographyScreen(isEdit: false,biographytext: "",)
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
                      height: 8.h,width: 140.w,decoration: BoxDecoration(color: Color(0xFF751ACD),borderRadius: BorderRadius.circular(25.r)),),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40.h,),
              Consumer<ProfileProvider>(
                  builder: (context, profileProvider, child) => profileProvider.lookingForList?.data != null?ListView.builder(
                    itemCount: profileProvider.lookingForList!.data!.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      for(int i=0;i<profileProvider.lookingForList!.data!.length;i++)
                      {
                        if(profileProvider.lookingForList!.data!.elementAt(index).name.toString()==widget.lookingfor)
                        {
                          profileProvider.lookingForList!.data!.elementAt(index).isSelected=true;
                          looking_id=profileProvider.lookingForList!.data!.elementAt(index).id!;
                        }
                        else{
                          profileProvider.lookingForList!.data!.elementAt(index).isSelected=false;
                        }
                      }
                      return Container(
                        height: 60.h,
                        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(16.r),),
                            border: Border.all(color: Color(0xFF912DCE),width: 1.5.w)),
                        margin: EdgeInsets.only(bottom: 30.h),
                        padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 5.h),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.network(profileProvider.lookingForList!.data!.elementAt(index).icon!),
                                SizedBox(width: 10.w,),
                                addRegularText(profileProvider.lookingForList!.data!.elementAt(index).name!,12, Color(0xFF000000)
                                    .withOpacity(0.70)),
                              ],
                            ),
                            Checkbox(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(5.0.r))),
                                activeColor: Colorss.mainColor,
                                side: MaterialStateBorderSide.resolveWith(
                                      (states) => BorderSide(
                                      width: 1.5.w, color: Colorss.mainColor),
                                ),
                                value: profileProvider.lookingForList!.data!.elementAt(index).isSelected!,
                                onChanged: (value) {

                                  setState(() {
                                    for(int i=0;i<profileProvider.lookingForList!.data!.length;i++)
                                    {
                                      if(profileProvider.lookingForList!.data!.elementAt(i).isSelected==true)
                                      {
                                        profileProvider.lookingForList!.data!.elementAt(i).isSelected=false;
                                      }
                                      widget.lookingfor=profileProvider.lookingForList!.data!.elementAt(index).name!;
                                      looking_id=profileProvider.lookingForList!.data!.elementAt(index).id!;
                                      print(widget.lookingfor);
                                      print("looking_id");
                                      print(looking_id);
                                      profileProvider.lookingForList!.data!.elementAt(index).isSelected = value;
                                    }
                                  });

                                })
                          ],
                        ),
                      );
                    },
                  ):Center(child: CircularProgressIndicator(),)
              ),
            ],
          ),
        ),
      ),
    );
  }
}
