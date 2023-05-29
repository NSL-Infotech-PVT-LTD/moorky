import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:http/http.dart'as http;
import 'package:moorky/auth/model/signupmodel.dart';
import 'package:moorky/dashboardscreen/view/dashboardscreen.dart';
import 'package:moorky/profilecreate/model/lookingformodel.dart';
import 'package:moorky/profilecreate/model/profileDetailsmodel.dart';
import 'package:moorky/profiledetailscreen/model/reportResonListModel.dart';
import 'package:moorky/quizscreens/model/questionupdatemodel.dart';


import '../model/intrestedmodel.dart';
import '../model/maritalstatusmodel.dart';
import '../repository/profileRepository.dart';

class ProfileProvider extends ChangeNotifier{
  bool flag=false;
  int swipecount=0;
  String profileImage="";
  String user_type="";
  String anotheruserID="";
  String anotheruserImage="";
  String anotheruserName="";
  bool isSubscriptionUser=false;
  List<dynamic> questionList = [];
  String useremail="";
  String quizquestion="";
  int direct_chat_count=0;
  bool activemonogomy=false;




  String datewith="";
  String only_premium_member="";
  String age_from="";
  String age_to="";
  String maritals="";
  String looking_fors="";
  String sexual_orientation="";
  String start_tall_are_you="";
  String end_tall_are_you="";
  String do_you_drink="";
  String do_you_smoke="";
  String feel_about_kids="";
  String educationfilter="";
  String introvert_or_extrovert="";
  String star_sign="";
  String have_pets="";
  String religionfilter="";
  String languages="";


  MaritalStatusModel? _maritalstatusList;
  MaritalStatusModel? get maritalstatusList => _maritalstatusList;

  LookingForModel? _lookingForList;
  LookingForModel? get lookingForList => _lookingForList;

  InterestedModel? _interestedList;
  InterestedModel? get interestedList => _interestedList;


  ProfileDetailModel? _profiledetails;
  ProfileDetailModel? get profiledetails => _profiledetails;

  ProfileDetailModel? _userprofiledetails;
  ProfileDetailModel? get userprofiledetails => _userprofiledetails;


  ReportReasonListModel? _reportReasonListModel;
  ReportReasonListModel? get reportReasonListModel => _reportReasonListModel;

  String smoke="";
  String sexual="";
  String drink="";
  String kids="";
  String education="";
  String introextro="";
  String starsign="";
  String pets="";
  String religion="";
  String height="";
  String question="";
  String language="";
  String school="";
  String work="";


  ProfileRepository? profileRepository;
  ProfileProvider(){
    initStream();
  }

  void resetallprofilelist(){
    _maritalstatusList=null;
    _lookingForList=null;
    _interestedList=null;
    _profiledetails=null;
    _userprofiledetails=null;
    _reportReasonListModel=null;
     smoke="";
     sexual="";
     drink="";
     kids="";
     education="";
     introextro="";
     starsign="";
     pets="";
     religion="";
     height="";
     question="";
     language="";
     school="";
     work="";
    notifyListeners();
  }
  void UserProfileInit(){
    _userprofiledetails=null;
  }


  void initStream() {
    profileRepository=new ProfileRepository();
    _profiledetails=null;
    quizquestion="";
  }

  void resetprofiledetails(){
    _profiledetails=null;
    notifyListeners();
  }
  void resetquestion(String question){
    quizquestion="";
    quizquestion=question;
    notifyListeners();
  }
  void iniresetuser(){
    _userprofiledetails=null;
  }
  void adddetails(ProfileDetailModel? model)
  {
    print("orientation ${model?.data?.quizQuestion?.sexualOrientation}");

    _profiledetails=model;
    isEvent=model!.data!.active_monogamy!;
    isChat=model.data!.active_monogamy!;
    anotheruserID=model.data!.active_monogamy_user_id.toString();
    anotheruserImage=model.data!.active_monogamy_user_image.toString();
    anotheruserName=model.data!.active_monogamy_user_name.toString();
    isSubscriptionUser=model.data!.subscription!;
    user_type=model.data!.user_plan!;
    swipecount=model.data!.swipe_count!;
    useremail=model.data!.email!.toString();
    direct_chat_count=model.data!.direct_chat_count;
    activemonogomy=model.data!.active_monogamy!;



    datewith=model.data!.userfilterdata!.date_with.toString();
    if(datewith=="")
      {
        datewith=model.data!.date_with_id!.toString();
      }
    only_premium_member=model.data!.userfilterdata!.only_premium_member.toString();
    age_from=model.data!.userfilterdata!.age_from.toString();
     age_to=model.data!.userfilterdata!.age_to.toString();
     maritals=model.data!.userfilterdata!.maritals.toString();
     looking_fors=model.data!.userfilterdata!.looking_fors.toString();
     sexual_orientation=model.data!.userfilterdata!.sexual_orientation.toString();
     start_tall_are_you=model.data!.userfilterdata!.start_tall_are_you.toString();
     end_tall_are_you=model.data!.userfilterdata!.end_tall_are_you.toString();
     do_you_drink=model.data!.userfilterdata!.do_you_drink.toString();
     do_you_smoke=model.data!.userfilterdata!.do_you_smoke.toString();
     feel_about_kids=model.data!.userfilterdata!.feel_about_kids.toString();
     educationfilter=model.data!.userfilterdata!.education.toString();
     introvert_or_extrovert=model.data!.userfilterdata!.introvert_or_extrovert.toString();
     star_sign=model.data!.userfilterdata!.star_sign.toString();
     have_pets=model.data!.userfilterdata!.have_pets.toString();
     religionfilter=model.data!.userfilterdata!.religion.toString();
     languages=model.data!.userfilterdata!.languages.toString();



    getQuizQuestion(model);

    notifyListeners();
  }
  void resetStreams() {
    initStream();
  }
  fetchMaritalList(String accessToken)
  async{
    _maritalstatusList=null;
    MaritalStatusModel? maritalstatusList = await ProfileRepository.getmaritalList(accessToken);
    if (_maritalstatusList == null) {
      _maritalstatusList = maritalstatusList;
    }
    notifyListeners();
  }
  fetchLookingforList(String accessToken)
  async{
    LookingForModel? lookingForList = await ProfileRepository.getlookingForList(accessToken);
    if (_lookingForList == null) {
      _lookingForList = lookingForList;
    }
    notifyListeners();
  }
  fetchIntrestedList(String accessToken)
  async{
    _interestedList=null;
    InterestedModel? interestedList = await ProfileRepository.getInterestedList(accessToken);
    if (_interestedList == null) {
      _interestedList = interestedList;
    }
    notifyListeners();
  }

