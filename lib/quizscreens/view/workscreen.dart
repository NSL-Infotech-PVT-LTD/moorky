import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moorky/commanWidget/commanwidget.dart';
import 'package:moorky/profilecreate/provider/profileprovider.dart';
import 'package:moorky/profilecreate/repository/profileRepository.dart';
import 'package:moorky/quizscreens/repository/quizrepository.dart';
import 'package:moorky/quizscreens/view/drinkscreen.dart';
import 'package:moorky/quizscreens/view/educationhavescreen.dart';
import 'package:moorky/quizscreens/view/extrovertintrovertscreen.dart';
import 'package:moorky/quizscreens/view/feelkidsscreen.dart';
import 'package:moorky/quizscreens/view/heightpickerscreen.dart';
import 'package:moorky/quizscreens/view/languages_screen.dart';
import 'package:moorky/quizscreens/view/petscreen.dart';
import 'package:moorky/quizscreens/view/religionscreen.dart';
import 'package:moorky/quizscreens/view/schoolscreen.dart';
import 'package:moorky/quizscreens/view/sexualorientationscreen.dart';
import 'package:moorky/quizscreens/view/smokescreen.dart';
import 'package:moorky/quizscreens/view/starsignscreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:moorky/constant/color.dart';
import '../../commanWidget/onboardbuttonwidget.dart';
import 'questionscreen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class Work extends StatefulWidget {
  bool isEdit=false;
  String jobtitle="";
  String companynametext="";
  bool back=false;
  bool skip=false;
  Work({required this.isEdit,required this.jobtitle,required this.companynametext,required this.back});
  @override
  State<Work> createState() => _WorkState();
}

