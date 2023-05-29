import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moorky/commanWidget/commanwidget.dart';
import 'package:moorky/dashboardscreen/model/youractivityListModel.dart';
import 'package:moorky/dashboardscreen/provider/dashboardprovider.dart';
import 'package:moorky/dashboardscreen/repository/dashboardrepository.dart';
import 'package:moorky/premiumscreen/view/premiumscreen.dart';
import 'package:moorky/profilecreate/model/profileDetailsmodel.dart';
import 'package:moorky/profilecreate/provider/profileprovider.dart';
import 'package:moorky/profilecreate/repository/profileRepository.dart';
import 'package:moorky/profiledetailscreen/view/profiledetailscreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../constant/color.dart';

class UserActivity_Screen extends StatefulWidget {
  const UserActivity_Screen({Key? key}) : super(key: key);

  @override
  State<UserActivity_Screen> createState() => _UserActivity_ScreenState();
}

class _UserActivity_ScreenState extends State<UserActivity_Screen> {
  SharedPreferences? preferences;
  ScrollController _scrollController = new ScrollController();
  String usertype="";
  int page=1;
  bool ispremium=false;

  bool isMonogamyUser=false;
  @override
  void initState() {
    Init();
    super.initState();
  }
  void Init() async {
    preferences = await SharedPreferences.getInstance();
    var provider=Provider.of<DashboardProvider>(context,listen: false);
    provider.resetLikeUserList();
    var profilepro=Provider.of<ProfileProvider>(context,listen: false);
    if(preferences!.getString("accesstoken")!=null)
    {
      print(preferences!.getString("accesstoken")!.toString());
      provider.fetchUserActivity(preferences!.getString("accesstoken").toString());
      profilepro.fetchProfileDetailsuseractivity(preferences!.getString("accesstoken").toString());
    }
    print("likeuserlist=====");
    if(preferences!.getString("usertype")!=null)
    {
      print("likeuserlist=====efefef");
      setState(() {
        usertype=preferences!.getString("usertype")!.toString();
      });
    }
    print("likeuserlist=====efefefdsdsdssffs");
    if(usertype=="premium")
    {
      if(profilepro.activemonogomy)
        {
          setState(() {
            ispremium=true;
            isMonogamyUser=true;
          });
        }
      else{
        setState(() {
          ispremium=true;
          isMonogamyUser=false;
        });
      }

        likeuserlist();
    }
    else{
      var profilepro=Provider.of<ProfileProvider>(context,listen: false);
        setState(() {
          ispremium=false;
        });
        likeuserlist();
      // Get.to(Premium_Screen());
    }
  }
  likeuserlist()async{
    print("likeuserlist");
    var dashboardprovider=Provider.of<DashboardProvider>(context,listen: false);
    if(preferences!.getString("accesstoken")!=null)
    {
      dashboardprovider.fetchLikeUserList(preferences!.getString("accesstoken").toString(),page,20,"likes");
      _scrollController.addListener(() {
        if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent)
        {
          print("asfasfasf");
          dashboardprovider.setLoadingState(LoadMoreStatus.LOADING);
          dashboardprovider.fetchLikeUserList(preferences!.getString("accesstoken").toString(),++page,20,"likes");
        }
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            SizedBox(height: 30.h,),
            SvgPicture.asset("assets/images/meter.svg",height: 50.h,width: 50.w,fit: BoxFit.fill,),
            SizedBox(height: 10.h,),
            Consumer<DashboardProvider>(builder:
                (context,dataProvider,child){
              if(dataProvider.yourActivitylistModel != null)
              {
                return dataProvider.yourActivitylistModel!.data!.length > 0
                    ?
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text.rich(TextSpan(
                        text:
                        "${AppLocalizations.of(context)!.youractivity}: ",
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontSize: 20,
                              color:
                              Color(0xFF6B00C3)),
                        ),
                        children: <InlineSpan>[
                          TextSpan(
                            text: dataProvider.yourActivitylistModel!.your_activity,
                            style: GoogleFonts.poppins(
                              textStyle:
                              TextStyle(
                                  fontSize: 20,
                                  color: Color(0xFFB560FF)),
                            ),
                          ),
                        ])),
                    SizedBox(height: 10.h,),
                    Container(
                      height: 150,
                      child: SfCartesianChart(
                          primaryXAxis: CategoryAxis(isVisible: true,arrangeByIndex: true,labelPlacement: LabelPlacement.onTicks,
                          labelStyle: TextStyle(color: Colors.black)),
                          primaryYAxis: CategoryAxis(isVisible: false,),
                          enableAxisAnimation: true,
                          borderWidth: 0,
                          onMarkerRender: (args) {
                            print(args.pointIndex!);
                            if(args.pointIndex! == 6)
                              {
                                args.color = Colorss.mainColor;
                                args.markerHeight = 10;
                                args.markerWidth = 10;
                                args.shape = DataMarkerType.circle;
                                args.borderWidth = 0;
                              }
                          },
                          plotAreaBorderWidth: 0,
                          series: <ChartSeries>[
                            LineSeries<UserActivityData, String>(
                                dataSource: dataProvider.yourActivitylistModel!.data!.reversed.toList(),
                                xValueMapper: (UserActivityData date, _) => date.date,
                                yValueMapper: (UserActivityData count, _) => count.count,
                                color: Colorss.mainColor,
                                markerSettings:MarkerSettings(isVisible: true,color: Colors.white,borderColor: Colorss.mainColor,
                                ),
                                dataLabelSettings: DataLabelSettings(isVisible: false
                                ))
                          ]
                      ),
                    ),
                    SizedBox(height: 10.h,),
                    addMediumText("${dataProvider.yourActivitylistModel!.matches} ${AppLocalizations.of(context)!.newcontact} · ${dataProvider.yourActivitylistModel!.visitors} ${AppLocalizations.of(context)!.newvisitor} · ${dataProvider.yourActivitylistModel!.likes} ${AppLocalizations.of(context)!.likedyou}", 12, Colors.black),
                  ],
                )
                    :
                Center(child: Container(
                  alignment: Alignment.center,
                  width: 200.w,
                  child: Column(
                    children: [
                      SizedBox(height: 25.h,),
                      SvgPicture.asset("assets/images/messagelike.svg",color: Colorss.mainColor,fit: BoxFit.scaleDown,
                        height: 100.h,width: 100.h,),
                      SizedBox(height: 15.h,),
                      addLightCenterText(AppLocalizations.of(context)!.huhseemsempty, 10, Color(0xFF15294B)),
                      SizedBox(height: 25.h,),
                      addCenterRegularText(AppLocalizations.of(context)!.keepswiping, 16, Colorss.mainColor),
                      SizedBox(height: 100.h,),
                    ],
                  ),
                ),);
              }
              return Center(child: CircularProgressIndicator(),);
            }),
            SizedBox(height: 40.h,),
            Column(
              children: [
                addBoldText(AppLocalizations.of(context)!.wholikesyou, 14, Colorss.mainColor
                ),
                Consumer<DashboardProvider>(builder:
                    (context,dataProvider,child){
                  if(dataProvider.likeuserList != null)
                  {
                    return dataProvider.likeuserList!.length > 0
                        ?
                    GridView.builder(
                        controller: _scrollController,
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0,
                          mainAxisExtent: 150.h
                        ),
                        itemBuilder: (context,index){
                          if ((index == (dataProvider.likeuserList!.length)-1) &&
                              dataProvider.likeuserList!.length < liketotalitems) {
                            print("the length is");
                            print( dataProvider.likeuserList!.length);
                            return Center(child: CircularProgressIndicator(),);
                          }
                          return ispremium?!isMonogamyUser?GestureDetector(
                            onTap: ()async{
                              var profileprovider = Provider.of<ProfileProvider>(context, listen: false);
                              profileprovider.UserProfileInit();

                              SharedPreferences preferences = await SharedPreferences.getInstance();
                              ProfileDetailModel? profiledetails;
                              if (preferences.getString("accesstoken") != null) {
                                profiledetails = await ProfileRepository.profileDetails(preferences.getString("accesstoken").toString());
                              }
                              if(profiledetails != null)
                              {
                                Get.to(ProfileDetailScreen(user_id: dataProvider.likeuserList!.elementAt(index).id.toString(), isSelf: false, isLike: true, isSearch: false,
                                  startheigh: profiledetails.data!.userfilterdata!.start_tall_are_you.toString(),
                                  endheigh: profiledetails.data!.userfilterdata!.end_tall_are_you.toString(),
                                  startag: profiledetails.data!.userfilterdata!.age_from.toString(),
                                  endag: profiledetails.data!.userfilterdata!.age_to.toString(),
                                  religion: profiledetails.data!.userfilterdata!.religion.toString(),
                                  search: "",
                                  star_sign: profiledetails.data!.userfilterdata!.star_sign.toString(),
                                  sexual_orientation: profiledetails.data!.userfilterdata!.sexual_orientation.toString(),
                                  refresh: "",
                                  feel_about_kids: profiledetails.data!.userfilterdata!.feel_about_kids.toString(),
                                  do_you_smoke: profiledetails.data!.userfilterdata!.do_you_smoke.toString(),
                                  do_you_drink: profiledetails.data!.userfilterdata!.do_you_drink.toString(),
                                  directchatcount:0,
                                  datewith: profiledetails.data!.userfilterdata!.date_with.toString(),
                                  education: profiledetails.data!.userfilterdata!.education.toString(),
                                  have_pets: profiledetails.data!.userfilterdata!.have_pets.toString(),
                                  isPremium: "",
                                  introvert_or_extrovert: profiledetails.data!.userfilterdata!.introvert_or_extrovert.toString(),
                                  looking_fors: profiledetails.data!.userfilterdata!.looking_fors.toString(),
                                  languages: profiledetails.data!.userfilterdata!.languages.toString(),
                                  languageList: profiledetails.data!.userfilterdata!.languages.toString().replaceAll("[", "").replaceAll("]", ""),
                                  maritals: profiledetails.data!.userfilterdata!.maritals.toString(),
                                  profileimage: "",
                                  type: "all",
                                  usertype: profiledetails.data!.user_type,
                                  userIndex: "",));
                              }
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),child: Container(
                              decoration: BoxDecoration(border: Border.all(color: Color(0xFFAB60ED),width: 0.5),
                              borderRadius: BorderRadius.circular(15.0),),
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl: dataProvider.likeuserList!.elementAt(index).profile_image.toString(),
                                  height: MediaQuery.of(context).size.height*0.75,width: MediaQuery.of(context).size.width*0.85,
                                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                                      Container(child: CircularProgressIndicator(value: downloadProgress.progress),alignment: Alignment.center,),
                                  errorWidget: (context, url, error) => Icon(Icons.error),
                                )
                            //Image.network(dataProvider.likeuserList!.elementAt(index).images!.elementAt(0).image,fit: BoxFit.fill,),
                            ),
                            ),
                          ):ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),child: Container(
                              decoration: BoxDecoration(border: Border.all(color: Color(0xFFAB60ED),width: 0.5),
                                borderRadius: BorderRadius.circular(15.0),),
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: dataProvider.likeuserList!.elementAt(index).profile_image.toString(),
                                height: MediaQuery.of(context).size.height*0.75,width: MediaQuery.of(context).size.width*0.85,
                                progressIndicatorBuilder: (context, url, downloadProgress) =>
                                    Container(child: CircularProgressIndicator(value: downloadProgress.progress),alignment: Alignment.center,),
                                errorWidget: (context, url, error) => Icon(Icons.error),
                              )
                            //Image.network(dataProvider.likeuserList!.elementAt(index).images!.elementAt(0).image,fit: BoxFit.fill,),
                          ),
                          ):GestureDetector(
                            onTap: (){
                              Get.to(Premium_Screen());
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),child: Container(
                                decoration: BoxDecoration(border: Border.all(color: Color(0xFFAB60ED),width: 0.5),
                                  borderRadius: BorderRadius.circular(15.0),),
                                child: ImageFiltered(
                                  imageFilter:  ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                                  child: BackdropFilter(
                                    filter:  ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                                    child: Container(
                                      decoration: new BoxDecoration(color: Colors.white.withOpacity(0.0)),
                                      child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        imageUrl: dataProvider.likeuserList!.elementAt(index).profile_image.toString(),
                                        height: MediaQuery.of(context).size.height*0.75,width: MediaQuery.of(context).size.width*0.85,
                                        progressIndicatorBuilder: (context, url, downloadProgress) =>
                                            Container(child: CircularProgressIndicator(value: downloadProgress.progress),alignment: Alignment.center,),
                                        errorWidget: (context, url, error) => Icon(Icons.error),
                                      ),
                                    ),
                                  ),
                                )
                              //Image.network(dataProvider.likeuserList!.elementAt(index).images!.elementAt(0).image,fit: BoxFit.fill,),
                            ),
                            ),
                          );
                        },
                        itemCount: dataProvider.likeuserList!.length)
                        :
                    Center(child: Container(
                      alignment: Alignment.center,
                      width: 200.w,
                      child: Column(
                        children: [
                          SizedBox(height: 25.h,),
                          SvgPicture.asset("assets/images/messagelike.svg",color: Colorss.mainColor,fit: BoxFit.scaleDown,
                          height: 100.h,width: 100.h,),
                          SizedBox(height: 15.h,),
                          addLightCenterText(AppLocalizations.of(context)!.huhseemsempty, 10, Color(0xFF15294B)),
                          SizedBox(height: 25.h,),
                          addCenterRegularText(AppLocalizations.of(context)!.keepswiping, 16, Colorss.mainColor),
                          SizedBox(height: 100.h,),
                        ],
                      ),
                    ),);
                  }
                  return Center(child: CircularProgressIndicator(),);
                }),
              ],
            ),
            Container(
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.only(bottom: 15.h,top: 5.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset("assets/images/moorky2.png",height: 45.h,width: 150.w,),
                  SizedBox(height: 5.h,),
                  Container(
                    height: 8.h,width: 140.w,decoration: BoxDecoration(color: Color(0xFF751ACD),borderRadius: BorderRadius.circular(25.r)),),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
