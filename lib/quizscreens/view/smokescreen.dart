import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moorky/commanWidget/commanwidget.dart';
import 'package:moorky/profilecreate/provider/profileprovider.dart';
import 'package:moorky/profilecreate/repository/profileRepository.dart';
import 'package:moorky/quizscreens/view/drinkscreen.dart';
import 'package:moorky/quizscreens/view/educationhavescreen.dart';
import 'package:moorky/quizscreens/view/extrovertintrovertscreen.dart';
import 'package:moorky/quizscreens/view/feelkidsscreen.dart';
import 'package:moorky/quizscreens/view/heightpickerscreen.dart';
import 'package:moorky/quizscreens/view/languages_screen.dart';
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
import 'package:moorky/constant/color.dart';
import '../../commanWidget/onboardbuttonwidget.dart';
import '../quizprovider/QuizProvider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class SmokeScreen extends StatefulWidget {
  bool isEdit=false;
  String smoketext = "";
  bool back=false;
  bool skip=false;
  SmokeScreen({required this.isEdit,required this.smoketext,required this.back});
  @override
  State<SmokeScreen> createState() => _SmokeScreenState();
}

class _SmokeScreenState extends State<SmokeScreen> {
  SharedPreferences? preferences;
  var _scaKey = GlobalKey<ScaffoldState>();
  bool isLoad=false;
  int smoke_id=0;
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
      quizprovider.fetchSmokeList(preferences!.getString("accesstoken").toString());
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
      body: Container(
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
                          'assets/images/smoke.svg',
                          height: 200.h,
                          width: 220.w,
                        ),
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      Container(
                          alignment: Alignment.topLeft,
                          child: addSemiBoldText(AppLocalizations.of(context)!.doyousmoke,18, Colorss.mainColor)
                      ),
                      SizedBox(
                        height: 20.sp,
                      ),
                      Consumer<QuizProvider>(
                          builder: (context, quizprovider, child) => quizprovider.smokeList?.data != null?
                          ListView.builder(
                            itemCount: quizprovider.smokeList!.data!.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              for(int i=0;i<quizprovider.smokeList!.data!.length;i++)
                                {
                                  if(quizprovider.smokeList!.data!.elementAt(index).name.toString()==widget.smoketext)
                                    {
                                      quizprovider.smokeList!.data!.elementAt(index).isSelected=true;
                                      smoke_id=quizprovider.smokeList!.data!.elementAt(index).id!;
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
                                    addRegularText( quizprovider.smokeList!.data!.elementAt(index).name!, 12, Color(0xFF15294B)),
                                    Checkbox(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.0.r))),
                                      activeColor: Colorss.mainColor,
                                      value: quizprovider.smokeList!.data!.elementAt(index).isSelected==null?false:quizprovider.smokeList!.data!.elementAt(index).isSelected,
                                      onChanged: (value) {
                                        setState(() {
                                          setState(() {
                                            for(int i=0;i<quizprovider.smokeList!.data!.length;i++)
                                            {
                                              if(quizprovider.smokeList!.data!.elementAt(i).isSelected==true)
                                              {
                                                quizprovider.smokeList!.data!.elementAt(i).isSelected=false;
                                              }
                                              widget.smoketext=quizprovider.smokeList!.data!.elementAt(index).name!;
                                              smoke_id=quizprovider.smokeList!.data!.elementAt(index).id!;
                                              quizprovider.smokeList!.data!.elementAt(index).isSelected = value;
                                            }
                                          });

                                        });
                                      },
                                      side: MaterialStateBorderSide.resolveWith(
                                            (states) => BorderSide(
                                            width: 1.5.w, color: Colorss.mainColor),
                                      ),
                                    ),
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
                            onBoardProgress(80.w),
                            widget.smoketext!=""?GestureDetector(
                                onTap: ()async {
                                  setState(() {
                                    isLoad=true;
                                  });
                                  var model=await ProfileRepository.updateProfile(smoke_id.toString(), "do_you_smoke", preferences!.getString("accesstoken")!);
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
                                     else if(provider.profiledetails!.data!.sexualOrientation == "")
                                    {
                                      if(provider.sexual == "")
                                        {
                                          Get.off(SexualOrientation(isEdit:true,sexualtext: "",back: true,));
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
                        onBoardProgress(80.w),
                        widget.smoketext!=""?Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  preferences!.setString("smoketext", smoke_id.toString());
                                  Navigator.push(context,
                                      MaterialPageRoute(builder:
                                          (context) =>
                                          FeelkidsScreen(isEdit: false,feelkidstext: "",back: true,)
                                      )
                                  );
                                },
                                child:
                                SvgPicture.asset('assets/images/tick.svg'))
                          ],
                        ): onBoardForwardButton(() {
                            preferences!.setString("smoketext", "");
                          Navigator.push(context,
                              MaterialPageRoute(builder:
                                  (context) =>
                                  FeelkidsScreen(isEdit: false,feelkidstext: "",back: true,)
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
    );
  }
}
