import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:moorky/constant/app_url.dart';
import 'package:moorky/dashboardscreen/model/campaigndetailmodel.dart';
import 'package:moorky/dashboardscreen/model/campaignmodel.dart';
import 'package:moorky/dashboardscreen/model/chatlistmodel.dart';
import 'package:moorky/dashboardscreen/model/eventmodellist.dart';
import 'package:moorky/dashboardscreen/model/filterListModel.dart';
import 'package:moorky/dashboardscreen/model/ghostmodel.dart';
import 'package:moorky/dashboardscreen/model/remainderListModel.dart';
import 'package:moorky/dashboardscreen/model/swipemodel.dart';
import 'package:moorky/dashboardscreen/model/userModel.dart';
import 'package:moorky/dashboardscreen/model/userschatListModel.dart';
import 'package:moorky/dashboardscreen/model/youractivityListModel.dart';
import 'package:moorky/dashboardscreen/provider/dashboardprovider.dart';
import 'package:moorky/profilecreate/model/intrestedmodel.dart';
import 'package:moorky/profilecreate/model/lookingformodel.dart';
import 'package:http/http.dart'as http;
import 'package:moorky/profilecreate/model/profileDetailsmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

int liketotalpage=0;
int liketotalitems=0;
class DashboardRepository{
  static Future<UserModel> getUserList(String accesstoken,int page,int limit,String age_from,String age_to,String date_with,String only_premium_member,String type,
      String search,String maritals,String looking_fors,String sexual_orientation,String start_tall_are_you,String end_tall_are_you,
      String do_you_drink,String do_you_smoke,String feel_about_kids,String education,String introvert_or_extrovert,
      String star_sign,String have_pets,String religion,String languages,String refresh)async{
    final Map<String, dynamic> apiBodyData = {
      'type': type.toString(),
      'limit': limit.toString(),
      'page': page.toString(),
      'only_premium_member': only_premium_member.toString(),
      'date_with': date_with.toString(),
      'age_from': age_from.toString(),
      'age_to': age_to.toString(),
      'search': search.toString(),
      'maritals': maritals.toString(),
      'looking_fors': looking_fors.toString(),
      'sexual_orientation': sexual_orientation.toString(),
      'start_tall_are_you': start_tall_are_you.toString(),
      'end_tall_are_you': end_tall_are_you.toString(),
      'do_you_drink': do_you_drink.toString(),
      'do_you_smoke': do_you_smoke.toString(),
      'feel_about_kids': feel_about_kids.toString(),
      'education': education.toString(),
      'introvert_or_extrovert': introvert_or_extrovert.toString(),
      'star_sign': star_sign.toString(),
      'have_pets': have_pets.toString(),
      'religion': religion.toString(),
      'languages': languages.toString(),
      'refresh':refresh.toString()
    };
    print("apiBodyData");
    print(apiBodyData);
    print(accesstoken);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("prefs.getString");
    print(prefs.getString("lang"));
    var response=await http.post(Uri.parse("${AppUrl.baseUrl}api/user/list"),
      body: apiBodyData,
      headers: {
        "authorization": "Bearer ${accesstoken.toString()}",
      "X-localization": "${prefs.getString("lang")}"
      },);
    print('dashboard api response ${jsonDecode(response.body)}');
    if(response.statusCode==200)
    {
      print(jsonDecode(response.body));
      return UserModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==422)
    {
      return UserModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==403)
    {
      return UserModel.fromJson(jsonDecode(response.body));
    }
    else{
      return throw(Exception("Not A Verify"));
    }
  }