  fetchProfileDetailsuseractivity(String accessToken)
  async{
    ProfileDetailModel? profiledetails = await ProfileRepository.profileDetails(accessToken);

      _profiledetails = profiledetails;
      profileImage=profiledetails.data!.images!.elementAt(0).image;
      isChat=profiledetails.data!.active_monogamy!;
      isEvent=profiledetails.data!.active_monogamy!;
      anotheruserID=profiledetails.data!.active_monogamy_user_id.toString();
      isSubscriptionUser=profiledetails.data!.subscription!;
      user_type=profiledetails.data!.user_plan!;
      swipecount=profiledetails.data!.swipe_count!;
      useremail=profiledetails.data!.email!.toString();
      anotheruserImage=profiledetails.data!.active_monogamy_user_image.toString();
      anotheruserName=profiledetails.data!.active_monogamy_user_name.toString();
      direct_chat_count=profiledetails.data!.direct_chat_count;
      activemonogomy=profiledetails.data!.active_monogamy!;
      datewith=profiledetails.data!.userfilterdata!.date_with.toString();
    if(datewith=="")
    {
      datewith=profiledetails.data!.date_with_id!.toString();
    }
      only_premium_member=profiledetails.data!.userfilterdata!.only_premium_member.toString();
      age_from=profiledetails.data!.userfilterdata!.age_from.toString();
      age_to=profiledetails.data!.userfilterdata!.age_to.toString();
      maritals=profiledetails.data!.userfilterdata!.maritals.toString();
      looking_fors=profiledetails.data!.userfilterdata!.looking_fors.toString();
      sexual_orientation=profiledetails.data!.userfilterdata!.sexual_orientation.toString();
      start_tall_are_you=profiledetails.data!.userfilterdata!.start_tall_are_you.toString();
      end_tall_are_you=profiledetails.data!.userfilterdata!.end_tall_are_you.toString();
      do_you_drink=profiledetails.data!.userfilterdata!.do_you_drink.toString();
      do_you_smoke=profiledetails.data!.userfilterdata!.do_you_smoke.toString();
      feel_about_kids=profiledetails.data!.userfilterdata!.feel_about_kids.toString();
      educationfilter=profiledetails.data!.userfilterdata!.education.toString();
      introvert_or_extrovert=profiledetails.data!.userfilterdata!.introvert_or_extrovert.toString();
      star_sign=profiledetails.data!.userfilterdata!.star_sign.toString();
      have_pets=profiledetails.data!.userfilterdata!.have_pets.toString();
      religionfilter=profiledetails.data!.userfilterdata!.religion.toString();
      languages=profiledetails.data!.userfilterdata!.languages.toString();

      getQuizQuestion(profiledetails);
    notifyListeners();
  }

