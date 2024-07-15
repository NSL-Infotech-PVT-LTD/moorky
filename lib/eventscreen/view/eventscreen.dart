import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:moorky/calender/flutter_neat_and_clean_calendar.dart';
import 'package:moorky/commanWidget/commanwidget.dart';
import 'package:moorky/constant/color.dart';
import 'package:moorky/dashboardscreen/homescreen/view/homescreen_new.dart';
import 'package:moorky/dashboardscreen/provider/dashboardprovider.dart';
import 'package:moorky/dashboardscreen/repository/dashboardrepository.dart';
import 'package:moorky/dashboardscreen/view/dashboardscreen.dart';
import 'package:moorky/eventscreen/view/customizationcalendar_screen.dart';
import 'package:moorky/lang/provider/locale_provider.dart';
import 'package:moorky/profilecreate/provider/profileprovider.dart';
import 'package:moorky/profilescreen/view/profilescreen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class Event_Screen extends StatefulWidget {
  @override
  State<Event_Screen> createState() => _Event_ScreenState();
}

class _Event_ScreenState extends State<Event_Screen> {
  SharedPreferences? preferences;
  bool isLoad=false;
  String anotherUserId="";
  DateTime? dateTime=DateTime.now();
  String currentDate="";
  int color=0;
  @override
  void initState() {
    Init();
    super.initState();
  }

  void Init() async {

    preferences = await SharedPreferences.getInstance();
    var dashprovider = Provider.of<DashboardProvider>(context, listen: false);
    var profilepro = Provider.of<ProfileProvider>(context, listen: false);
    profilepro.resetStreams();
    dashprovider.resetEventList();
    if (preferences!.getString("accesstoken") != null) {
      print("hello2");
      print(profilepro.anotheruserID);
      profilepro.fetchProfileDetails(preferences!.getString("accesstoken").toString());
      dashprovider.fetchEventList(
          preferences!.getString("accesstoken").toString(),profilepro.anotheruserID);
      print("hello25");
      setState(() {
        anotherUserId=profilepro.anotheruserID;
      });
    }
  }
  final List<NeatCleanCalendarEvent> _eventList=[];


