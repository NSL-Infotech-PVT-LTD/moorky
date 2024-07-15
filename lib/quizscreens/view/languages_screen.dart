import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:moorky/commanWidget/commanwidget.dart';
import 'package:moorky/dashboardscreen/messagescreen/view/ghostmode_screen.dart';
import 'package:moorky/dashboardscreen/view/dashboardscreen.dart';
import 'package:moorky/profilecreate/provider/profileprovider.dart';
import 'package:moorky/profilecreate/repository/profileRepository.dart';
import 'package:moorky/quizscreens/model/questionupdatemodel.dart';
import 'package:moorky/quizscreens/quizprovider/QuizProvider.dart';
import 'package:moorky/quizscreens/repository/quizrepository.dart';
import 'package:moorky/quizscreens/view/drinkscreen.dart';
import 'package:moorky/quizscreens/view/educationhavescreen.dart';
import 'package:moorky/quizscreens/view/extrovertintrovertscreen.dart';
import 'package:moorky/quizscreens/view/feelkidsscreen.dart';
import 'package:moorky/quizscreens/view/heightpickerscreen.dart';
import 'package:moorky/quizscreens/view/petscreen.dart';
import 'package:moorky/quizscreens/view/questionscreen.dart';
import 'package:moorky/quizscreens/view/religionscreen.dart';
import 'package:moorky/quizscreens/view/schoolscreen.dart';
import 'package:moorky/quizscreens/view/sexualorientationscreen.dart';
import 'package:moorky/quizscreens/view/smokescreen.dart';
import 'package:moorky/quizscreens/view/starsignscreen.dart';
import 'package:moorky/quizscreens/view/workscreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../commanWidget/onboardbuttonwidget.dart';
import 'package:moorky/constant/color.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LanguageListScreen extends StatefulWidget {
  bool isEdit=false;
  String langugaesId="";
  bool back=false;
  bool skip=false;
  LanguageListScreen({required this.isEdit,required this.langugaesId,required this.back});
  @override
  State<LanguageListScreen> createState() => _LanguageListScreenState();
}

class _LanguageListScreenState extends State<LanguageListScreen> {
  SharedPreferences? preferences;
  int count=0;
  @override
  void initState() {
    Init();
    super.initState();
  }