  fetchProfileDetails(String accessToken)
  async{
    ProfileDetailModel? profiledetails = await ProfileRepository.profileDetails(accessToken);
    if (_profiledetails == null) {
      _profiledetails = profiledetails;
      profileImage=profiledetails.data!.images!.elementAt(0).image;
      isChat=profiledetails.data!.active_monogamy!;
      isEvent=profiledetails.data!.active_monogamy!;
      anotheruserID=profiledetails.data!.active_monogamy_user_id.toString();
      isSubscriptionUser=profiledetails.data!.subscription!;
      user_type=profiledetails.data!.user_plan!;
      swipecount=profiledetails.data!.swipe_count!;
      useremail=profiledetails.data!.email!.toString();
      anotheruserImage=profiledetails.data!.active_monogamy_user_image.toString();
      anotheruserName=profiledetails.data!.active_monogamy_user_name.toString();
      direct_chat_count=profiledetails.data!.direct_chat_count;
      activemonogomy=profiledetails.data!.active_monogamy!;
      datewith=profiledetails.data!.userfilterdata!.date_with.toString();
      if(datewith=="")
      {
        datewith=profiledetails.data!.date_with_id!.toString();
      }
      only_premium_member=profiledetails.data!.userfilterdata!.only_premium_member.toString();
      age_from=profiledetails.data!.userfilterdata!.age_from.toString();
      age_to=profiledetails.data!.userfilterdata!.age_to.toString();
      maritals=profiledetails.data!.userfilterdata!.maritals.toString();
      looking_fors=profiledetails.data!.userfilterdata!.looking_fors.toString();
      sexual_orientation=profiledetails.data!.userfilterdata!.sexual_orientation.toString();
      start_tall_are_you=profiledetails.data!.userfilterdata!.start_tall_are_you.toString();
      end_tall_are_you=profiledetails.data!.userfilterdata!.end_tall_are_you.toString();
      do_you_drink=profiledetails.data!.userfilterdata!.do_you_drink.toString();
      do_you_smoke=profiledetails.data!.userfilterdata!.do_you_smoke.toString();
      feel_about_kids=profiledetails.data!.userfilterdata!.feel_about_kids.toString();
      educationfilter=profiledetails.data!.userfilterdata!.education.toString();
      introvert_or_extrovert=profiledetails.data!.userfilterdata!.introvert_or_extrovert.toString();
      star_sign=profiledetails.data!.userfilterdata!.star_sign.toString();
      have_pets=profiledetails.data!.userfilterdata!.have_pets.toString();
      religionfilter=profiledetails.data!.userfilterdata!.religion.toString();
      languages=profiledetails.data!.userfilterdata!.languages.toString();

      getQuizQuestion(profiledetails);
    }
    notifyListeners();
  }

  fetchUserProfileDetails(String accessToken,String user_id)
  async{
    ProfileDetailModel? userprofiledetails = await ProfileRepository.userprofileDetails(accessToken,user_id);
    if (_userprofiledetails == null) {
      _userprofiledetails = userprofiledetails;
    }
    notifyListeners();
  }

  fetchUserReportReason(String accessToken)
  async{
    ReportReasonListModel? reportReasonListModel = await ProfileRepository.userreportReason(accessToken);
    if (_reportReasonListModel == null) {
      _reportReasonListModel = reportReasonListModel;
    }
    notifyListeners();
  }

  getQuizQuestion(ProfileDetailModel model) {
    if (model.data!.sexualOrientation != "") {
    }
    else {
      if (quizquestion == "") {
        quizquestion = model.data!.quizQuestion!.sexualOrientation;
      }
    }

    if (model.data!.tallAreYou != "") {
    } else {
      if (quizquestion == "") {
        quizquestion = model.data!.quizQuestion!.tallAreYou;
      }
    }
    if (model.data!.school != "") {
    } else {
      if (quizquestion == "") {
        quizquestion =
            model.data!.quizQuestion!.school;
      }
    }
    if (model.data!.jobTitle != "") {
    } else {
      if (quizquestion == "") {
        quizquestion = model.data!.quizQuestion!.jobTitle;
      }
    }
    if (model.data!.companyName != "") {
    } else {
      if (quizquestion == "") {
        quizquestion = model.data!.quizQuestion!.companyName;
      }
    }
    if (model.data!.userQuestions!.length >
        0) {
    } else {
      if (quizquestion == "") {
        quizquestion = model.data!.quizQuestion!.answer_question;
      }
    }
    if (model.data!.doYouDrink != "") {
    } else {
      if (quizquestion == "") {
        quizquestion = model.data!.quizQuestion!.doYouDrink;
      }
    }
    if (model.data!.doYouSmoke != "") {
    } else {
      if (quizquestion == "") {
        quizquestion = model.data!.quizQuestion!.doYouSmoke;
      }
    }
    if (model.data!.feelAboutKids != "") {
    } else {
      if (quizquestion == "") {
        quizquestion = model.data!.quizQuestion!.feelAboutKids;
      }
    }
    if (model.data!.education != "") {
    } else {
      if (quizquestion == "") {
        quizquestion = model.data!.quizQuestion!.education;
      }
    }
    if (model.data!.introvertOrExtrovert !=
        "") {
    } else {
      if (quizquestion == "") {
        quizquestion = model.data!.quizQuestion!.introvertOrExtrovert;
      }
    }
    if (model.data!.starSign != "") {
    } else {
      if (quizquestion == "") {
        quizquestion = model.data!.quizQuestion!.starSign;
      }
    }
    if (model.data!.havePets != "") {
    } else {
      if (quizquestion == "") {
        quizquestion = model.data!.quizQuestion!.havePets;
      }
    }
    if (model.data!.religion != "") {
    } else {
      if (quizquestion == "") {
        quizquestion = model.data!.quizQuestion!.religion;
      }
    }
    notifyListeners();
  }

}