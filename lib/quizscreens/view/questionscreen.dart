import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moorky/commanWidget/commanwidget.dart';
import 'package:moorky/profilecreate/provider/profileprovider.dart';
import 'package:moorky/profilecreate/repository/profileRepository.dart';
import 'package:moorky/quizscreens/model/questionupdatemodel.dart';
import 'package:moorky/quizscreens/repository/quizrepository.dart';
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
import 'package:moorky/quizscreens/view/workscreen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../quizprovider/QuizProvider.dart';
import 'drinkscreen.dart';
import '../../commanWidget/onboardbuttonwidget.dart';
import 'package:moorky/constant/color.dart';
class QuestionScreen extends StatefulWidget {
  bool isEdit=false;
  List<dynamic> questionList=<dynamic>[];
  bool back=false;
  bool skip=false;
  QuestionScreen({required this.isEdit,required this.questionList,required this.back});
  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  SharedPreferences? preferences;
  var _scaKey = GlobalKey<ScaffoldState>();
  bool isLoad=false;
  String answer="";
  @override
  void initState() {
    Init();
    super.initState();
  }


  void Init() async {
    if(widget.questionList.isNotEmpty)
      {
        answer=widget.questionList.elementAt(0)['answer'];
        print("answerif");
        print(answer);
      }

    print("answer");
    print(answer);
    preferences = await SharedPreferences.getInstance();
    var quizprovider=Provider.of<QuizProvider>(context,listen: false);
    quizprovider.resetStreams();
    if(preferences!.getString("accesstoken")!=null)
    {
      print(preferences!.getString("accesstoken")!);
      quizprovider.fetchQuestionList(preferences!.getString("accesstoken").toString());
    }
  }

