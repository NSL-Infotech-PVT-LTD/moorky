
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:moorky/commanWidget/commanwidget.dart';
import 'package:moorky/constant/color.dart';
import 'package:moorky/dashboardscreen/provider/dashboardprovider.dart';
import 'package:moorky/dashboardscreen/view/dashboardscreen.dart';
import 'package:moorky/premiumscreen/view/premiumscreen.dart';
import 'package:moorky/settingscreen/model/notificationextenstion.dart';
import 'package:moorky/settingscreen/provider/setting_provider.dart';
import 'package:moorky/settingscreen/repository/setting_repository.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Notification_Screen extends StatefulWidget {
  String notificationtype="";
  Notification_Screen({Key? key,required this.notificationtype}) : super(key: key);

  @override
  State<Notification_Screen> createState() => _Notification_ScreenState();
}

class _Notification_ScreenState extends State<Notification_Screen> {
  SharedPreferences? preferences;
  String date="";
  @override
  void initState() {
    Init();
    super.initState();
  }
  bool isLoad=false;
  bool isdelete=false;
  int page=1;
  ScrollController _scrollController = new ScrollController();
  String usertype="";
  bool ispremium=false;


  void Init() async {
    preferences = await SharedPreferences.getInstance();
    if(preferences!.getString("usertype")!=null)
    {
      print("likeuserlist=====efefef");
      setState(() {
        usertype=preferences!.getString("usertype")!.toString();
        print("preferences!.getString(""usertype"")!.toString()");
        print(preferences!.getString("usertype")!.toString());
        print(usertype);
      });
    }
    if(usertype=="premium")
    {
      print("likeuserlist=====efefefdsdsdssffs========");

      setState(() {
        ispremium=true;
      });
    }
    else{
      setState(() {
        ispremium=false;
      });
    }
    date="";

    var profileprovider=Provider.of<SettingProvider>(context,listen: false);
    profileprovider.resetStreams();
    if(preferences!.getString("accesstoken")!=null)
    {
      print("in sharedprefernce");
      profileprovider.fetchNotificationList(preferences!.getString("accesstoken").toString(),page,20,widget.notificationtype);
      _scrollController.addListener(() {
        print("dc");
        if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent)
        {
          print("asfasfasf");
          profileprovider.setLoadingState(LoadMoreStatus.LOADING);
          profileprovider.fetchNotificationList(preferences!.getString("accesstoken").toString(),++page,20,widget.notificationtype);
        }
      });
    }
  }
  var _scaKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: addMediumText(AppLocalizations.of(context)!.notificatin, 18, Colorss.mainColor),
        centerTitle: true,
        backgroundColor: Color(0xFFFAFAFA),
        elevation: 0.0,
        leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: SvgPicture.asset(
              "assets/images/arrowback.svg",
              fit: BoxFit.scaleDown,
              color: Colorss.mainColor,
            )),
        actions: [
          IconButton(
              iconSize: 75,
              padding: EdgeInsets.zero,
              onPressed: () async{
                var isDelete = await SettingRepository
                    .deletenotification(
                    preferences!.getString(
                        "accesstoken").toString(),
                    "",widget.notificationtype);
                if (isDelete) {
                    Init();
                }
              },
              icon: addLightText(AppLocalizations.of(context)!.clear, 12, Colorss.mainColor)
          ),
        ],
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.all(20.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h,),
              Consumer<SettingProvider>(
                  builder: (context, settingProvider, child) =>settingProvider.notificationList?.data != null ?
                  settingProvider.notificationList!.data!.length > 0 ?ListView.builder(
                    itemCount: settingProvider.notificationList!.data!.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      var inputFormat = DateFormat('dd/MM/yyyy HH:mm');
                      var inputDate = inputFormat.parse(settingProvider
                          .notificationList!.data!.elementAt(index).createdAt
                          .toString());
                      var outputFormat = DateFormat('hh:mm a');
                      var utp = outputFormat.format(inputDate);
                      if ((index == (settingProvider.notificationList!.data!
                          .length - 1)) &&
                          settingProvider.notificationList!.data!.length <
                              settingProvider.notificationList!.rows) {
                        return Center(child: CircularProgressIndicator(),);
                      }
                      print("sdfsdf");
                      if(date.contains(settingProvider.notificationList!.data!.elementAt(index).date))
                      {
                        print(index);
                        settingProvider.notificationList!.data!.elementAt(index).date="";
                      }
                      else{
                        print("index $index");
                        date=settingProvider.notificationList!.data!.elementAt(index).date;
                        print("date $date");
                        var now=DateTime.now();
                        var outputFormat = DateFormat('dd-MMM-yyyy');
                        var today = outputFormat.format(now);
                        print("utp $today");

                        var yesterdaydate=DateTime.now().subtract(Duration(days:1));
                        var yesterday = outputFormat.format(yesterdaydate);
                        print("utp $yesterday");
                        if(settingProvider.notificationList!.data!.elementAt(index).date==today)
                          {
                            settingProvider.notificationList!.data!.elementAt(index).seletdate=AppLocalizations.of(context)!.today;
                          }
                        else if(settingProvider.notificationList!.data!.elementAt(index).date==yesterday)
                        {
                          settingProvider.notificationList!.data!.elementAt(index).seletdate=AppLocalizations.of(context)!.yesterday;
                        }
                        else{
                          settingProvider.notificationList!.data!.elementAt(index).seletdate=settingProvider.notificationList!.data!.elementAt(index).date;
                        }
                        // print(date);
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //settingProvider.notificationList!.data!.elementAt(index).date!=""?addBoldText(settingProvider.notificationList!.data!.elementAt(index).date, 18, Colors.black):Container(),

                          settingProvider.notificationList!.data!.elementAt(index).seletdate!=""?Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              addBoldText(settingProvider.notificationList!.data!.elementAt(index).seletdate, 18, Colorss.mainColor),
                              Divider(height: 1,
                                thickness: 1.5.h,
                                color: Colors.black.withOpacity(0.40),),
                            ],
                          ):Container(),

                          SizedBox(height: 20.h,),
                          !ispremium?GestureDetector(
                            child: ImageFiltered(
                      imageFilter:  ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                      child: BackdropFilter(
                      filter:  ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                      child: Container(
                              margin: EdgeInsets.only(
                                  bottom: 20.w, right: 10.w),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .center,
                                    children: [
                                      SizedBox(
                                          height: 80.h,
                                          width: 80.w,
                                          child: CircleAvatar(
                                            backgroundColor: Colors.white,
                                            backgroundImage: CachedNetworkImageProvider(settingProvider
                                                .notificationList!
                                                .data!
                                                .elementAt(index)
                                                .notification!.image
                                                .toString()),
                                            radius: 500,)),
                                      SizedBox(width: 15.w,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,
                                        children: [
                                          addBoldText(
                                              settingProvider.notificationList!
                                                  .data!
                                                  .elementAt(index)
                                                  .notification!.title
                                                  .toString(), 12,
                                              Colors.black),
                                          SizedBox(height: 5.h,),
                                          addRegularText(
                                              settingProvider.notificationList!
                                                  .data!
                                                  .elementAt(index)
                                                  .notification!.body
                                                  .toString(), 10,
                                              Colors.black),
                                          SizedBox(height: 5.h,),
                                          addRegularText(
                                              utp, 7, Colorss.mainColor),
                                        ],
                                      )
                                    ],
                                  ),
                                  !settingProvider.notificationList!.data!
                                      .elementAt(index).notification!
                                      .isNotifictiondelete!
                                      ? GestureDetector(
                                      onTap: () async {
                                        setState(() {
                                          settingProvider.notificationList!
                                              .data!
                                              .elementAt(index)
                                              .notification!
                                              .isNotifictiondelete = true;
                                        });

                                        var isDelete = await SettingRepository
                                            .deletenotification(
                                            preferences!.getString(
                                                "accesstoken").toString(),
                                            settingProvider.notificationList!
                                                .data!.elementAt(index).id
                                                .toString(),"single");
                                        if (isDelete) {
                                          setState(() {
                                            settingProvider.notificationList!
                                                .data!
                                                .elementAt(index)
                                                .notification!
                                                .isNotifictiondelete = false;
                                            Init();

                                          });

                                          // isdelete=false;
                                        }
                                      },
                                      child: SvgPicture.asset(
                                        "assets/images/notificationdelete.svg",
                                        height: 24.h, width: 24.w,))
                                      : CircularProgressIndicator(),
                                ],
                              ),
                            ))),
                            onTap: (){
                              Get.to(Premium_Screen());
                            },
                          ):Container(
                            margin: EdgeInsets.only(
                                bottom: 20.w, right: 10.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment
                                  .spaceBetween,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment
                                      .center,
                                  children: [
                                    SizedBox(
                                        height: 80.h,
                                        width: 80.w,
                                        child: CircleAvatar(
                                          backgroundColor: Colors.white,
                                          backgroundImage: CachedNetworkImageProvider(settingProvider
                                              .notificationList!
                                              .data!
                                              .elementAt(index)
                                              .notification!.image
                                              .toString()),
                                          radius: 500,)),
                                    SizedBox(width: 15.w,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      mainAxisAlignment: MainAxisAlignment
                                          .center,
                                      children: [
                                        addBoldText(
                                            settingProvider.notificationList!
                                                .data!
                                                .elementAt(index)
                                                .notification!.title
                                                .toString(), 12,
                                            Colors.black),
                                        SizedBox(height: 5.h,),
                                        addRegularText(
                                            settingProvider.notificationList!
                                                .data!
                                                .elementAt(index)
                                                .notification!.body
                                                .toString(), 10,
                                            Colors.black),
                                        SizedBox(height: 5.h,),
                                        addRegularText(
                                            utp, 7, Colorss.mainColor),
                                      ],
                                    )
                                  ],
                                ),
                                !settingProvider.notificationList!.data!
                                    .elementAt(index).notification!
                                    .isNotifictiondelete!
                                    ? GestureDetector(
                                    onTap: () async {
                                      setState(() {
                                        settingProvider.notificationList!
                                            .data!
                                            .elementAt(index)
                                            .notification!
                                            .isNotifictiondelete = true;
                                      });

                                      var isDelete = await SettingRepository
                                          .deletenotification(
                                          preferences!.getString(
                                              "accesstoken").toString(),
                                          settingProvider.notificationList!
                                              .data!.elementAt(index).id
                                              .toString(),"single");
                                      if (isDelete) {
                                        setState(() {
                                          settingProvider.notificationList!
                                              .data!
                                              .elementAt(index)
                                              .notification!
                                              .isNotifictiondelete = false;
                                          Init();

                                        });

                                        // isdelete=false;
                                      }
                                    },
                                    child: SvgPicture.asset(
                                      "assets/images/notificationdelete.svg",
                                      height: 24.h, width: 24.w,))
                                    : CircularProgressIndicator(),
                              ],
                            ),
                          )
                          // ),
                        ],
                      );
                    },
                  ):Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 100.h,),
                        SvgPicture.asset("assets/images/brotherhood.svg"),
                        SizedBox(height: 50.h,),
                        addBoldText(AppLocalizations.of(context)!.morechancegettingalike, 11, Colors.black),
                        SizedBox(height: 10.h,),
                        addRegularText(AppLocalizations.of(context)!.completeyourprofile, 9, Colors.black),
                        SizedBox(height: 10.h,),
                        addRegularText(AppLocalizations.of(context)!.smileinyourprofile, 9, Colors.black),
                        SizedBox(height: 10.h,),
                        addRegularText(AppLocalizations.of(context)!.beactive, 9, Colors.black),
                        SizedBox(height: 40.h,),
                        GestureDetector(
                          onTap: (){
                            Get.off(DashBoardScreen(pageIndex: 1,isNotification: false,));
                          },
                            child: addBoldText(AppLocalizations.of(context)!.keepswiping, 11, Color(0xFFC2A3DD))),
                        SizedBox(height: 100.h,),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10.w,vertical: 20.h),
                          child: GestureDetector(
                            onTap: (){
                              Get.to(Premium_Screen());
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(45.r)
                              ),
                              child: Container(
                                height: 60.h,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: <Color>[
                                        Color(0xFF570084),
                                        Color(0xFFA33BE5)
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(45.r)),
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 30.0.w,right: 15.w),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          SvgPicture.asset("assets/images/slike.svg",fit: BoxFit.scaleDown,height: 30.h,width: 25.w,),
                                          SizedBox(width: 30.w,),
                                          Container(
                                            width: MediaQuery.of(context).size.width * 0.60,
                                            child: Text(AppLocalizations.of(context)!.getmoorkypremium,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: TextStyle(
                                                color: Color(0xFFFFFFFF),
                                                fontSize: 20.sp
                                            )),
                                          ),
                                        ],
                                      ),
                                      SvgPicture.asset("assets/images/arrowforword.svg",height: 15.h,width: 15.w,),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ) : Center(child: CircularProgressIndicator())


              )
            ],
          ),
        ),
      ),
    );
  }
}