  void Init() async {
    preferences = await SharedPreferences.getInstance();
    var quizprovider=Provider.of<QuizProvider>(context,listen: false);
    quizprovider.resetStreams();
    if(preferences!.getString("accesstoken")!=null)
    {
      quizprovider.fetchLanguageList(preferences!.getString("accesstoken").toString());
    }
  }
  var _scaKey = GlobalKey<ScaffoldState>();
  bool isLoad=false;
  @override
  Widget build(BuildContext context) {
    print("widget.isEdit");
    print(widget.isEdit);
    return Scaffold(
      key: _scaKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: (){
                Navigator.of(context).pop();
              },
              child: SvgPicture.asset("assets/images/arrowback.svg",fit: BoxFit.scaleDown,))
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                    vertical: 20.h, horizontal: 25.w),
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        'assets/images/extrovertintrovert.svg',
                        height: 200.h,
                        width: 220.w,
                      ),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: addSemiBoldText(AppLocalizations.of(context)!.inwhichlanguage, 18, Colorss.mainColor)
                    ),
                    SizedBox(
                      height: 20.sp,
                    ),
                    Expanded(
                      child: Consumer<QuizProvider>(
                          builder: (context, quizprovider, child) => quizprovider.languageList?.data != null?
                          ListView.builder(
                            itemCount: quizprovider.languageList!.data!.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: ScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              for(int i=0;i<quizprovider.languageList!.data!.length;i++)
                              {
                                if(quizprovider.languageList!.data!.elementAt(index).id.toString()==widget.langugaesId)
                                {
                                  quizprovider.languageList!.data!.elementAt(index).isSelected=true;
                                }
                              }
                              return Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(12.sp),
                                    ),
                                    border: Border.all(
                                        color: Color(0xFF912DCE), width: 1.w)),
                                margin: EdgeInsets.only(bottom: 10.h),
                                padding: EdgeInsets.only(left: 20.w,right: 5.w),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    addRegularText(quizprovider.languageList!.data!.elementAt(index).language!, 12, Color(0xFF363D4E)),
                                    Checkbox(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.0.r))),
                                      activeColor: Colorss.mainColor,
                                      value: quizprovider.languageList!.data!.elementAt(index).isSelected!,
                                      onChanged: (value) {
                                        setState(() {
                                          for(int i=0;i<quizprovider.languageList!.data!.length;i++)
                                          {
                                            if(quizprovider.languageList!.data!.elementAt(i).isSelected==true)
                                            {
                                              quizprovider.languageList!.data!.elementAt(i).isSelected=false;
                                            }
                                            widget.langugaesId=quizprovider.languageList!.data!.elementAt(index).id.toString();
                                            quizprovider.languageList!.data!.elementAt(index).isSelected = value;
                                          }
                                        });

                                        //   setState(() {
                                        //     quizprovider.languageList!.data!.elementAt(index).isSelected = value;
                                        //     print(quizprovider.languageList!.data!.elementAt(index).isSelected);
                                        //     //LanguageListUpdateModel lan=LanguageListUpdateModel(language: quizprovider.languageList!.data!.elementAt(index).language.toString(),language_id: quizprovider.languageList!.data!.elementAt(index).id.toString());
                                        //     if(quizprovider.languageList!.data!.elementAt(index).isSelected==true)
                                        //     {
                                        //           widget.languageList.add(quizprovider.languageList!.data!.elementAt(index).id.toString());
                                        //
                                        //         }
                                        //         else{
                                        //           widget.languageList.remove(quizprovider.languageList!.data!.elementAt(index).id.toString());
                                        //
                                        //
                                        //       print("jhsgajhsgcasc");
                                        //      // print(lan.toJson());
                                        //     }
                                        //
                                        //
                                        //
                                        //
                                        //
                                        // });
                                      },
                                      side: MaterialStateBorderSide.resolveWith(
                                            (states) => BorderSide(
                                            width: 1.5.w, color: Colorss.mainColor),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          ):Center(child: CircularProgressIndicator(),)
                      ),
                    )
                  ],
                ),
              ),
            ),
            widget.isEdit?Column(
              children: [
                !isLoad?
                SizedBox(
                    width: double.maxFinite,
                    child: Column(children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children: [
                            widget.back?onBoardBackwardButton((){
                              Get.back();
                            }):Container(),
                            onBoardProgress(220.w),
                            widget.langugaesId!=""?GestureDetector(
                                onTap: ()async {
                                  setState(() {
                                    isLoad=true;
                                  });
                                  var model=await ProfileRepository.updateProfile(widget.langugaesId, "user_languages", preferences!.getString("accesstoken")!);
                                  if(model.statusCode==200)
                                  {
                                    setState(() {
                                      isLoad=false;
                                    });
                                    var provider=await Provider.of<ProfileProvider>(context,listen: false);
                                    provider.resetStreams();
                                    provider.adddetails(model);
                                    if(provider.profiledetails!.data!.tallAreYou == "")
                                    {
                                      if(provider.height=="")
                                        {
                                          Get.off(HeightPicker(isEdit: true, distanceValue: "",back: true,));
                                        }
                                    }
                                    else if(provider.profiledetails!.data!.school == "")
                                    {
                                      if(provider.school == "")
                                        {
                                          Get.off(School(isEdit: true, schoolText: "",back: true,));
                                        }
                                    }
                                     else if(provider.profiledetails!.data!.jobTitle == "")
                                    {
                                    if(provider.work == "")
                                    {
                                      Get.off(Work(isEdit: true, jobtitle: "",companynametext: "",back: true,));
                                    }
                                    }
                                     else if(provider.profiledetails!.data!.userQuestions!.length == 0)
                                    {
                                    if(provider.question == "")
                                    {
                                      Get.off(QuestionScreen(isEdit:true,questionList: [],back: true,));
                                    }
                                    }
                                    else if(provider.profiledetails!.data!.doYouDrink == "")
                                    {
                                      if(provider.drink =="")
                                        {
                                          Get.off(Drink(isEdit:true,drinktext: "",back: true,));
                                        }
                                    }
                                    else if(provider.profiledetails!.data!.doYouSmoke == "")
                                    {
                                    if(provider.smoke =="")
                                    {
                                      Get.off(SmokeScreen(isEdit:true,smoketext: "",back: true,));
                                    }
                                    }
                                    else if(provider.profiledetails!.data!.feelAboutKids == "")
                                    {
                                      if(provider.kids == "")
                                        {
                                          Get.off(FeelkidsScreen(isEdit:true,feelkidstext: "",back: true,));
                                        }
                                    }
                                     else if(provider.profiledetails!.data!.sexualOrientation == "")
                                    {
                                      if(provider.sexual == "")
                                        {
                                          Get.off(SexualOrientation(isEdit:true,sexualtext: "",back: true,));
                                        }
                                    }
                                     else if(provider.profiledetails!.data!.education == "")
                                    {
                                      if(provider.education=="")
                                        {
                                          Get.off(EducationHaveScreen(isEdit:true,educationtext: "",back: true,));
                                        }
                                    }
                                    else if(provider.profiledetails!.data!.introvertOrExtrovert == "")
                                    {
                                      if(provider.introextro == "")
                                        {
                                          Get.off(ExtrovertIntrovertScreen(isEdit:true,introextrotext: "",back: true,));
                                        }
                                    }
                                       else if(provider.profiledetails!.data!.starSign == "")
                                    {
                                      if(provider.starsign=="")
                                        {
                                          Get.off(StarSignScreen(isEdit:true,starsigntext: "",back: true,));
                                        }
                                    }
                                     else if(provider.profiledetails!.data!.havePets == "")
                                    {
                                      if(provider.pets=="")
                                        {
                                          Get.off(PetScreen(isEdit:true,petstext: "",back: true,));
                                        }
                                    }
                                    else if(provider.profiledetails!.data!.religion == "")
                                    {
                                      if(provider.religion=="")
                                        {
                                          Get.off(ReligionScreen(isEdit:true,religiontext: "",back: true,));
                                        }
                                    }
                                    else{
                                      Navigator.pop(context);
                                    }

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
                                child:
                                SvgPicture.asset('assets/images/tick.svg')):Container(width: 30.w,)
                          ],
                        ),
                      ),
                    ])):Container(child: CircularProgressIndicator(),alignment: Alignment.topCenter,),
                Container(
                  alignment: Alignment.bottomCenter,
                  margin: EdgeInsets.only(bottom: 15.h,top: 5.h),
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
            ):SizedBox(
                width: double.maxFinite,
                child: Column(children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        widget.back?onBoardBackwardButton((){
                          Get.back();
                        }):Container(),
                        onBoardProgress(220.w),
                        widget.langugaesId != ""?Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                                onTap: ()async {
                                  preferences!.setString("languagetext", widget.langugaesId.toString());
                                  bool ghostmode=false;
                                  String usertype="";
                                  if(preferences!.getBool("ghostactivate") != null)
                                    {
                                      ghostmode= preferences!.getBool("ghostactivate")!;
                                    }
                                  print("ghostmode");
                                  print(ghostmode);

                                  if(preferences!.getString("usertype") != null)
                                  {
                                    usertype= preferences!.getString("usertype")!.toString();
                                  }
                                  print("usertype");
                                  if(usertype=="basic"||usertype=="premium")
                                    {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder:
                                              (context) =>
                                              GhostMode_Screen(isskip: false,usertype: usertype,)
                                          )
                                      );
                                    }
                                  else if(usertype=="normal"){
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
                                      var ghostprofile=await ProfileRepository.updateProfile("1", "ghost_profile", preferences!.getString("accesstoken")!);
                                      if(ghostprofile.statusCode==200)
                                      {
                                        preferences!.setString("realphoto", "realphoto");
                                        Get.to(DashBoardScreen(pageIndex: 1,isNotification: false,));
                                      }
                                    }
                                  }
                                  else{
                                    preferences!.setString("realphoto", "realphoto");
                                    Get.to(DashBoardScreen(pageIndex: 1,isNotification: false,));
                                    // Navigator.push(context,
                                    //     MaterialPageRoute(builder:
                                    //         (context) =>
                                    //         PhotoVerifyScreen(back: true,isEdit: false,realphoto: "",)
                                    //     )
                                    // );
                                  }

                                },
                                child:
                                SvgPicture.asset('assets/images/tick.svg'))
                          ],
                        ):onBoardForwardButton(() async{
                          preferences!.setString("languagetext", "");
                          bool ghostmode=false;
                          String usertype="";
                          if(preferences!.getBool("ghostactivate") != null)
                          {
                            ghostmode= preferences!.getBool("ghostactivate")!;
                          }
                          print("ghostmode");
                          print(ghostmode);

                          if(preferences!.getString("usertype") != null)
                          {
                            usertype= preferences!.getString("usertype")!.toString();
                          }
                          print("usertype");
                          if(usertype=="basic"||usertype=="premium")
                          {
                            Navigator.push(context,
                                MaterialPageRoute(builder:
                                    (context) =>
                                    GhostMode_Screen(isskip: false,usertype: usertype,)
                                )
                            );
                          }
                          else if(usertype=="normal"){
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
                              var ghostprofile=await ProfileRepository.updateProfile("1", "ghost_profile", preferences!.getString("accesstoken")!);
                              if(ghostprofile.statusCode==200)
                              {
                                preferences!.setString("realphoto", "realphoto");
                                Get.to(DashBoardScreen(pageIndex: 1,isNotification: false,));
                              }
                            }
                          }
                          else{
                            preferences!.setString("realphoto", "realphoto");
                            Get.to(DashBoardScreen(pageIndex: 1,isNotification: false,));
                            // Navigator.push(context,
                            //     MaterialPageRoute(builder:
                            //         (context) =>
                            //         PhotoVerifyScreen(back: true,isEdit: false,realphoto: "",)
                            //     )
                            // );
                          }
                        }),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    margin: EdgeInsets.only(bottom: 15.h,top: 5.h),
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
                ])),
          ],
        ),
      ),
    );
  }
}
