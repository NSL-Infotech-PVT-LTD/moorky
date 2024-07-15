import 'dart:io';
import 'package:moorky/commanWidget/commanwidget.dart';
import 'package:moorky/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moorky/lang/provider/locale_provider.dart';
import 'package:moorky/profilecreate/provider/profileprovider.dart';
import 'package:moorky/profilecreate/repository/profileRepository.dart';
import 'package:moorky/profilecreate/view/lookingforscreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class MaritalStatus extends StatefulWidget {
  bool isEdit=false;
  String maritalStatus = "";
  MaritalStatus({required this.isEdit,required this.maritalStatus});
  @override
  State<MaritalStatus> createState() => _MaritalStatusState();
}

class _MaritalStatusState extends State<MaritalStatus> {

  SharedPreferences? preferences;
  @override
  void initState() {
    Init();
    super.initState();
  }
  bool isLoad=false;
  int maritalindex=0;
  int marital_id=0;

  void Init() async {
    var localprovider=Provider.of<LocaleProvider>(context,listen: false);
    localprovider.getLocaleFromSettings();
    preferences = await SharedPreferences.getInstance();
      var profileprovider=Provider.of<ProfileProvider>(context,listen: false);
      if(preferences!.getString("accesstoken")!=null)
        {
          print("in sharedprefernce");
          profileprovider.fetchMaritalList(preferences!.getString("accesstoken").toString());
        }
  }
  var _scaKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: addMediumText(AppLocalizations.of(context)!.maritalstatus, 18, Colorss.mainColor),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              Navigator.of(context).pop();
            },
            child: SvgPicture.asset(
              "assets/images/arrowback.svg",
              fit: BoxFit.scaleDown,
            )),
        actions: [
          !widget.isEdit?IconButton(
            iconSize: 60,
            onPressed: () {
              preferences!.setString("maritalstatus", "");
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LookingForScreen(isEdit: false,lookingfor: "",)));
            },
            icon: Container(
              child: addSemiElipsBoldText(AppLocalizations.of(context)!.skip, 16, Color(0xFFADADAD)),padding: EdgeInsets.only(right: 8),)
      ):Container(),
        ],
      ),
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
                  preferences!.setString("maritalstatus", marital_id.toString());
                  var model=await ProfileRepository.updateProfile(marital_id.toString(), "marital_status", preferences!.getString("accesstoken")!);
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
                onTap: () {
                  preferences!.setString("maritalstatus", marital_id.toString());
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LookingForScreen(isEdit: false,lookingfor: "",)));
                },
                child: Container(
                  height: 70.h,
                  margin: EdgeInsets.only(left: 25.w, right: 25.w),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: <Color>[Color(0xFF570084), Color(0xFFA33BE5)],
                      ),
                      borderRadius: BorderRadius.circular(50.r)),
                  alignment: Alignment.center,
                  child: addMediumText(AppLocalizations.of(context)!.continues, 14, Color(0xFFffffff))
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                margin: EdgeInsets.only(bottom: 15.h, top: 30.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset(
                      "assets/images/moorky2.png",
                      height: 45.h,
                      width: 150.w,
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Container(
                      height: 8.h,
                      width: 140.w,
                      decoration: BoxDecoration(
                          // color: Color(0xFF751ACD),
                          borderRadius: BorderRadius.circular(25.r)),
                    ),
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                addBoldText(AppLocalizations.of(context)!.yourmaritalstatus, 15, Colorss.mainColor),
                SizedBox(
                  height: 20.h,
                ),
                Consumer<ProfileProvider>(
                  builder: (context, profileProvider, child) => profileProvider.maritalstatusList?.data != null?ListView.builder(
                    itemCount: profileProvider.maritalstatusList!.data!.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      for(int i=0;i<profileProvider.maritalstatusList!.data!.length;i++)
                      {
                        if(profileProvider.maritalstatusList!.data!.elementAt(index).name.toString()==widget.maritalStatus)
                        {
                          profileProvider.maritalstatusList!.data!.elementAt(index).isSelected=true;
                          marital_id=profileProvider.maritalstatusList!.data!.elementAt(index).id!;
                        }
                        else{
                          profileProvider.maritalstatusList!.data!.elementAt(index).isSelected=false;
                        }
                      }
                      return Card(
                        elevation: 0.5,
                        child: Container(
                          height: 60.h,
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              addRegularText(profileProvider.maritalstatusList!.data!.elementAt(index).name!,12, Color(0xFF000000)
                                  .withOpacity(0.70)),
                              Checkbox(
                                  activeColor: Colorss.mainColor,
                                  value: profileProvider.maritalstatusList!.data!.elementAt(index).isSelected!,
                                  onChanged: (value) {

                                      setState(() {
                                        for(int i=0;i<profileProvider.maritalstatusList!.data!.length;i++)
                                        {
                                          if(profileProvider.maritalstatusList!.data!.elementAt(i).isSelected==true)
                                          {
                                            profileProvider.maritalstatusList!.data!.elementAt(i).isSelected=false;
                                          }
                                          widget.maritalStatus=profileProvider.maritalstatusList!.data!.elementAt(index).name!;
                                          marital_id=profileProvider.maritalstatusList!.data!.elementAt(index).id!;
                                          profileProvider.maritalstatusList!.data!.elementAt(index).isSelected = value;
                                          maritalindex=index;
                                        }
                                      });

                                  })
                            ],
                          ),
                        ),
                      );
                    },
                  ):Center(child: CircularProgressIndicator(),)
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