  @override
  Widget build(BuildContext context) {
    var profilepro = Provider.of<ProfileProvider>(context);
    final provider = Provider.of<LocaleProvider>(context);
    //currentDate=DateFormat('d MMMM y',provider.locale!.languageCode.toString()).format(dateTime!);
    if(!profilepro.activemonogomy)
    {
      print("fhhjdfghjsdf==");
      Get.off(DashBoardScreen(pageIndex: 1,isNotification: false,));
    }
    else{
      print("fhhjdfghjsdf");
    }

    return Scaffold(
      appBar:AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Image.asset("assets/images/moorky2.png",fit: BoxFit.scaleDown,height: 60.h,width: 100.w,),
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 10.w,),
            Consumer<ProfileProvider>(
              builder: (context,profileprovider,child) {
                return InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: (){
                      Get.to(ProfileScreen());
                    },
                    child:
                    ClipOval(
                        child: (profileprovider
                            ?.profiledetails?.data?.profile_image ??
                            "")
                            .isEmpty
                            ? CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.blue,
                          child: Image.asset("assets/images/imgavtar.png"),
                        )
                            : CachedNetworkImage(
                          imageUrl: profileprovider
                              ?.profiledetails?.data?.profile_image ??
                              "",
                          fit: BoxFit.cover,
                          imageBuilder: (context, imageProvider) =>
                              CircleAvatar(
                                backgroundImage: imageProvider,
                                radius: 20.0,
                              ),
                        )),);
              }
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(bottom: 10),
          child: Consumer<DashboardProvider>(builder:
              (context,dataProvider,child){
            if(dataProvider.eventModelList?.data != null)
            {
              _eventList.clear();
              for(int i=0;i<dataProvider.eventModelList!.data!.length;i++){
                var t=DateTime.parse(dataProvider.eventModelList!.data!.elementAt(i).date);
                _eventList.add( NeatCleanCalendarEvent(dataProvider.eventModelList!.data!.elementAt(i).title,
                    startTime: DateTime(t.year, t.month,
                        t.day,t.hour, t.minute),
                    endTime: DateTime(t.year, t.month,
                        t.day,t.hour, t.minute),
                    color: Color(int.parse(dataProvider.eventModelList!.data!.elementAt(i).event_color_code==""?dataProvider.eventModelList!.usersDetail!.user_color.toString():dataProvider.eventModelList!.data!.elementAt(i).event_color_code)),
                    isMultiDay: true));
              }
              return
                Container(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 120.h,
                                  width: 120.w,
                                  margin: EdgeInsets.only(top: 80.h),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    backgroundImage: NetworkImage(dataProvider.eventModelList!.usersDetail!.userImage.toString()),
                                  ),
                                ),
                                SizedBox(width: 70.w,),
                                Container(
                                  height: 120.h,
                                  width: 120.w,
                                  margin: EdgeInsets.only(top:20.h,bottom: 80.h),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    backgroundImage: NetworkImage(dataProvider.eventModelList!.usersDetail!.secondaryUserImage.toString()),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Align(
                              alignment: Alignment.center,
                              child: Container(
                                height: 120.h,
                                width: 120.w,
                                margin: EdgeInsets.only(top: 50.h),
                                child: Image.asset("assets/images/superlike.png"),
                              )
                          )
                        ],
                      ),
                      SizedBox(height: 10.h,),
                      addMediumText(DateFormat('EEEE',provider.locale!.languageCode.toString()).format(DateTime.now()),14,Colorss.mainColor),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          addRegularText(DateFormat('d MMMM y',provider.locale!.languageCode.toString()).format(DateTime.now()), 12, Colorss.mainColor),
                          // SizedBox(width: 5.w,),
                          // Icon(Icons.keyboard_arrow_down,size: 16,color: Colorss.mainColor,)
                          // SvgPicture.asset("assets/images/arrowdown.svg",fit: BoxFit.scaleDown,color: Colorss.mainColor,width: 12,)
                        ],
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height*0.45,
                        child: Calendar(
                          isExpanded: true,
                          eventsList: _eventList,
                          eventTileHeight: 0.0,
                          eventDoneColor: Colors.green,
                          selectedColor: Colorss.mainColor,
                          selectedTodayColor: Colorss.mainColor,
                          todayColor: Colorss.mainColor,
                          eventColor:  null,
                          hideTodayIcon: true,
                          hideBottomBar: true,
                          locale: 'en-Us',
                          onDateSelected: (DateTime date){
                            setState(() {
                              dateTime=date;
                              print(dateTime);
                            });
                          },
                          weekDays: [AppLocalizations.of(context)!.sun,AppLocalizations.of(context)!.mon,AppLocalizations.of(context)!.tue,AppLocalizations.of(context)!.wed,AppLocalizations.of(context)!.thur,AppLocalizations.of(context)!.fri,AppLocalizations.of(context)!.sat],
                          expandableDateFormat: 'EEEE, dd. MMMM yyyy',
                          datePickerType: DatePickerType.date,
                          dayOfWeekStyle: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 13),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            addMediumText(AppLocalizations.of(context)!.schedule, 12, Colorss.mainColor),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    Get.to(CustomizationCalendar_Screen(isEdit: true,title: "",date: DateFormat('d MMMM y',provider.locale!.languageCode.toString()).format(dateTime!),description: "",user_id: anotherUserId,event_id: "",remainder: AppLocalizations.of(context)!.pleaseselectremainder,remainderid: "",type: "self",));
                                  },
                                  child: Container(
                                      height: 40.h,
                                      width: 120.w,
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.bottomCenter,
                                            end: Alignment.topCenter,
                                            colors: <Color>[
                                              Color(0xFF570084),
                                              Color(0xFFA33BE5)
                                            ],
                                          ),
                                          borderRadius: BorderRadius.circular(10.r)),
                                      alignment: Alignment.center,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset("assets/images/add.svg",fit: BoxFit.scaleDown,color: Colors.white,height: 8,width: 8,),
                                          SizedBox(width: 8.h,),
                                          addMediumText(AppLocalizations.of(context)!.forme, 10, Color(0xFFFFFFFF)),
                                        ],
                                      )
                                  ),
                                ),
                                SizedBox(width: 20.w,),
                                GestureDetector(
                                  onTap: (){
                                    Get.to(CustomizationCalendar_Screen(isEdit: true,title: "",date:
                                    DateFormat('d MMMM y  HH:mm:ss').format(dateTime!).toString(),

                                      description: "",user_id: anotherUserId,event_id: "",remainder: AppLocalizations.of(context)!.pleaseselectremainder,remainderid: "",type: "both",));
                                  },
                                  child: Container(
                                      height: 40.h,
                                      width: 120.w,
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.bottomCenter,
                                            end: Alignment.topCenter,
                                            colors: <Color>[
                                              Color(0xFF570084),
                                              Color(0xFFA33BE5)
                                            ],
                                          ),
                                          borderRadius: BorderRadius.circular(10.r)),
                                      alignment: Alignment.center,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset("assets/images/add.svg",fit: BoxFit.scaleDown,color: Colors.white,height: 8,width: 8,),
                                          SizedBox(width: 8.h,),
                                          addMediumText(AppLocalizations.of(context)!.addevent, 10, Color(0xFFFFFFFF)),
                                        ],
                                      )
                                  ),
                                ),
                              ],
                            )

                          ],
                        ),
                      ),
                      SizedBox(height: 30.h,),
                      dataProvider.eventModelList!.data!.length > 0
                          ? ListView.builder(
                        itemCount: dataProvider.eventModelList!.data!.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: ScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          print("dataProvider.eventModelList!.data!.elementAt(index).date");
                          print(dataProvider.eventModelList!.data!.elementAt(index).date);
                          var now = DateTime.now();
                          var inputFormat = DateFormat('yyyy-MM-dd');
                          var inputDate = inputFormat.parse(
                              dateTime
                                  .toString());
                          var outputFormat = DateFormat('yyyy-MM-dd');
                          var utp = outputFormat.format(inputDate);
                          var t=DateTime.parse(dataProvider.eventModelList!.data!.elementAt(index).date);
                          var outputdate = outputFormat.format(t);
                          print("utp");
                          print(utp);
                          print("outputdate");
                          print(outputdate);
                          if(outputdate==utp)
                            {
                              print("utp====");
                              print(dataProvider.eventModelList!.data!.elementAt(index).date);
                            }
                          return GestureDetector(
                            onTap: (){
                              Get.to(
                                  CustomizationCalendar_Screen(
                                    isEdit: false,title: dataProvider.eventModelList!.data!.elementAt(index).title,description: dataProvider.eventModelList!.data!.elementAt(index).description,date: DateFormat('d MMMM y HH:mm:ss').format(DateTime.parse(dataProvider.eventModelList!.data!.elementAt(index).date)).toString(),remainder: dataProvider.eventModelList!.data!.elementAt(index).reminder!.title.toString(),
                                    user_id: anotherUserId,event_id: dataProvider.eventModelList!.data!.elementAt(index).id.toString(),
                                    remainderid: dataProvider.eventModelList!.data!.elementAt(index).reminder!.id.toString(),type: dataProvider.eventModelList!.data!.elementAt(index).event_for.toString(),));
                            },
                            child: outputdate==utp?Container(
                              margin: EdgeInsets.symmetric(horizontal: 15),
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color:Color(int.parse(dataProvider.eventModelList!.usersDetail!.user_color.toString())).withOpacity(0.20),
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          height: 15.h,
                                          decoration: BoxDecoration(
                                              color:Color(int.parse(dataProvider.eventModelList!.usersDetail!.user_color.toString())),
                                              borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
                                          ),
                                        ),
                                        Padding(padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  addBoldText(dataProvider.eventModelList!.data!.elementAt(index).title, 14, Colors.white),
                                                  SizedBox(height: 5,),
                                                  addRegularText(dataProvider.eventModelList!.data!.elementAt(index).description, 8, Colors.white),
                                                  SizedBox(height: 10.h,),
                                                  Row(
                                                    crossAxisAlignment: CrossAxisAlignment.end,
                                                    children: [
                                                      SvgPicture.asset("assets/images/watchs.svg",fit: BoxFit.scaleDown,),
                                                      SizedBox(width: 10,),
                                                      addRegularText(DateFormat('d MMMM y').format(DateTime.parse(dataProvider.eventModelList!.data!.elementAt(index).date)), 9, Colors.white),
                                                    ],
                                                  ),
                                                  SizedBox(height: 5.h,),
                                                ],
                                              ),

                                            ],
                                          ),
                                        )

                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 20.h,),
                                ],
                              ),
                            ):Container(
                            ),
                          );
                        },
                      ) :
                      Center(child: Container(
                          child: Text(AppLocalizations.of(context)!.noeventlist)
                      ),
                      ),
                      SizedBox(height: 20,),
                      !isLoad?
                      GestureDetector(
                        onTap: ()async{
                          setState(() {
                            isLoad=true;
                          });
                          var profileprovider = Provider
                              .of<ProfileProvider>(
                              context, listen: false);
                          var mongonomystart=await DashboardRepository.monogonomystop(preferences!.getString("accesstoken")!,dataProvider.eventModelList!.usersDetail!.secondaryUserId.toString(),"0");
                          if(mongonomystart.statusCode==200)
                          {
                            setState(() {
                              isLoad=false;
                            });
                            print("sahjgjsahc");
                            profileprovider.resetStreams();
                            profileprovider.adddetails(mongonomystart);
                            Get.off(DashBoardScreen(pageIndex: 1,isNotification: false,));
                          }
                        },
                        child: Container(
                            height: 40.h,
                            width: 200.w,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: <Color>[
                                    Color(0xFF570084),
                                    Color(0xFFA33BE5)
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(10.r)),
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset("assets/images/add.svg",fit: BoxFit.scaleDown,color: Colors.white,height: 8,width: 8,),
                                SizedBox(width: 8.h,),
                                addMediumText(AppLocalizations.of(context)!.removemonogamy, 10, Color(0xFFFFFFFF)),
                              ],
                            )
                        ),
                      ):
                    Container(alignment: Alignment.topCenter,child: CircularProgressIndicator(),),

                    ],

                  ),
                );
            }
            return Shimmer.fromColors(
                period: Duration(milliseconds: 800),
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.white,
                child: Container(

                  child:Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      Container(
                        margin: EdgeInsets.only(top: 80.h),
                        decoration: BoxDecoration(shape: BoxShape.circle,  color: Colors.green,),
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          enabled: true,
                          child:   Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: CircleAvatar(
                              radius: 40,
                            ),
                          ),),
                      ),

                        Align(
                            alignment: Alignment.center,
                            child: Container(
                              height: 120.h,
                              width: 120.w,
                              margin: EdgeInsets.only(top: 50.h),
                              child: Image.asset("assets/images/superlike.png"),
                            )
                        ),
                        Container(
                          margin: EdgeInsets.only(top:20.h,bottom: 80.h),
                          decoration: BoxDecoration(shape: BoxShape.circle,  color: Colors.green,),
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            enabled: true,
                            child:   Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: CircleAvatar(
                                radius: 40,
                              ),
                            ),),
                        ),
                    ],),
                    SizedBox(height: 30,),
                    Container(

                      color: Colors.green,
                      constraints: BoxConstraints(maxHeight: 500.h,),
                    ),
                  ],)
                ));
          }),
        ),
      ),
    );
  }
}
