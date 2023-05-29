import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:moorky/commanWidget/commanwidget.dart';
import 'package:moorky/constant/color.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:moorky/dashboardscreen/provider/dashboardprovider.dart';
import 'package:moorky/dashboardscreen/view/dashboardscreen.dart';
import 'package:moorky/profilecreate/provider/profileprovider.dart';
import 'package:moorky/profilecreate/repository/profileRepository.dart';
import 'package:moorky/quizscreens/repository/quizrepository.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../premiumscreen/view/premiumscreen.dart';

class GhostMode_Screen extends StatefulWidget {
  bool isskip=false;
  String usertype="";
 GhostMode_Screen({required this.isskip,required this.usertype});

  @override
  State<GhostMode_Screen> createState() => _GhostMode_ScreenState();
}

class _GhostMode_ScreenState extends State<GhostMode_Screen> {
  SharedPreferences? preferences;
  bool isLoad=false;
  @override
  void initState() {
    Init();
    super.initState();
  }
  void Init() async {
    preferences = await SharedPreferences.getInstance();
    var provider=Provider.of<DashboardProvider>(context,listen: false);
    provider.resetLikeUserList();
    if(preferences!.getString("accesstoken")!=null)
    {
      print(preferences!.getString("accesstoken")!.toString());
      provider.fetchGhostStickerList(preferences!.getString("accesstoken").toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: addMediumText(AppLocalizations.of(context)!.ghostmode, 18, Colorss.mainColor),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
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
        height: 9.h,
        alignment: Alignment.bottomCenter,
        margin: EdgeInsets.only(bottom: 15.h),
        child: Container(
          height: 8.h,width: 140.w,decoration: BoxDecoration(color: Colorss.mainColor,borderRadius: BorderRadius.circular(25.r)),),
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 145,
                    child: addMediumText(AppLocalizations.of(context)!.chooseyoursticker, 23, Colorss.mainColor)),
                SizedBox(height: 30.h,),
                !isLoad?Consumer<DashboardProvider>(builder:
                    (context,dataProvider,child){
                  if(dataProvider.ghostModel != null)
                  {
                    return dataProvider.ghostModel!.data!.length > 0
                        ?
                    Column(
                      children: [
                        GridView.builder(
                          itemCount: dataProvider.ghostModel!.data!.length,
                          shrinkWrap: true,
                          physics:  NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 5.0,
                            mainAxisSpacing: 5.0,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: ()async{
                                setState(() {
                                  isLoad = true;
                                });
                                if(widget.isskip)
                                  {
                                    var model=await ProfileRepository.updateProfile(dataProvider.ghostModel!.data!.elementAt(index).id.toString(), "ghost_sticker_id", preferences!.getString("accesstoken")!);
                                    if(model.statusCode==200)
                                    {
                                      var ghostprofile=await ProfileRepository.updateProfile("1", "ghost_profile", preferences!.getString("accesstoken")!);
                                      if(ghostprofile.statusCode==200)
                                      {
                                        preferences!.setString("realphoto", "realphoto");
                                        Get.to(DashBoardScreen(pageIndex: 1,isNotification: false,));
                                      }
                                    }
                                    else if(model.statusCode==422){
                                      showSnakbar(model.message!, context);
                                    }
                                    else {
                                      showSnakbar(model.message!, context);
                                    }
                                  }
                                else{
                                  preferences!
                                      .setString("realphoto", "");
                                  var quizModel = await QuizRepository
                                      .updatedrinktoverifyphoto(
                                      preferences!
                                          .getString("drinktext")!,
                                      preferences!
                                          .getString("smoketext")!,
                                      preferences!
                                          .getString("feelkidstext")!,
                                      preferences!.getString(
                                          "educationtext")!,
                                      preferences!.getString(
                                          "introextrotext")!,
                                      preferences!
                                          .getString("starsigntext")!,
                                      preferences!
                                          .getString("petstext")!,
                                      preferences!
                                          .getString("religiontext")!,
                                      preferences!
                                          .getString("accesstoken")!,
                                      preferences!.getString("languagetext")!,preferences!.getString("realphoto")!);
                                  if (quizModel.statusCode == 200) {
                                    setState(() {
                                      isLoad = false;
                                    });
                                    preferences!.setString("drinktext","");
                                    preferences!.setString("feelkidstext","");
                                    preferences!.setString("educationtext","");
                                    preferences!.setString("smoketext","");
                                    preferences!.setString("starsigntext","");
                                    preferences!.setString("introextrotext","");
                                    preferences!.setString("petstext","");
                                    preferences!.setString("religiontext","");
                                    preferences!.setString("languagetext","");
                                    var ghostprofile=await ProfileRepository.updateProfile("1", "ghost_profile", preferences!.getString("accesstoken")!);
                                    if(ghostprofile.statusCode==200)
                                    {
                                      preferences!.setString("realphoto", "realphoto");
                                      Get.to(DashBoardScreen(pageIndex: 1,isNotification: false,));
                                    }
                                  }
                                }

                              },

                                child: ClipRRect(child: Image.network(dataProvider.ghostModel!.data!.elementAt(index).icon,height: 100,width: 100,fit: BoxFit.contain,),));
                          },
                        ),
                        SizedBox(height: 30.h,),
                        widget.usertype=="premium"?Container():Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            addRegularText("${AppLocalizations.of(context)!.morethan50sticker} ", 14, Color(0xFF8D8D8D)),
                            GestureDetector(
                                onTap: (){
                                  Get.to(Premium_Screen());
                                },
                                child: addunderlineRegularText(AppLocalizations.of(context)!.here, 14, Color(0xFFA055CD),TextDecoration.underline)),
                          ],
                        )
                      ],
                    )
                        :
                    Center(child: Container(
                      alignment: Alignment.center,
                      width: 200.w,
                      child: Text("${AppLocalizations.of(context)!.nostickerfound} 😔")
                    ),);
                  }
                  return Center(child: CircularProgressIndicator(),);
                }):Center(child: CircularProgressIndicator(),)


              ],
            ),
          ),
        ),
      ),
    );
  }
}
