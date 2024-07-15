import 'package:age_calculator/age_calculator.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:moorky/auth/view/password_screen.dart';
import 'package:moorky/commanWidget/commanwidget.dart';
import 'package:moorky/constant/color.dart';
import 'package:moorky/profilecreate/view/genderscreen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'photoscreen.dart';
import '../provider/profileprovider.dart';

class DateofBirthScreen extends StatefulWidget {
  @override
  State<DateofBirthScreen> createState() => _DateofBirthScreenState();
}

class _DateofBirthScreenState extends State<DateofBirthScreen> {
  bool isTrue=false;
  String name="";
  String age="X";
  String? selectedValue1;
  String? selectedValue2;
  String? selectedValue3;
  var dd = TextEditingController();
  var mm = TextEditingController();
  var yyyy = TextEditingController();
  SharedPreferences? preferences;
  var key = GlobalKey<FormState>();
  DateTime nowDate = DateTime.now();
  late int currYear = nowDate.year;
  bool isGhost=false;
  String lang="";
  @override
  void initState() {
    print(selectedValue2);
    Init();
    super.initState();
  }
  void Init()async{
    preferences=await SharedPreferences.getInstance();
    if(preferences!.getString("lang")!=null)
    {
      lang=preferences!.getString("lang").toString();
      setState(() {
      });
    }
  }
  var _scaKey = GlobalKey<ScaffoldState>();
  void _next() {
    if (key.currentState!.validate()) {
      if (int.parse(age.toString()) < 0) {
        showSnakbar(AppLocalizations.of(context)!.pleaseentervaliddob, context);
        return;
      } else if (int.parse(dd.text) == 0 ||
          int.parse(dd.text) > 31 ||
          int.parse(mm.text) == 0 ||
          int.parse(mm.text) > 12 ||
          int.parse(yyyy.text) == 0 ||
          int.parse(yyyy.text) < 1900 ||
          (int.parse(yyyy.text) > currYear)) {
        showSnakbar(AppLocalizations.of(context)!.entervaliddate, context);

        //Fluttertoast.showToast(msg: "Enter Valid Date");
        return;
      } else if (int.parse(age) < 18) {
        showSnakbar(AppLocalizations.of(context)!.pleaseenterage18, context);
        //Fluttertoast.showToast(msg: "Please enter age >= 18.");
        return;
      }
      preferences!.setString("age", age);
      String month;
      String day;
      month=mm.text;
      day=dd.text;
      if(month.length>1)
        {
          print(month);
          print("adasds");

        }
      else{
        if(int.parse(month)<10)
        {
         setState(() {
           month="0${month}";
         });
        }
        print(month);
      }

      if(day.length>1)
      {
        print(day);
        print("adasds");

      }
      else{
        if(int.parse(day)<10)
        {
          setState(() {
            day="0${day}";
          });

        }
        print(day);
      }

        preferences!.setString("dateofbirth","${yyyy.text}-${month}-${day}");
        print(preferences!.getString("dateofbirth"));
        if(preferences!
            .getBool("ghostactivate")!=null)
          {
            isGhost=preferences!
                .getBool("ghostactivate")!;
          }
        if(isGhost)
          {
            Navigator.push(context,
                MaterialPageRoute(builder:
                    (context) =>
                    GenderScreen(gender: "",isEdit:false,showGender: false,)
                )
            );
          }
        else{
          Get.to(PhotoScreen(isEdit: false,imagefile1: "",
            imagefile2: "",
            imagefile3: "",
            imagefile4: "",
            imagefile5: "",
            imagefile6: "",
            imageid1: "",
            imageid2: "",
            imageid3: "",
            imageid4: "",
            imageid5: "",
            imageid6: "",));
        }

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(title: addMediumText(AppLocalizations.of(context)!.dateofbirth,18,Colorss.mainColor),centerTitle: true,backgroundColor: Colors.transparent,elevation: 0,leading:
      InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: (){
            Navigator.of(context).pop();
          },
          child: SvgPicture.asset("assets/images/arrowback.svg",fit: BoxFit.scaleDown,))),
      body: Form(
        key: key,
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 120.h,),
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceEvenly,
                      children: [
                          Container(
                            width: 90.w,
                            padding: EdgeInsets.only(left: 5),
                            decoration: BoxDecoration(color:Colors.white,borderRadius: BorderRadius.circular(20),border: Border.all(color: Colorss.mainColor,width: 1.5.w)),
                            child: TextFormField(
                              validator: (val) {
                                if (val!.isEmpty)
                                  return '*required';
                                return null;
                              },
                              autofocus: true,
                              maxLength: 2,
                              onChanged: (val) {
                                if (val.length == 2) {
                                  print(dd.text);
                                  print(mm.text);
                                  print(yyyy.text);
                                  setState(() {
                                    if(dd.text.toString()!=""&&mm.text.toString()!=""&&yyyy.text.toString()!="")
                                    {
                                      age = getDOB(dd.text +
                                          "-" +
                                          mm.text +
                                          "-" +
                                          yyyy.text);
                                    }
                                  });
                                  FocusScope.of(context)
                                      .nextFocus();
                                }
                              },
                              controller: dd,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  errorStyle: Theme.of(context)
                                      .textTheme
                                      .headline5
                                      ?.copyWith(color: Colors.red),
                                  counterText: "",
                                  border: InputBorder.none,
                                hintStyle: GoogleFonts.poppins(fontSize: 16,color:Color(0xFF7118C5),fontWeight: FontWeight.w600),
                                  hintText: AppLocalizations.of(context)!.dd),
                              style: GoogleFonts.poppins(fontSize: 16,color:Color(0xFF7118C5),fontWeight: FontWeight.w600),
                              textAlign: TextAlign.center,
                            ),
                          ),
                              SizedBox(width: 2.w,),
                        Container(
                          width: 90.w,
                          padding: EdgeInsets.only(left: 5),
                          decoration: BoxDecoration(color:Colors.white,borderRadius: BorderRadius.circular(20),border: Border.all(color: Colorss.mainColor,width: 1.5.w)),
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            validator: (val) {
                              if (val!.isEmpty)
                                return '*required';
                              return null;
                            },
                            onChanged: (val) {
                              if (val.length == 2) {
                                print(dd.text);
                                print(mm.text);
                                print(yyyy.text);
                                setState(() {
                                  if(dd.text.toString()!=""&&mm.text.toString()!=""&&yyyy.text.toString()!="")
                                    {
                                      age = getDOB(dd.text +
                                          "-" +
                                          mm.text +
                                          "-" +
                                          yyyy.text);
                                    }
                                });
                                FocusScope.of(context)
                                    .nextFocus();
                              } else if (val.isEmpty) {
                                FocusScope.of(context)
                                    .previousFocus();
                              }
                            },
                            maxLength: 2,
                            autofocus: false,
                            controller: mm,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                errorStyle: Theme.of(context)
                                    .textTheme
                                    .headline5
                                    ?.copyWith(color: Colors.red),
                                counterText: "",
                                border: InputBorder.none,
                                hintText: AppLocalizations.of(context)!.mm,
                              hintStyle: GoogleFonts.poppins(fontSize: 16,color:Color(0xFF7118C5),fontWeight: FontWeight.w600),),
                            style: GoogleFonts.poppins(fontSize: 16,color:Color(0xFF7118C5),fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(width: 2.w,),
                        Container(
                          width: 90.w,
                          padding: EdgeInsets.only(left: 5),
                          decoration: BoxDecoration(color:Colors.white,borderRadius: BorderRadius.circular(20),border: Border.all(color: Colorss.mainColor,width: 1.5.w)),
                          child: TextFormField(
                            textInputAction: TextInputAction.done,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return '*required';
                              }
                              return null;
                            },
                            autofocus: false,
                            maxLength: 4,
                            controller: yyyy,
                            onChanged: (val) {
                              print(dd.text);
                              print(mm.text);
                              print(yyyy.text);
                              if (val.length >= 4) {
                                if(dd.text.toString()!=""&&mm.text.toString()!=""&&yyyy.text.toString()!="")
                                {
                                  age = getDOB(dd.text +
                                      "-" +
                                      mm.text +
                                      "-" +
                                      yyyy.text);
                                }
                                FocusScope.of(context).unfocus();
                              } else if (val.isEmpty) {
                                FocusScope.of(context)
                                    .previousFocus();
                              }
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                errorStyle: Theme.of(context)
                                    .textTheme
                                    .headline5
                                    ?.copyWith(color: Colors.red),
                                border: InputBorder.none,
                                counterText: "",
                                hintStyle: GoogleFonts.poppins(fontSize: 16,color:Color(0xFF7118C5),fontWeight: FontWeight.w600),
                                hintText: AppLocalizations.of(context)!.yyyy),
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(fontSize: 16,color:Color(0xFF7118C5),fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 35.h,),
                    Container(
                      padding: EdgeInsets.only(left: 20.w,right: 60.w),
                      child: addLightText(
                          lang=="tr"?
                      "${age} ${AppLocalizations.of(context)!.youare} 😇":"${AppLocalizations.of(context)!.youare} ${age} 😇", 12, Color(0xFF15294B))
                    ),
                  ],
                ),
                Column(
                  children: [
                    age!="X"?InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: ()async{
                        _next();
                      },
                      child: Container(
                        height: 70.h,
                        margin: EdgeInsets.only(left: 25.w,right: 25.w,bottom: 15.h),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: <Color>[
                                Color(0xFF570084),
                                Color(0xFFA33BE5)
                              ],
                            ),
                            borderRadius: BorderRadius.circular(50.r)),
                        alignment: Alignment.center,
                        child: addMediumText(AppLocalizations.of(context)!.continues, 14, Color(0xFFFFFFFF))
                      ),
                    ):Container(
                      height: 70.h,
                      margin: EdgeInsets.only(top: 90.h,left: 25.w,right: 25.w,bottom: 15.h),
                      decoration: BoxDecoration(
                          border: Border.all(color: Color(0xFFC2A3DD),width: 1.0),

                          borderRadius: BorderRadius.circular(50.r)),
                      alignment: Alignment.center,
                      child: addMediumText(AppLocalizations.of(context)!.continues, 14, Color(0xFFC2A3DD))
                    ),
                    // Container(
                    //   margin: EdgeInsets.only(bottom: 15.h),
                    //   child: Container(
                    //     height: 8.h,width: 140.w,decoration: BoxDecoration(color: Colors.black,borderRadius: BorderRadius.circular(25.r)),),
                    // ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  String getDOB(String birthDateString) {
    String datePattern = "dd-MM-yyyy";

    DateTime birthDate = DateFormat(datePattern).parse(birthDateString);
    DateDuration duration;
    // Find out your age as of today's date 2021-03-08
    duration = AgeCalculator.age(birthDate);
    return "${duration.years}";
  }
}
