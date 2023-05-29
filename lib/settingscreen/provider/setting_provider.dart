import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:http/http.dart'as http;
import 'package:moorky/auth/model/signupmodel.dart';
import 'package:moorky/dashboardscreen/provider/dashboardprovider.dart';
import 'package:moorky/premiumscreen/model/premiumListmodel.dart';
import 'package:moorky/premiumscreen/model/premiumplan_model.dart';
import 'package:moorky/profilecreate/model/lookingformodel.dart';
import 'package:moorky/profilecreate/model/profileDetailsmodel.dart';
import 'package:moorky/quizscreens/model/questionupdateresponsemodel.dart';
import 'package:moorky/settingscreen/model/notification_model.dart';

import '../repository/setting_repository.dart';

class SettingProvider extends ChangeNotifier{
  NotificationModel? _notificationList;
  NotificationModel? get notificationList => _notificationList;


  PremiumPlansModel? _premiumPlansModel;
  PremiumPlansModel? get premiumPlansModel => _premiumPlansModel;

  PremiumListModel? _premiumListModel;
  PremiumListModel? get premiumListModel => _premiumListModel;



  int totalnotiPages=0;
  int planid=0;
  String sku="";

  List<String> skulist=[];
  List<String> date=[];
  LoadMoreStatus _loadMoreStatus=LoadMoreStatus.STABLE;
  var list;
  getLoadMoreStatus() => _loadMoreStatus;
  SettingProvider(){
    initStream();
  }

  // void UserProfileInit(){
  //   _notificationList=null;
  // }
  //
  //

  void resetallsettinglist(){
    _notificationList=null;
    _premiumPlansModel=null;
    _premiumListModel=null;
    notifyListeners();
  }
  void resetPriumiumPlans(){
    _premiumListModel=null;
    _premiumPlansModel=null;
  }
  void initStream() {
    _notificationList=null;

    totalnotiPages=0;
  }
  // void adddetails(ProfileDetailModel? model)
  // {
  //   _profiledetails=model;
  //   notifyListeners();
  // }
  void resetStreams() {
    initStream();
  }
  fetchPremiumPlans(String accessToken,String plan)
  async{
    PremiumPlansModel? premiumPlansModel = await SettingRepository.getpremuimplansList(accessToken,plan);
    if (_premiumPlansModel == null) {
      _premiumPlansModel = premiumPlansModel;
      planid=premiumPlansModel.data!.elementAt(0).id;
      if(Platform.isIOS)
        {
          sku=premiumPlansModel.data!.elementAt(0).ios_sku;
        }
      else{
        sku=premiumPlansModel.data!.elementAt(0).android_sku;
      }
      for(int i=0;i<premiumPlansModel.data!.length;i++)
        {
          if(Platform.isIOS)
          {
            if(premiumPlansModel.data!.elementAt(i).ios_sku!="")
            {
              skulist.add(premiumPlansModel.data!.elementAt(i).ios_sku);
            }
          }
          else{
            if(premiumPlansModel.data!.elementAt(i).android_sku!="")
            {
              skulist.add(premiumPlansModel.data!.elementAt(i).android_sku);
            }
          }


        }

    }
    notifyListeners();
  }
  fetchPremiumList(String accessToken,String plan)
  async{
    PremiumListModel? premiumListModel = await SettingRepository.getpremuimList(accessToken,plan);
    if (_premiumListModel == null) {
      _premiumListModel = premiumListModel;
    }
    notifyListeners();
  }


  fetchNotificationList(String accessToken,int page, int limit,String type)
  async{
    if((totalnotiPages==0)||page<=totalnotiPages) {
      NotificationModel? notificationList = await SettingRepository.getnotificationList(accessToken,page,limit,type);
      if (_notificationList == null) {
        totalnotiPages=notificationList.pages;
        _notificationList = notificationList;
        //_orderList = new List<OrderModel>.empty(growable: true);
      }
      else{
        _notificationList!.data!.addAll(notificationList.data!.toList());
        _notificationList = _notificationList;
        // One load more is done will make it status as stable.
        setLoadingState(LoadMoreStatus.STABLE);
      }
    }
    notifyListeners();
    if(page > totalnotiPages){
      // One load more is done will make it status as stable.
      setLoadingState(LoadMoreStatus.STABLE);
      notifyListeners();
    }
  }

  setLoadingState(LoadMoreStatus loadMoreStatus) {
    _loadMoreStatus = loadMoreStatus;
    notifyListeners();
  }

  notify(){
    notifyListeners();
  }

}