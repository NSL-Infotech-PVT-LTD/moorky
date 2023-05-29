import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:http/http.dart'as http;
import 'package:moorky/auth/model/emailsignupmodel.dart';
import 'package:moorky/auth/model/newpasswordmodel.dart';
import 'package:moorky/auth/model/signupmodel.dart';
import 'package:moorky/auth/model/updatePhoneModel.dart';
import 'package:moorky/constant/app_url.dart';

import '../model/emailmodel.dart';
import '../model/signupverifymodel.dart';



class AuthProvider extends ChangeNotifier{

  Future<Signupmodel> login(String phonecode, String phonenumber) async {
    print('phonecode sended ${phonecode}');
    final Map<String, dynamic> apiBodyData = {
      'phone_code': phonecode,
      'phone_number': phonenumber
    };
    var response=await http.post(Uri.parse("${AppUrl.baseUrl}api/phonesignup"),body: apiBodyData);

 print('signup with phone ${response.body}');

      if(response.statusCode==200)
        {
          return Signupmodel.fromJson(jsonDecode(response.body));
        }
      else if(response.statusCode==422)
      {
        return Signupmodel.fromJson(jsonDecode(response.body));
      }
      else if(response.statusCode==403)
      {
        return Signupmodel.fromJson(jsonDecode(response.body));
      }
      else{
        return throw(Exception("Not A Registered"));
      }
  }

  Future<Signupverifymodel> otpVerify(String token, String otp) async {
    print('here token ${token}');
    print('here otp ${otp}');

    final Map<String, dynamic> apiBodyData = {
      'token': token,
      'otp': otp.toString()
    };
    var response=await http.post(Uri.parse("${AppUrl.baseUrl}api/signup/verify"),body: apiBodyData);

    print('otpVerify ${response.body}');
    if(response.statusCode==200)
    {
      print('statusCode=200');
      print(jsonDecode(response.body));
      return Signupverifymodel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==422)
    {
      print('statusCode=422');
      return Signupverifymodel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==403)
    {
      print('statusCode=403');
      return Signupverifymodel.fromJson(jsonDecode(response.body));
    }
    else{
      return throw(Exception("Not A Verify"));
    }
  }

  Future<Signupverifymodel> updateotpVerify(String token, String otp,String accesstoken) async {
    final Map<String, dynamic> apiBodyData = {
      'token': token,
      'otp': otp.toString()
    };
    var response=await http.post(Uri.parse("${AppUrl.baseUrl}api/phone-verify"),body: apiBodyData,
      headers: {
        "authorization": "Bearer ${accesstoken.toString()}"
      },);

    if(response.statusCode==200)
    {
      print(jsonDecode(response.body));
      return Signupverifymodel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==422)
    {
      return Signupverifymodel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==403)
    {
      return Signupverifymodel.fromJson(jsonDecode(response.body));
    }
    else{
      return throw(Exception("Not A Verify"));
    }
  }

  Future<EmailModel> updateEmail(String email, String accesstoken) async {
    print(email.toString());
    final Map<String, dynamic> apiBodyData = {
      'email': email.toString(),
    };
    var response=await http.post(Uri.parse("${AppUrl.baseUrl}api/update/email"),body: apiBodyData,
    headers: {
      "authorization": "Bearer ${accesstoken.toString()}"
      },);

    if(response.statusCode==200)
    {
      return EmailModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==422)
      {
        return EmailModel.fromJson(jsonDecode(response.body));
      }
    else if(response.statusCode==403)
    {
      return EmailModel.fromJson(jsonDecode(response.body));
    }
    else{
      return throw(Exception("Not A Verify"));
    }
  }

  Future<EmailModel> changePassword(String currentpassword,String newpassword,String confirmpassword, String accesstoken) async {
    final Map<String, dynamic> apiBodyData = {
      'current_password': currentpassword.toString(),
      'password': newpassword.toString(),
      'password_confirmation': confirmpassword.toString(),
    };
    var response=await http.post(Uri.parse("${AppUrl.baseUrl}api/password/change"),body: apiBodyData,
      headers: {
        "authorization": "Bearer ${accesstoken.toString()}"
      },);

    if(response.statusCode==200)
    {
      return EmailModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==422)
    {
      return EmailModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==403)
    {
      return EmailModel.fromJson(jsonDecode(response.body));
    }
    else{
      return throw(Exception("Not A Verify"));
    }
  }

