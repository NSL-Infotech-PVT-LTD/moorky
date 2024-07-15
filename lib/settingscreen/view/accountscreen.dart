import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:moorky/auth/view/changepasswordscreen.dart';
import 'package:moorky/auth/view/login_screen.dart';
import 'package:moorky/commanWidget/commanwidget.dart';
import 'package:moorky/constant/color.dart';
import 'package:moorky/dashboardscreen/homescreen/view/homescreen.dart';
import 'package:moorky/dashboardscreen/provider/dashboardprovider.dart';
import 'package:moorky/dashboardscreen/repository/dashboardrepository.dart';
import 'package:moorky/lang/provider/locale_provider.dart';
import 'package:moorky/profilecreate/provider/profileprovider.dart';
import 'package:moorky/profilecreate/repository/profileRepository.dart';
import 'package:moorky/profilecreate/view/genderscreen.dart';
import 'package:moorky/quizscreens/quizprovider/QuizProvider.dart';
import 'package:moorky/settingscreen/provider/setting_provider.dart';
import 'package:moorky/settingscreen/view/locationscreen.dart';
import 'package:moorky/zegocloud/model/user_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zego_zim/zego_zim.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool _switchValue=false;
  SharedPreferences? preferences;
  bool isSignout=false;
  bool isDelete=false;
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
    var profileprovider = Provider.of<ProfileProvider>(context, listen: false);
    profileprovider.resetStreams();
    if (preferences!.getString("accesstoken") != null) {
      profileprovider.fetchProfileDetails(
          preferences!.getString("accesstoken").toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: addMediumText(AppLocalizations.of(context)!.account,18, Colorss.mainColor),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.5,
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
              color: Colorss.mainColor,
            )),
      ),
      bottomNavigationBar: Container(
        alignment: Alignment.center,
        color: Colors.white,
        height: 80.h,
        padding: EdgeInsets.only(bottom: 10.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset("assets/images/moorky2.png",height: 45.h,width: 150.w,),
            Container(
              height: 8.h,width: 140.w,),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Consumer<ProfileProvider>(
              builder: (context, profileProvider, child) {
                return profileProvider.profiledetails?.data != null?Column(
                  children: [
                    Card(
                      margin: EdgeInsets.symmetric(vertical: 2),
                      elevation: 0.5,
                      child: Container(
                        padding: EdgeInsets.all(25.r),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            addRegularText(AppLocalizations.of(context)!.name, 14, Colorss.mainColor),
                            addRegularText("${profileProvider.profiledetails!.data!.name}", 14, Colorss.mainColor),
                          ],
                        ),
                      ),
                    ),
                    Card( elevation: 0.5,
                      margin: EdgeInsets.symmetric(vertical: 2),
                      child: Container(
                        padding: EdgeInsets.all(25.r),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            addRegularText(AppLocalizations.of(context)!.birthday, 14, Colorss.mainColor),
                            addRegularText("${profileProvider.profiledetails!.data!.dateOfBirth}", 14, Colorss.mainColor),
                          ],
                        ),
                      ),
                    ),
                    Card( elevation: 0.5,
                      margin: EdgeInsets.symmetric(vertical: 2),
                      child: Container(
                        padding: EdgeInsets.all(25.r),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            addRegularText(AppLocalizations.of(context)!.gender, 14, Colorss.mainColor),
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: (){
                                Get.to(GenderScreen(isEdit: true,gender:profileProvider.profiledetails!.data!.gender,showGender: profileProvider.profiledetails!.data!.showGender!,));
                              },
                              child: Row(
                                children: [
                                  addRegularText("${profileProvider.profiledetails!.data!.gender}", 14, Colorss.mainColor),
                                  SizedBox(width: 10.w,),
                                  SvgPicture.asset("assets/images/arrowforword.svg",height: 15.h,width: 15.w,color: Colorss.mainColor,),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Card( elevation: 0.5,
                      margin: EdgeInsets.symmetric(vertical: 2),
                      child: Container(
                        padding: EdgeInsets.all(25.r),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            addRegularText(AppLocalizations.of(context)!.location, 14, Colorss.mainColor),
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: (){
                                Get.to(LocationScreen());
                              },
                              child: Row(
                                children: [
                                  SizedBox(width:200.w,child: Align(alignment: Alignment.centerRight,child: addRegularText("${profileProvider.profiledetails!.data!.city}", 14, Colorss.mainColor))),
                                  SizedBox(width: 10.w,),
                                  SvgPicture.asset("assets/images/arrowforword.svg",height: 15.h,width: 15.w,color: Colorss.mainColor,),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Card(
                      elevation: 0.5,
                      margin: EdgeInsets.symmetric(vertical: 2),
                      child: Container(
                        padding: EdgeInsets.all(25.r),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width*0.60,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  addRegularText(AppLocalizations.of(context)!.hideacoount, 14, Colorss.mainColor),
                                  SizedBox(height: 15.h,),
                                  addRegularText(AppLocalizations.of(context)!.likeyoudeleted, 9, Color(0xFFA8A8A8))
                                ],
                              ),
                            ),
                            CupertinoSwitch(
                              trackColor:  Color(0xFFC2A3DD),
                              activeColor:  Color(0xFfAB60ED),
                              value: profileProvider.profiledetails!.data!.hide_account,
                              onChanged: (value) async{
                                String hide_account="0";
                                setState(() {
                                  if(value==true)
                                  {
                                    setState(() {
                                      hide_account="1";
                                    });
                                  }
                                  else{
                                    setState(() {
                                      hide_account="0";
                                    });
                                  }


                                });

                                showDialog(
                                    context: context,
                                    builder: (context) => StatefulBuilder(
                                        builder: (BuildContext context,
                                            StateSetter stateSetter) =>
                                            Material(
                                              color: Colors.transparent,
                                              child: Container(
                                                alignment: Alignment.center,
                                                color: Colors.transparent,
                                                child: Container(
                                                  width: MediaQuery.of(context).size.width *
                                                      0.80,
                                                  margin: EdgeInsets.only(bottom: 30),
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                      BorderRadius.circular(20.w)),
                                                  child: Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                    children: <Widget>[
                                                      SizedBox(
                                                        height: 20.h,
                                                      ),
                                                      addBoldText(
                                                          AppLocalizations.of(context)!
                                                              .areyousure,
                                                          12,
                                                          Color(0xFF4D4D4D)),
                                                      SizedBox(
                                                        height: 10.h,
                                                      ),
                                                      Container(
                                                          margin: EdgeInsets.symmetric(
                                                              horizontal: 20),
                                                          child: addCenterRegularText(
                                                              AppLocalizations.of(context)!
                                                                  .hidewarning,
                                                              10,
                                                              Color(0xFF4D4D4D))),
                                                      SizedBox(
                                                        height: 30.h,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.spaceAround,
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              Navigator.of(context).pop();
                                                            },
                                                            child: Container(
                                                              height: 40,
                                                              alignment: Alignment.center,
                                                              width: 110,
                                                              child: addRegularText(
                                                                  AppLocalizations.of(
                                                                      context)!
                                                                      .cancel,
                                                                  12,
                                                                  Color(0xFF4D4D4D)),
                                                              decoration: BoxDecoration(
                                                                  color: Color(0xFFF5F5F5),
                                                                  borderRadius:
                                                                  BorderRadius.circular(
                                                                      5)),
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () async {
                                                              showLoader(context);
                                                              var model=await ProfileRepository.updateProfile(hide_account, "hide_account", preferences!.getString("accesstoken")!);
                                                              if(model.statusCode==200)
                                                              {
                                                                var provider=await Provider.of<ProfileProvider>(context,listen: false);
                                                                provider.resetStreams();
                                                                provider.adddetails(model);

                                                                if(value==true)
                                                                {
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
                                                                  try {
                                                                    await ZIM.getInstance()!.
                                                                    logout();
                                                                    UserModel.release();
                                                                    final prefs = await SharedPreferences.getInstance();
                                                                    await prefs.setString('userID', '');
                                                                    await prefs.setString('userName', '');
                                                                    prefs.clear();
                                                                    Navigator.of(context)
                                                                        .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
                                                                  } on PlatformException catch (onError) {

                                                                  }

                                                                  setState(() {
                                                                    role="";
                                                                    socialrole="";
                                                                  });
                                                                }
                                                              }
                                                              else if(model.statusCode==422){
                                                                Navigator.of(context).pop();
                                                                showSnakbar(model.message!, context);
                                                              }
                                                              else {
                                                                Navigator.of(context).pop();
                                                                showSnakbar(model.message!, context);
                                                              }
                                                            },
                                                            child: Container(
                                                              height: 40,
                                                              alignment: Alignment.center,
                                                              width: 110,
                                                              child: addRegularText(
                                                                  AppLocalizations.of(
                                                                      context)!
                                                                      .hide,
                                                                  12,
                                                                  Color(0xFFFFFFFF)),
                                                              decoration: BoxDecoration(
                                                                  color: Color(0xFF007AFF),
                                                                  borderRadius:
                                                                  BorderRadius.circular(
                                                                      5)),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(height: 20,)
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )));

                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      elevation: 0.5,
                      margin: EdgeInsets.symmetric(vertical: 2),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(25.r),
                        child: Column(
                          children: [
                            addLightCenterText(AppLocalizations.of(context)!.makesureyoucan, 12, Color(0xFF15294B)),
                            SizedBox(height: 15.h,),
                            addMediumText(profileProvider.profiledetails!.data!.email, 12, Color(0xFF080808)),
                            SizedBox(height: 50.h,),
                            !isSignout?GestureDetector(
                              onTap: ()async{
                                setState(() {
                                  isSignout=true;
                                });

                                bool issignout=await DashboardRepository.signOut(preferences!.getString("accesstoken").toString());
                                FirebaseAuth.instance.signOut();
                                if(issignout)
                                  {
                                    setState(() {
                                      isSignout=false;
                                    });
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
                                    try {
                                      await ZIM.getInstance()!.logout();
                                      UserModel.release();
                                      final prefs = await SharedPreferences.getInstance();
                                      await prefs.setString('userID', '');
                                      await prefs.setString('userName', '');
                                      Navigator.of(context)
                                          .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
                                    } on PlatformException catch (onError) {

                                    }
                                    setState(() {
                                      role="";
                                      socialrole="";
                                    });
                                  }
                                else{
                                  setState(() {
                                    isSignout=false;
                                  });
                                }

                              },
                              child: Container(
                                height: 60.h,
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
                                child: addLightText(AppLocalizations.of(context)!.signout, 14, Color(0xFFFFFFFF))
                              ),
                            ):Container(alignment: Alignment.topCenter,child: CircularProgressIndicator(),),
                            SizedBox(height: 20.h,),
                            GestureDetector(
                              onTap: (){
                                Get.to(ChangePasswordScreen());
                              },
                              child: addMediumUnderLineText(AppLocalizations.of(context)!.changepassword, 12, Color(0xFF6C4DDA))
                            ),
                            SizedBox(height: 100.h,),
                            !isDelete?GestureDetector(
                              onTap: ()async{
                                showDialog(
                                    context: context,
                                    builder: (context) => StatefulBuilder(
                                        builder: (BuildContext context,
                                            StateSetter stateSetter) =>
                                            Material(
                                              color: Colors.transparent,
                                              child: Container(
                                                alignment: Alignment.center,
                                                color: Colors.transparent,
                                                child: Container(
                                                  width: MediaQuery.of(context).size.width *
                                                      0.80,
                                                  margin: EdgeInsets.only(bottom: 30),
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                      BorderRadius.circular(20.w)),
                                                  child: Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                    children: <Widget>[
                                                      SizedBox(
                                                        height: 20.h,
                                                      ),
                                                      addBoldText(
                                                          AppLocalizations.of(context)!
                                                              .areyousure,
                                                          12,
                                                          Color(0xFF4D4D4D)),
                                                      SizedBox(
                                                        height: 10.h,
                                                      ),
                                                      Container(
                                                          margin: EdgeInsets.symmetric(
                                                              horizontal: 20),
                                                          child: addCenterRegularText(
                                                              AppLocalizations.of(context)!
                                                                  .deleteaccounts,
                                                              10,
                                                              Color(0xFF4D4D4D))),
                                                      SizedBox(
                                                        height: 30.h,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.spaceAround,
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              Navigator.of(context).pop();
                                                            },
                                                            child: Container(
                                                              height: 40,
                                                              alignment: Alignment.center,
                                                              width: 110,
                                                              child: addRegularText(
                                                                  AppLocalizations.of(
                                                                      context)!
                                                                      .cancel,
                                                                  12,
                                                                  Color(0xFF4D4D4D)),
                                                              decoration: BoxDecoration(
                                                                  color: Color(0xFFF5F5F5),
                                                                  borderRadius:
                                                                  BorderRadius.circular(
                                                                      5)),
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () async {
                                                              showLoader(context);
                                                              bool isdelete=await DashboardRepository.deleteUser(preferences!.getString("accesstoken").toString());
                                                              if(isdelete)
                                                              {
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
                                                                try {
                                                                  await ZIM.getInstance()!.logout();
                                                                  UserModel.release();
                                                                  final prefs = await SharedPreferences.getInstance();
                                                                  await prefs.setString('userID', '');
                                                                  await prefs.setString('userName', '');
                                                                  Navigator.of(context)
                                                                      .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
                                                                } on PlatformException catch (onError) {

                                                                }
                                                                stateSetter(() {
                                                                  role="";
                                                                  socialrole="";
                                                                });
                                                              }
                                                              else{
                                                                Navigator.pop(context);
                                                                stateSetter(() {
                                                                  isDelete=false;
                                                                });
                                                              }
                                                            },
                                                            child: Container(
                                                              height: 40,
                                                              alignment: Alignment.center,
                                                              width: 110,
                                                              child: addRegularText(
                                                                  AppLocalizations.of(
                                                                      context)!
                                                                      .delete,
                                                                  12,
                                                                  Color(0xFFFFFFFF)),
                                                              decoration: BoxDecoration(
                                                                  color: Color(0xFF007AFF),
                                                                  borderRadius:
                                                                  BorderRadius.circular(
                                                                      5)),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(height: 20,)
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )));
                              },
                              child: addMediumDecorationunderlineText(AppLocalizations.of(context)!.deleteaccount, 11, Color(0xFFA7A7A7))
                            ):Container(alignment: Alignment.topCenter,child: CircularProgressIndicator(),),
                          ],
                        ),
                      ),
                    ),
                  ],
                ):Center(child: CircularProgressIndicator(),);
              }
          )
        ),
      ),
    );
  }
}
void showLoader(context) async => await showDialog(
  context: context,
  barrierDismissible: false,
  builder: (context) => WillPopScope(
    onWillPop: () async => false,
    child: Container(
      color: Colors.black26,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: const Center(
        child: CircularProgressIndicator.adaptive(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      ),
    ),
  ),
);