  static Future<UserModel> getSaecrhUserList(String accesstoken,int page,int limit,String type,String user_id)async{
    final Map<String, dynamic> apiBodyData = {
      'type': type.toString(),
      'limit': limit.toString(),
      'page': page.toString(),
      'user_id': user_id.toString(),
    };
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response=await http.post(Uri.parse("${AppUrl.baseUrl}api/user/list"),
      body: apiBodyData,
      headers: {
        "authorization": "Bearer ${accesstoken.toString()}",
      "X-localization": "${prefs.getString("lang")}"
      },);
    print(jsonDecode(response.body));
    if(response.statusCode==200)
    {
      print(jsonDecode(response.body));
      return UserModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==422)
    {
      return UserModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==403)
    {
      return UserModel.fromJson(jsonDecode(response.body));
    }
    else{
      return throw(Exception("Not A Verify"));
    }
  }
  static Future<List<UserDatum>?> getLikeUserList(String accesstoken,int page,int limit,String type)async{
    print('accesstoken>>${accesstoken}');
    final Map<String, dynamic> apiBodyData = {
      'type': type.toString(),
      'limit': limit.toString(),
      'page': page.toString(),
    };
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response=await http.post(Uri.parse("${AppUrl.baseUrl}api/user/list"),
      body: apiBodyData,
      headers: {
        "authorization": "Bearer ${accesstoken.toString()}",
        "X-localization": "${prefs.getString("lang")}"
      },);
    if(response.statusCode==200)
    {
      liketotalpage=jsonDecode(response.body)['pages'];
      liketotalitems=jsonDecode(response.body)['rows'];
      return likeUserFromJson(jsonDecode(response.body)['data']);
    }
    else if(response.statusCode==422)
    {
      return likeUserFromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==403)
    {
      return likeUserFromJson(jsonDecode(response.body));
    }
    else{
      return throw(Exception("Not A Verify"));
    }
  }



  static Future<List<UserDatum>?> getSearchUserList(String accesstoken,String type,String user_id)async{
    final Map<String, dynamic> apiBodyData = {
      'type': type.toString(),
      'user_id': user_id.toString(),
    };
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response=await http.post(Uri.parse("${AppUrl.baseUrl}api/user/list"),
      body: apiBodyData,
      headers: {
        "authorization": "Bearer ${accesstoken.toString()}",
        "X-localization": "${prefs.getString("lang")}"
      },);
    if(response.statusCode==200)
    {
      return likeUserFromJson(jsonDecode(response.body)['data']);
    }
    else if(response.statusCode==422)
    {
      return likeUserFromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==403)
    {
      return likeUserFromJson(jsonDecode(response.body));
    }
    else{
      return throw(Exception("Not A Verify"));
    }
  }

