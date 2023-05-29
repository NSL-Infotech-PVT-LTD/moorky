import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart';
import 'package:moorky/profilecreate/model/intrestedmodel.dart';
import 'package:moorky/profilecreate/model/lookingformodel.dart';
import 'package:moorky/profilecreate/model/profileDetailsmodel.dart';
import 'package:moorky/profiledetailscreen/model/reportResonListModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constant/app_url.dart';
import '../model/maritalstatusmodel.dart';
import 'package:http/http.dart'as http;
class ProfileRepository{
  static Future<MaritalStatusModel> getmaritalList(String accesstoken)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("${prefs.getString("lang")}");
    var response=await http.post(Uri.parse("${AppUrl.baseUrl}api/marital/list"),
      headers: {
        "authorization": "Bearer ${accesstoken.toString()}",
        "X-localization": "${prefs.getString("lang")}"
      },);
    if(response.statusCode==200)
    {
      log(jsonDecode(response.body).toString());
      //print(jsonDecode(response.body));
      return MaritalStatusModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==422)
    {
      return MaritalStatusModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==403)
    {
      return MaritalStatusModel.fromJson(jsonDecode(response.body));
    }
    else{
      return throw(Exception("Not A Verify"));
    }
  }

  static Future<LookingForModel> getlookingForList(String accesstoken)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response=await http.post(Uri.parse("${AppUrl.baseUrl}api/looking-for/list"),
      headers: {
        "authorization": "Bearer ${accesstoken.toString()}",
        "X-localization": "${prefs.getString("lang")}"
      },);
    if(response.statusCode==200)
    {
      print(jsonDecode(response.body));
      return LookingForModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==422)
    {
      return LookingForModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==403)
    {
      return LookingForModel.fromJson(jsonDecode(response.body));
    }
    else{
      return throw(Exception("Not A Verify"));
    }
  }

  static Future<InterestedModel> getInterestedList(String accesstoken)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("bjcksjbcksbckbskcsbk");
    print("${prefs.getString("lang")}");
    var response=await http.post(Uri.parse("${AppUrl.baseUrl}api/interests/list"),
      headers: {
        "authorization": "Bearer ${accesstoken.toString()}",
        "X-localization": "${prefs.getString("lang")}"
      },);
    if(response.statusCode==200)
    {
      print(jsonDecode(response.body));
      return InterestedModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==422)
    {
      return InterestedModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==403)
    {
      return InterestedModel.fromJson(jsonDecode(response.body));
    }
    else{
      return throw(Exception("Not A Verify"));
    }
  }

  static Future<ProfileDetailModel> updatenametoIntrested(String name,String dateofbirth,
      String gender,int showgender,String datewith,String biography,String intrest,String maritalStatus,
      String lookingFor,List<String> images,String accesstoken,String age,List<String> imageindex,String date_with_id,String gender_id)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var uri = Uri.parse("${AppUrl.baseUrl}api/profile/create");
    var request =  http.MultipartRequest("POST", uri);
    List<MultipartFile> newList = <MultipartFile>[];
    if(images.length>0)
      {
        for (int i = 0; i < images.length; i++) {
          http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
              'images[]', images[i]);
          newList.add(multipartFile);
        }
        request.fields.addAll(
            {"name": name,"date_of_birth":dateofbirth,"gender":gender,"show_gender":showgender.toString(),
              "date_with":datewith,"marital_status":maritalStatus,"looking_for":lookingFor,"biography":biography,"interests":intrest.toString(),"age":age,"imageindex":imageindex.toString().replaceAll("[", "").replaceAll("]", ""),"gender_id":gender_id,"date_with_id":date_with_id});
      }
    else{
      request.fields.addAll(
          {"name": name,"date_of_birth":dateofbirth,"gender":gender,"show_gender":showgender.toString(),
            "date_with":datewith,"marital_status":maritalStatus,"looking_for":lookingFor,"biography":biography,"interests":intrest.toString(),"age":age});
    }

    request.headers.addAll({"authorization": "Bearer ${accesstoken.toString()}",
      'X-localization': "${prefs.getString("lang")}"});

    request.files.addAll(newList);

    var response = await request.send();
    final respStr = await response.stream.bytesToString();
    print("response.statusCode");
    print(response.statusCode);
    if(response.statusCode==200)
    {
      print(respStr.toString());
      return ProfileDetailModel.fromJson(jsonDecode(respStr.toString()));
    }
    else if(response.statusCode==422)
    {
      print(respStr.toString());
      return ProfileDetailModel.fromJson(jsonDecode(respStr.toString()));
    }
    else if(response.statusCode==403)
    {
      print(respStr.toString());
      return ProfileDetailModel.fromJson(jsonDecode(respStr.toString()));
    }
    else{
      print(respStr.toString());
      return throw(Exception("Not A Verify"));
    }
  }

  static Future<ProfileDetailModel> updateLocation(
      String latitude,
      String longitude,
      String city,
      String state,
      String country,
      String accesstoken)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var uri = Uri.parse("${AppUrl.baseUrl}api/profile/create");
    var request =  http.MultipartRequest("POST", uri);
    request.headers.addAll({"authorization": "Bearer ${accesstoken.toString()}",
      'X-localization': "${prefs.getString("lang")}"});
    request.fields.addAll(
        {"latitude": latitude,
          "longitude":longitude,
          "city":city,
          "state":state,
          "country":country,});
    var response = await request.send();
    final respStr = await response.stream.bytesToString();
    if(response.statusCode==200)
    {
      print(respStr.toString());
      return ProfileDetailModel.fromJson(jsonDecode(respStr.toString()));
    }
    else if(response.statusCode==422)
    {
      return ProfileDetailModel.fromJson(jsonDecode(respStr));
    }
    else if(response.statusCode==403)
    {
      return ProfileDetailModel.fromJson(jsonDecode(respStr));
    }
    else{
      return throw(Exception("Not A Verify"));
    }
  }

  static Future<ProfileDetailModel> updateProfile(String value,String key,String accesstoken)async{
    print("key");
    print(key);
    print("value");
    print(value);
    final Map<String, dynamic> apiBodyData = {
      '$key': value,
    };
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response=await http.post(Uri.parse("${AppUrl.baseUrl}api/profile/create"),
      body: apiBodyData,
      headers: {
        "authorization": "Bearer ${accesstoken.toString()}",
        "X-localization": "${prefs.getString("lang")}"
      },);

    if(response.statusCode==200)
    {
      print(response.body);
      return ProfileDetailModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==422)
    {
      return ProfileDetailModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==403)
    {
      return ProfileDetailModel.fromJson(jsonDecode(response.body));
    }
    else{
      return throw(Exception("Not A Verify"));
    }
  }

  static Future<ProfileDetailModel> updateGhost(String value,String key,String accesstoken)async{
    final Map<String, dynamic> apiBodyData = {
      '$key': value,
    };
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response=await http.post(Uri.parse("${AppUrl.baseUrl}api/ghost-mode/update"),
      body: apiBodyData,
      headers: {
        "authorization": "Bearer ${accesstoken.toString()}",
        "X-localization": "${prefs.getString("lang")}"
      },);

    if(response.statusCode==200)
    {
      print(response);
      return ProfileDetailModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==422)
    {
      return ProfileDetailModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==403)
    {
      return ProfileDetailModel.fromJson(jsonDecode(response.body));
    }
    else{
      return throw(Exception("Not A Verify"));
    }
  }


  static Future<ProfileDetailModel> updateWork(String jobtitle,String companyname,String accesstoken)async{
    final Map<String, dynamic> apiBodyData = {
      'job_title': jobtitle,
      'company_name': companyname,
    };
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response=await http.post(Uri.parse("${AppUrl.baseUrl}api/profile/create"),
      body: apiBodyData,
      headers: {
        "authorization": "Bearer ${accesstoken.toString()}",
        "X-localization": "${prefs.getString("lang")}"
      },);

    if(response.statusCode==200)
    {
      return ProfileDetailModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==422)
    {
      return ProfileDetailModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==403)
    {
      return ProfileDetailModel.fromJson(jsonDecode(response.body));
    }
    else{
      return throw(Exception("Not A Verify"));
    }
  }

  static Future<ProfileDetailModel> updateProfileImage(List<String> images,String accesstoken,List<String> imagesIndex,List<String> httpIndex,List<String> httpImages)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var uri = Uri.parse("${AppUrl.baseUrl}api/profile/create");

    var request =  http.MultipartRequest("POST", uri);
    List<MultipartFile> newList = <MultipartFile>[];
    for (int i = 0; i < images.length; i++) {
      print('images[]=${images[i]}');
      print('imageindex=${imagesIndex.toString().replaceAll("[", "").replaceAll("]", "")}');
      print('image_orders=${httpIndex.toString().replaceAll("[", "").replaceAll("]", "")}');
      print('image_ids=${httpImages.toString().replaceAll("[", "").replaceAll("]", "")}');
      print('authorization token=${accesstoken.toString()}');
      print('authorization lang=${newList}');
      print('newList=${prefs.getString("lang")}');
      http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
          'images[]', images[i]);
      newList.add(multipartFile);
    }
    request.fields.addAll({
      "imageindex": imagesIndex.toString().replaceAll("[", "").replaceAll("]", ""),
      "image_orders":httpIndex.toString().replaceAll("[", "").replaceAll("]", ""),
      "image_ids":httpImages.toString().replaceAll("[", "").replaceAll("]", "")});
    request.headers.addAll({"authorization": "Bearer ${accesstoken.toString()}",
      'X-localization': "${prefs.getString("lang")}"});
    request.files.addAll(newList);

    var response = await request.send();
    final respStr = await response.stream.bytesToString();
    if(response.statusCode==200)
    {
      print(respStr.toString());
      return ProfileDetailModel.fromJson(jsonDecode(respStr.toString()));
    }
    else if(response.statusCode==422)
    {
      print(respStr.toString());
      return ProfileDetailModel.fromJson(jsonDecode(respStr.toString()));
    }
    else if(response.statusCode==403)
    {
      print(respStr.toString());
      return ProfileDetailModel.fromJson(jsonDecode(respStr.toString()));
    }
    else{
      return throw(Exception("Not A Verify"));
    }
  }

  static Future<ProfileDetailModel> updateRealImage(String images,String accesstoken)async{
    print(images);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var uri = Uri.parse("${AppUrl.baseUrl}api/profile/create");
    var request =  http.MultipartRequest("POST", uri);
    http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
        'real_photo', images);
    request.headers.addAll({"authorization": "Bearer ${accesstoken.toString()}",
      'X-localization': "${prefs.getString("lang")}"});
    request.files.add(multipartFile);

    var response = await request.send();
    final respStr = await response.stream.bytesToString();
    if(response.statusCode==200)
    {
      print(respStr.toString());
      return ProfileDetailModel.fromJson(jsonDecode(respStr.toString()));
    }
    else if(response.statusCode==422)
    {
      print(respStr.toString());
      return ProfileDetailModel.fromJson(jsonDecode(respStr.toString()));
    }
    else if(response.statusCode==403)
    {
      print(respStr.toString());
      return ProfileDetailModel.fromJson(jsonDecode(respStr.toString()));
    }
    else{
      return throw(Exception("Not A Verify"));
    }
  }

  static Future<ProfileDetailModel> profileDetails(String accesstoken)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response= await http.post(Uri.parse("${AppUrl.baseUrl}api/profile/detail"),
      headers: {
        "authorization": "Bearer ${accesstoken.toString()}",
        "X-localization": "${prefs.getString("lang")}"
      },);
    print(response.statusCode);
    print(accesstoken.toString());

    if(response.statusCode==200)
    {
      return ProfileDetailModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==422)
    {
      return ProfileDetailModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==403)
    {
      return ProfileDetailModel.fromJson(jsonDecode(response.body));
    }
    else{
      return throw(Exception("Not A Verify"));
    }
  }

  static Future<ProfileDetailModel> userprofileDetails(String accesstoken,String user_id)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final Map<String, dynamic> apiBodyData = {
      'id': user_id,
    };
    var response=await http.post(Uri.parse("${AppUrl.baseUrl}api/profile/detail"),
      body: apiBodyData,
      headers: {
        "authorization": "Bearer ${accesstoken.toString()}",
        "X-localization": "${prefs.getString("lang")}"
      },);
    print(response.statusCode);
    print(response.body);

    if(response.statusCode==200)
    {
      return ProfileDetailModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==422)
    {
      return ProfileDetailModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==403)
    {
      return ProfileDetailModel.fromJson(jsonDecode(response.body));
    }
    else{
      return throw(Exception("Not A Verify"));
    }
  }

  static Future<ReportReasonListModel> userreportReason(String accesstoken)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response=await http.post(Uri.parse("${AppUrl.baseUrl}api/report/reasons"),
      headers: {
        "authorization": "Bearer ${accesstoken.toString()}",
        "X-localization": "${prefs.getString("lang")}"
      },);
    print(response.statusCode);
    print(response.body);

    if(response.statusCode==200)
    {
      return ReportReasonListModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==422)
    {
      return ReportReasonListModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==403)
    {
      return ReportReasonListModel.fromJson(jsonDecode(response.body));
    }
    else{
      return throw(Exception("Not A Verify"));
    }
  }

  static Future<bool> imageDelete(String accesstoken,String image_id)async{

    final Map<String, dynamic> apiBodyData = {
      'id': image_id,
    };
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response=await http.post(Uri.parse("${AppUrl.baseUrl}api/image/delete"),
      body: apiBodyData,
      headers: {
        "authorization": "Bearer ${accesstoken.toString()}",
        "X-localization": "${prefs.getString("lang")}"
      },);
    print(response.statusCode);
    print(response.body);

    if(response.statusCode==200)
    {
      return true;
    }
    else if(response.statusCode==422)
    {
      return false;
    }
    else if(response.statusCode==403)
    {
      return false;
    }
    else{
      return false;
    }
  }

  static Future<bool> userReport(String accesstoken,String user_id,String reason_id,String hide,String reason)async{

    final Map<String, dynamic> apiBodyData = {
      'user_id': user_id,
      'report_reason_id': reason_id,
      'reason': reason,
      'hide': hide,
    };
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response=await http.post(Uri.parse("${AppUrl.baseUrl}api/user/report"),
      body: apiBodyData,
      headers: {
        "authorization": "Bearer ${accesstoken.toString()}",
        "X-localization": "${prefs.getString("lang")}"
      },);
    print(response.statusCode);
    print(response.body);

    if(response.statusCode==200)
    {
      return true;
    }
    else if(response.statusCode==422)
    {
      return false;
    }
    else if(response.statusCode==403)
    {
      return false;
    }
    else{
      return false;
    }
  }

  static Future<bool> userHide(String accesstoken,String user_id)async{

    final Map<String, dynamic> apiBodyData = {
      'user_id': user_id,
    };
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response=await http.post(Uri.parse("${AppUrl.baseUrl}api/user/hide"),
      body: apiBodyData,
      headers: {
        "authorization": "Bearer ${accesstoken.toString()}",
        "X-localization": "${prefs.getString("lang")}"
      },);
    print(response.statusCode);
    print(response.body);

    if(response.statusCode==200)
    {
      return true;
    }
    else if(response.statusCode==422)
    {
      return false;
    }
    else if(response.statusCode==403)
    {
      return false;
    }
    else{
      return false;
    }
  }

  static Future<ProfileDetailModel> userQuestionDelete(String accesstoken,String question_id)async{

    final Map<String, dynamic> apiBodyData = {
      'question_id': question_id,
    };
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response=await http.post(Uri.parse("${AppUrl.baseUrl}api/user/question/delete"),
      body: apiBodyData,
      headers: {
        "authorization": "Bearer ${accesstoken.toString()}",
        "X-localization": "${prefs.getString("lang")}"
      },);
    print(response.statusCode);
    print(response.body);

    if(response.statusCode==200)
    {
      return ProfileDetailModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==422)
    {
      return ProfileDetailModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==403)
    {
      return ProfileDetailModel.fromJson(jsonDecode(response.body));
    }
    else{
      return throw(Exception("Not A Verify"));
    }
  }
}