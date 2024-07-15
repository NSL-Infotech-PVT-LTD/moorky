import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:http/http.dart'as http;
import 'package:moorky/profilecreate/model/profileDetailsmodel.dart';
import 'package:moorky/quizscreens/model/languagemodel.dart';
import 'package:moorky/quizscreens/model/questionlistmodel.dart';
import 'package:moorky/quizscreens/model/questionupdateresponsemodel.dart';
import 'package:moorky/quizscreens/model/quizcommonmodel.dart';
import 'package:moorky/quizscreens/model/quizmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constant/app_url.dart';
class QuizRepository{
  static Future<QuizCommonModel> getsexualorientationList(String accesstoken)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response=await http.post(Uri.parse("${AppUrl.baseUrl}api/sexual-orientation/list"),
      headers: {
        "authorization": "Bearer ${accesstoken.toString()}",
        "X-localization": "${prefs.getString("lang")}"
      },);
    if(response.statusCode==200)
    {
      print(jsonDecode(response.body));
      return QuizCommonModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==422)
    {
      return QuizCommonModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==403)
    {
      return QuizCommonModel.fromJson(jsonDecode(response.body));
    }
    else{
      return throw(Exception("Not A Verify"));
    }
  }
  static Future<QuizCommonModel> getHeightList(String accesstoken)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response=await http.post(Uri.parse("${AppUrl.baseUrl}api/height-option/list"),
      headers: {
        "authorization": "Bearer ${accesstoken.toString()}",
        "X-localization": "${prefs.getString("lang")}"
      },);
    if(response.statusCode==200)
    {
      print(jsonDecode(response.body));
      return QuizCommonModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==422)
    {
      return QuizCommonModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==403)
    {
      return QuizCommonModel.fromJson(jsonDecode(response.body));
    }
    else{
      return throw(Exception("Not A Verify"));
    }
  }

  static Future<QuizCommonModel> getdrinklist(String accesstoken)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response=await http.post(Uri.parse("${AppUrl.baseUrl}api/drink-option/list"),
      headers: {
        "authorization": "Bearer ${accesstoken.toString()}",
        "X-localization": "${prefs.getString("lang")}"
      },);
    if(response.statusCode==200)
    {
      print(jsonDecode(response.body));
      return QuizCommonModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==422)
    {
      return QuizCommonModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==403)
    {
      return QuizCommonModel.fromJson(jsonDecode(response.body));
    }
    else{
      return throw(Exception("Not A Verify"));
    }
  }

  static Future<QuizCommonModel> getsmokelist(String accesstoken)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response=await http.post(Uri.parse("${AppUrl.baseUrl}api/smoke-option/list"),
      headers: {
        "authorization": "Bearer ${accesstoken.toString()}",
        "X-localization": "${prefs.getString("lang")}"
      },);
    print(accesstoken.toString());
    if(response.statusCode==200)
    {
      print(jsonDecode(response.body));
      return QuizCommonModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==422)
    {
      return QuizCommonModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==403)
    {
      return QuizCommonModel.fromJson(jsonDecode(response.body));
    }
    else{
      return throw(Exception("Not A Verify"));
    }
  }

  static Future<QuizCommonModel> getfeelkidslist(String accesstoken)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response=await http.post(Uri.parse("${AppUrl.baseUrl}api/feel-about-kid/list"),
      headers: {
        "authorization": "Bearer ${accesstoken.toString()}",
        "X-localization": "${prefs.getString("lang")}"
      },);
    if(response.statusCode==200)
    {
      print(jsonDecode(response.body));
      return QuizCommonModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==422)
    {
      return QuizCommonModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==403)
    {
      return QuizCommonModel.fromJson(jsonDecode(response.body));
    }
    else{
      return throw(Exception("Not A Verify"));
    }
  }


  static Future<QuizCommonModel> geteducationlist(String accesstoken)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response=await http.post(Uri.parse("${AppUrl.baseUrl}api/education-level/list"),
      headers: {
        "authorization": "Bearer ${accesstoken.toString()}",
        "X-localization": "${prefs.getString("lang")}"
      },);
    if(response.statusCode==200)
    {
      print(jsonDecode(response.body));
      return QuizCommonModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==422)
    {
      return QuizCommonModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==403)
    {
      return QuizCommonModel.fromJson(jsonDecode(response.body));
    }
    else{
      return throw(Exception("Not A Verify"));
    }
  }

  static Future<QuizCommonModel> getintroextrolist(String accesstoken)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response=await http.post(Uri.parse("${AppUrl.baseUrl}api/introvert-or-extrovert/list"),
      headers: {
        "authorization": "Bearer ${accesstoken.toString()}",
        "X-localization": "${prefs.getString("lang")}"
      },);
    if(response.statusCode==200)
    {
      print(jsonDecode(response.body));
      return QuizCommonModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==422)
    {
      return QuizCommonModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==403)
    {
      return QuizCommonModel.fromJson(jsonDecode(response.body));
    }
    else{
      return throw(Exception("Not A Verify"));
    }
  }

  static Future<QuizCommonModel> getstarsignlist(String accesstoken)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response=await http.post(Uri.parse("${AppUrl.baseUrl}api/star-sign/list"),
      headers: {
        "authorization": "Bearer ${accesstoken.toString()}",
        "X-localization": "${prefs.getString("lang")}"
      },);
    if(response.statusCode==200)
    {
      print(jsonDecode(response.body));
      return QuizCommonModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==422)
    {
      return QuizCommonModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==403)
    {
      return QuizCommonModel.fromJson(jsonDecode(response.body));
    }
    else{
      return throw(Exception("Not A Verify"));
    }
  }

  static Future<QuizCommonModel> getpetslist(String accesstoken)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response=await http.post(Uri.parse("${AppUrl.baseUrl}api/have-pet/list"),
      headers: {
        "authorization": "Bearer ${accesstoken.toString()}",
        "X-localization": "${prefs.getString("lang")}"
      },);
    if(response.statusCode==200)
    {
      print(jsonDecode(response.body));
      return QuizCommonModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==422)
    {
      return QuizCommonModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==403)
    {
      return QuizCommonModel.fromJson(jsonDecode(response.body));
    }
    else{
      return throw(Exception("Not A Verify"));
    }
  }
  static Future<QuizCommonModel> getreligionlist(String accesstoken)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response=await http.post(Uri.parse("${AppUrl.baseUrl}api/religion/list"),
      headers: {
        "authorization": "Bearer ${accesstoken.toString()}",
        "X-localization": "${prefs.getString("lang")}"
      },);
    if(response.statusCode==200)
    {
      print(jsonDecode(response.body));
      return QuizCommonModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==422)
    {
      return QuizCommonModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==403)
    {
      return QuizCommonModel.fromJson(jsonDecode(response.body));
    }
    else{
      return throw(Exception("Not A Verify"));
    }
  }







  static Future<QuizModel> updatesexualtowork(String sexualorientation,String accesstoken,String height,String school,String jobtitle,String companyname) async {
    final Map<String, dynamic> apiBodyData = {
      'sexual_orientation': sexualorientation,
      'tall_are_you': height,
      'school': school,
      'job_title': jobtitle,
      'company_name': companyname,
    };
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response=await http.post(Uri.parse("${AppUrl.baseUrl}api/profile/create"),body: apiBodyData,
      headers: {
      "authorization": "Bearer ${accesstoken.toString()}",
        "X-localization": "${prefs.getString("lang")}"
      },);
    if(response.statusCode==200)
    {
      print("in beraea");
      print(jsonDecode(response.body));
      return QuizModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==422)
    {
      print(jsonDecode(response.body));
      return QuizModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==403)
    {
      return QuizModel.fromJson(jsonDecode(response.body));
    }
    else{
      return throw(Exception("Not A Registered"));
    }
  }

  static Future<QuestionListModel> getquestionList(String accesstoken)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response=await http.post(Uri.parse("${AppUrl.baseUrl}api/question/list"),
      headers: {
        "authorization": "Bearer ${accesstoken.toString()}",
        "X-localization": "${prefs.getString("lang")}"
      },);
    if(response.statusCode==200)
    {
      print(jsonDecode(response.body));
      return QuestionListModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==422)
    {
      return QuestionListModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==403)
    {
      return QuestionListModel.fromJson(jsonDecode(response.body));
    }
    else{
      return throw(Exception("Not A Verify"));
    }
  }
  static Future<LanguageListModel> getlanguageList(String accesstoken)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("dsdsdsdsdsd${prefs.getString("lang")}");
    var response=await http.post(Uri.parse("${AppUrl.baseUrl}api/language/list"),

      headers: {
        "authorization": "Bearer ${accesstoken.toString()}",
        "X-localization": "${prefs.getString("lang")}"
      },
    body: {
      "X-localization": "${prefs.getString("lang")}"
    }
    );
    if(response.statusCode==200)
    {
      print(jsonDecode(response.body));
      return LanguageListModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==422)
    {
      return LanguageListModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==403)
    {
      return LanguageListModel.fromJson(jsonDecode(response.body));
    }
    else{
      return throw(Exception("Not A Verify"));
    }
  }

  static Future<LanguageListModel> getapplanguageList(String accesstoken)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response=await http.post(Uri.parse("${AppUrl.baseUrl}api/app/languages"),
      headers: {
        "authorization": "Bearer ${accesstoken.toString()}",
        "X-localization": "${prefs.getString("lang")}"
      },);
    if(response.statusCode==200)
    {
      print(jsonDecode(response.body));
      return LanguageListModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==422)
    {
      return LanguageListModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==403)
    {
      return LanguageListModel.fromJson(jsonDecode(response.body));
    }
    else{
      return throw(Exception("Not A Verify"));
    }
  }
  static Future<ProfileDetailModel> userquestionlistupdate(String accesstoken,List<dynamic> questionlist)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var request = http.Request('POST', Uri.parse('${AppUrl.baseUrl}api/user/question/update'));
    request.body="${{jsonEncode("answers"):jsonEncode(questionlist)}}";
    request.headers.addAll({"authorization": "Bearer ${accesstoken.toString()}",
      'Content-Type': 'application/json','X-localization': "${prefs.getString("lang")}"});
    http.StreamedResponse response = await request.send();
    print(response.statusCode);
    var responstr=await response.stream.bytesToString();
    if(response.statusCode==200)
    {

      return ProfileDetailModel.fromJson(jsonDecode(responstr));
    }
    else if(response.statusCode==422)
    {
      return ProfileDetailModel.fromJson(jsonDecode(responstr));
    }
    else if(response.statusCode==403)
    {
      return ProfileDetailModel.fromJson(jsonDecode(responstr));
    }
    else{
      return throw(Exception("Not A Verify"));
    }
  }

  static Future<QuizModel> updatedrinktoverifyphoto(
      String drink,
      String smoke,
      String feelkids,
      String education,
      String introextro,
      String starsign,
      String pets,
      String religion,
      String accesstoken,String language,String realphoto)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var uri = Uri.parse("${AppUrl.baseUrl}api/profile/create");
    var request =  http.MultipartRequest("POST", uri);
    if(realphoto!="")
      {
        http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
            'real_photo', realphoto);
        request.files.add(multipartFile);
      }
    request.headers.addAll({"authorization": "Bearer ${accesstoken.toString()}",
      'X-localization': "${prefs.getString("lang")}"});
    request.fields.addAll(
        {"do_you_drink": drink,"do_you_smoke":smoke,"feel_about_kids":feelkids,"education":education.toString(),
          "introvert_or_extrovert":introextro,"star_sign":starsign,"have_pets":pets,"religion":religion,"user_languages":language});
    var response = await request.send();
    final respStr = await response.stream.bytesToString();
    if(response.statusCode==200)
    {


      print(respStr.toString());
      return QuizModel.fromJson(jsonDecode(respStr.toString()));
    }
    else if(response.statusCode==422)
    {
      return QuizModel.fromJson(jsonDecode(respStr));
    }
    else if(response.statusCode==403)
    {
      return QuizModel.fromJson(jsonDecode(respStr));
    }
    else{
      return throw(Exception("Not A Verify"));
    }
  }



}