  Future<EmailModel> updatePassword(String password, String accesstoken) async {
    print(accesstoken);
    print(password.toString());
    final Map<String, dynamic> apiBodyData = {
      'password': password,
    };
    var response=await http.post(Uri.parse("${AppUrl.baseUrl}api/update/password"),body: apiBodyData,
      headers: {
        "authorization": "Bearer ${accesstoken.toString()}"
      },);

    if(response.statusCode==200)
    {
      print(jsonDecode(response.body));
      return EmailModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==422)
    {
      return EmailModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==403)
    {
      return EmailModel.fromJson(jsonDecode(response.body));
    }
    else{
      return throw(Exception("Not A Verify"));
    }
  }

  Future<EmailSignUpModel> emailsignup(String email, String password,String type) async {
    print(type);
    print(email);
    print(password);
    final Map<String, dynamic> apiBodyData = {
      'email':email,
      'password': password,
      'type':type
    };
    var response=await http.post(Uri.parse("${AppUrl.baseUrl}api/emailsignup"),body: apiBodyData,);
    print(AppUrl.baseUrl);
    print(response.request?.url);

    if(response.statusCode==200)
    {
      print(jsonDecode(response.body));
      return EmailSignUpModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==422)
    {
      return EmailSignUpModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==403)
    {
      return EmailSignUpModel.fromJson(jsonDecode(response.body));
    }
    else{
      return throw(Exception("Not A Verify"));
    }
  }

  Future<EmailSignUpModel> socialsignup(String email, String provider,String provider_id) async {
    final Map<String, dynamic> apiBodyData = {
      'email':email,
      'provider_id': provider_id,
      'provider': provider,
    };
    var response=await http.post(Uri.parse("${AppUrl.baseUrl}api/signup/social"),body: apiBodyData,);
    print(response.statusCode);

    if(response.statusCode==200)
    {
      print(jsonDecode(response.body));
      return EmailSignUpModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==422)
    {
      print(jsonDecode(response.body));
      return EmailSignUpModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==403)
    {
      return EmailSignUpModel.fromJson(jsonDecode(response.body));
    }
    else{
      return throw(Exception("Not A Verify"));
    }
  }

  Future<UpdatePhoneModel> updatephone(String phonecode, String phonenumber,String accesstoken) async {
    final Map<String, dynamic> apiBodyData = {
      'phone_code': phonecode,
      'phone_number': phonenumber
    };
    print("asfafasdfasd");
    var response=await http.post(Uri.parse("${AppUrl.baseUrl}api/update/phone"),body: apiBodyData,
      headers: {
        "authorization": "Bearer ${accesstoken.toString()}"
      },);
    print("asfafasdfasd====");
    if(response.statusCode==200)
    {
      return UpdatePhoneModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==422)
    {
      return UpdatePhoneModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==403)
    {
      return UpdatePhoneModel.fromJson(jsonDecode(response.body));
    }
    else{
      return throw(Exception("Not A Registered"));
    }
  }

  Future<bool> forgetPassword(String email) async {
    final Map<String, dynamic> apiBodyData = {
      'email': email.toString(),
    };
    var response=await http.post(Uri.parse("${AppUrl.baseUrl}api/password/reset/email"),body: apiBodyData);

    if(response.statusCode==200)
    {
      print(jsonDecode(response.body));
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
    else
    {
      return throw(Exception("Not A Verify"));
    }
  }

  Future<NewpasswordModel> resetPassword(String password,String token,String confirmpassword) async {
    final Map<String, dynamic> apiBodyData = {
      'token': token.toString(),
      'password': password.toString(),
      'password_confirmation': confirmpassword.toString(),
    };
    var response=await http.post(Uri.parse("${AppUrl.baseUrl}api/password/reset"),body: apiBodyData);

    if(response.statusCode==200)
    {
      print(jsonDecode(response.body));
      return NewpasswordModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==422)
    {
      return NewpasswordModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==403)
    {
      return NewpasswordModel.fromJson(jsonDecode(response.body));
    }
    else{
      return throw(Exception("Not A Verify"));
    }
  }

  notify(){
    notifyListeners();
  }

}