  static Future<FilterListModel> getFilterList(String accesstoken)async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("{prefs.getString(""lang"")}");
    print("${prefs.getString("lang")}");
    var response=await http.post(Uri.parse("${AppUrl.baseUrl}api/content/list"),
      headers: {
        "authorization": "Bearer ${accesstoken.toString()}",
        "X-localization": "${prefs.getString("lang")}"
      },);
    if(response.statusCode==200)
    {
      print(jsonDecode(response.body));
      return FilterListModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==422)
    {
      return FilterListModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==403)
    {
      return FilterListModel.fromJson(jsonDecode(response.body));
    }
    else{
      return throw(Exception("Not A Verify"));
    }
  }

  static Future<RemainderListModel> getRemainderList(String accesstoken)async{
    print(accesstoken);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response=await http.post(Uri.parse("${AppUrl.baseUrl}api/event/reminder-option"),
      headers: {
        "authorization": "Bearer ${accesstoken.toString()}",
        "X-localization": "${prefs.getString("lang")}"
      },);
    if(response.statusCode==200)
    {
      print(jsonDecode(response.body));
      return RemainderListModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==422)
    {
      return RemainderListModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==403)
    {
      return RemainderListModel.fromJson(jsonDecode(response.body));
    }
    else{
      return throw(Exception("Not A Verify"));
    }
  }

  static Future<EventModelList> getEventList(String accesstoken,String userId)async{
    print(accesstoken);
    final Map<String, dynamic> apiBodyData = {
      'user_id': userId.toString(),
    };
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response=await http.post(Uri.parse("${AppUrl.baseUrl}api/event/list"),
      body: apiBodyData,
      headers: {
        "authorization": "Bearer ${accesstoken.toString()}",
        "X-localization": "${prefs.getString("lang")}"
      },);
    if(response.statusCode==200)
    {
      print(jsonDecode(response.body));
      return EventModelList.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==422)
    {
      return EventModelList.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==403)
    {
      return EventModelList.fromJson(jsonDecode(response.body));
    }
    else{
      return throw(Exception("Not A Verify"));
    }
  }

  static Future<GhostModel> getGhostStickerList(String accesstoken)async{
    print(accesstoken);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response=await http.post(Uri.parse("${AppUrl.baseUrl}api/ghost/stickers"),
      headers: {
        "authorization": "Bearer ${accesstoken.toString()}",
        "X-localization": "${prefs.getString("lang")}"
      },);
    if(response.statusCode==200)
    {
      print(jsonDecode(response.body));
      return GhostModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==422)
    {
      return GhostModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==403)
    {
      return GhostModel.fromJson(jsonDecode(response.body));
    }
    else{
      return throw(Exception("Not A Verify"));
    }
  }

  static Future<UsersChatListModel> getChatList(String accesstoken)async{

    print(accesstoken);
    // final Map<String, dynamic> apiBodyData = {
    //   'search': searchuserchat,
    // };
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response=await http.post(Uri.parse("${AppUrl.baseUrl}api/chat-users/list"),
     // body: apiBodyData,
      headers: {
        "authorization": "Bearer ${accesstoken.toString()}",
        "X-localization": "${prefs.getString("lang")}"
      },);
    print(jsonDecode(response.body));
    if(response.statusCode==200)
    {
      print(jsonDecode(response.body));
      return UsersChatListModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==422)
    {
      return UsersChatListModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==403)
    {
      return UsersChatListModel.fromJson(jsonDecode(response.body));
    }
    else{
      return throw(Exception("Not A Verify"));
    }
  }

  static Future<YourActivitylistModel> getUserAcitvity(String accesstoken)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response=await http.post(Uri.parse("${AppUrl.baseUrl}api/log/counts"),
      headers: {
        "authorization": "Bearer ${accesstoken.toString()}",
        "X-localization": "${prefs.getString("lang")}"
      },);
    if(response.statusCode==200)
    {
      print(jsonDecode(response.body));
      return YourActivitylistModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==422)
    {
      return YourActivitylistModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==403)
    {
      return YourActivitylistModel.fromJson(jsonDecode(response.body));
    }
    else{
      return throw(Exception("Not A Verify"));
    }
  }


  static Future<CampaignModel> getCampignList(String accesstoken)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response=await http.post(Uri.parse("${AppUrl.baseUrl}api/campaign/list"),
      headers: {
        "authorization": "Bearer ${accesstoken.toString()}",
        "X-localization": "${prefs.getString("lang")}"
      },);
    if(response.statusCode==200)
    {
      print(jsonDecode(response.body));
      return CampaignModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==422)
    {
      return CampaignModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==403)
    {
      return CampaignModel.fromJson(jsonDecode(response.body));
    }
    else{
      return throw(Exception("Not A Verify"));
    }
  }

  static Future<CampaignDetailModel> getCampignDetails(String accesstoken,int id)async{
    final Map<String, dynamic> apiBodyData = {
      'id': id.toString(),
    };
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response=await http.post(Uri.parse("${AppUrl.baseUrl}api/campaign/detail"),
      body: apiBodyData,
      headers: {
        "authorization": "Bearer ${accesstoken.toString()}",
        "X-localization": "${prefs.getString("lang")}"
      },);
    if(response.statusCode==200)
    {
      print(jsonDecode(response.body));
      return CampaignDetailModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==422)
    {
      return CampaignDetailModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==403)
    {
      return CampaignDetailModel.fromJson(jsonDecode(response.body));
    }
    else{
      return throw(Exception("Not A Verify"));
    }
  }


  static Future<bool> updateview(String accesstoken)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response=await http.post(Uri.parse("${AppUrl.baseUrl}api/campaign/view"),
      headers: {
        "authorization": "Bearer ${accesstoken.toString()}",
        "X-localization": "${prefs.getString("lang")}"
      },);
    if(response.statusCode==200)
    {
      print("hello");
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

  static Future<bool> eventcreate(String accesstoken,String user_id,String title,String description,String date,String reminder_id,String type)async{
    final Map<String, dynamic> apiBodyData = {
      'user_id': user_id.toString(),
      'title': title.toString(),
      'description': description.toString(),
      'date': date.toString(),
      'reminder_id': reminder_id.toString(),
      'event_for': type.toString(),
    };
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response=await http.post(Uri.parse("${AppUrl.baseUrl}api/event/create"),
      body: apiBodyData,
      headers: {
        "authorization": "Bearer ${accesstoken.toString()}",
        "X-localization": "${prefs.getString("lang")}"
      },);
    print(response.body);
    if(response.statusCode==200)
    {
      print(response.body);
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

  static Future<bool> eventupdate(String accesstoken,String eventid,String title,String description,String utp,String reminder_id,String type)async{
    print(utp);
    print(eventid);
    print(title);
    print(description);
    final Map<String, dynamic> apiBodyData = {
      'id': eventid.toString(),
      'title': title.toString(),
      'description': description.toString(),
      'date': utp.toString(),
      'reminder_id': reminder_id.toString(),
      'event_for': type.toString(),
    };
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response=await http.post(Uri.parse("${AppUrl.baseUrl}api/event/update"),
      body: apiBodyData,
      headers: {
        "authorization": "Bearer ${accesstoken.toString()}",
        "X-localization": "${prefs.getString("lang")}"
      },);
    if(response.statusCode==200)
    {
      print(response.body);
      print("hello");
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

  static Future<bool> eventdelete(String accesstoken,String event_id)async{
    final Map<String, dynamic> apiBodyData = {
      'id': event_id.toString(),
    };
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response=await http.post(Uri.parse("${AppUrl.baseUrl}api/event/delete"),
      body: apiBodyData,
      headers: {
        "authorization": "Bearer ${accesstoken.toString()}",
        "X-localization": "${prefs.getString("lang")}"
      },);
    if(response.statusCode==200)
    {
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
  static Future<UserSwipeModel> userlike(String accesstoken,String user_id,String is_super_like)async{
    final Map<String, dynamic> apiBodyData = {
      'user_id': user_id.toString(),
      'is_super_like': is_super_like.toString(),
    };
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response=await http.post(Uri.parse("${AppUrl.baseUrl}api/user/like"),
      body: apiBodyData,
      headers: {
        "authorization": "Bearer ${accesstoken.toString()}",
        "X-localization": "${prefs.getString("lang")}"
      },);
    if(response.statusCode==200)
    {
      return UserSwipeModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==422)
    {
      return UserSwipeModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==403)
    {
      return UserSwipeModel.fromJson(jsonDecode(response.body));
    }
    else{
      print(response.statusCode==403);
      print(response.body);
      return throw(Exception("Not A Verify"));
    }
  }
  static Future<bool> userUndo(String accesstoken,String user_id)async{

    final Map<String, dynamic> apiBodyData = {
      'user_id': user_id.toString(),
    };
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response=await http.post(Uri.parse("${AppUrl.baseUrl}api/user/undo"),
      body: apiBodyData,
      headers: {
        "authorization": "Bearer ${accesstoken.toString()}",
        "X-localization": "${prefs.getString("lang")}"
      },);
    if(response.statusCode==200)
    {
      print(response.body);
      print("hello");
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
  static Future<UserSwipeModel> userdislike(String accesstoken,String user_id)async{
    print(accesstoken);
    print(user_id);
    final Map<String, dynamic> apiBodyData = {
      'user_id': user_id.toString(),
    };
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response=await http.post(Uri.parse("${AppUrl.baseUrl}api/user/dislike"),
      body: apiBodyData,
      headers: {
        "authorization": "Bearer ${accesstoken.toString()}",
        "X-localization": "${prefs.getString("lang")}"
      },);
    if(response.statusCode==200)
    {
      print(response.body);
      print("hello");
      return UserSwipeModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==422)
    {
      return UserSwipeModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==403)
    {
      return UserSwipeModel.fromJson(jsonDecode(response.body));
    }
    else{
      print('api/user/dislike ${response.body.toString()}');
      return throw(Exception("Not A Verify"));
    }
  }

  static Future<bool> signOut(String accesstoken)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response=await http.post(Uri.parse("${AppUrl.baseUrl}api/signout"),
      headers: {
        "authorization": "Bearer ${accesstoken.toString()}",
        "X-localization": "${prefs.getString("lang")}"
      },);
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
  static Future<bool> deleteUser(String accesstoken)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response=await http.post(Uri.parse("${AppUrl.baseUrl}api/account/delete"),
      headers: {
        "authorization": "Bearer ${accesstoken.toString()}",
        "X-localization": "${prefs.getString("lang")}"
      },);
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
  static Future<bool> userChatDelete(String accesstoken,String user_id)async{

    final Map<String, dynamic> apiBodyData = {
      'user_id': user_id,
    };
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response=await http.post(Uri.parse("${AppUrl.baseUrl}api/chat/delete"),
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

  static Future<ChatListModel> chatList(String accesstoken,String user_id)async{
    final Map<String, dynamic> apiBodyData = {
      'user_id': user_id.toString(),
    };
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response=await http.post(Uri.parse("${AppUrl.baseUrl}api/chat/list"),
      body: apiBodyData,
      headers: {
        "authorization": "Bearer ${accesstoken.toString()}",
        "X-localization": "${prefs.getString("lang")}"
      },);
    print(jsonDecode(response.body));
    if(response.statusCode==200)
    {
      print("hello");
      return ChatListModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==422)
    {
      return ChatListModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==403)
    {
      return ChatListModel.fromJson(jsonDecode(response.body));
    }
    else{
      return throw(Exception("Not A Verify"));
    }
  }


  static Future<ProfileDetailModel> monogonomystart(String accesstoken,String user_id,String isSuperlike)async{
    final Map<String, dynamic> apiBodyData = {
      'user_id': user_id.toString(),
      'is_super_monogamy': isSuperlike.toString(),
    };
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response=await http.post(Uri.parse("${AppUrl.baseUrl}api/monogamy/start"),
      body: apiBodyData,
      headers: {
        "authorization": "Bearer ${accesstoken.toString()}",
        "X-localization": "${prefs.getString("lang")}"
      },);
    print(jsonDecode(response.body));
    if(response.statusCode==200)
    {
      print("hello");
      return ProfileDetailModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==422)
    {
      return ProfileDetailModel.fromJson(jsonDecode(response.body));;
    }
    else if(response.statusCode==403)
    {
      return ProfileDetailModel.fromJson(jsonDecode(response.body));;
    }
    else{
      return throw(Exception("Not A Verify"));
    }
  }

  static Future<ChatListModel> chatcreate(String accesstoken,String user_id,String type,String message)async{
    final Map<String, dynamic> apiBodyData = {
      'user_id': user_id.toString(),
      'message_type': type.toString(),
      'message': message.toString(),
    };
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response=await http.post(Uri.parse("${AppUrl.baseUrl}api/chat/create"),
      body: apiBodyData,
      headers: {
        "authorization": "Bearer ${accesstoken.toString()}",
        "X-localization": "${prefs.getString("lang")}"
      },);
    print(jsonDecode(response.body));
    if(response.statusCode==200)
    {
      print("hello");
      print(jsonDecode(response.body));
      return ChatListModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==422)
    {
      return ChatListModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==403)
    {
      return ChatListModel.fromJson(jsonDecode(response.body));
    }
    else{
      return throw(Exception("Not A Verify"));
    }
  }

  static Future<ProfileDetailModel> monogonomystop(String accesstoken,String user_id,String isSuperlike)async{
    final Map<String, dynamic> apiBodyData = {
      'user_id': user_id.toString(),
      'is_super_monogamy': isSuperlike.toString(),
    };
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response=await http.post(Uri.parse("${AppUrl.baseUrl}api/monogamy/stop"),
      body: apiBodyData,
      headers: {
        "authorization": "Bearer ${accesstoken.toString()}",
        "X-localization": "${prefs.getString("lang")}"
      },);
    if(response.statusCode==200)
    {
      print("hello");
      return ProfileDetailModel.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode==422)
    {
      return ProfileDetailModel.fromJson(jsonDecode(response.body));;
    }
    else if(response.statusCode==403)
    {
      return ProfileDetailModel.fromJson(jsonDecode(response.body));;
    }
    else{
      return throw(Exception("Not A Verify"));
    }
  }
}