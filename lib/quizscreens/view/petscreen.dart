import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:moorky/commanWidget/commanwidget.dart';
import 'package:moorky/profilecreate/provider/profileprovider.dart';
import 'package:moorky/profilecreate/repository/profileRepository.dart';
import 'package:moorky/quizscreens/quizprovider/QuizProvider.dart';
import 'package:moorky/quizscreens/view/drinkscreen.dart';
import 'package:moorky/quizscreens/view/educationhavescreen.dart';
import 'package:moorky/quizscreens/view/extrovertintrovertscreen.dart';
import 'package:moorky/quizscreens/view/feelkidsscreen.dart';
import 'package:moorky/quizscreens/view/heightpickerscreen.dart';
import 'package:moorky/quizscreens/view/languages_screen.dart';
import 'package:moorky/quizscreens/view/questionscreen.dart';
import 'package:moorky/quizscreens/view/schoolscreen.dart';
import 'package:moorky/quizscreens/view/sexualorientationscreen.dart';
import 'package:moorky/quizscreens/view/smokescreen.dart';
import 'package:moorky/quizscreens/view/starsignscreen.dart';
import 'package:moorky/quizscreens/view/workscreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../commanWidget/onboardbuttonwidget.dart';
import 'religionscreen.dart';
import 'package:moorky/constant/color.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class PetScreen extends StatefulWidget {
  bool isEdit=false;
  String petstext = "";
  bool back=false;
  bool skip=false;
  PetScreen({required this.isEdit,required this.petstext,required this.back});
  @override
  State<PetScreen> createState() => _PetScreenState();
}

class _PetScreenState extends State<PetScreen> {
  SharedPreferences? preferences;
  int have_pets_id=0;
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
      quizprovider.fetchPetsList(preferences!.getString("accesstoken").toString());
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
                        'assets/images/pet.svg',
                        height: 200.h,
                        width: 220.w,
                      ),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    Container(
                        alignment: Alignment.topLeft,
                        child: addSemiBoldText(AppLocalizations.of(context)!.doyouhavepets,18, Colorss.mainColor)
                    ),
                    SizedBox(
                      height: 20.sp,
                    ),
                    Expanded(
                      child: Consumer<QuizProvider>(
                          builder: (context, quizprovider, child) => quizprovider.petsList?.data != null?
                          ListView.builder(
                            itemCount: quizprovider.petsList!.data!.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: ScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              for(int i=0;i<quizprovider.petsList!.data!.length;i++)
                              {
                                if(quizprovider.petsList!.data!.elementAt(index).name.toString()==widget.petstext)
                                {
                                  quizprovider.petsList!.data!.elementAt(index).isSelected=true;
                                  have_pets_id=quizprovider.petsList!.data!.elementAt(index).id!;
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
                                    addRegularText(quizprovider.petsList!.data!.elementAt(index).name!, 12, Color(0xFF15294B)),
                                    Checkbox(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.0.r))),
                                      activeColor: Colorss.mainColor,
                                      value: quizprovider.petsList!.data!.elementAt(index).isSelected==null?false:quizprovider.petsList!.data!.elementAt(index).isSelected,
                                      onChanged: (value) {
                                        setState(() {
                                          setState(() {
                                            for(int i=0;i<quizprovider.petsList!.data!.length;i++)
                                            {
                                              if(quizprovider.petsList!.data!.elementAt(i).isSelected==true)
                                              {
                                                quizprovider.petsList!.data!.elementAt(i).isSelected=false;
                                              }
                                              widget.petstext=quizprovider.petsList!.data!.elementAt(index).name!;
                                              have_pets_id=quizprovider.petsList!.data!.elementAt(index).id!;
                                              quizprovider.petsList!.data!.elementAt(index).isSelected = value;
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
                            onBoardProgress(200.w),
                            widget.petstext!=""?GestureDetector(
                                onTap: ()async {
                                  setState(() {
                                    isLoad=true;
                                  });
                                  var model=await ProfileRepository.updateProfile(have_pets_id.toString(), "have_pets", preferences!.getString("accesstoken")!);
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
                        onBoardProgress(200.w),
                        widget.petstext!=""?Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  preferences!.setString("petstext", have_pets_id.toString());
                                  Navigator.push(context,
                                      MaterialPageRoute(builder:
                                          (context) =>
                                          ReligionScreen(isEdit: false,religiontext: "",back: true,)
                                      )
                                  );
                                },
                                child:
                                SvgPicture.asset('assets/images/tick.svg'))
                          ],
                        ):onBoardForwardButton(() {
                            preferences!.setString("petstext", "");
                          Navigator.push(context,
                              MaterialPageRoute(builder:
                                  (context) =>
                                  ReligionScreen(isEdit: false,religiontext: "",back: true,)
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
                          height: 8.h,width: 140.w,)
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
