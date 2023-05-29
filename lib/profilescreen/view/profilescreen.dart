import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moorky/commanWidget/commanwidget.dart';
import 'package:moorky/dashboardscreen/homescreen/view/homescreen.dart';
import 'package:moorky/dashboardscreen/messagescreen/view/ghostmode_screen.dart';
import 'package:moorky/dashboardscreen/messagescreen/view/messagescreen.dart';
import 'package:moorky/dashboardscreen/messagescreen/view/useractivity_screen.dart';
import 'package:moorky/dashboardscreen/provider/dashboardprovider.dart';
import 'package:moorky/lang/provider/locale_provider.dart';
import 'package:moorky/profilecreate/provider/profileprovider.dart';
import 'package:moorky/profilecreate/repository/profileRepository.dart';
import 'package:moorky/profilecreate/view/editprofilescreen.dart';
import 'package:moorky/profilecreate/view/namescreen.dart';
import 'package:moorky/quizscreens/quizprovider/QuizProvider.dart';
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
import 'package:moorky/settingscreen/provider/setting_provider.dart';
import 'package:moorky/settingscreen/view/settingscreen.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:moorky/constant/color.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../premiumscreen/view/premiumscreen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  double percentage = 0.0;
  String quizquestion = "";

  SharedPreferences? preferences;
  @override
  void initState() {
    Init();
    super.initState();
  }

  void Init() async {
    preferences = await SharedPreferences.getInstance();
    var profileprovider = Provider.of<ProfileProvider>(context, listen: false);
    profileprovider.resetStreams();
    if (preferences!.getString("accesstoken") != null) {
      profileprovider.fetchProfileDetails(
          preferences!.getString("accesstoken").toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    percentage = 0.0;
    return Scaffold(
      appBar: AppBar(
        title: username != ""
            ? addSemiBoldText(username, 18, Colorss.mainColor)
            : Container(),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              Navigator.of(context).pop();
            },
            child: SvgPicture.asset(
              "assets/images/cross.svg",
              fit: BoxFit.scaleDown,
              color: Color(0xFF000000),
            )),
        actions: [
          IconButton(
            iconSize: 60,
            onPressed: () {
              Get.to(SettingScreen());
            },
            icon: SvgPicture.asset(
              "assets/images/setting.svg",
              fit: BoxFit.scaleDown,
              color: Color(0xFF000000),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        alignment: Alignment.center,
        height: 10.h,
        margin: EdgeInsets.only(bottom: 15.h),
        child: Container(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 8.h,
            width: 140.w,
            decoration: BoxDecoration(
                color: Color(0xFF751ACD),
                borderRadius: BorderRadius.circular(25.r)),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Consumer<ProfileProvider>(
              builder: (context, profileProvider, child) {
                percentage = 0.0;
                if (profileProvider.profiledetails?.data != null) {
                  print("!profileProvider.profiledetails!.data!.ghost_profile!");
                  print(!profileProvider.profiledetails!.data!.ghost_profile!);
                  username = profileProvider.profiledetails!.data!.name;
                  if (profileProvider.profiledetails!.data!.name != "") {
                    percentage = double.parse(percentage.toStringAsFixed(2)) + 0.06;
                  }
                  if (profileProvider.profiledetails!.data!.dateOfBirth != "") {
                    percentage = double.parse(percentage.toStringAsFixed(2)) + 0.06;
                  }
                  if (profileProvider.profiledetails!.data!.images!.length > 0) {
                    percentage = double.parse(percentage.toStringAsFixed(2)) + 0.06;
                  }
                  if (profileProvider.profiledetails!.data!.gender != "") {
                    percentage = double.parse(percentage.toStringAsFixed(2)) + 0.06;
                  }
                  if (profileProvider.profiledetails!.data!.dateWith != "") {
                    percentage = double.parse(percentage.toStringAsFixed(2)) + 0.06;
                  }
                  if (profileProvider.profiledetails!.data!.maritalStatus != "") {
                    percentage = double.parse(percentage.toStringAsFixed(2)) + 0.07;
                  }
                  if (profileProvider.profiledetails!.data!.lookingFor != "") {
                    percentage = double.parse(percentage.toStringAsFixed(2)) + 0.07;
                  }
                  if (profileProvider.profiledetails!.data!.biography != "") {
                    percentage = double.parse(percentage.toStringAsFixed(2)) + 0.08;
                  }
                  if (profileProvider.profiledetails!.data!.interests!.length > 0) {
                    percentage = double.parse(percentage.toStringAsFixed(2)) + 0.09;
                  }

                  if (profileProvider.profiledetails!.data!.sexualOrientation !=
                      "") {
                    percentage = double.parse(percentage.toStringAsFixed(2)) + 0.03;
                  } else {
                    if (quizquestion == "") {
                      quizquestion = AppLocalizations.of(context)!.whatsexyaloreintaion;
                    }
                  }

                  if (profileProvider.profiledetails!.data!.tallAreYou != "") {
                    percentage = double.parse(percentage.toStringAsFixed(2)) + 0.03;
                  } else {
                    if (quizquestion == "") {
                      quizquestion = AppLocalizations.of(context)!.howtallareyou;
                    }
                  }
                  if (profileProvider.profiledetails!.data!.school != "") {
                    percentage = double.parse(percentage.toStringAsFixed(2)) + 0.03;
                  } else {
                    if (quizquestion == "") {
                      quizquestion = AppLocalizations.of(context)!.gotoschool;
                    }
                  }
                  if (profileProvider.profiledetails!.data!.jobTitle != "") {
                    percentage =
                        double.parse(percentage.toStringAsFixed(2)) + 0.015;
                  } else {
                    if (quizquestion == "") {
                      quizquestion = AppLocalizations.of(context)!.whatwork;
                    }
                  }
                  if (profileProvider.profiledetails!.data!.companyName != "") {
                    percentage =
                        double.parse(percentage.toStringAsFixed(2)) + 0.015;
                  } else {
                    if (quizquestion == "") {
                      quizquestion = AppLocalizations.of(context)!.whatwork;
                    }
                  }
                  if (profileProvider.profiledetails!.data!.userQuestions!.length >
                      0) {
                    percentage = double.parse(percentage.toStringAsFixed(2)) + 0.03;
                  } else {
                    if (quizquestion == "") {
                      quizquestion = AppLocalizations.of(context)!.answerquestions;
                    }
                  }
                  if (profileProvider.profiledetails!.data!.doYouDrink != "") {
                    percentage = double.parse(percentage.toStringAsFixed(2)) + 0.03;
                  } else {
                    if (quizquestion == "") {
                      quizquestion = AppLocalizations.of(context)!.doyoudrink;
                    }
                  }
                  if (profileProvider.profiledetails!.data!.doYouSmoke != "") {
                    percentage = double.parse(percentage.toStringAsFixed(2)) + 0.03;
                  } else {
                    if (quizquestion == "") {
                      quizquestion = AppLocalizations.of(context)!.doyousmoke;
                    }
                  }
                  if (profileProvider.profiledetails!.data!.feelAboutKids != "") {
                    percentage = double.parse(percentage.toStringAsFixed(2)) + 0.03;
                  } else {
                    if (quizquestion == "") {
                      quizquestion = AppLocalizations.of(context)!.feelaboutkids;
                    }
                  }
                  if (profileProvider.profiledetails!.data!.education != "") {
                    percentage = double.parse(percentage.toStringAsFixed(2)) + 0.03;
                  } else {
                    if (quizquestion == "") {
                      quizquestion = AppLocalizations.of(context)!.whateducation;
                    }
                  }
                  if (profileProvider.profiledetails!.data!.introvertOrExtrovert !=
                      "") {
                    percentage = double.parse(percentage.toStringAsFixed(2)) + 0.03;
                  } else {
                    if (quizquestion == "") {
                      quizquestion = AppLocalizations.of(context)!.areyouintroextro;
                    }
                  }
                  if (profileProvider.profiledetails!.data!.starSign != "") {
                    percentage = double.parse(percentage.toStringAsFixed(2)) + 0.03;
                  } else {
                    if (quizquestion == "") {
                      quizquestion = AppLocalizations.of(context)!.whatreligion;
                    }
                  }
                  if (profileProvider.profiledetails!.data!.havePets != "") {
                    percentage = double.parse(percentage.toStringAsFixed(2)) + 0.04;
                  } else {
                    if (quizquestion == "") {
                      quizquestion = AppLocalizations.of(context)!.doyouhavepets;
                    }
                  }
                  if (profileProvider.profiledetails!.data!.religion != "") {
                    percentage = double.parse(percentage.toStringAsFixed(2)) + 0.03;
                  } else {
                    if (quizquestion == "") {
                      quizquestion = AppLocalizations.of(context)!.whatreligion;
                    }
                  }

                  // if (profileProvider.profiledetails!.data!.realPhoto != "") {
                  // } else {
                  //   if (quizquestion == "") {
                  //     quizquestion = profileProvider
                  //         .profiledetails!.data!.quizQuestion!.realPhoto;
                  //   }
                  // }

                  print("percentage");
                  print(percentage);
                  print("!profileProvider.profiledetails!.data!.ghost_profile!");
                  print(profileProvider.profiledetails!.data!.ghost_profile!);
                  print(profileProvider
                      .profiledetails!.data!.profile_image!
                      .toString());
                }
                print(percentage);
                return profileProvider.profiledetails?.data != null
                    ? Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 60.h),
                          alignment: Alignment.topCenter,
                          child: CircularPercentIndicator(
                            radius: 60.0,
                            lineWidth: 3.0,
                            animation: true,
                            backgroundColor: Colors.transparent,
                            percent:
                            double.parse(percentage.toStringAsFixed(1)),
                            reverse: true,
                            center: CachedNetworkImage(
                              imageUrl: profileProvider
                                  .profiledetails!.data!.profile_image!
                                  .toString(),
                              fit: BoxFit.cover,
                              imageBuilder: (context, imageProvider) =>
                                  CircleAvatar(
                                    backgroundImage: imageProvider,
                                    radius: 57.0,
                                  ),
                            ),
                            progressColor: Colorss.mainColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    Text(
                      "${profileProvider.profiledetails!.data!.name}, ${profileProvider.profiledetails!.data!.age}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: "Avenir Heavy",
                          fontSize: 24,
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    Text(
                      "#${profileProvider.profiledetails!.data!.id}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: "Avenir Heavy",
                          fontSize: 24,
                          color: Colorss.mainColor),
                    ),
                    (percentage * 100).toStringAsFixed(0) != "100"
                        ? InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        Get.to(EditprofileScreen(
                          viewprofile: false,
                          percentage:
                          (percentage * 100).toStringAsFixed(0),
                        ));
                      },
                      child: Container(
                        height: 30.h,
                        margin: EdgeInsets.only(top: 20.h),
                        width: 130.w,
                        decoration: BoxDecoration(
                            color: Color(0xFFC2A3DD),
                            borderRadius: BorderRadius.circular(50.r)),
                        alignment: Alignment.center,
                        child: Text(
                            "%${(percentage * 100).toStringAsFixed(0)} ${AppLocalizations.of(context)!.complete}",
                            textScaleFactor: 1.0,
                            style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 12)),
                      ),
                    )
                        : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            Get.to(EditprofileScreen(
                              viewprofile: true,
                              percentage:
                              (percentage * 100).toStringAsFixed(0),
                            ));
                          },
                          child: Container(
                            height: 30.h,
                            margin: EdgeInsets.only(top: 20.h),
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                                color: Colorss.mainColor,
                                borderRadius:
                                BorderRadius.circular(50.r)),
                            alignment: Alignment.center,
                            child: Text(
                                AppLocalizations.of(context)!
                                    .viewprofile,
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                    color: Color(0xFFFFFFFF),
                                    fontSize: 12)),
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(Premium_Screen());
                      },
                      child: Container(
                        height: 70.h,
                        margin: EdgeInsets.only(
                            top: 40.h, left: 25.w, right: 25.w),
                        width: MediaQuery.of(context).size.width * 0.90,
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
                        child: Padding(
                          padding: EdgeInsets.only(left: 30.0.w, right: 15.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SvgPicture.asset(
                                "assets/images/slike.svg",
                                fit: BoxFit.scaleDown,
                                height: 30.h,
                                width: 25.w,
                              ),
                              addMediumText(
                                  AppLocalizations.of(context)!
                                      .getmoorkypremium
                                      .toUpperCase(),
                                  14,
                                  Colors.white),
                              SvgPicture.asset(
                                "assets/images/arrowforword.svg",
                                height: 15.h,
                                width: 15.w,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 60.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.w),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (profileProvider.quizquestion ==
                                      profileProvider.profiledetails!.data!
                                          .quizQuestion!.sexualOrientation) {
                                    profileProvider.quizquestion = AppLocalizations.of(context)!.whatsexyaloreintaion;
                                    Get.to(SexualOrientation(
                                      isEdit: true,
                                      sexualtext: "",
                                      back: false,
                                    ));
                                  } else if (profileProvider.quizquestion ==
                                      profileProvider.profiledetails!.data!
                                          .quizQuestion!.tallAreYou) {
                                    Get.to(HeightPicker(
                                      isEdit: true,
                                      distanceValue: "",
                                      back: false,
                                    ));
                                  } else if (profileProvider.quizquestion ==
                                      profileProvider.profiledetails!.data!
                                          .quizQuestion!.school) {
                                    Get.to(School(
                                      isEdit: true,
                                      schoolText: "",
                                      back: false,
                                    ));
                                  } else if (profileProvider.quizquestion ==
                                      profileProvider.profiledetails!.data!
                                          .quizQuestion!.jobTitle) {
                                    Get.to(Work(
                                      isEdit: true,
                                      jobtitle: "",
                                      companynametext: "",
                                      back: false,
                                    ));
                                  } else if (profileProvider.quizquestion ==
                                      profileProvider.profiledetails!.data!
                                          .quizQuestion!.companyName) {
                                    Get.to(Work(
                                      isEdit: true,
                                      jobtitle: "",
                                      companynametext: "",
                                      back: false,
                                    ));
                                  } else if (profileProvider.quizquestion ==
                                      profileProvider.profiledetails!.data!
                                          .quizQuestion!.answer_question) {
                                    Get.to(QuestionScreen(
                                      isEdit: true,
                                      questionList: [],
                                      back: false,
                                    ));
                                  } else if (profileProvider.quizquestion ==
                                      profileProvider.profiledetails!.data!
                                          .quizQuestion!.doYouDrink) {
                                    Get.to(Drink(
                                      isEdit: true,
                                      drinktext: "",
                                      back: false,
                                    ));
                                  } else if (profileProvider.quizquestion ==
                                      profileProvider.profiledetails!.data!
                                          .quizQuestion!.doYouSmoke) {
                                    Get.to(SmokeScreen(
                                      isEdit: true,
                                      smoketext: "",
                                      back: false,
                                    ));
                                  } else if (profileProvider.quizquestion ==
                                      profileProvider.profiledetails!.data!
                                          .quizQuestion!.feelAboutKids) {
                                    Get.to(FeelkidsScreen(
                                      isEdit: true,
                                      feelkidstext: "",
                                      back: false,
                                    ));
                                  } else if (profileProvider.quizquestion ==
                                      profileProvider.profiledetails!.data!
                                          .quizQuestion!.education) {
                                    Get.to(EducationHaveScreen(
                                      isEdit: true,
                                      educationtext: "",
                                      back: false,
                                    ));
                                  } else if (profileProvider.quizquestion ==
                                      profileProvider
                                          .profiledetails!
                                          .data!
                                          .quizQuestion!
                                          .introvertOrExtrovert) {
                                    Get.to(ExtrovertIntrovertScreen(
                                      isEdit: true,
                                      introextrotext: "",
                                      back: false,
                                    ));
                                  } else if (profileProvider.quizquestion ==
                                      profileProvider.profiledetails!.data!
                                          .quizQuestion!.starSign) {
                                    Get.to(StarSignScreen(
                                      isEdit: true,
                                      starsigntext: "",
                                      back: false,
                                    ));
                                  } else if (profileProvider.quizquestion ==
                                      profileProvider.profiledetails!.data!
                                          .quizQuestion!.havePets) {
                                    Get.to(PetScreen(
                                      isEdit: true,
                                      petstext: "",
                                      back: false,
                                    ));
                                  } else if (profileProvider.quizquestion ==
                                      profileProvider.profiledetails!.data!
                                          .quizQuestion!.religion) {
                                    Get.to(ReligionScreen(
                                      isEdit: true,
                                      religiontext: "",
                                      back: false,
                                    ));
                                  }
                                },
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/images/quiz.svg",
                                      height: 50.h,
                                      width: 50.w,
                                    ),
                                    SizedBox(
                                      width: 25.w,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        addRegularText(
                                            AppLocalizations.of(context)!
                                                .quiz,
                                            14,
                                            Color(0xFF7F7F7F)),
                                        SizedBox(
                                          height: 2.h,
                                        ),
                                        addMediumText(
                                            quizquestion,
                                            12,
                                            Color(0xFF8524BF))
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SvgPicture.asset(
                                "assets/images/arrowforword.svg",
                                height: 15.h,
                                width: 15.w,
                                color: Color(0xFF828282),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          !profileProvider.activemonogomy
                              ? GestureDetector(
                            onTap: () {
                              Get.to(MessageScreen(index: 1));
                            },
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/images/activity.svg",
                                      height: 50.h,
                                      width: 50.w,
                                    ),
                                    SizedBox(
                                      width: 25.w,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        addRegularText(
                                            AppLocalizations.of(
                                                context)!
                                                .youractivity,
                                            14,
                                            Color(0xFF7F7F7F)),
                                        SizedBox(
                                          height: 2.h,
                                        ),
                                        addMediumText(
                                            AppLocalizations.of(context)!.medium,
                                            12,
                                            Color(0xFF466FFF))
                                      ],
                                    ),
                                  ],
                                ),
                                SvgPicture.asset(
                                  "assets/images/arrowforword.svg",
                                  height: 15.h,
                                  width: 15.w,
                                  color: Color(0xFF828282),
                                )
                              ],
                            ),
                          )
                              : GestureDetector(
                            onTap: () {
                              //Get.to(MessageScreen(index: 1));
                            },
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/images/activity.svg",
                                      height: 50.h,
                                      width: 50.w,
                                    ),
                                    SizedBox(
                                      width: 25.w,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        addRegularText(
                                            AppLocalizations.of(
                                                context)!
                                                .youractivity,
                                            14,
                                            Color(0xFF7F7F7F)),
                                        SizedBox(
                                          height: 2.h,
                                        ),
                                        addMediumText(
                                            AppLocalizations.of(context)!.medium,
                                            12,
                                            Color(0xFF466FFF))
                                      ],
                                    ),
                                  ],
                                ),
                                SvgPicture.asset(
                                  "assets/images/arrowforword.svg",
                                  height: 15.h,
                                  width: 15.w,
                                  color: Color(0xFF828282),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          profileProvider.profiledetails!.data!.ghost_profile!
                              ? profileProvider
                              .profiledetails!.data!.is_ghost!
                              ? GestureDetector(
                            onTap: () async {
                              await _deactivateghost(
                                  profileProvider);
                            },
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/images/incognito.svg",
                                      height: 50.h,
                                      width: 50.w,
                                    ),
                                    SizedBox(
                                      width: 25.w,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        addRegularText(
                                            AppLocalizations.of(
                                                context)!
                                                .ghostmode,
                                            14,
                                            Color(0xFF7F7F7F)),
                                        SizedBox(
                                          height: 2.h,
                                        ),
                                        addMediumText(
                                            AppLocalizations.of(
                                                context)!
                                                .deactivate,
                                            12,
                                            Color(0xFF363D4E))
                                      ],
                                    ),
                                  ],
                                ),
                                SvgPicture.asset(
                                  "assets/images/arrowforword.svg",
                                  height: 15.h,
                                  width: 15.w,
                                  color: Color(0xFF828282),
                                )
                              ],
                            ),
                          )
                              : GestureDetector(
                            onTap: () async {
                              await _activateghost(profileProvider);
                            },
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/images/incognito.svg",
                                      height: 50.h,
                                      width: 50.w,
                                    ),
                                    SizedBox(
                                      width: 25.w,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        addRegularText(
                                            AppLocalizations.of(
                                                context)!
                                                .ghostmode,
                                            14,
                                            Color(0xFF7F7F7F)),
                                        SizedBox(
                                          height: 2.h,
                                        ),
                                        addMediumText(
                                            AppLocalizations.of(
                                                context)!
                                                .activate,
                                            12,
                                            Color(0xFF363D4E))
                                      ],
                                    ),
                                  ],
                                ),
                                SvgPicture.asset(
                                  "assets/images/arrowforword.svg",
                                  height: 15.h,
                                  width: 15.w,
                                  color: Color(0xFF828282),
                                )
                              ],
                            ),
                          )
                              : GestureDetector(
                            onTap: () async {
                              await _newactivateghost(profileProvider);
                            },
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/images/incognito.svg",
                                      height: 50.h,
                                      width: 50.w,
                                    ),
                                    SizedBox(
                                      width: 25.w,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        addRegularText(
                                            AppLocalizations.of(
                                                context)!
                                                .ghostmode,
                                            14,
                                            Color(0xFF7F7F7F)),
                                        SizedBox(
                                          height: 2.h,
                                        ),
                                        addMediumText(
                                            AppLocalizations.of(
                                                context)!
                                                .noghostaccountadded,
                                            12,
                                            Color(0xFF363D4E))
                                      ],
                                    ),
                                  ],
                                ),
                                SvgPicture.asset(
                                  "assets/images/arrowforword.svg",
                                  height: 15.h,
                                  width: 15.w,
                                  color: Color(0xFF828282),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
                    : Center(
                  child: CircularProgressIndicator(),
                );
              }),
        ),
      ),
    );
  }

  Future<bool> _deactivateghost(ProfileProvider profileProvider) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            AppLocalizations.of(context)!.areyousure,
            style: TextStyle(height: 1),
          ),
          content: Text(
            AppLocalizations.of(context)!.doyouwantdeactivateyourghostaccount,
            style: TextStyle(height: 1),
          ),
          actions: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop(false);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  AppLocalizations.of(context)!.no,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                if (!profileProvider.profiledetails!.data!.active_monogamy!) {
                  var model = await ProfileRepository.updateGhost(
                      '0', "is_ghost", preferences!.getString("accesstoken")!);
                  if (model.statusCode == 200) {
                    var provider = await Provider.of<ProfileProvider>(context,
                        listen: false);
                    provider.resetStreams();
                    provider.adddetails(model);
                    preferences!.setBool("ghostactivate", false);
                    Navigator.pop(context);
                  } else if (model.statusCode == 422) {
                    showSnakbar(model.message!, context);
                  } else {
                    showSnakbar(model.message!, context);
                  }
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  AppLocalizations.of(context)!.yes,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<bool> _activateghost(ProfileProvider profileProvider) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            AppLocalizations.of(context)!.areyousure,
            style: TextStyle(height: 1),
          ),
          content: Text(
            AppLocalizations.of(context)!.doyouwantactivateyourghostaccount,
            style: TextStyle(height: 1),
          ),
          actions: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop(false);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  AppLocalizations.of(context)!.no,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                if (!profileProvider.profiledetails!.data!.active_monogamy!) {
                  var provider = await Provider.of<ProfileProvider>(context,
                      listen: false);
                  var model = await ProfileRepository.updateGhost(
                      '1', "is_ghost", preferences!.getString("accesstoken")!);
                  if (model.statusCode == 200) {
                    provider.resetStreams();
                    provider.adddetails(model);
                    if (profileProvider.profiledetails!.data!.ghost_profile!) {
                      preferences!.setBool("ghostactivate", true);
                      Navigator.pop(context);
                    } else {
                      preferences!.setBool("inter", false);
                      preferences!.setString("realphoto", "");
                      preferences!.setBool("onboardcomplete", true);
                      preferences!.setBool("accountcreated", true);
                      preferences!.setBool("ghostactivate", true);
                      preferences!.setString(
                          "usertype",
                          profileProvider.profiledetails!.data!.user_plan
                              .toString());
                      Navigator.pop(context);

                      // if(profileProvider.profiledetails.data)
                      Get.to(
                          NameScreen(name: "", isEdit: false, isGhost: true));
                    }
                  } else if (model.statusCode == 422) {
                    showSnakbar(model.message!, context);
                  } else {
                    showSnakbar(model.message!, context);
                  }
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  AppLocalizations.of(context)!.yes,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<bool> _newactivateghost(ProfileProvider profileProvider) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            AppLocalizations.of(context)!.areyousure,
            style: TextStyle(height: 1),
          ),
          content: Text(
            AppLocalizations.of(context)!.doyouwantactivateyourghostaccount,
            style: TextStyle(height: 1),
          ),
          actions: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop(false);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  AppLocalizations.of(context)!.no,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                if (!profileProvider.profiledetails!.data!.active_monogamy!) {
                  var provider = await Provider.of<ProfileProvider>(context,
                      listen: false);
                  var model = await ProfileRepository.updateGhost(
                      '1', "is_ghost", preferences!.getString("accesstoken")!);
                  if (model.statusCode == 200) {
                    provider.resetStreams();
                    provider.adddetails(model);
                    if (profileProvider.profiledetails!.data!.ghost_profile!) {
                      preferences!.setBool("ghostactivate", true);
                      Navigator.pop(context);
                    } else {
                      preferences!.setBool("inter", false);
                      preferences!.setString("realphoto", "");
                      preferences!.setBool("onboardcomplete", true);
                      preferences!.setBool("accountcreated", true);
                      preferences!.setBool("ghostactivate", true);
                      preferences!.setString(
                          "usertype",
                          profileProvider.profiledetails!.data!.user_plan
                              .toString());
                      print(
                          "preferences!.getString(" "usertype" ").toString()");
                      print(preferences!.getString("usertype").toString());
                      var profileprovider =
                      Provider.of<ProfileProvider>(context, listen: false);
                      var settingprovider =
                      Provider.of<SettingProvider>(context, listen: false);
                      var quixprovider =
                      Provider.of<QuizProvider>(context, listen: false);
                      var dashboardprovider = Provider.of<DashboardProvider>(
                          context,
                          listen: false);
                      profileprovider.resetallprofilelist();
                      settingprovider.resetallsettinglist();
                      dashboardprovider.resetalldashboardlist();
                      quixprovider.resetAllquizlist();

                      Navigator.pop(context);

                      // if(profileProvider.profiledetails.data)
                      Get.to(
                          NameScreen(name: "", isEdit: false, isGhost: true));
                    }
                  } else if (model.statusCode == 422) {
                    showSnakbar(model.message!, context);
                  } else {
                    showSnakbar(model.message!, context);
                  }
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  AppLocalizations.of(context)!.yes,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
