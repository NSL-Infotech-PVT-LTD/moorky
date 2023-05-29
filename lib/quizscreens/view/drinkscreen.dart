import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moorky/commanWidget/commanwidget.dart';
import 'package:moorky/profilecreate/provider/profileprovider.dart';
import 'package:moorky/profilecreate/repository/profileRepository.dart';
import 'package:moorky/quizscreens/quizprovider/QuizProvider.dart';
import 'package:moorky/quizscreens/view/educationhavescreen.dart';
import 'package:moorky/quizscreens/view/extrovertintrovertscreen.dart';
import 'package:moorky/quizscreens/view/feelkidsscreen.dart';
import 'package:moorky/quizscreens/view/heightpickerscreen.dart';
import 'package:moorky/quizscreens/view/petscreen.dart';
import 'package:moorky/quizscreens/view/questionscreen.dart';
import 'package:moorky/quizscreens/view/religionscreen.dart';
import 'package:moorky/quizscreens/view/schoolscreen.dart';
import 'package:moorky/quizscreens/view/sexualorientationscreen.dart';
import 'package:moorky/quizscreens/view/starsignscreen.dart';
import 'package:moorky/quizscreens/view/workscreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../commanWidget/onboardbuttonwidget.dart';
import 'languages_screen.dart';
import 'smokescreen.dart';
import 'package:moorky/constant/color.dart';
class Drink extends StatefulWidget {
 bool isEdit=false;
 String drinktext = "";
 bool back=false;
 Drink({required this.isEdit,required this.drinktext,required this.back});

  @override
  State<Drink> createState() => _DrinkState();
}

