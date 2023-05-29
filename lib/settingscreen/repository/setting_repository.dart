import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:moorky/premiumscreen/model/paymentresponsemodel.dart';
import 'package:moorky/premiumscreen/model/premiumListmodel.dart';
import 'package:moorky/premiumscreen/model/premiumplan_model.dart';
import 'package:moorky/settingscreen/model/notification_model.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../constant/app_url.dart';
int notificationtotalpage=0;
int notificationtotalitems=0;
class SettingRepository{
  static Future<NotificationModel> getnotificationList(String accesstoken,int page,int limit,String type)async{
    final Map<String, dynamic> apiBodyData = {
      'page': page.toString(),
      'limit': limit.toString(),
      'type': type.toString(),
    };
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response=await http.post(Uri.parse("${AppUrl.baseUrl}api/notification/list"),
      body: apiBodyData,
      headers: {
        "authorization": "Bearer ${accesstoken.toString()}",
        "X-localization": "${prefs.getString("lang")}"
      },);
    if(response.statusCode==200)
    {
      print(jsonDecode(response.body));
      notificationtotalpage=jsonDecode(response.body)['pages'];
      notificationtotalitems=jsonDecode(response.body)['rows'];
      print(notificationtotalpage);
      print(notificationtotalitems);
      return NotificationModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==422)
    {
      return NotificationModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==403)
    {
      return NotificationModel.fromJson(jsonDecode(response.body));
    }
    else{
      return throw(Exception("Not A Verify"));
    }
  }

  static Future<bool> deletenotification(String accesstoken,String id,String type)async{
    print(id);
    print(accesstoken);
    final Map<String, dynamic> apiBodyData = {
      'id': id.toString(),
      'type':type
    };
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response=await http.post(Uri.parse("${AppUrl.baseUrl}api/notification/delete"),
      body: apiBodyData,
      headers: {
        "authorization": "Bearer ${accesstoken.toString()}",
        "X-localization": "${prefs.getString("lang")}"
      },);
    print(response.statusCode);
    if(response.statusCode==200)
    {
      print(jsonDecode(response.body));
      return true;
    }
    else if(response.statusCode==422)
    {
      return true;
    }
    else if(response.statusCode==403)
    {
      return true;
    }
    else{
      return false;
    }
  }


  static Future<PremiumPlansModel> getpremuimplansList(String accesstoken,String plan)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final Map<String, dynamic> apiBodyData = {
      'plan': plan.toString(),
    };
    var response=await http.post(Uri.parse("${AppUrl.baseUrl}api/plan/list"),
      body: apiBodyData,
      headers: {
        "authorization": "Bearer ${accesstoken.toString()}",
        "X-localization": "${prefs.getString("lang")}"
      },);
    if(response.statusCode==200)
    {
      return PremiumPlansModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==422)
    {
      return PremiumPlansModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==403)
    {
      return PremiumPlansModel.fromJson(jsonDecode(response.body));
    }
    else{
      return throw(Exception("Not A Verify"));
    }
  }

  static Future<PremiumListModel> getpremuimList(String accesstoken,String plan)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final Map<String, dynamic> apiBodyData = {
      'plan': plan.toString(),
    };
    var response=await http.post(Uri.parse("${AppUrl.baseUrl}api/plan/sliders"),
      body: apiBodyData,
      headers: {
        "authorization": "Bearer ${accesstoken.toString()}",
        "X-localization": "${prefs.getString("lang")}"
      },);
    if(response.statusCode==200)
    {
      return PremiumListModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==422)
    {
      return PremiumListModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==403)
    {
      return PremiumListModel.fromJson(jsonDecode(response.body));
    }
    else{
      return throw(Exception("Not A Verify"));
    }
  }


  static Future<PaymentresponseModel> getPaymentResponse(String accesstoken,String plan_id,String product_id,String transaction_id,String transaction_date,String transaction_receipt)async{
    final Map<String, dynamic> apiBodyData = {
      'plan_id': plan_id.toString(),
      'product_id': product_id.toString(),
      'transaction_id': transaction_id.toString(),
      'transaction_date': transaction_date.toString(),
      'transaction_receipt': transaction_receipt.toString(),
    };

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response=await http.post(Uri.parse("${AppUrl.baseUrl}api/plans/new"),
      body: apiBodyData,
      headers: {
        "authorization": "Bearer ${accesstoken.toString()}",
        "X-localization": "${prefs.getString("lang")}"
      },);
    if(response.statusCode==200)
    {
      return PaymentresponseModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==422)
    {
      return PaymentresponseModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==403)
    {
      return PaymentresponseModel.fromJson(jsonDecode(response.body));
    }
    else{
      return throw(Exception("Not A Verify"));
    }
  }
}