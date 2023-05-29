import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moorky/commanWidget/commanwidget.dart';
import 'package:moorky/profilecreate/provider/profileprovider.dart';
import 'package:moorky/profilecreate/repository/profileRepository.dart';
import 'package:moorky/quizscreens/quizprovider/QuizProvider.dart';
import 'package:moorky/quizscreens/view/drinkscreen.dart';
import 'package:moorky/quizscreens/view/educationhavescreen.dart';
import 'package:moorky/quizscreens/view/extrovertintrovertscreen.dart';
import 'package:moorky/quizscreens/view/feelkidsscreen.dart';
import 'package:moorky/quizscreens/view/languages_screen.dart';
import 'package:moorky/quizscreens/view/petscreen.dart';
import 'package:moorky/quizscreens/view/questionscreen.dart';
import 'package:moorky/quizscreens/view/religionscreen.dart';
import 'package:moorky/quizscreens/view/sexualorientationscreen.dart';
import 'package:moorky/quizscreens/view/smokescreen.dart';
import 'package:moorky/quizscreens/view/starsignscreen.dart';
import 'package:moorky/quizscreens/view/workscreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:moorky/constant/color.dart';
import '../../commanWidget/onboardbuttonwidget.dart';
import 'schoolscreen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class HeightPicker extends StatefulWidget {
  bool isEdit=false;
  String distanceValue="130.0";
  bool back=false;
  bool skip=false;
  HeightPicker({required this.isEdit,required this.distanceValue,required this.back});

  @override
  State<HeightPicker> createState() => _HeightPickerState();
}

class _HeightPickerState extends State<HeightPicker> {
  SharedPreferences? preferences;
  var _scaKey = GlobalKey<ScaffoldState>();
  String height="";
  int height_option=0;
  @override
  void initState() {
    print(widget.distanceValue);
    if (double.tryParse(widget.distanceValue) != null) {

      print('a is a numeric string');
    } else {
      height=widget.distanceValue;
      widget.distanceValue="130";
      print('a is NOT a numeric string');
    }

    // var r=isNumeric(int.parse(widget.distanceValue));
    // print(r);
    print(height);

    Init();
    super.initState();
  }


  void Init() async {
    preferences = await SharedPreferences.getInstance();
    var quizprovider=Provider.of<QuizProvider>(context,listen: false);
    quizprovider.resetStreams();
    if(preferences!.getString("accesstoken")!=null)
    {
      quizprovider.fetchHeightList(preferences!.getString("accesstoken").toString());
    }
  }
  bool isLoad=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaKey,
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
                      vertical: 20.sp, horizontal: 25.sp),
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: SvgPicture.asset(
                          'assets/images/height.svg',
                          height: 200.h,
                          width: 220.w,
                        ),
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      Container(
                          alignment: Alignment.topLeft,
                          child: addSemiBoldText(AppLocalizations.of(context)!.howtallareyou,18, Colorss.mainColor)
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              addBoldText('${double.parse(widget.distanceValue).toStringAsFixed(0)} cm', 12, Colors.black),
                              addBoldText('270 Cm', 12, Color(0xFF9A9999)),
                            ],
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: SfSlider(
                              min: 130.0,
                              max: 270.0,
                              value: widget.distanceValue!=""?double.parse(double.parse(widget.distanceValue).toStringAsFixed(0)):0.0,
                              interval: 20,
                              showTicks: false,
                              showLabels: false,
                              enableTooltip: true,
                              thumbIcon: Container(decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(25)),margin: EdgeInsets.all(4),),

                              tooltipShape: SfPaddleTooltipShape(),
                              stepSize: 1,
                              minorTicksPerInterval: 1,
                              activeColor: Colorss.mainColor,
                              onChanged: (value) {
                                setState(() {
                                  widget.distanceValue = value.toString();
                                  height="";
                                  print("distance value");
                                  print(widget.distanceValue);
                                });
                              },
                              onChangeEnd: (value) {
                                print(value);
                              },
                            ),
                          ),
                          Consumer<QuizProvider>(
                              builder: (context, quizprovider, child) => quizprovider.heightList?.data != null?ListView.builder(
                                itemCount: quizprovider.heightList!.data!.length,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(vertical: 7.sp),
                                    child: Row(
                                      children: [
                                        Container(
                                          child: Radio(
                                              value: quizprovider.heightList!.data!.elementAt(index).name.toString(),
                                            groupValue: height,
                                            fillColor:
                                            height==
                                                ""?MaterialStateColor.resolveWith((states) => Color(0xFFD24F94)):
                                            MaterialStateColor.resolveWith((states) => Colorss.mainColor),

                                              onChanged: (value)
                                              {
                                                setState(() {
                                                  print(value);
                                                  height=value.toString();
                                                  widget.distanceValue="130";

                                                  //widget.distanceValue = value.toString();
                                                });
                                              },activeColor: Colorss.mainColor,),
                                          height: 30.h,
                                        ),
                                        addRegularText( quizprovider.heightList!.data!.elementAt(index).name!, 12, Color(0xFF15294B)),
                                      ],
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
                            onBoardProgress(20.w),
                            widget.distanceValue!=""?GestureDetector(
                                onTap: ()async {
                                  setState(() {
                                    isLoad=true;
                                  });
                                  if(height != "")
                                  {
                                    preferences!.setString("height", height);
                                  }
                                  else{
                                    preferences!.setString("height", widget.distanceValue);
                                  }
                                  print(preferences!.getString("height").toString());
                                  var model=await ProfileRepository.updateProfile(preferences!.getString("height").toString(), "tall_are_you", preferences!.getString("accesstoken")!);
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
            )

          :SizedBox(
                width: double.maxFinite,
                child: Column(children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.sp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        widget.back?onBoardBackwardButton((){
                          Get.back();
                        }):Container(),
                        onBoardProgress(20.w),
                        (widget.distanceValue!="0" || widget.distanceValue!="0.0")?Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  print(widget.distanceValue);
                                  print(height);
                                  if(height != "")
                                  {
                                    preferences!.setString("height", height);
                                  }
                                  else{
                                    preferences!.setString("height", '${widget.distanceValue} cm');
                                  }
                                  print(preferences!.getString("height").toString());
                                  Navigator.push(context,
                                      MaterialPageRoute(builder:
                                          (context) =>
                                          School(isEdit: false,schoolText: "",back: true,)
                                      )
                                  );
                                },
                                child:
                                SvgPicture.asset('assets/images/tick.svg'))
                          ],
                        ):onBoardForwardButton(() {
                          preferences!.setString("height", "");
                          Navigator.push(context,
                              MaterialPageRoute(builder:
                                  (context) =>
                                  School(isEdit: false,schoolText: "",back: true,)
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
