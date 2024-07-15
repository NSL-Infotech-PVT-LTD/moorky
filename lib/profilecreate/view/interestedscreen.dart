import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moorky/commanWidget/commanwidget.dart';
import 'package:moorky/profilecreate/repository/profileRepository.dart';
import 'package:moorky/quizscreens/view/startquizscreen.dart';
import 'package:moorky/constant/color.dart';
import 'package:moorky/zegocloud/model/user_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:zego_zim/zego_zim.dart';
import '../provider/profileprovider.dart';
class InterstedScreen extends StatefulWidget {
  bool isEdit=false;
  List<String> intrestlist=<String>[];
  InterstedScreen({required this.isEdit,required this.intrestlist});
  @override
  State<InterstedScreen> createState() => _InterstedScreenState();
}

class _InterstedScreenState extends State<InterstedScreen> {
  SharedPreferences? preferences;

  ProfileRepository? profileRepository;
  String lang="";
  @override
  void initState() {
    profileRepository=new ProfileRepository();
    Init();
    super.initState();
  }
  void Init()async{
    print(widget.intrestlist);
    preferences=await SharedPreferences.getInstance();
    var profileprovider=Provider.of<ProfileProvider>(context,listen: false);
    if(preferences!.getString("accesstoken")!=null)
    {
      profileprovider.fetchIntrestedList(preferences!.getString("accesstoken").toString());
    }
    if(preferences!.getString("lang")!=null)
    {
      lang=preferences!.getString("lang").toString();
      setState(() {
      });
    }
  }
  var _scaKey = GlobalKey<ScaffoldState>();
  bool isLoad=false;
  bool skipLoad=false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaKey,
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Align(child: Image.asset("assets/images/inter1.png",fit: BoxFit.fill,height: 145,width: 108,),alignment: Alignment.topLeft,),
              Align(child: Image.asset("assets/images/inter2.png",fit: BoxFit.fill,height: 145,width: 108,),alignment: Alignment.topRight,),
              Align(child: Image.asset("assets/images/inter3.png",fit: BoxFit.fill,height: 155,width: 128,),alignment: Alignment.bottomLeft,),
              Align(child: Container(
                margin: EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                  child: Image.asset("assets/images/moorky2.png",width: 150,)),alignment: Alignment.bottomRight,),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      child: Row(
                        children: [
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: (){
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              child: SvgPicture.asset("assets/images/arrowback.svg",color: Colors.white,fit: BoxFit.scaleDown,
                              ),
                              margin: EdgeInsets.only(top: 20.h,left: 20.w),
                              alignment: Alignment.topLeft,),
                          ),
                          !widget.isEdit?
                          !isLoad?!skipLoad?InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: ()async{
                              setState(() {
                                skipLoad=true;
                              });

                              List<String> imageindex=[];
                              List<String> images=[];
                              if(preferences!.getStringList("imagesindex") !=null)
                                {
                                  imageindex= preferences!.getStringList("imagesindex")!;
                                }
                              else{
                                imageindex=[];
                              }
                              if(preferences!.getStringList("photo") !=null)
                              {
                                images= preferences!.getStringList("photo")!;
                              }
                              else{
                                images=[];
                              }
                              preferences!.setString("intrested","");
                              var profileModel=await ProfileRepository.updatenametoIntrested(
                                  preferences!.getString("name")!,
                                  preferences!.getString("dateofbirth")!,
                                  preferences!.getString("gender")!,
                                  preferences!.getInt("showgender")!,
                                  preferences!.getString("datewith")!,
                                  preferences!.getString("biography")!,
                                  preferences!.getString("intrested")!,
                                  preferences!.getString("maritalstatus")!,
                                  preferences!.getString("lookingfor")!,
                                  images,
                                  preferences!.getString("accesstoken")!,
                                  preferences!.getString("age")!,imageindex,preferences!.getString("datewithid")!,preferences!.getString("genderid")!);
                              if(profileModel.statusCode==200)
                              {
                                // try {
                                //   ZIMUserInfo userInfo = ZIMUserInfo();
                                //   userInfo.userID=profileModel.data!.id.toString();
                                //   userInfo.userName=profileModel.data!.name.toString();
                                //   await ZIM.getInstance()!.login(userInfo);
                                //   Navigator.of(context).pop;
                                //   print('success');
                                //   UserModel.shared().userInfo = userInfo;
                                //   final prefs = await SharedPreferences.getInstance();
                                //   await prefs.setString('userID', profileModel.data!.id.toString());
                                //   await prefs.setString('userName', profileModel.data!.name.toString());
                                  setState(() {
                                    skipLoad=false;
                                  });
                                  // preferences!.setBool("inter",true);
                                  // preferences!.setBool("is_ghost",profileModel.data!.is_ghost!);
                                  // preferences!.setString("name","");
                                  // preferences!.setString("dateofbirth","");
                                  // preferences!.setString("gender","");
                                  // preferences!.setString("datewith","");
                                  // preferences!.setString("biography","");
                                  // preferences!.setString("intrested","");
                                  // preferences!.setString("maritalstatus","");
                                  // preferences!.setString("lookingfor","");
                                  // preferences!.setString("maritalstatus","");
                                  // preferences!.setString("age","");
                                  // preferences!.setStringList("photo",[]);
                                  // preferences!.setStringList("imagesindex",[]);



                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder:
                                          (context) =>
                                          StartQuizScreen(isGhostMode: profileModel.data!.is_ghost!,)
                                      )
                                  );

                                // } on PlatformException catch (onError) {
                                //   Navigator.of(context).pop();
                                // }

                              }
                            },
                            child: Container(
                              child: addLightText(AppLocalizations.of(context)!.skip, 16, Color(0xFFFFFFFF)),
                              margin: EdgeInsets.only(top: 20.h,left: 20.w,right: 20.w),
                              ),
                          ):Container(child: CircularProgressIndicator(),alignment: Alignment.topCenter,):Container():Container(
                            child: addLightText(AppLocalizations.of(context)!.skip, 16, Color(0xFFFFFFFF)),
                            margin: EdgeInsets.only(top: 20.h,left: 20.w,right: 20.w),
                          )
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      ),
                    ),
                    Text.rich(
                        TextSpan(
                        text:
                        "${AppLocalizations.of(context)!.what} ",
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontSize: 40.sp,
                              color:
                              Color(0xFFC2A3DD).withOpacity(0.90)),
                        ),
                        children: <InlineSpan>[
                            lang=="tr"?TextSpan(
                            text: '${AppLocalizations.of(context)!.tickels}${AppLocalizations.of(context)!.your}',
                            style: GoogleFonts.poppins(
                              textStyle:
                              TextStyle(
                                  fontSize: 40.sp,
                                  fontStyle: FontStyle.italic,
                                  color: Colorss.mainColor.withOpacity(0.90)),
                            ),
                          ):TextSpan(
                           text: '${AppLocalizations.of(context)!.tickels}',
                           style: GoogleFonts.poppins(
                             textStyle:
                             TextStyle(
                                 fontSize: 40.sp,
                                 fontStyle: FontStyle.italic,
                                 color: Colorss.mainColor.withOpacity(0.90)),
                           ),
                         ),
                        ])),
                    Text.rich(TextSpan(
                        text:
                        lang!="tr"?"${AppLocalizations.of(context)!.your} ":"",
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontSize: 40.sp,
                              color:
                              Color(0xFFC2A3DD).withOpacity(0.90)),
                        ),
                        children: <InlineSpan>[
                          TextSpan(
                            text: '${AppLocalizations.of(context)!.fancies}',
                            style: GoogleFonts.poppins(
                              textStyle:
                              TextStyle(
                                  fontSize: 40.sp,
                                  fontStyle: FontStyle.italic,
                                  color: Colorss.mainColor.withOpacity(0.90)),
                            ),
                          ),
                        ])),
                    SizedBox(height: 5.h,),
                    addMediumText(AppLocalizations.of(context)!.chooseyourintereset, 14,  Color(0xFFC2A3DD).withOpacity(0.90)),
                    SizedBox(height: 20.h,),
                    Expanded(
                        child:
                    SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.h),
                        child: Column(
                          children: [
                            Consumer<ProfileProvider>(
                                builder: (context, profileProvider, child) => profileProvider.interestedList?.data != null?
                                GridView.builder(
                                  itemCount: profileProvider.interestedList!.data!.length,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  physics:  ScrollPhysics(),
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      crossAxisSpacing: 10.0,
                                      mainAxisSpacing: 10.0,
                                      mainAxisExtent: 40.0.h),
                                  itemBuilder: (BuildContext context, int index) {
                                    if(widget.intrestlist.isNotEmpty)
                                    {
                                      for(int i=0;i<widget.intrestlist.length;i++)
                                      {
                                        if(widget.intrestlist.elementAt(i).toString()==profileProvider.interestedList!.data!.elementAt(index).id.toString())
                                        {
                                          profileProvider.interestedList!.data!.elementAt(index).isSelected = true;
                                        }
                                      }
                                    }
                                    return InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () {
                                        setState(() {
                                          profileProvider.interestedList!.data!.elementAt(index).isSelected = !profileProvider.interestedList!.data!.elementAt(index).isSelected!;

                                              if(profileProvider.interestedList!.data!.elementAt(index).isSelected==true)
                                              {
                                                widget.intrestlist.add(profileProvider.interestedList!.data!.elementAt(index).id!.toString());
                                              }
                                              else{
                                                widget.intrestlist.remove(profileProvider.interestedList!.data!.elementAt(index).id!.toString());
                                              }
                                        });
                                      },
                                      child: profileProvider.interestedList?.data!.elementAt(index).isSelected==false?Container(
                                        height: 40.h,
                                        decoration: BoxDecoration(borderRadius:
                                        BorderRadius.all(Radius.circular(20.r)),border: Border.all(color: Colorss.mainColor,
                                            width: 1.5)),
                                        alignment: Alignment.center,
                                        child: addMediumText(profileProvider.interestedList!.data!.elementAt(index).name!,10, Colorss.mainColor)
                                      ):Container(
                                        height: 40.h,
                                        decoration: BoxDecoration(borderRadius:
                                        BorderRadius.all(Radius.circular(20.r)),color: Colorss.mainColor),
                                        alignment: Alignment.center,
                                        child: addMediumText(profileProvider.interestedList!.data!.elementAt(index).name!,10, Color(0xffffffff))
                                      ),
                                    );
                                  },
                                ):Center(child: CircularProgressIndicator(),)
                            ),

                          ],
                        ),
                      ),
                    )),
                    SizedBox(height: 20.h,),
                    widget.isEdit?!isLoad?InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: ()async{
                        setState(() {
                          isLoad=true;
                        });
                        String interset="";
                        if(widget.intrestlist.isNotEmpty)
                          {
                            interset=widget.intrestlist.toString().replaceAll("[", "").trim().replaceAll("]", "").trim();
                          }
                        else{
                          interset="0";
                        }
                        preferences!.setString("intrested",interset);
                        print("interset");
                        print(interset);
                        var model=await ProfileRepository.updateProfile(interset, "interests", preferences!.getString("accesstoken")!);
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
                          height: 40.h,
                          width: MediaQuery.of(context).size.width*0.30,
                          decoration: BoxDecoration(borderRadius:
                          BorderRadius.all(Radius.circular(20.r)),border: Border.all(color: Colorss.mainColor,
                              width: 1.5)),
                          alignment: Alignment.center,
                          child: addMediumText(AppLocalizations.of(context)!.update,10, Colorss.mainColor)
                      )
                    ):Container(child: CircularProgressIndicator(),alignment: Alignment.topCenter,):
                    !skipLoad?!isLoad?InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: ()async{
                        setState(() {
                          isLoad=true;
                        });
                        List<String> imageindex=[];
                        List<String> images=[];
                        if(preferences!.getStringList("imagesindex") !=null)
                        {
                          imageindex= preferences!.getStringList("imagesindex")!;
                        }
                        else{
                          imageindex=[];
                        }
                        if(preferences!.getStringList("photo") !=null)
                        {
                          images= preferences!.getStringList("photo")!;
                        }
                        else{
                          images=[];
                        }
                        preferences!.setString("intrested",widget.intrestlist.toString().replaceAll("[", "").trim().replaceAll("]", "").trim());
                        var profileModel=await ProfileRepository.updatenametoIntrested(
                            preferences!.getString("name")!,
                            preferences!.getString("dateofbirth")!,
                            preferences!.getString("gender")!,
                            preferences!.getInt("showgender")!,
                            preferences!.getString("datewith")!,
                            preferences!.getString("biography")!,
                            preferences!.getString("intrested")!,
                            preferences!.getString("maritalstatus")!,
                            preferences!.getString("lookingfor")!,
                            images,
                            preferences!.getString("accesstoken")!,
                            preferences!.getString("age")!,imageindex,preferences!.getString("datewithid")!,preferences!.getString("genderid")!);
                        if(profileModel.statusCode==200)
                          {
                            // try {
                            //   ZIMUserInfo userInfo = ZIMUserInfo();
                            //   userInfo.userID=profileModel.data!.id.toString();
                            //   userInfo.userName=profileModel.data!.name.toString();
                            //   await ZIM.getInstance()!.login(userInfo);
                            //   Navigator.of(context).pop;
                            //   print('success');
                            //   UserModel.shared().userInfo = userInfo;
                            //   print(userInfo.userID);
                            //   print(userInfo.userName);
                            //   preferences!.setString('userID', userInfo.userID.toString());
                            //   preferences!.setString('userName', userInfo.userName.toString());
                            //   print(preferences!.getString('userID').toString());
                            //   print(preferences!.getString('userName').toString());
                              setState(() {
                                isLoad=false;
                              });
                              // preferences!.setBool("inter",true);
                              // preferences!.setBool("is_ghost",profileModel.data!.is_ghost!);
                              // preferences!.setString("name","");
                              // preferences!.setString("dateofbirth","");
                              // preferences!.setString("gender","");
                              // preferences!.setString("datewith","");
                              // preferences!.setString("biography","");
                              // preferences!.setString("intrested","");
                              // preferences!.setString("maritalstatus","");
                              // preferences!.setString("lookingfor","");
                              // preferences!.setString("maritalstatus","");
                              // preferences!.setString("age","");
                              // preferences!.setStringList("photo",[]);
                              // preferences!.setStringList("imagesindex",[]);
                              Navigator.push(context,
                                  MaterialPageRoute(builder:
                                      (context) =>
                                      StartQuizScreen(isGhostMode: profileModel.data!.is_ghost!,)
                                  )
                              );

                            // } on PlatformException catch (onError) {
                            //   Navigator.of(context).pop();
                            // }
                          }

                      },
                      child: Container(
                          height: 50.h,
                          width: MediaQuery.of(context).size.width*0.35,
                          decoration: BoxDecoration(borderRadius:
                          BorderRadius.all(Radius.circular(20.r)),border: Border.all(color: Colorss.mainColor,
                              width: 1.5)),
                          alignment: Alignment.center,
                          child: addMediumText(AppLocalizations.of(context)!.continues,15, Colorss.mainColor)
                      )
                    ):Container(child: CircularProgressIndicator(),alignment: Alignment.topCenter,):Container(
                        height: 40.h,
                        width: MediaQuery.of(context).size.width*0.30,
                        decoration: BoxDecoration(borderRadius:
                        BorderRadius.all(Radius.circular(20.r)),border: Border.all(color: Colorss.mainColor,
                            width: 1.5)),
                        alignment: Alignment.center,
                        child: addMediumText(AppLocalizations.of(context)!.continues,10, Colorss.mainColor)
                    ),
                    SizedBox(height: 100,)
                  ],
                ),
              )
            ],
          )
        ),
      ),
    );
  }
  // login(profileModel) async {
  //   try {
  //     ZIMUserInfo userInfo = ZIMUserInfo();
  //     userInfo.userID=profileModel.data!.id.toString();
  //     userInfo.userName=profileModel.data!.name.toString();
  //     await ZIM.getInstance()!.login(userInfo);
  //     Navigator.of(context).pop;
  //     print('success');
  //     UserModel.shared().userInfo = userInfo;
  //     final prefs = await SharedPreferences.getInstance();
  //     await prefs.setString('userID', profileModel.data!.id.toString());
  //     await prefs.setString('userName', profileModel.data!.name.toString());
  //     setState(() {
  //       isLoad=false;
  //     });
  //     preferences!.setBool("inter",true);
  //     preferences!.setBool("is_ghost",profileModel.data!.is_ghost!);
  //     Navigator.push(context,
  //         MaterialPageRoute(builder:
  //             (context) =>
  //             StartQuizScreen(isGhostMode: profileModel.data!.is_ghost!,)
  //         )
  //     );
  //
  //   } on PlatformException catch (onError) {
  //     Navigator.of(context).pop();
  //   }
  // }

}