  Future<String> answerbottemsheet(BuildContext context,String question,String answer) async{
    TextEditingController answerController=new TextEditingController();
    await showModalBottomSheet<dynamic>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => SafeArea(
          child: Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: 50.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.r),
                    topRight: Radius.circular(30.r)),
              ),
              child: StatefulBuilder(
                  builder: (BuildContext context, StateSetter stateSetter) {
                    return Container(
                      padding: EdgeInsets.all(25.r),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child:
                                addBoldCenterText(question, 14, Colorss.mainColor,),
                          ),
                          SizedBox(height: 20.h,),
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: MediaQuery.of(context).viewInsets.bottom),
                            child: TextFormField(
                              maxLines: 6,
                              textInputAction: TextInputAction.done,
                              controller: answerController,
                              textCapitalization: TextCapitalization.sentences,
                              onChanged: (value){
                                setState(() {
                                  answer=value;
                                });
                              },
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16.0.r),
                                    borderSide: BorderSide(
                                        color: Colorss.mainColor,
                                        width: 1.0
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16.0.r),
                                    borderSide: BorderSide(
                                        color: Colorss.mainColor,
                                        width: 1.0
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16.0.r),
                                    borderSide: BorderSide(
                                        color: Colorss.mainColor,
                                        width: 1.0
                                    ),
                                  ),
                                  filled: true,
                                  hintStyle: GoogleFonts.poppins(textStyle: TextStyle(color: Colors.grey[600])),
                                  hintText: AppLocalizations.of(context)!.enteryourans,
                                  fillColor: Colors.white70),
                            ),
                          ),
                          SizedBox(height: 20.h,),
                          answer!=""?Align(
                            alignment: Alignment.topRight,
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: (){
                                setState(() {
                                  answer=answerController.text;
                                });
                                Navigator.of(context).pop();
                              },
                              child: SvgPicture.asset('assets/images/tick.svg'),
                            ),
                          ):Align(
                            alignment: Alignment.topRight,
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: (){
                                setState(() {
                                  answer=answerController.text;
                                });
                                Navigator.of(context).pop();
                              },
                              child: SvgPicture.asset('assets/images/lighttick.svg',),
                            ),
                          ),
                        ],
                      ),
                    );
                  })),
        ));

    return answer;
  }
  @override
  Widget build(BuildContext context) {
    print("widget.isEdit");
    print(widget.isEdit);
    print(widget.questionList);
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        'assets/images/questionans.svg',
                        height: 80.h,
                        width: 80.w,
                      ),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                 addBoldText(AppLocalizations.of(context)!.answerquestions, 20, Colorss.mainColor),
                    SizedBox(
                      height: 10.h,
                    ),
                    addRegularText(AppLocalizations.of(context)!.youranswerhelp, 12, Color(0xFF363D4E).withOpacity(0.40)),
                    SizedBox(
                      height: 20.h,
                    ),
                    Consumer<QuizProvider>(
                        builder: (context, quizprovider, child) => quizprovider.questionList?.data != null?
                        Expanded(
                          child: ListView.builder(
                            itemCount: quizprovider.questionList!.data!.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: ScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              print(widget.questionList);
                              for(int i=0;i<widget.questionList.length;i++)
                              {
                                print("===${widget.questionList.elementAt(i)['question_id']}");
                                print(widget.questionList.elementAt(i)['answer']);

                                if(widget.questionList.elementAt(i)['question_id']==quizprovider.questionList!.data!.elementAt(index).id.toString())
                                {
                                  print(quizprovider.questionList!.data!.elementAt(index).id.toString());
                                  quizprovider.questionList!.data!.elementAt(index).answer = widget.questionList.elementAt(i)['answer'].toString();
                                }
                              }

                              return InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: ()async{
                                  quizprovider.questionList!.data!.elementAt(index).answer=await answerbottemsheet(context,quizprovider.questionList!.data!.elementAt(index).question!,quizprovider.questionList!.data!.elementAt(index).answer!);
                                  answer=quizprovider.questionList!.data!.elementAt(index).answer.toString();
                                  print("answeriddd");
                                  print(answer);
                                  if(quizprovider.questionList!.data!.elementAt(index).answer!="")
                                    {
                                      QuestionUpdateModel questionmodel=QuestionUpdateModel(question_id: quizprovider.questionList!.data!.elementAt(index).id!.toString(),answer: quizprovider.questionList!.data!.elementAt(index).answer!);
                                      for(int i=0;i<widget.questionList.length;i++)
                                      {
                                        if(widget.questionList.elementAt(i)['question_id']==quizprovider.questionList!.data!.elementAt(index).id.toString())
                                        {
                                          widget.questionList.remove(widget.questionList.elementAt(i));
                                        }
                                      }
                                      widget.questionList.add(questionmodel.toJson());
                                    }
                                },
                                child: Container(
                                  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(16.r),),color: Color(0xFFC2A3DD).withOpacity(0.20)),
                                  margin: EdgeInsets.only(bottom: 15.h),
                                  padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 20.h),
                                  alignment: Alignment.center,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      addBoldCenterText(quizprovider.questionList!.data!.elementAt(index).question!, 12, Colorss.mainColor),
                                      quizprovider.questionList!.data!.elementAt(index).answer!=""?SizedBox(height: 10.h,):Container(),
                                      quizprovider.questionList!.data!.elementAt(index).answer!=""?Text(quizprovider.questionList!.data!.elementAt(index).answer!,
                                        style: GoogleFonts.poppins(textStyle: TextStyle(
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.w500)),
                                      ):Container(),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ):Center(child: CircularProgressIndicator(),)
                    ),
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
                            onBoardProgress(40.w),
                            (answer!="")?GestureDetector(
                                onTap: ()async {
                                  setState(() {
                                    isLoad=true;
                                  });
                                  var model=await QuizRepository.userquestionlistupdate(preferences!.getString("accesstoken")!,widget.questionList);

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
                                     else if(provider.profiledetails!.data!.sexualOrientation == "")
                                    {
                                      if(provider.sexual == "")
                                        {
                                          Get.off(SexualOrientation(isEdit:true,sexualtext: "",back: true,));
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
            ):SizedBox(
                width: double.maxFinite,
                child: Column(children: [
                  !isLoad?Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.sp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        widget.back?onBoardBackwardButton((){
                          Get.back();
                        }):Container(),
                        onBoardProgress(40.w),
                        (answer!="")?Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                                onTap: () async{
                                  print(widget.questionList.length);
                                  print(widget.questionList);
                                  if(widget.questionList.length>0)
                                    {
                                      var questionUpdateModel=await QuizRepository.userquestionlistupdate(preferences!.getString("accesstoken")!,widget.questionList);
                                      if(questionUpdateModel.statusCode==200)
                                      {
                                        setState(() {
                                          isLoad=false;
                                        });
                                        Get.to(Drink(isEdit: false,drinktext: "",back: true,));
                                      }
                                    }
                                  else{
                                      Get.to(Drink(isEdit: false,drinktext: "",back: true,));
                                  }


                                },
                                child:
                                SvgPicture.asset('assets/images/tick.svg'))
                          ],
                        ):onBoardForwardButton(() async{

                                Get.to(Drink(isEdit: false,drinktext: "",back: true,));
                        }),
                      ],
                    ),
                  ):Container(child: CircularProgressIndicator(),alignment: Alignment.topCenter,),
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