class _WorkState extends State<Work> {
  TextEditingController jobtitleController=new TextEditingController();
  TextEditingController companynameController=new TextEditingController();
  var _scaKey = GlobalKey<ScaffoldState>();
  SharedPreferences? preferences;
  bool isLoad=false;
  @override
  void initState() {
    Init();
    super.initState();
  }
  void Init() async {
    preferences = await SharedPreferences.getInstance();
    jobtitleController.text=widget.jobtitle;
    companynameController.text=widget.companynametext;
  }
  @override
  Widget build(BuildContext context) {
    print("widget.isEdit");
    print(widget.isEdit);
    return Scaffold(
      key:_scaKey,
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
            child: SvgPicture.asset("assets/images/arrowback.svg",fit: BoxFit.scaleDown,)),
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
                            'assets/images/work.svg',
                            height: 200.h,
                            width: 220.w,
                          ),
                        ),
                        SizedBox(
                          height: 40.h,
                        ),
                        Container(
                            alignment: Alignment.topLeft,
                            child: addSemiBoldText(AppLocalizations.of(context)!.whatwork,18, Colorss.mainColor)
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Container(
                          child: TextFormField(
                            controller: jobtitleController,
                            onChanged: (value){
                              setState(() {
                                widget.jobtitle=value;
                              });
                            },
                            textCapitalization: TextCapitalization.sentences,
                            style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 22.sp)),
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                                isDense: true,
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xFFC2A3DD)),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xFFC2A3DD)),
                                ),
                                hintText: AppLocalizations.of(context)!.jobtitle,
                                hintStyle: GoogleFonts.poppins(textStyle: TextStyle(color: Color(0xFFa8a8a8), fontSize: 22.sp))),
                          ),
                        ),
                        SizedBox(
                          height: 25.h,
                        ),
                        Container(
                          child: TextFormField(
                            controller: companynameController,
                            onChanged: (value){
                              setState(() {
                                widget.companynametext=value;
                              });
                            },
                            textCapitalization: TextCapitalization.sentences,
                            style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 22.sp)),
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                                isDense: true,
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xFFC2A3DD)),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xFFC2A3DD)),
                                ),
                                hintText: AppLocalizations.of(context)!.comapnyname,
                                hintStyle:  GoogleFonts.poppins(textStyle: TextStyle(color: Color(0xFFa8a8a8), fontSize: 22.sp))),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              widget.isEdit?!isLoad?
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
                          onBoardProgress(30.w),
                          (widget.jobtitle!=""&&widget.companynametext!="")?GestureDetector(
                              onTap: ()async {
                                setState(() {
                                  isLoad=true;
                                });
                                var model=await ProfileRepository.updateWork(widget.jobtitle.toString(),widget.companynametext.toString(), preferences!.getString("accesstoken")!);
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
                                   else if(provider.profiledetails!.data!.sexualOrientation == "")
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
                  ])):Container(child: CircularProgressIndicator(),alignment: Alignment.topCenter,):!isLoad?SizedBox(
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
                          onBoardProgress(30.sp),
                          (widget.jobtitle!=""&&widget.companynametext!="")?Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                  onTap: () async{
                                    print(widget.jobtitle);
                                    print(widget.companynametext);
                                    setState(() {
                                      isLoad=true;
                                    });
                                    preferences!.setString("jobtitle", widget.jobtitle.toString());
                                    preferences!.setString("companyname", widget.companynametext.toString());
                                    preferences!.getString("accesstoken").toString();
                                    preferences!.getString("sexualtext").toString();
                                    preferences!.getString("height").toString();
                                    preferences!.getString("school").toString();
                                    preferences!.getString("jobtitle").toString();
                                    preferences!.getString("companyname").toString();
                                    var profileModel=await QuizRepository.updatesexualtowork(preferences!.getString("sexualtext").toString(),
                                        preferences!.getString("accesstoken").toString(),
                                        preferences!.getString("height").toString(),
                                        preferences!.getString("school").toString(),
                                        preferences!.getString("jobtitle").toString(),
                                        preferences!.getString("companyname").toString());
                                    print(profileModel.statusCode);
                                    if(profileModel.statusCode==200)
                                    {
                                      setState(() {
                                        isLoad=false;
                                      });
                                      widget.companynametext="";
                                      widget.jobtitle="";
                                      companynameController.clear();
                                      jobtitleController.clear();

                                      List<dynamic> questionList=<dynamic>[];
                                      Navigator.push(context,
                                          MaterialPageRoute(builder:
                                              (context) =>
                                              QuestionScreen(isEdit: false,questionList:questionList,back: true,)
                                          )
                                      );
                                    }
                                  },
                                  child:
                                  SvgPicture.asset('assets/images/tick.svg'))
                            ],
                          ):onBoardForwardButton(()async {
                            setState(() {
                              isLoad=true;
                            });
                              preferences!.setString("jobtitle", "");
                              preferences!.setString("companyname", "");
                            var profileModel=await QuizRepository.updatesexualtowork(preferences!.getString("sexualtext")!,
                                preferences!.getString("accesstoken")!,
                                preferences!.getString("height")!,
                                preferences!.getString("school")!,
                                preferences!.getString("jobtitle")!,
                                preferences!.getString("companyname")!);
                            print(profileModel.statusCode);
                            if(profileModel.statusCode==200)
                            {
                              setState(() {
                                isLoad=false;
                              });
                              widget.companynametext="";
                              widget.jobtitle="";
                              companynameController.clear();
                              jobtitleController.clear();

                              List<dynamic> questionList=<dynamic>[];
                              Navigator.push(context,
                                  MaterialPageRoute(builder:
                                      (context) =>
                                          QuestionScreen(isEdit: false,questionList:questionList,back: true,)
                                  )
                              );
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
                            height: 8.h,width: 140.w,decoration: BoxDecoration(color: Color(0xFF751ACD),borderRadius: BorderRadius.circular(25.r)),),
                        ],
                      ),
                    ),
                  ])):Container(child: CircularProgressIndicator(),alignment: Alignment.topCenter,),
            ],
          ),
        ),
      ),
    );
  }
}