class _DrinkState extends State<Drink> {
  var _scaKey = GlobalKey<ScaffoldState>();
  bool isLoad=false;
  int drink_id=0;
  SharedPreferences? preferences;
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
      quizprovider.fetchDrinkList(preferences!.getString("accesstoken").toString());
    }
  }
  
  @override
  Widget build(BuildContext context) {
    print("widget.isEdit");
    print(widget.isEdit);
    return Scaffold(
      key:_scaKey,
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
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
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
                            'assets/images/drink.svg',
                            height: 200.h,
                            width: 220.w,
                          ),
                        ),
                        SizedBox(
                          height: 40.h,
                        ),
                        Container(
                            alignment: Alignment.topLeft,
                            child: addSemiBoldText(AppLocalizations.of(context)!.doyoudrink,18, Colorss.mainColor)
                        ),
                        SizedBox(
                          height: 20.sp,
                        ),
                        Consumer<QuizProvider>(
                            builder: (context, quizprovider, child) => quizprovider.drinkList?.data != null?
                            ListView.builder(
                              itemCount: quizprovider.drinkList!.data!.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                for(int i=0;i<quizprovider.drinkList!.data!.length;i++)
                                {
                                  if(quizprovider.drinkList!.data!.elementAt(index).name.toString()==widget.drinktext)
                                  {
                                    quizprovider.drinkList!.data!.elementAt(index).isSelected=true;
                                    drink_id=quizprovider.drinkList!.data!.elementAt(index).id!;
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
                                      addRegularText( quizprovider.drinkList!.data!.elementAt(index).name!, 12, Color(0xFF15294B)),
                                      Checkbox(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5.0.r))),
                                        activeColor: Colorss.mainColor,
                                        value: quizprovider.drinkList!.data!.elementAt(index).isSelected==null?false:quizprovider.drinkList!.data!.elementAt(index).isSelected,
                                        onChanged: (value) {
                                          setState(() {
                                            setState(() {
                                              for(int i=0;i<quizprovider.drinkList!.data!.length;i++)
                                              {
                                                if(quizprovider.drinkList!.data!.elementAt(i).isSelected==true)
                                                {
                                                  quizprovider.drinkList!.data!.elementAt(i).isSelected=false;
                                                }
                                                widget.drinktext=quizprovider.drinkList!.data!.elementAt(index).name!;
                                                drink_id=quizprovider.drinkList!.data!.elementAt(index).id!;
                                                quizprovider.drinkList!.data!.elementAt(index).isSelected = value;
                                              }
                                            });

                                          });
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
                      ],
                    ),
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
                              onBoardProgress(60.w),
                              widget.drinktext!=""?GestureDetector(
                                  onTap: ()async {
                                    setState(() {
                                      isLoad=true;
                                    });
                                    var model=await ProfileRepository.updateProfile(drink_id.toString(), "do_you_drink", preferences!.getString("accesstoken")!);
                                    if(model.statusCode==200)
                                    {
                                      setState(() {
                                        isLoad=false;
                                      });
                                      var provider=await Provider.of<ProfileProvider>(context,listen: false);
                                      provider.resetStreams();
                                      provider.adddetails(model);

                                      if(provider.profiledetails!.data!.sexualOrientation == "")
                                      {
                                        if(provider.sexual == "")
                                        {
                                          Get.off(SexualOrientation(isEdit:true,sexualtext: "",back: true,));
                                        }
                                      }
                                   else if(provider.profiledetails!.data!.tallAreYou == "")
                                    {
                                      if(provider.height == "")
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
                                      else if(provider.profiledetails!.data!.languages!.length == 0)
                                      {
                                        if(provider.language=="")
                                          {
                                            Get.off(LanguageListScreen(isEdit:true,langugaesId: "",back: true,));
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
                              // GestureDetector(
                              //     onTap: ()async {
                              //       var provider=await Provider.of<ProfileProvider>(context,listen: false);
                              //       if(provider.profiledetails!.data!.tallAreYou == "")
                              //       {
                              //         if(provider.height == "")
                              //           {
                              //             provider.height="1";
                              //             Get.to(HeightPicker(isEdit: true, distanceValue: "",back: true,));
                              //           }
                              //       }
                              //       if(provider.profiledetails!.data!.school == "")
                              //       {
                              //         if(provider.school == "")
                              //           {
                              //             provider.school="1";
                              //             Get.to(School(isEdit: true, schoolText: "",back: true,));
                              //           }
                              //       }
                              //       if(provider.profiledetails!.data!.jobTitle == "")
                              //       {
                              //         if(provider.work == "")
                              //           {
                              //             provider.work="1";
                              //             Get.to(Work(isEdit: true, jobtitle: "",companynametext: "",back: true,));
                              //           }
                              //       }
                              //       if(provider.profiledetails!.data!.userQuestions!.length == 0)
                              //       {
                              //         if(provider.question == "")
                              //           {
                              //             provider.question="1";
                              //             Get.to(QuestionScreen(isEdit:true,questionList: [],back: true,));
                              //           }
                              //       }
                              //       if(provider.profiledetails!.data!.sexualOrientation == "")
                              //       {
                              //         if(provider.sexual == "")
                              //           {
                              //             provider.sexual="1";
                              //             Get.to(SexualOrientation(isEdit:true,sexualtext: "",back: true,));
                              //           }
                              //       }
                              //       if(provider.profiledetails!.data!.doYouSmoke == "")
                              //       {
                              //         if(provider.smoke == "")
                              //           {
                              //             provider.smoke="1";
                              //             Get.to(SmokeScreen(isEdit:true,smoketext: "",back: true,));
                              //           }
                              //       }
                              //       if(provider.profiledetails!.data!.feelAboutKids == "")
                              //       {
                              //         if(provider.kids=="")
                              //           {
                              //             provider.kids="1";
                              //             Get.to(FeelkidsScreen(isEdit:true,feelkidstext: "",back: true,));
                              //           }
                              //       }
                              //       if(provider.profiledetails!.data!.education == "")
                              //       {
                              //         if(provider.education=="")
                              //           {
                              //             provider.education="1";
                              //             Get.to(EducationHaveScreen(isEdit:true,educationtext: "",back: true,));
                              //           }
                              //       }
                              //       if(provider.profiledetails!.data!.introvertOrExtrovert == "")
                              //       {
                              //         if(provider.introextro == "")
                              //           {
                              //             provider.introextro="1";
                              //             Get.to(ExtrovertIntrovertScreen(isEdit:true,introextrotext: "",back: true,));
                              //           }
                              //       }
                              //       if(provider.profiledetails!.data!.starSign == "")
                              //       {
                              //         if(provider.starsign == "")
                              //           {
                              //             provider.starsign="1";
                              //             Get.to(StarSignScreen(isEdit:true,starsigntext: "",back: true,));
                              //           }
                              //       }
                              //       if(provider.profiledetails!.data!.havePets == "")
                              //       {
                              //         if(provider.pets == "")
                              //           {
                              //             provider.pets="1";
                              //             Get.to(PetScreen(isEdit:true,petstext: "",back: true,));
                              //           }
                              //       }
                              //       if(provider.profiledetails!.data!.religion == "")
                              //       {
                              //         if(provider.religion == "")
                              //           {
                              //             provider.religion="1";
                              //             Get.to(ReligionScreen(isEdit:true,religiontext: "",back: true,));
                              //           }
                              //       }
                              //       if(provider.profiledetails!.data!.languages!.length == 0)
                              //       {
                              //         if(provider.language == "")
                              //           {
                              //             provider.language="1";
                              //             Get.to(LanguageListScreen(isEdit:true,langugaesId: "",back: true,));
                              //           }
                              //       }
                              //       if(provider.profiledetails!.data!.realPhoto == "")
                              //       {
                              //         Get.to(PhotoVerifyScreen(back: true,realphoto: "",isEdit: true,));
                              //       }
                              //       else {
                              //         Navigator.pop(context);}
                              //     },
                              //     child:
                              //     SvgPicture.asset('assets/images/forward.svg'))
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
                          height: 8.h,width: 140.w,decoration: BoxDecoration(color: Color(0xFF751ACD),borderRadius: BorderRadius.circular(25.r)),),
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
                          onBoardProgress(60.w),
                          widget.drinktext!=""?Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    preferences!.setString("drinktext", drink_id.toString());
                                    print(widget.drinktext);
                                    Navigator.push(context,
                                        MaterialPageRoute(builder:
                                            (context) =>
                                            SmokeScreen(isEdit: false,smoketext: "",back: true,)
                                        )
                                    );
                                  },
                                  child:
                                  SvgPicture.asset('assets/images/tick.svg'))
                            ],
                          ):onBoardForwardButton(() {
                              preferences!.setString("drinktext", "");
                            Navigator.push(context,
                                MaterialPageRoute(builder:
                                    (context) =>
                                    SmokeScreen(isEdit: false,smoketext: "",back: true,)
                                )
                            );
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
                            height: 8.h,width: 140.w,decoration: BoxDecoration(color: Color(0xFF751ACD),borderRadius: BorderRadius.circular(25.r)),),
                        ],
                      ),
                    ),
                  ])),
            ],
          ),
        ),
      ),
    );
  }
}
