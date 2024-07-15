import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:moorky/premiumscreen/view/basicplanscreen.dart';
import 'package:moorky/premiumscreen/view/premiumscreen.dart';
import 'package:moorky/settingscreen/view/accountscreen.dart';
import 'package:moorky/commanWidget/commanwidget.dart';
import 'package:moorky/constant/color.dart';
import 'package:moorky/settingscreen/view/confidentiality_screen.dart';
import 'package:moorky/settingscreen/view/helpcenterscreen.dart';
import 'package:moorky/settingscreen/view/languagescreen.dart';
import 'package:moorky/settingscreen/view/licencescreen.dart';
import 'package:moorky/settingscreen/view/notification_screen.dart';
import 'package:moorky/settingscreen/view/notification_type_screen.dart';
import 'package:moorky/settingscreen/view/privacypolicyscreen.dart';
import 'package:moorky/settingscreen/view/termsofusescreen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: addMediumText(AppLocalizations.of(context)!.settings, 18, Colorss.mainColor),
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
          //   Container(
          //     height: 8.h,width: 140.w,),),
          // ],
      ]  ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                child: Padding(
                  padding: EdgeInsets.all(15.0.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: (){
                          Get.to(BasicPlan_Screen());
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r)
                          ),
                          child: Container(
                            height: 75.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r)),
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.only(left: 30.0.w,right: 15.w),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset("assets/images/slike.svg",fit: BoxFit.scaleDown,height: 30.h,width: 25.w,color: Color(0xFF6B18C3),),
                                      SizedBox(width: 30.w,),
                                      addMediumText(AppLocalizations.of(context)!.getmoorkybasic, 14, Color(0xFF6B18C3))
                                    ],
                                  ),
                                  SvgPicture.asset("assets/images/arrowforword.svg",height: 15.h,width: 15.w,color: Color(0xFF6B18C3),),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height:10.h),
                      InkWell(
                        onTap: (){
                          Get.to(Premium_Screen());
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r)
                          ),
                          child: Container(
                            height: 75.h,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: <Color>[
                                    Color(0xFF570084),
                                    Color(0xFFA33BE5)
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(10.r)),
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.only(left: 30.0.w,right: 15.w),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset("assets/images/slike.svg",fit: BoxFit.scaleDown,height: 30.h,width: 25.w,),
                                      SizedBox(width: 30.w,),
                                      addMediumText(AppLocalizations.of(context)!.getmoorkypremium, 14, Color(0xFFFFFFFF))
                                    ],
                                  ),
                                  SvgPicture.asset("assets/images/arrowforword.svg",height: 15.h,width: 15.w,),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height:10.h),
                      InkWell(
                        onTap: (){
                          Get.to(Premium_Screen());
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r)
                          ),
                          child: Container(
                            height: 75.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r)),
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.only(left: 30.0.w,right: 15.w),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset("assets/images/slike.svg",fit: BoxFit.scaleDown,height: 30.h,width: 25.w,color: Color(0xFF6B18C3),),
                                      SizedBox(width: 30.w,),
                                      addMediumText(AppLocalizations.of(context)!.get50xboost, 14, Color(0xFF6B18C3))
                                    ],
                                  ),
                                  SvgPicture.asset("assets/images/arrowforword.svg",height: 15.h,width: 15.w,color: Color(0xFF6B18C3),),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height:10.h),
                    ],
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding: EdgeInsets.only(top: 23.0.r,left: 23.0.r,right: 23.0.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                          padding:  EdgeInsets.all(8.0.r),
                          child: addMediumText(AppLocalizations.of(context)!.generalsetting, 13, Color(0xFF888888))
                      ),
                      SizedBox(height: 10.h,),
                      InkWell(
                        onTap: (){
                          Get.to(AccountScreen());
                        },
                        child: Row(
                          children: [
                            Icon(Icons.person_outline,size: 24.h,color: Color(0xFF6B18C3),),
                            SizedBox(width: 10.w,),
                            addLightText(AppLocalizations.of(context)!.account, 13, Colorss.mainColor)
                          ],
                        ),
                      ),
                      SizedBox(height: 25.h,),
                      InkWell(
                        onTap: (){
                          Get.to(Notification_Type_Screen());
                        },
                        child: Row(
                          children: [
                            Icon(Icons.notifications_none_sharp,size: 24.h,color: Color(0xFF6B18C3),),
                            SizedBox(width: 10.w,),
                            addLightText(AppLocalizations.of(context)!.notificatin, 13, Colorss.mainColor)
                          ],
                        ),
                      ),
                      SizedBox(height: 25.h,),
                      InkWell(
                        onTap: (){
                          Get.to(Confidentiality_Screen());
                        },
                        child: Row(
                          children: [
                            SvgPicture.asset("assets/images/confi.svg",height: 24.h,width: 24.w,color: Color(0xFF6B18C3)),
                            SizedBox(width: 10.w,),
                            addLightText(AppLocalizations.of(context)!.confidentaility, 13, Colorss.mainColor)
                          ],
                        ),
                      ),
                      SizedBox(height: 25.h,),
                      InkWell(
                        onTap: (){
                          Get.to(LanguageScreen());
                        },
                        child: Row(
                          children: [
                            SvgPicture.asset("assets/images/lang.svg",height: 24.h,width: 24.w,color: Color(0xFF6C4DDA)),
                            SizedBox(width: 10.w,),
                            addLightText(AppLocalizations.of(context)!.language, 13, Colorss.mainColor)
                          ],
                        ),
                      ),
                      SizedBox(height:30.h),

                    ],
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding: EdgeInsets.all(23.0.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      addMediumText(AppLocalizations.of(context)!.moorky, 13, Color(0xFF888888)),
                      SizedBox(height:20.h),
                      InkWell(
                        onTap: (){
                          Get.to(HelpCenterScreen());
                        },
                        child: Row(
                          children: [
                            SvgPicture.asset("assets/images/note.svg",height: 24.h,width: 24.w,color: Color(0xFF8D8D8D)),
                            SizedBox(width: 10.w,),
                            addLightText(AppLocalizations.of(context)!.helpcenter, 13, Colorss.mainColor)
                          ],
                        ),
                      ),
                      SizedBox(height: 25.h,),
                      InkWell(
                        onTap: (){
                          Get.to(PrivacyPolicyScreen());
                        },
                        child: Row(
                          children: [
                            SvgPicture.asset("assets/images/qr.svg",height: 24.h,width: 24.w,color: Color(0xFF8D8D8D)),
                            SizedBox(width: 10.w,),
                            addLightText(AppLocalizations.of(context)!.privacyplovy, 13, Colorss.mainColor)
                          ],
                        ),
                      ),
                      SizedBox(height: 25.h,),
                      InkWell(
                        onTap: (){
                          Get.to(TermsofUseScreen());
                        },
                        child: Row(
                          children: [
                            SvgPicture.asset("assets/images/star.svg",height: 24.h,width: 24.w,color: Color(0xFF8D8D8D)),
                            SizedBox(width: 10.w,),
                            addLightText(AppLocalizations.of(context)!.termsofuse, 13, Colorss.mainColor)
                          ],
                        ),
                      ),
                      SizedBox(height: 25.h,),
                      InkWell(
                        onTap: (){
                          Get.to(LicenceScreen());
                        },
                        child: Row(
                          children: [
                            SvgPicture.asset("assets/images/licence.svg",height: 24.h,width: 24.w,color: Color(0xFF8D8D8D)),
                            SizedBox(width: 10.w,),
                            addLightText(AppLocalizations.of(context)!.licence, 13, Colorss.mainColor)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
