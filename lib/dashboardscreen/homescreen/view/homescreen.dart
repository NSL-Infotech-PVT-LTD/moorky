import 'dart:io';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moorky/commanWidget/commanwidget.dart';
import 'package:moorky/dashboardscreen/messagescreen/new_chat_screen.dart';
import 'package:moorky/dashboardscreen/provider/dashboardprovider.dart';
import 'package:moorky/dashboardscreen/repository/dashboardrepository.dart';
import 'package:moorky/dashboardscreen/view/dashboardscreen.dart';
import 'package:moorky/premiumscreen/view/premiumscreen.dart';
import 'package:moorky/profilecreate/provider/profileprovider.dart';
import 'package:moorky/profiledetailscreen/view/profiledetailscreen.dart';
import 'package:moorky/profilescreen/view/profilescreen.dart';
import 'package:moorky/settingscreen/Swipecard.dart';
import 'package:moorky/settingscreen/view/notification_type_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:moorky/constant/color.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../lang/provider/locale_provider.dart';
import '../../../profilecreate/repository/profileRepository.dart';

 String username = "";

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

// class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
class _HomeScreenState extends State<HomeScreen> {
  bool left = false;
  bool right = false;

  SfRangeValues _values = SfRangeValues(18.0, 100.0);
  SfRangeValues _heightvalues = SfRangeValues(140.0, 150.0);

  bool _switchValue = false;
  double startage = 18.0;
  double endage = 100.0;
  String userId = "";

  double startheight = 130.0;
  double endheight = 270.0;
  bool isPremiums = true;
  bool isUserLiked = false;

  String startheigh = "";
  String endheigh = "";

  String startag = "";
  String endag = "";

  String isPremium = "";
  String datewith = "";

  bool ismen = false;
  bool iswomen = false;
  bool both = false;

  String type = "all";
  String search = "";

  String maritals = "";
  String looking_fors = "";
  String sexual_orientation = "";
  String do_you_drink = "";
  String do_you_smoke = "";
  String feel_about_kids = "";
  String education = "";
  String introvert_or_extrovert = "";
  String star_sign = "";
  String have_pets = "";
  String religion = "";

  String userIndex = "";
  String languageList = "";
  String languages = "";
  String usertype = "";
  int directchatcount = 0;
  String profileimage = "";
  SharedPreferences? preferences;
  String refresh = "";
  TextEditingController searchController = TextEditingController();
  int count = 0;
  final _imageController = PageController();

  String city = '';
  String state = '';
  String country = '';
  String longitude = '';
  String latitude = '';
  List<Card> cardDeck = <Card>[];
  int qindex = 0;

  @override
  void initState() {
    //WidgetsBinding.instance.addObserver(this);
    Init();
    super.initState();
  }

  swipeItemInit(DashboardProvider dashboardprovider) {
    cardDeck = [];
    for (int index = dashboardprovider.currentCard;
        index < dashboardprovider.userModelList.length;
        index++) {
      cardDeck.add(
        Card(
          color: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(43),
            //set border radius more than 50% of height and width to make circle
          ),
          child: Container(
            height: Get.height * 0.7,
            width: Get.width * 0.85,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(43), color: Colors.white),
            child: SingleChildScrollView(
              controller: dashboardprovider.scrollController,
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      SizedBox(
                        height: Get.height * 0.7,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(43),
                          child: dashboardprovider.userModelList
                                      .elementAt(index)
                                      .profile_image !=
                                  ""
                              ? CachedNetworkImage(
                                  fit: dashboardprovider.userModelList
                                          .elementAt(index)
                                          .is_ghost!
                                      ? BoxFit.cover
                                      : BoxFit.cover,
                                  imageUrl: dashboardprovider.userModelList
                                      .elementAt(index)
                                      .profile_image
                                      .toString(),
                                  height: dashboardprovider.userModelList
                                          .elementAt(index)
                                          .is_ghost!
                                      ? MediaQuery.of(context).size.height *
                                          0.75
                                      : MediaQuery.of(context).size.height *
                                          0.75,
                                  width: dashboardprovider.userModelList
                                          .elementAt(index)
                                          .is_ghost!
                                      ? MediaQuery.of(context).size.width * 0.85
                                      : MediaQuery.of(context).size.width *
                                          0.85,
                                  progressIndicatorBuilder: (context, url,
                                          downloadProgress) =>
                                      Container(
                                          alignment: Alignment.center,
                                          child: Shimmer.fromColors(
                                              child: Container(),
                                              baseColor: Colors.black12,
                                              highlightColor: Colors.white)),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                )
                              : Image.asset(
                                  "assets/images/imgavtar.png",
                                  height:
                                      MediaQuery.of(context).size.height * 0.75,
                                  width:
                                      MediaQuery.of(context).size.width * 0.85,
                                  fit: BoxFit.fill,
                                ),
                        ),
                      ),
                      Positioned(
                          bottom: 20,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(27),
                                color: Colors.black12.withOpacity(0.35)),
                            margin: EdgeInsets.only(bottom: 10.h),
                            child: InkWell(
                              onTap: () {
                                var profileprovider =
                                    Provider.of<ProfileProvider>(context,
                                        listen: false);
                                profileprovider?.UserProfileInit();
                                // Get.to(ProfileDetailScreen(
                                //   index: index,
                                //   user_id: dashboardprovider.userModelList
                                //       .elementAt(index)
                                //       .id
                                //       .toString(),
                                //   isSelf: false,
                                //   isLike: false,
                                //   isSearch: false,
                                //   search: search,
                                //   introvert_or_extrovert:
                                //       introvert_or_extrovert,
                                //   isPremium: isPremium,
                                //   sexual_orientation: sexual_orientation,
                                //   star_sign: star_sign,
                                //   startag: startag,
                                //   startheigh: startheigh,
                                //   refresh: refresh,
                                //   religion: religion,
                                //   have_pets: have_pets,
                                //   education: education,
                                //   endag: endag,
                                //   endheigh: endheigh,
                                //   datewith: datewith,
                                //   directchatcount: directchatcount,
                                //   do_you_drink: do_you_drink,
                                //   do_you_smoke: do_you_smoke,
                                //   feel_about_kids: feel_about_kids,
                                //   languageList: languageList,
                                //   languages: languages,
                                //   looking_fors: looking_fors,
                                //   maritals: maritals,
                                //   profileimage: profileimage,
                                //   type: type,
                                //   userIndex: userIndex,
                                //   usertype: usertype,
                                // ));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(27),
                                ),
                                padding: EdgeInsets.symmetric(
                                    vertical: 15.h, horizontal: 20.w),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(27),
                                  ),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.55,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        dashboardprovider.userModelList
                                                .elementAt(index)
                                                .hide_my_age!
                                            ? addSemiBoldText(
                                                "${dashboardprovider.userModelList.elementAt(index).name}",
                                                14,
                                                Colors.white)
                                            : addSemiBoldText(
                                                "${dashboardprovider.userModelList.elementAt(index).name}, ${dashboardprovider.userModelList.elementAt(index).age}",
                                                14,
                                                Colors.white),
                                        dashboardprovider.userModelList
                                                .elementAt(index)
                                                .hide_my_location!
                                            ? Container()
                                            : (dashboardprovider.userModelList
                                                            .elementAt(index)
                                                            .city !=
                                                        "" &&
                                                    dashboardprovider
                                                            .userModelList
                                                            .elementAt(index)
                                                            .state !=
                                                        "")
                                                ? addSemiBoldText(
                                                    "${dashboardprovider.userModelList.elementAt(index).city}, ${dashboardprovider.userModelList.elementAt(index).state}",
                                                    10,
                                                    Colors.white)
                                                : Container(),
                                        SizedBox(
                                          height: 8.h,
                                        ),
                                        dashboardprovider.userModelList
                                                    .elementAt(index)
                                                    .lookingFor !=
                                                ""
                                            ? Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    color: Color(0xFFa3a3a3)),
                                                height: 20,
                                                width: 100,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SvgPicture.network(
                                                      dashboardprovider
                                                          .userModelList
                                                          .elementAt(index)
                                                          .looking_for_icon,
                                                      fit: BoxFit.scaleDown,
                                                      height: 8,
                                                      width: 8,
                                                      color: Colors.white,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    addLightText(
                                                        "${dashboardprovider.userModelList.elementAt(index).lookingFor}",
                                                        8,
                                                        Colors.white)
                                                  ],
                                                ),
                                              )
                                            : Container(),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ))
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(43),
                          bottomLeft: Radius.circular(43)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        SizedBox(
                          height: 10.h,
                        ),
                        dashboardprovider.userModelList
                                    .elementAt(index)
                                    .biography !=
                                ""
                            ? addSemiBoldText(
                                "${AppLocalizations.of(context)!.aboutme}",
                                15,
                                Colorss.mainColor)
                            : SizedBox.shrink(),
                        SizedBox(
                          height: 5.h,
                        ),
                        dashboardprovider.userModelList
                                    .elementAt(index)
                                    .biography !=
                                ""
                            ? addLightText(
                                '${dashboardprovider.userModelList.elementAt(index).biography}',
                                11,
                                Colorss.mainColor)
                            : Container(),
                        SizedBox(
                          height: 15.h,
                        ),


                        Divider(
                          height: 1,
                          thickness: 0.5,
                          color: Color(0xFF6B00C3),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 5),
                          child: addSemiBoldText(
                              "${dashboardprovider.userModelList.elementAt(index).name} ${AppLocalizations.of(context)!.photos}",
                              15,
                              Colorss.mainColor),
                        ),
                        (dashboardprovider.userModelList
                                        .elementAt(index)
                                        .images ??
                                    [])
                                .isNotEmpty
                            ? Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.50,
                                width: MediaQuery.of(context).size.width * 0.85,
                                child: PageView.builder(
                                  controller: _imageController,
                                  physics: ScrollPhysics(),
                                  onPageChanged: (i) {},
                                  itemCount: (dashboardprovider.userModelList
                                              .elementAt(index)
                                              .images ??
                                          [])
                                      .length,
                                  itemBuilder: (context, i) =>
                                      CachedNetworkImage(
                                    imageUrl: (dashboardprovider.userModelList
                                                .elementAt(index)
                                                .images
                                                ?.elementAt(i)
                                                .image ??
                                            "")
                                        .toString(),
                                    height: MediaQuery.of(context).size.height *
                                        0.50,
                                    width: MediaQuery.of(context).size.width *
                                        0.85,
                                    fit: BoxFit.cover,
                                    progressIndicatorBuilder:
                                        (context, url, downloadProgress) =>
                                            Container(
                                      child: CircularProgressIndicator(
                                          value: downloadProgress.progress),
                                      alignment: Alignment.center,
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                ),
                              )
                            : Container(),
                        dashboardprovider.userModelList[index].lookingFor != ""
                            ? Column(
                                children: [
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Divider(
                                    height: 1,
                                    thickness: 0.5,
                                    color: Color(0xFF6B00C3),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20.w),
                                    child: Row(
                                      children: [
                                        SvgPicture.network(
                                          dashboardprovider.userModelList[index]
                                              .looking_for_icon,
                                          color: Color(0xff6B18C3),
                                          fit: BoxFit.scaleDown,
                                          height: 35.h,
                                          width: 35.w,
                                        ),
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        addLightText(
                                            AppLocalizations.of(context)!
                                                .lookingfor,
                                            15,
                                            Color(0xFFB38AE0)),
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        addLightText(
                                            "${dashboardprovider.userModelList[index].lookingFor}",
                                            15,
                                            Color(0xFF6B00C3)),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            : Container(),
                        SizedBox(
                          height: 10.h,
                        ),
                        dashboardprovider.userModelList[index].lookingFor != ""?  Divider(
                          height: 1,
                          thickness: 0.5,
                          color: Color(0xFF6B00C3),
                        ):SizedBox.shrink(),
                        SizedBox(
                          height: 10.h,
                        ),
                        dashboardprovider
                                    .userModelList[index].interests!.length >
                                0
                            ? Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.r),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    addSemiBoldText(
                                        AppLocalizations.of(context)!.interset,
                                        15,
                                        Colorss.mainColor),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Wrap(
                                      children: List.generate(
                                          dashboardprovider.userModelList[index]
                                              .interests!.length,
                                          (indexs) =>
                                              !(dashboardprovider
                                                      .userModelList[index]
                                                      .interests!
                                                      .elementAt(indexs)
                                                      .interestMatch!)
                                                  ? Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Stack(
                                                          children: [
                                                            Align(
                                                              alignment: Alignment
                                                                  .bottomCenter,
                                                              child: Container(
                                                                height: 40.h,
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            10,
                                                                        vertical:
                                                                            5),
                                                                margin:
                                                                    EdgeInsets
                                                                        .all(5
                                                                            .r),
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.all(Radius.circular(20
                                                                            .r)),
                                                                    border: Border.all(
                                                                        color: Colorss
                                                                            .mainColor,
                                                                        width:
                                                                            1.5)),
                                                                child: Text(
                                                                  (dashboardprovider
                                                                              .userModelList[index]
                                                                              .interests?[indexs]
                                                                              .name ??
                                                                          "")
                                                                      .toString(),
                                                                  style: GoogleFonts
                                                                      .poppins(
                                                                    textStyle: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        fontSize: 18
                                                                            .sp,
                                                                        color: Colorss
                                                                            .mainColor),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    )
                                                  : Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Container(
                                                          height: 50.h,
                                                          child: Stack(
                                                            children: [
                                                              Align(
                                                                alignment: Alignment
                                                                    .bottomCenter,
                                                                child:
                                                                    Container(
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.all(Radius.circular(20
                                                                              .r)),
                                                                      color: Colorss
                                                                          .mainColor),
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                          horizontal:
                                                                              15,
                                                                          vertical:
                                                                              5),
                                                                  margin:
                                                                      EdgeInsets
                                                                          .all(5
                                                                              .r),
                                                                  height: 60.h,
                                                                  child: Text(
                                                                    (dashboardprovider.userModelList[index].interests?[indexs].name ??
                                                                            "")
                                                                        .toString(),
                                                                    style: GoogleFonts
                                                                        .poppins(
                                                                      textStyle: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontSize: 18
                                                                              .sp,
                                                                          color:
                                                                              Color(0xFFFFFFFF)),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Container(
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            500)),
                                                                child:
                                                                    CircleAvatar(
                                                                  radius: 12.r,
                                                                  backgroundImage:
                                                                      CachedNetworkImageProvider(
                                                                    (dashboardprovider
                                                                            .userModelList?[index]
                                                                            .profile_image ??
                                                                        ""),
                                                                  ),
                                                                ),
                                                                alignment:
                                                                    Alignment
                                                                        .topLeft,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    )),
                                    ),
                                  ],
                                ),
                              )
                            : Container(),
                        SizedBox(
                          height: 10.h,
                        ),
                        dashboardprovider.userModelList[index].userQuestions!
                                    .length >
                                0
                            ?
                        Column(
                                children: [
                                  Divider(
                                    thickness: 1.5.h,
                                    color: Color(0xFFD3ACF5),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20.w),
                                    child: Material(
                                      elevation: 1,
                                      borderRadius: BorderRadius.circular(15.r),
                                      color: Colors.white,
                                      shadowColor: Colors.white,
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        padding: EdgeInsets.all(15.r),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            addBoldText(
                                                "${dashboardprovider.userModelList[index].userQuestions![qindex].question!.question.toString()}",
                                                14,
                                                Colorss.mainColor),
                                            SizedBox(
                                              height: 15.h,
                                            ),
                                            addRegularText(
                                                dashboardprovider
                                                    .userModelList[index]
                                                    .userQuestions![qindex]
                                                    .answer!
                                                    .toString(),
                                                12,
                                                Color(0xFFAB60ED)),
                                            SizedBox(
                                              height: 5.h,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Container(),
                        dashboardprovider.userModelList[index].userQuestions!
                                    .length >
                                1
                            ? Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                  width: 250.w,
                                  child: SfSlider(
                                    max: dashboardprovider.userModelList[index]
                                            .userQuestions!.length -
                                        1,
                                    value: qindex,
                                    thumbIcon: Center(
                                        child: Icon(
                                      Icons.circle,
                                      color: Colors.white,
                                      size: 12,
                                    )),
                                    inactiveColor: Color(0xFFD3ACF5),
                                    interval: 1,
                                    showTicks: false,
                                    showLabels: false,
                                    minorTicksPerInterval: 1,
                                    activeColor: Colorss.mainColor,
                                    onChanged: (value) {},
                                    onChangeEnd: (value) {
                                      print(value);
                                    },
                                  ),
                                ),
                              )
                            : Container(),
                        Divider(
                          thickness: 1.5.h,
                          color: Color(0xFFD3ACF5),
                        ),
                        dashboardprovider
                                    .userModelList[index].languages!.length >
                                0
                            ? Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.r),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    addSemiBoldText(
                                        AppLocalizations.of(context)!.langugaes,
                                        15,
                                        Colorss.mainColor),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Container(
                                      height: 40.h,
                                      child: ListView.builder(
                                        itemCount: dashboardprovider
                                            .userModelList[index]
                                            .languages!
                                            .length,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        physics: ScrollPhysics(),
                                        itemBuilder: (BuildContext context,
                                            int langIndex) {
                                          return Container(
                                              height: 40.h,
                                              padding: EdgeInsets.all(2.r),
                                              margin: EdgeInsets.all(5.r),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              20.r)),
                                                  border: Border.all(
                                                      color: Colorss.mainColor,
                                                      width: 1)),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  SizedBox(
                                                    width: 10.w,
                                                  ),
                                                  SvgPicture.network(
                                                    dashboardprovider
                                                        .userModelList[index]
                                                        .languages![langIndex]
                                                        .icon,
                                                    fit: BoxFit.scaleDown,
                                                    height: 20.h,
                                                    width: 20.w,
                                                  ),
                                                  SizedBox(
                                                    width: 10.w,
                                                  ),
                                                  addCenterRegularText(
                                                      dashboardprovider
                                                          .userModelList[index]
                                                          .languages![langIndex]
                                                          .language,
                                                      11,
                                                      Colorss.mainColor),
                                                  SizedBox(
                                                    width: 10.w,
                                                  ),
                                                ],
                                              ));
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : Container(),
                        dashboardprovider.userModelList[index].userQuestions!
                            .length >
                            0
                            ? Divider(
                          thickness: 1.5.h,
                          color: Color(0xFFD3ACF5),
                        ):SizedBox.shrink(),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            dashboardprovider.isDisLikeLoading?CircularProgressIndicator():  GestureDetector(
                              onTap: () async {
                                if (usertype == "normal") {
                                  var proprovider =
                                      Provider.of<ProfileProvider>(context,
                                          listen: false);
                                  if (proprovider.swipecount < 20) {
                                    dashboardprovider.showLoaderOnDisLike(true);
                                    var isdislike =
                                        await DashboardRepository.userdislike(
                                            preferences!
                                                .getString("accesstoken")!,
                                            dashboardprovider
                                                .userModelList[index].id.toString());
                                    dashboardprovider.showLoaderOnDisLike(false);

                                    if (isdislike.statusCode == 200) {
                                      if (isUserLiked) {
                                        var dashboardprovider =
                                            Provider.of<DashboardProvider>(
                                                context,
                                                listen: false);
                                        dashboardprovider.resetInitStreamLike();
                                        if (preferences!
                                                .getString("accesstoken") !=
                                            null) {
                                          dashboardprovider.fetchLikeUserList(
                                              preferences!
                                                  .getString("accesstoken")
                                                  .toString(),
                                              1,
                                              20,
                                              "likes");

                                          dashboardprovider
                                              .removeUserFromIndex(
                                              index: index);
                                          Get.off(DashBoardScreen(
                                            pageIndex: 1,
                                            isNotification: false,
                                          ));
                                        }
                                      } else {
                                        var dashboardprovider =
                                            Provider.of<DashboardProvider>(
                                                context,
                                                listen: false);
                                        dashboardprovider.resetStreams();
                                        if (preferences!
                                                .getString("accesstoken") !=
                                            null) {
                                          dashboardprovider.fetchUserList(
                                              preferences!
                                                  .getString("accesstoken")
                                                  .toString(),
                                              1,
                                              20,
                                              startag,
                                              endag,
                                              datewith,
                                              isPremium,
                                              type,
                                              search,
                                              maritals,
                                              looking_fors,
                                              sexual_orientation,
                                              startheigh,
                                              endheigh,
                                              do_you_drink,
                                              do_you_smoke,
                                              feel_about_kids,
                                              education,
                                              introvert_or_extrovert,
                                              star_sign,
                                              have_pets,
                                              religion,
                                              languageList
                                                  .toString()
                                                  .replaceAll("[", "")
                                                  .replaceAll("]", ""),
                                              refresh);
                                          dashboardprovider
                                              .removeUserFromIndex(
                                              index: index);
                                          Get.off(DashBoardScreen(
                                            pageIndex: 1,
                                            isNotification: false,
                                          ));

                                        }
                                      }
                                    }
                                  }
                                  else {

                                    Get.to(Premium_Screen());
                                  }
                                }
                                else {
                                  dashboardprovider.showLoaderOnDisLike(true);
                                  var islike =
                                      await DashboardRepository.userdislike(
                                          preferences!
                                              .getString("accesstoken")!,
                                          dashboardprovider
                                              .userModelList[index].id
                                              .toString());
                                  dashboardprovider.showLoaderOnDisLike(false);
                                  if (islike.statusCode == 200) {
                                    if (isUserLiked) {
                                      var dashboardprovider =
                                          Provider.of<DashboardProvider>(
                                              context,
                                              listen: false);
                                      dashboardprovider.resetInitStreamLike();
                                      if (preferences!
                                              .getString("accesstoken") !=
                                          null) {
                                        print("sdgfahs");
                                        print(preferences!
                                            .getString("accesstoken"));
                                        dashboardprovider.fetchLikeUserList(
                                            preferences!
                                                .getString("accesstoken")
                                                .toString(),
                                            1,
                                            20,
                                            "likes");
                                        dashboardprovider
                                            .removeUserFromIndex(
                                            index: index);
                                        Get.off(DashBoardScreen(
                                          pageIndex: 1,
                                          isNotification: false,
                                        ));
                                      }
                                    } else {
                                      var dashboardprovider =
                                          Provider.of<DashboardProvider>(
                                              context,
                                              listen: false);
                                      dashboardprovider.resetStreams();
                                      if (preferences!
                                              .getString("accesstoken") !=
                                          null) {
                                        print("sdgfahs");
                                        print(preferences!
                                            .getString("accesstoken"));
                                        dashboardprovider.fetchUserList(
                                            preferences!
                                                .getString("accesstoken")
                                                .toString(),
                                            1,
                                            20,
                                            startag,
                                            endag,
                                            datewith,
                                            isPremium,
                                            type,
                                            search,
                                            maritals,
                                            looking_fors,
                                            sexual_orientation,
                                            startheigh,
                                            endheigh,
                                            do_you_drink,
                                            do_you_smoke,
                                            feel_about_kids,
                                            education,
                                            introvert_or_extrovert,
                                            star_sign,
                                            have_pets,
                                            religion,
                                            languageList
                                                .toString()
                                                .replaceAll("[", "")
                                                .replaceAll("]", ""),
                                            refresh);
                                        dashboardprovider
                                            .removeUserFromIndex(
                                            index: index);
                                        Get.off(DashBoardScreen(
                                          pageIndex: 1,
                                          isNotification: false,
                                        ));
                                      }
                                    }
                                  }
                                }
                              },
                              child: Container(
                                height: 60.h,
                                width: 60.w,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: <Color>[
                                        Color(0xFFA33BE5),
                                        Color(0xFF570084),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(15.r)),
                                alignment: Alignment.center,
                                child:
                                    SvgPicture.asset("assets/images/cross.svg"),
                              ),
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                            dashboardprovider.isHideLoading?CircularProgressIndicator():   GestureDetector(
                              onTap: () async {
                                if (usertype == "normal") {
                                  var proprovider =
                                      Provider.of<ProfileProvider>(context,
                                          listen: false);
                                  if (proprovider.swipecount < 100) {
                                    dashboardprovider.showLoaderOnReport(true);
                                    var islike =
                                        await DashboardRepository.userlike(
                                            preferences!
                                                .getString("accesstoken")!,
                                            dashboardprovider
                                                .userModelList[index].id
                                                .toString(),
                                            "1");
                                    dashboardprovider.showLoaderOnReport(false);

                                    if (islike.statusCode == 200) {
                                      if (isUserLiked) {
                                        DashboardProvider? dashboardprovider =
                                            Provider.of<DashboardProvider>(
                                                context,
                                                listen: false);
                                        dashboardprovider.removeUserFromIndex(
                                            index: index ?? 0);
                                        Get.off(DashBoardScreen(
                                          pageIndex: 1,
                                          isNotification: false,
                                        ));
                                      } else {
                                        var dashboardprovider =
                                            Provider.of<DashboardProvider>(
                                                context,
                                                listen: false);
                                        // dashboardprovider.resetStreams();
                                        if (preferences!
                                                .getString("accesstoken") !=
                                            null) {
                                          DashboardProvider? dashboardprovider =
                                              Provider.of<DashboardProvider>(
                                                  context,
                                                  listen: false);
                                          dashboardprovider.removeUserFromIndex(
                                              index: index ?? 0);
                                          Get.off(DashBoardScreen(
                                            pageIndex: 1,
                                            isNotification: false,
                                          ));
                                        }
                                      }
                                    }
                                  } else {

                                    Get.to(Premium_Screen());
                                  }
                                } else {
                                  dashboardprovider.showLoaderOnReport(true);

                                  var islike =
                                      await DashboardRepository.userlike(
                                          preferences!
                                              .getString("accesstoken")!,
                                          dashboardprovider
                                              .userModelList[index].id
                                              .toString(),
                                          "1");
                                  dashboardprovider.showLoaderOnReport(false);

                                  if (islike.statusCode == 200) {
                                    if (isUserLiked) {
                                      DashboardProvider? dashboardprovider =
                                          Provider.of<DashboardProvider>(
                                              context,
                                              listen: false);
                                      dashboardprovider.userModelList
                                          .removeAt(index);
                                      Get.off(DashBoardScreen(
                                        pageIndex: 1,
                                        isNotification: false,
                                      ));
                                    } else {
                                      DashboardProvider? dashboardprovider =
                                          Provider.of<DashboardProvider>(
                                              context,
                                              listen: false);
                                      dashboardprovider.userModelList
                                          .removeAt(index ?? 0);
                                      Get.off(DashBoardScreen(
                                        pageIndex: 1,
                                        isNotification: false,
                                      ));
                                    }
                                  }
                                }
                              },
                              child: Column(
                                children: [
                                  Container(
                                    height: 80.h,
                                    width: 80.w,
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: <Color>[
                                            Color(0xFFA33BE5),
                                            Color(0xFF570084),
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(15.r)),
                                    alignment: Alignment.center,
                                    child:
                                        SvgPicture.asset("assets/images/slike.svg"),
                                  ),
                                SizedBox(height: 10.h,),
                                addMediumText(AppLocalizations.of(context)!.hidereport, 15, Color(0xFF15294B)),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                            dashboardprovider.isLikeLoading
                                ? CircularProgressIndicator()
                                : GestureDetector(
                                    onTap: () async {
                                      print("usertype");
                                      print(usertype);
                                      if (usertype == "normal") {
                                        var proprovider =
                                            Provider.of<ProfileProvider>(
                                                context,
                                                listen: false);
                                        if (proprovider.swipecount < 100) {
                                          dashboardprovider.showLoaderOnLike(true);

                                          var islike = await DashboardRepository
                                              .userlike(
                                                  preferences!.getString(
                                                      "accesstoken")!,
                                                  dashboardprovider
                                                      .userModelList[index].id
                                                      .toString(),
                                                  "0");
                                          print("islike.statusCode");
                                          print(isUserLiked);
                                          dashboardprovider.showLoaderOnLike(false);

                                          if (islike.statusCode == 200) {
                                            if (isUserLiked) {
                                              // if (preferences!.getString("accesstoken") != null) {
                                              //   var profileprovider = Provider.of<
                                              //           ProfileProvider>(
                                              //       context,
                                              //       listen:
                                              //           false);
                                              //   var mongonomystart = await DashboardRepository.monogonomystart(
                                              //       preferences!.getString(
                                              //           "accesstoken")!,
                                              //       widget
                                              //           .user_id,
                                              //       "0");
                                              //   if (mongonomystart
                                              //           .statusCode ==
                                              //       200) {
                                              //     print(
                                              //         "aHJDGjhadgjaD");
                                              //     profileprovider
                                              //         .resetStreams();
                                              //     profileprovider
                                              //         .adddetails(
                                              //             mongonomystart);
                                              //     print(
                                              //         "mongonomystart.data!.active_monogamy");
                                              //     print(mongonomystart
                                              //         .data!
                                              //         .active_monogamy);
                                              //
                                              //     Get.off(
                                              //         DashBoardScreen());
                                              //   } else {
                                              //     print(
                                              //         "aHJDGjhadgjaD===else");
                                              //   }
                                              //
                                              //   Navigator.pop(
                                              //       context);
                                              // }
                                              DashboardProvider?
                                                  dashboardprovider = Provider
                                                      .of<DashboardProvider>(
                                                          context,
                                                          listen: false);
                                              dashboardprovider
                                                  .removeUserFromIndex(
                                                      index: index ?? 0);
                                              Get.off(DashBoardScreen(
                                                pageIndex: 1,
                                                isNotification: false,
                                              ));
                                            } else {
                                              DashboardProvider?
                                                  dashboardprovider = Provider
                                                      .of<DashboardProvider>(
                                                          context,
                                                          listen: false);
                                              dashboardprovider
                                                  .removeUserFromIndex(
                                                      index: index ?? 0);

                                              // Get.off(
                                              //     DashBoardScreen(pageIndex: 1,isNotification: false,));
                                              Get.off(DashBoardScreen(
                                                pageIndex: 1,
                                                isNotification: false,
                                              ));
                                              // var dashboardprovider = Provider.of<DashboardProvider>(context, listen: false);
                                              // dashboardprovider.resetStreams();
                                              // if (preferences!.getString("accesstoken") != null) {
                                              //   dashboardprovider.fetchUserList(
                                              //       preferences!.getString("accesstoken").toString(),
                                              //       1,
                                              //       20,
                                              //       widget.startag,
                                              //       widget.endag,
                                              //       widget.datewith,
                                              //       widget.isPremium,
                                              //       widget.type,
                                              //       widget.search,
                                              //       widget.maritals,
                                              //       widget.looking_fors,
                                              //       widget.sexual_orientation,
                                              //       widget.startheigh,
                                              //       widget.endheigh,
                                              //       widget.do_you_drink,
                                              //       widget.do_you_smoke,
                                              //       widget.feel_about_kids,
                                              //       widget.education,
                                              //       widget.introvert_or_extrovert,
                                              //       widget.star_sign,
                                              //       widget.have_pets,
                                              //       widget.religion,
                                              //       widget.languageList.toString().replaceAll("[", "").replaceAll("]", ""),
                                              //       widget.refresh);
                                              //   dashboardprovider
                                              //       .addUser();
                                              //   Navigator.pop(
                                              //       context);
                                              // }
                                            }
                                          } else {
                                            showSnakbar(
                                                "${islike.message}", context);
                                            Navigator.pop(context);
                                          }
                                        } else {
                                          Navigator.pop(context);
                                          Get.to(Premium_Screen());
                                        }
                                      } else {
                                        dashboardprovider.showLoaderOnLike(true);

                                        var islike =
                                            await DashboardRepository.userlike(
                                                preferences!
                                                    .getString("accesstoken")!,
                                                dashboardprovider
                                                    .userModelList[index].id
                                                    .toString(),
                                                "0");
                                        print(islike);
                                        dashboardprovider.showLoaderOnLike(false);

                                        if (islike.statusCode == 200) {
                                          if (isUserLiked) {
                                            DashboardProvider?
                                                dashboardprovider =
                                                Provider.of<DashboardProvider>(
                                                    context,
                                                    listen: false);
                                            dashboardprovider
                                                .removeUserFromIndex(
                                                    index: index ?? 0);
                                            // if (preferences!.getString("accesstoken") != null) {
                                            //   var profileprovider = Provider.of<
                                            //           ProfileProvider>(
                                            //       context,
                                            //       listen:
                                            //           false);
                                            //   var mongonomystart = await DashboardRepository.monogonomystart(
                                            //       preferences!
                                            //           .getString(
                                            //               "accesstoken")!,
                                            //       widget
                                            //           .user_id,
                                            //       "0");
                                            //   if (mongonomystart
                                            //           .statusCode ==
                                            //       200) {
                                            //     print(
                                            //         "aHJDGjhadgjaD");
                                            //     profileprovider
                                            //         .resetStreams();
                                            //     profileprovider
                                            //         .adddetails(
                                            //             mongonomystart);
                                            //     print(
                                            //         "mongonomystart.data!.active_monogamy");
                                            //     print(mongonomystart
                                            //         .data!
                                            //         .active_monogamy);
                                            //
                                            //     Get.off(
                                            //         DashBoardScreen());
                                            //   } else {
                                            //     print(
                                            //         "aHJDGjhadgjaD===else");
                                            //   }
                                            //
                                            //   Navigator.pop(
                                            //       context);
                                            // }
                                            Navigator.pop(context);

                                            // Get.off(
                                            //     DashBoardScreen(pageIndex: 1,isNotification: false,));
                                          } else {
                                            DashboardProvider?
                                                dashboardprovider =
                                                Provider.of<DashboardProvider>(
                                                    context,
                                                    listen: false);
                                            dashboardprovider
                                                .removeUserFromIndex(
                                                    index: index ?? 0);
                                            // var dashboardprovider =
                                            //     Provider.of<
                                            //             DashboardProvider>(
                                            //         context,
                                            //         listen:
                                            //             false);
                                            // dashboardprovider
                                            //     .resetStreams();
                                            // if (preferences!
                                            //         .getString(
                                            //             "accesstoken") !=
                                            //     null) {
                                            //   print(
                                            //       "sdgfahs");
                                            //   print(preferences!
                                            //       .getString(
                                            //           "accesstoken"));
                                            //   dashboardprovider.fetchUserList(
                                            //       preferences!.getString("accesstoken").toString(),
                                            //       1,
                                            //       20,
                                            //       widget.startag,
                                            //       widget.endag,
                                            //       widget.datewith,
                                            //       widget.isPremium,
                                            //       widget.type,
                                            //       widget.search,
                                            //       widget.maritals,
                                            //       widget.looking_fors,
                                            //       widget.sexual_orientation,
                                            //       widget.startheigh,
                                            //       widget.endheigh,
                                            //       widget.do_you_drink,
                                            //       widget.do_you_smoke,
                                            //       widget.feel_about_kids,
                                            //       widget.education,
                                            //       widget.introvert_or_extrovert,
                                            //       widget.star_sign,
                                            //       widget.have_pets,
                                            //       widget.religion,
                                            //       widget.languageList.toString().replaceAll("[", "").replaceAll("]", ""),
                                            //       widget.refresh);
                                            //   dashboardprovider
                                            //       .addUser();
                                            Navigator.pop(context);
                                          }
                                        } else {
                                          Navigator.pop(context);
                                        }
                                      }
                                    },
                                    child: Container(
                                      height: 60.h,
                                      width: 60.w,
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: <Color>[
                                              Color(0xFFA33BE5),
                                              Color(0xFF570084),
                                            ],
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(15.r)),
                                      alignment: Alignment.center,
                                      child: SvgPicture.asset(
                                          "assets/images/heart.svg"),
                                    ),
                                  ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> GetAddressFromLatLong(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    city = '${place.locality}';
    state = '${place.administrativeArea}';
    country = '${place.country}';
    setState(() {});
  }

  ProfileProvider? profileprovider;
  Init() async {
    preferences = await SharedPreferences.getInstance();
    var dashboardprovider =
        Provider.of<DashboardProvider>(context, listen: false);
    dashboardprovider = Provider.of<DashboardProvider>(context, listen: false);
    dashboardprovider.resetStreams();
    dashboardprovider.resetFilter();
    Position position = await _getGeoLocationPosition();

    latitude = position.latitude.toString();
    longitude = position.longitude.toString();
    String? locallang = Platform.localeName;
    List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude, position.longitude,
        localeIdentifier: locallang);
    print(placemarks);
    Placemark place = placemarks[0];

    setState(() {
      city = '${place.locality}';
      state = '${place.administrativeArea}';
      country = '${place.country}';
    });

    if (preferences!.getString("accesstoken") != null) {
      if (latitude.toString() == null ||
          latitude.toString() == "null" ||
          latitude == "") {
        latitude = "";
        longitude = "";
        var model = await ProfileRepository.updateLocation(
            latitude,
            longitude,
            city,
            state,
            country,
            preferences!.getString("accesstoken").toString());
        if (model.statusCode == 200) {
        } else if (model.statusCode == 422) {
          showSnakbar(model.message!, context);
        } else {
          showSnakbar(model.message!, context);
        }
      } else {
        var model = await ProfileRepository.updateLocation(
            latitude,
            longitude,
            city,
            state,
            country,
            preferences!.getString("accesstoken").toString());
        if (model.statusCode == 200) {
        } else if (model.statusCode == 422) {
          showSnakbar(model.message!, context);
        } else {
          showSnakbar(model.message!, context);
        }
      }
    }

    profileprovider = Provider.of<ProfileProvider>(context, listen: false);
    profileprovider?.resetStreams();
    profileprovider
        ?.fetchProfileDetails(preferences!.getString("accesstoken").toString());

    dashboardprovider
        .fetchFilterList(preferences!.getString("accesstoken").toString());

    setState(() {
      if (profileprovider?.start_tall_are_you != "") {
        _heightvalues = SfRangeValues(
            double.parse(profileprovider?.start_tall_are_you ?? "0.0"), 150.0);
        startheight =
            double.parse(profileprovider?.start_tall_are_you ?? "0.0");
        startheigh = (profileprovider?.start_tall_are_you ?? "0");
      }
      if (profileprovider?.end_tall_are_you != "") {
        _heightvalues = SfRangeValues(
            130.0, double.parse(profileprovider?.end_tall_are_you ?? ""));
        endheight = double.parse(profileprovider?.end_tall_are_you ?? "");
        endheigh = profileprovider?.end_tall_are_you ?? "";
      }

      if (profileprovider?.end_tall_are_you != "" &&
          profileprovider?.start_tall_are_you != "") {
        _heightvalues = SfRangeValues(
            double.parse(profileprovider?.start_tall_are_you ?? ""),
            double.parse(profileprovider?.end_tall_are_you ?? ""));
        endheight = double.parse(profileprovider?.end_tall_are_you ?? "");
        startheight = double.parse(profileprovider?.start_tall_are_you ?? "");
        startheigh = profileprovider?.start_tall_are_you ?? "";
        endheigh = profileprovider?.end_tall_are_you ?? "";
      }

      if (profileprovider?.age_from != "") {
        _values =
            SfRangeValues(double.parse(profileprovider?.age_from ?? ""), 30.0);
        startage = double.parse(profileprovider?.age_from ?? "");
        startag = profileprovider?.age_from ?? "";
      }
      if (profileprovider?.age_to != "") {
        _values =
            SfRangeValues(130.0, double.parse(profileprovider?.age_to ?? ""));
        endage = double.parse(profileprovider?.age_to ?? "");
        endag = profileprovider?.age_to ?? "";
      }

      if (profileprovider?.age_from != "" && profileprovider?.age_to != "") {
        _values = SfRangeValues(double.parse(profileprovider?.age_from ?? ""),
            double.parse(profileprovider?.age_to ?? ""));
        startage = double.parse(profileprovider?.age_from ?? "");
        startag = profileprovider?.age_from ?? "";
        endage = double.parse(profileprovider?.age_to ?? "");
        endag = profileprovider?.age_to ?? "";
      }

      datewith = profileprovider?.datewith ?? "";
      isPremium = profileprovider?.only_premium_member ?? "";
      if (profileprovider?.only_premium_member == "0") {
        _switchValue = false;
      } else if (profileprovider?.only_premium_member == "1") {
        _switchValue = true;
      } else {
        _switchValue = false;
      }
      if (datewith == "0") {
        ismen = true;
      } else if (datewith == "1") {
        iswomen = true;
      } else if (datewith == "2") {
        both = true;
      } else {
        ismen = false;
        iswomen = false;
        both = false;
      }
      maritals = profileprovider?.maritals ?? "";

      looking_fors = profileprovider?.looking_fors ?? "";
      sexual_orientation = profileprovider?.sexual_orientation ?? "";
      do_you_drink = profileprovider?.do_you_drink ?? "";
      do_you_smoke = profileprovider?.do_you_smoke ?? "";
      feel_about_kids = profileprovider?.feel_about_kids ?? "";
      education = profileprovider?.educationfilter ?? "";
      introvert_or_extrovert = profileprovider?.introvert_or_extrovert ?? "";
      star_sign = profileprovider?.star_sign ?? "";
      have_pets = profileprovider?.have_pets ?? "";
      religion = profileprovider?.religionfilter ?? "";
      languageList = profileprovider?.languages ?? "";
      usertype = profileprovider?.user_type ?? "";
      directchatcount = profileprovider?.direct_chat_count ?? 0;
      profileimage = profileprovider?.profileImage ?? "";
    });
    if (preferences!.getString("name") != null) {
      setState(() {
        username = preferences!.getString("name")!;
      });
    }
    if (preferences!.getString("usertype") != null) {
      setState(() {
        usertype = preferences!.getString("usertype")!.toString();
      });
    }
    if (preferences!.getString("accesstoken") != null) {
      Future.delayed(const Duration(seconds: 1), () {
        dashboardprovider.clearCurrentCard();

        cardDeck = [];
        dashboardprovider
            .fetchUserList(
                preferences!.getString("accesstoken").toString(),
                1,
                20,
                startag,
                endag,
                datewith,
                isPremium,
                type,
                search,
                maritals,
                looking_fors,
                sexual_orientation,
                startheigh,
                endheigh,
                do_you_drink,
                do_you_smoke,
                feel_about_kids,
                education,
                introvert_or_extrovert,
                star_sign,
                have_pets,
                religion,
                languageList.toString().replaceAll("[", "").replaceAll("]", ""),
                refresh)
            .whenComplete(() {
          swipeItemInit(dashboardprovider);
          setState(() {});
        });
      });
    }
    createAccountWithEmail(preferences!.getString("email") ?? "", "12345678");
  }

  Future<String?> createAccountWithEmail(String email, String password) async {
    String errorMessage;
    User? user;
    FirebaseFirestore firebasStorage = FirebaseFirestore.instance;
    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      user = userCredential.user;
      if (user!.uid.isNotEmpty) {
      firebasStorage.collection('users').doc(user.uid).set(
            {'nickname': email, 'photoUrl': user.photoURL, 'id': user.uid,"isTyping":false});

        return 'Success';
      }
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case "EMAIL_ALREADY_IN_USE":
        case "email-already-in-use":
          errorMessage = "Email already used. Go to login page.";
          break;
        default:
          errorMessage = "Login failed. Please try again.";
          break;
      }

      return errorMessage;
    }

    return null;
  }

  DeckEmptyInit() async {
    print("asdasdasd sdasdasdasd");
    preferences = await SharedPreferences.getInstance();
    var dashboardprovider =
        Provider.of<DashboardProvider>(context, listen: false);
    dashboardprovider.resetStreams();
    var profileprovider = Provider.of<ProfileProvider>(context, listen: false);
    setState(() {
      usertype = profileprovider.user_type ?? "";
      directchatcount = profileprovider.direct_chat_count ?? 0;
      profileimage = profileprovider.profileImage ?? "";
    });
    if (preferences!.getString("name") != null) {
      setState(() {
        username = preferences!.getString("name")!;
      });
    }
    if (preferences!.getString("usertype") != null) {
      setState(() {
        usertype = preferences!.getString("usertype")!.toString();
      });
    }
    if (preferences!.getString("accesstoken") != null) {
      dashboardprovider.clearCurrentCard();
      cardDeck = [];
      dashboardprovider
          .fetchUserList(
              preferences!.getString("accesstoken").toString(),
              1,
              20,
              startag,
              endag,
              datewith,
              isPremium,
              type,
              search,
              maritals,
              looking_fors,
              sexual_orientation,
              startheigh,
              endheigh,
              do_you_drink,
              do_you_smoke,
              feel_about_kids,
              education,
              introvert_or_extrovert,
              star_sign,
              have_pets,
              religion,
              languageList.toString().replaceAll("[", "").replaceAll("]", ""),
              refresh)
          .whenComplete(() {
        cardDeck = [];
        dashboardprovider.clearCurrentCard();
        swipeItemInit(dashboardprovider);
      });
      // profileprovider?.fetchProfileDetails(
      //     preferences!.getString("accesstoken").toString());
    }
  }

  Future<void> filterbottemsheet(
      BuildContext context, ProfileProvider profileProvider) async {
    await showModalBottomSheet<dynamic>(
        context: context,
        useRootNavigator: true,
        isScrollControlled: true,
        builder: (context) => SafeArea(
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(top: 50.h),
                  decoration: BoxDecoration(
                    color: Color(0xfff2f3f4),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.r),
                        topRight: Radius.circular(30.r)),
                  ),
                  child: StatefulBuilder(
                      builder: (BuildContext context, StateSetter stateSetter) {
                    return SingleChildScrollView(
                      child: GestureDetector(
                        onTap: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                color: Colors.transparent,
                                width: MediaQuery.of(context).size.width,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 25.w, vertical: 15.h),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        child: SvgPicture.asset(
                                          "assets/images/cross.svg",
                                          color: Color(0xFF000100),
                                          height: 20.h,
                                          width: 20.w,
                                        ),
                                        onTap: () async {
                                          if (searchController
                                              .text.isNotEmpty) {
                                            var dashboardProvider =
                                                Provider.of<DashboardProvider>(
                                                    context,
                                                    listen: false);
                                            dashboardProvider.noUserdata =
                                                false;
                                            dashboardProvider.resetStreams();
                                            if (preferences!
                                                    .getString("accesstoken") !=
                                                null) {

                                              int page = 1;
                                              int limit = 20;
                                              dashboardProvider
                                                  .fetchSearcUserList(
                                                      preferences!
                                                          .getString(
                                                              "accesstoken")
                                                          .toString(),
                                                      searchController.text,
                                                      page,
                                                      limit);
                                              dashboardProvider.addUser();
                                            }
                                          }
                                          else {
                                            var dashboardProvider =
                                                Provider.of<DashboardProvider>(
                                                    context,
                                                    listen: false);
                                            dashboardProvider.noUserdata =
                                                false;
                                            dashboardProvider.resetStreams();
                                            if (preferences!
                                                    .getString("accesstoken") !=
                                                null) {
                                              dashboardProvider
                                                  .clearCurrentCard();
                                              cardDeck = [];
                                              dashboardProvider
                                                  .fetchUserList(
                                                      preferences!
                                                          .getString(
                                                              "accesstoken")
                                                          .toString(),
                                                      1,
                                                      20,
                                                      startag,
                                                      endag,
                                                      datewith,
                                                      isPremium,
                                                      type,
                                                      search,
                                                      maritals,
                                                      looking_fors,
                                                      sexual_orientation,
                                                      startheigh,
                                                      endheigh,
                                                      do_you_drink,
                                                      do_you_smoke,
                                                      feel_about_kids,
                                                      education,
                                                      introvert_or_extrovert,
                                                      star_sign,
                                                      have_pets,
                                                      religion,
                                                      languageList
                                                          .toString()
                                                          .replaceAll("[", "")
                                                          .replaceAll("]", ""),
                                                      "0")
                                                  .whenComplete(() {
                                                swipeItemInit(
                                                    dashboardProvider);
                                              });
                                              dashboardProvider.addUser();
                                            }
                                          }
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      Container(
                                          alignment: Alignment.topCenter,
                                          child: addMediumText(
                                              AppLocalizations.of(context)!
                                                  .filters,
                                              22,
                                              Colorss.mainColor)),
                                      InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () {
                                            stateSetter(() {
                                              var dashboardProvider = Provider
                                                  .of<DashboardProvider>(
                                                      context,
                                                      listen: false);
                                              dashboardProvider.fetchFilterList(
                                                  preferences!
                                                      .getString("accesstoken")
                                                      .toString());
                                              dashboardProvider.filterUser();
                                              _switchValue = false;
                                              startage = 22.0;
                                              endage = 100.0;
                                              _values =
                                                  SfRangeValues(18.0, 100);
                                              startheight = 130.0;
                                              endheight = 270.0;
                                              _heightvalues =
                                                  SfRangeValues(130.0, 270);
                                              isPremium = "";
                                              datewith =
                                                  profileprovider?.datewith ??
                                                      "";
                                              ismen = false;
                                              iswomen = false;
                                              both = false;
                                              type = "all";
                                              startag = "";
                                              endag = "";
                                              isPremium = "";
                                              type = "";
                                              search = "";
                                              maritals = "";
                                              looking_fors = "";
                                              sexual_orientation = "";
                                              startheigh = "";
                                              endheigh = "";
                                              do_you_drink = "";
                                              do_you_smoke = "";
                                              feel_about_kids = "";
                                              education = "";
                                              introvert_or_extrovert = "";
                                              star_sign = "";
                                              have_pets = "";
                                              religion = "";
                                              languageList = "";
                                              searchController.clear();
                                              dashboardProvider.noUserdata =
                                                  false;
                                              dashboardProvider.resetStreams();
                                              if (preferences!.getString(
                                                      "accesstoken") !=
                                                  null) {
                                                dashboardProvider
                                                    .clearCurrentCard();
                                                cardDeck = [];
                                                dashboardProvider
                                                    .fetchUserList(
                                                        preferences!
                                                            .getString(
                                                                "accesstoken")
                                                            .toString(),
                                                        1,
                                                        20,
                                                        startag,
                                                        endag,
                                                        datewith,
                                                        isPremium,
                                                        type,
                                                        search,
                                                        maritals,
                                                        looking_fors,
                                                        sexual_orientation,
                                                        startheigh,
                                                        endheigh,
                                                        do_you_drink,
                                                        do_you_smoke,
                                                        feel_about_kids,
                                                        education,
                                                        introvert_or_extrovert,
                                                        star_sign,
                                                        have_pets,
                                                        religion,
                                                        languageList
                                                            .toString()
                                                            .replaceAll("[", "")
                                                            .replaceAll(
                                                                "]", ""),
                                                        "0")
                                                    .whenComplete(() {
                                                  swipeItemInit(
                                                      dashboardProvider);
                                                });
                                                dashboardProvider.addUser();
                                              }
                                              Navigator.of(context).pop();
                                            });
                                          },
                                          child: addLightText(
                                              AppLocalizations.of(context)!
                                                  .clear,
                                              14,
                                              Colorss.mainColor)),
                                    ],
                                  ),
                                ),
                              ),
                              Divider(
                                thickness: 0.7.h,
                                color: Color(0xFF707070),
                                height: 1.h,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 25.w, vertical: 25.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    addSemiBoldText(
                                        AppLocalizations.of(context)!.basic,
                                        18,
                                        Colorss.mainColor),
                                    Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.r)),
                                      child: Padding(
                                        padding: EdgeInsets.all(20.0.r),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            TextField(
                                              controller: searchController,
                                              onChanged: (value) {},
                                              keyboardType: TextInputType.phone,
                                              decoration: InputDecoration(
                                                  hintText: AppLocalizations.of(
                                                          context)!
                                                      .searchbyuserid,
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        width: 1,
                                                        color:
                                                            Colorss.mainColor),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.0),
                                                  ),
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          vertical: 15.0,
                                                          horizontal: 10),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        width: 1,
                                                        color:
                                                            Colorss.mainColor),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.0),
                                                  )),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.60,
                                                    child: addMediumText(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .showonlypremium,
                                                        14,
                                                        Colorss.mainColor)),
                                                CupertinoSwitch(
                                                  trackColor: Color(0xFFf1f1f1),
                                                  activeColor:
                                                      Color(0xFFAB60ED),
                                                  value: _switchValue,
                                                  onChanged: (value) {
                                                    stateSetter(() {
                                                      _switchValue =
                                                          !_switchValue;
                                                      if (_switchValue) {
                                                        isPremium = "1";
                                                      } else {
                                                        isPremium = "0";
                                                      }
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 15.h,
                                            ),
                                            Divider(
                                              thickness: 0.7.h,
                                              color: Color(0xFF707070),
                                              height: 1.h,
                                            ),
                                            SizedBox(
                                              height: 15.h,
                                            ),
                                            addSemiBoldText(
                                                AppLocalizations.of(context)!
                                                    .datewith,
                                                14,
                                                Colorss.mainColor),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            Wrap(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    stateSetter(() {
                                                      ismen = true;
                                                      iswomen = false;
                                                      both = false;
                                                      datewith = "0";
                                                    });
                                                  },
                                                  child: ismen
                                                      ? Container(
                                                          height: 40.h,
                                                          margin:
                                                              EdgeInsets.all(2),
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      10,
                                                                  vertical: 5),
                                                          decoration: BoxDecoration(
                                                              color: Colorss
                                                                  .mainColor,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30.r)),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              SvgPicture.asset(
                                                                "assets/images/mal.svg",
                                                                height: 20.h,
                                                                width: 20.w,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                              SizedBox(
                                                                width: 8.w,
                                                              ),
                                                              addMediumElipsText(
                                                                  AppLocalizations.of(
                                                                          context)!
                                                                      .man,
                                                                  12,
                                                                  Colors.white),
                                                            ],
                                                          ),
                                                        )
                                                      : Container(
                                                          height: 40.h,
                                                          margin:
                                                              EdgeInsets.all(2),
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      10,
                                                                  vertical: 5),
                                                          decoration: BoxDecoration(
                                                              color: Color(
                                                                  0xFFF2E7FA),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30.r)),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              SvgPicture.asset(
                                                                "assets/images/mal.svg",
                                                                height: 20.h,
                                                                width: 20.w,
                                                              ),
                                                              SizedBox(
                                                                width: 8.w,
                                                              ),
                                                              addMediumElipsText(
                                                                  AppLocalizations.of(
                                                                          context)!
                                                                      .man,
                                                                  12,
                                                                  Colorss
                                                                      .mainColor),
                                                            ],
                                                          ),
                                                        ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    stateSetter(() {
                                                      ismen = false;
                                                      iswomen = true;
                                                      both = false;
                                                      datewith = "1";
                                                    });
                                                  },
                                                  child: iswomen
                                                      ? Container(
                                                          height: 40.h,
                                                          margin:
                                                              EdgeInsets.all(2),
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      10,
                                                                  vertical: 5),
                                                          decoration: BoxDecoration(
                                                              color: Colorss
                                                                  .mainColor,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30.r)),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              SvgPicture.asset(
                                                                "assets/images/femal.svg",
                                                                height: 20.h,
                                                                width: 20.w,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                              SizedBox(
                                                                width: 8.w,
                                                              ),
                                                              addMediumElipsText(
                                                                  AppLocalizations.of(
                                                                          context)!
                                                                      .woman,
                                                                  12,
                                                                  Colors.white),
                                                            ],
                                                          ),
                                                        )
                                                      : Container(
                                                          height: 40.h,
                                                          margin:
                                                              EdgeInsets.all(2),
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      10,
                                                                  vertical: 5),
                                                          decoration: BoxDecoration(
                                                              color: Color(
                                                                  0xFFF2E7FA),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30.r)),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              SvgPicture.asset(
                                                                "assets/images/femal.svg",
                                                                height: 20.h,
                                                                width: 20.w,
                                                              ),
                                                              SizedBox(
                                                                width: 8.w,
                                                              ),
                                                              addMediumElipsText(
                                                                  AppLocalizations.of(
                                                                          context)!
                                                                      .woman,
                                                                  12,
                                                                  Colorss
                                                                      .mainColor),
                                                            ],
                                                          ),
                                                        ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    stateSetter(() {
                                                      ismen = false;
                                                      iswomen = false;
                                                      both = true;
                                                      datewith = "2";
                                                    });
                                                  },
                                                  child: both
                                                      ? Container(
                                                          height: 40.h,
                                                          margin:
                                                              EdgeInsets.all(2),
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      10,
                                                                  vertical: 5),
                                                          decoration: BoxDecoration(
                                                              color: Colorss
                                                                  .mainColor,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30.r)),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              SvgPicture.asset(
                                                                "assets/images/both.svg",
                                                                height: 20.h,
                                                                width: 20.w,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                              SizedBox(
                                                                width: 8.w,
                                                              ),
                                                              addMediumElipsText(
                                                                  AppLocalizations.of(
                                                                          context)!
                                                                      .both,
                                                                  12,
                                                                  Colors.white),
                                                            ],
                                                          ),
                                                        )
                                                      : Container(
                                                          height: 40.h,
                                                          margin:
                                                              EdgeInsets.all(2),
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      10,
                                                                  vertical: 5),
                                                          decoration: BoxDecoration(
                                                              color: Color(
                                                                  0xFFF2E7FA),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30.r)),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              SvgPicture.asset(
                                                                "assets/images/both.svg",
                                                                height: 20.h,
                                                                width: 20.w,
                                                              ),
                                                              SizedBox(
                                                                width: 8.w,
                                                              ),
                                                              addMediumElipsText(
                                                                  AppLocalizations.of(
                                                                          context)!
                                                                      .both,
                                                                  12,
                                                                  Colorss
                                                                      .mainColor),
                                                            ],
                                                          ),
                                                        ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 15.h,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                addSemiBoldText(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .age,
                                                    15,
                                                    Colorss.mainColor),
                                                addMediumText(
                                                    "${startage.toStringAsFixed(0)}-${endage.toStringAsFixed(0)}",
                                                    14,
                                                    Colorss.mainColor),
                                              ],
                                            ),
                                            SfRangeSlider(
                                              min: 18,
                                              max: 100,
                                              values: _values,
                                              interval: 1.0,
                                              showTicks: false,
                                              showLabels: false,
                                              stepSize: 1.0,
                                              minorTicksPerInterval: 1,
                                              onChanged:
                                                  (SfRangeValues values) {
                                                stateSetter(() {
                                                  _values = values;
                                                  startage = values.start;
                                                  endage = values.end;
                                                  startag = startage
                                                      .toStringAsFixed(0);
                                                  endag =
                                                      endage.toStringAsFixed(0);
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 25.h,
                                    ),
                                    (profileprovider?.user_type.toString() ==
                                                "normal" ||
                                            profileprovider?.user_type
                                                    .toString() ==
                                                "basic")
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  addSemiBoldText(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .advanced,
                                                      18,
                                                      Colorss.mainColor),
                                                  SizedBox(
                                                    height: 5.h,
                                                  ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.50,
                                                    child: addRegularText(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .getabetterresult,
                                                        10,
                                                        Colorss.mainColor),
                                                  )
                                                ],
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  Get.to(Premium_Screen());
                                                },
                                                child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.r),
                                                        border: Border.all(
                                                            color: Colorss
                                                                .mainColor,
                                                            width: 1.0.h)),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 10.h,
                                                            horizontal: 15.w),
                                                    child: addMediumText(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .activate,
                                                        16,
                                                        Colorss.mainColor)),
                                              )
                                            ],
                                          )
                                        : Container(),
                                    SizedBox(
                                      height: 25.h,
                                    ),
                                    Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.r)),
                                      child: Padding(
                                        padding: EdgeInsets.all(20.0.r),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 5.h,
                                            ),
                                            profileprovider?.profiledetails
                                                        ?.data?.user_plan
                                                        .toString() ==
                                                    "premium"
                                                ? Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .height,
                                                            style: TextStyle(
                                                                color: Colorss
                                                                    .mainColor,
                                                                fontSize: 20.sp,
                                                                fontFamily:
                                                                    "Avenir Black",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                          Text(
                                                            '${startheight.toStringAsFixed(0)}-${endheight.toStringAsFixed(0)}cm',
                                                            style: TextStyle(
                                                                color: Colorss
                                                                    .mainColor,
                                                                fontSize: 20.sp,
                                                                fontFamily:
                                                                    "Avenir Black",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                        ],
                                                      ),
                                                      SfRangeSlider(
                                                        min: 130.0,
                                                        max: 270.0,
                                                        values: _heightvalues,
                                                        interval: 1.0,
                                                        showTicks: false,
                                                        showLabels: false,
                                                        stepSize: 1.0,
                                                        minorTicksPerInterval:
                                                            1,
                                                        onChanged:
                                                            (SfRangeValues
                                                                values) {
                                                          stateSetter(() {
                                                            _heightvalues =
                                                                values;
                                                            startheight =
                                                                values.start;
                                                            endheight =
                                                                values.end;

                                                            startheigh = startheight
                                                                .toStringAsFixed(
                                                                    0);
                                                            endheigh = endheight
                                                                .toStringAsFixed(
                                                                    0);
                                                          });
                                                        },
                                                      ),
                                                      Consumer<
                                                              DashboardProvider>(
                                                          builder: (context,
                                                                  dashboardprovider,
                                                                  child) =>
                                                              dashboardprovider
                                                                          .filterListModel !=
                                                                      null
                                                                  ? Container(
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          dashboardprovider.filterListModel!.feelAboutKids!.isNotEmpty
                                                                              ? Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  mainAxisSize: MainAxisSize.min,
                                                                                  children: [
                                                                                    Text(
                                                                                      AppLocalizations.of(context)!.kid,
                                                                                      style: TextStyle(color: Colorss.mainColor, fontSize: 20.sp, fontFamily: "Avenir Black", fontWeight: FontWeight.w500),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 10.h,
                                                                                    ),
                                                                                    Wrap(
                                                                                      children: List.generate(dashboardprovider.filterListModel!.feelAboutKids!.length, (index) {
                                                                                        for (int i = 0; i < dashboardprovider.filterListModel!.feelAboutKids!.length; i++) {
                                                                                          if (dashboardprovider.filterListModel!.feelAboutKids!.elementAt(index).id.toString() == feel_about_kids) {
                                                                                            dashboardprovider.filterListModel!.feelAboutKids!.elementAt(index).isSelected = true;
                                                                                            feel_about_kids = dashboardprovider.filterListModel!.feelAboutKids!.elementAt(index).id!.toString();
                                                                                          }
                                                                                        }
                                                                                        return GestureDetector(
                                                                                          onTap: () {
                                                                                            stateSetter(() {
                                                                                              for (int i = 0; i < dashboardprovider.filterListModel!.feelAboutKids!.length; i++) {
                                                                                                if (dashboardprovider.filterListModel!.feelAboutKids!.elementAt(i).isSelected == true) {
                                                                                                  dashboardprovider.filterListModel!.feelAboutKids!.elementAt(i).isSelected = false;
                                                                                                }
                                                                                                feel_about_kids = dashboardprovider.filterListModel!.feelAboutKids!.elementAt(index).id.toString();
                                                                                                dashboardprovider.filterListModel!.feelAboutKids!.elementAt(index).isSelected = true;
                                                                                              }
                                                                                            });
                                                                                          },
                                                                                          child: !dashboardprovider.filterListModel!.feelAboutKids!.elementAt(index).isSelected!
                                                                                              ? Container(
                                                                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r), border: Border.all(color: Colorss.mainColor, width: 1.0.h)),
                                                                                                  padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                                                                                                  margin: EdgeInsets.all(3),
                                                                                                  child: Text(
                                                                                                    dashboardprovider.filterListModel!.feelAboutKids!.elementAt(index).name,
                                                                                                    style: TextStyle(color: Colorss.mainColor, fontSize: 20.sp, fontFamily: "Avenir Heavy", fontWeight: FontWeight.w500),
                                                                                                  ),
                                                                                                )
                                                                                              : Container(
                                                                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r), color: Colorss.mainColor),
                                                                                                  padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                                                                                                  margin: EdgeInsets.all(3),
                                                                                                  child: Text(
                                                                                                    dashboardprovider.filterListModel!.feelAboutKids!.elementAt(index).name,
                                                                                                    style: TextStyle(color: Colors.white, fontSize: 20.sp, fontFamily: "Avenir Heavy", fontWeight: FontWeight.w500),
                                                                                                  ),
                                                                                                ),
                                                                                        );
                                                                                      }),
                                                                                    ),
                                                                                  ],
                                                                                )
                                                                              : Container(),
                                                                          SizedBox(
                                                                            height:
                                                                                20.h,
                                                                          ),
                                                                          dashboardprovider.filterListModel!.smokeOptions!.isNotEmpty
                                                                              ? Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  mainAxisSize: MainAxisSize.min,
                                                                                  children: [
                                                                                    Text(
                                                                                      AppLocalizations.of(context)!.smoke,
                                                                                      style: TextStyle(color: Colorss.mainColor, fontSize: 20.sp, fontFamily: "Avenir Black", fontWeight: FontWeight.w500),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 10.h,
                                                                                    ),
                                                                                    Wrap(
                                                                                      children: List.generate(dashboardprovider.filterListModel!.smokeOptions!.length, (index) {
                                                                                        for (int i = 0; i < dashboardprovider.filterListModel!.smokeOptions!.length; i++) {
                                                                                          if (dashboardprovider.filterListModel!.smokeOptions!.elementAt(index).id.toString() == do_you_smoke) {
                                                                                            dashboardprovider.filterListModel!.smokeOptions!.elementAt(index).isSelected = true;
                                                                                            do_you_smoke = dashboardprovider.filterListModel!.smokeOptions!.elementAt(index).id!.toString();
                                                                                          }
                                                                                        }
                                                                                        return GestureDetector(
                                                                                          onTap: () {
                                                                                            stateSetter(() {
                                                                                              for (int i = 0; i < dashboardprovider.filterListModel!.smokeOptions!.length; i++) {
                                                                                                if (dashboardprovider.filterListModel!.smokeOptions!.elementAt(i).isSelected == true) {
                                                                                                  dashboardprovider.filterListModel!.smokeOptions!.elementAt(i).isSelected = false;
                                                                                                }
                                                                                                do_you_smoke = dashboardprovider.filterListModel!.smokeOptions!.elementAt(index).id.toString();
                                                                                                print(do_you_smoke);
                                                                                                preferences!.setString("filterdo_you_smoke", do_you_smoke);
                                                                                                dashboardprovider.filterListModel!.smokeOptions!.elementAt(index).isSelected = true;
                                                                                              }
                                                                                            });
                                                                                          },
                                                                                          child: !dashboardprovider.filterListModel!.smokeOptions!.elementAt(index).isSelected!
                                                                                              ? Container(
                                                                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r), border: Border.all(color: Colorss.mainColor, width: 1.0.h)),
                                                                                                  padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                                                                                                  margin: EdgeInsets.all(3),
                                                                                                  child: Text(
                                                                                                    dashboardprovider.filterListModel!.smokeOptions!.elementAt(index).name,
                                                                                                    style: TextStyle(color: Colorss.mainColor, fontSize: 20.sp, fontFamily: "Avenir Heavy", fontWeight: FontWeight.w500),
                                                                                                  ),
                                                                                                )
                                                                                              : Container(
                                                                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r), color: Colorss.mainColor),
                                                                                                  padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                                                                                                  margin: EdgeInsets.all(3),
                                                                                                  child: Text(
                                                                                                    dashboardprovider.filterListModel!.smokeOptions!.elementAt(index).name,
                                                                                                    style: TextStyle(color: Colors.white, fontSize: 20.sp, fontFamily: "Avenir Heavy", fontWeight: FontWeight.w500),
                                                                                                  ),
                                                                                                ),
                                                                                        );
                                                                                      }),
                                                                                    ),
                                                                                  ],
                                                                                )
                                                                              : Container(),
                                                                          SizedBox(
                                                                            height:
                                                                                20.h,
                                                                          ),
                                                                          dashboardprovider.filterListModel!.languages!.isNotEmpty
                                                                              ? Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  mainAxisSize: MainAxisSize.min,
                                                                                  children: [
                                                                                    Text(
                                                                                      AppLocalizations.of(context)!.langugaes,
                                                                                      style: TextStyle(color: Colorss.mainColor, fontSize: 20.sp, fontFamily: "Avenir Black", fontWeight: FontWeight.w500),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 10.h,
                                                                                    ),
                                                                                    Wrap(
                                                                                      children: List.generate(dashboardprovider.filterListModel!.languages!.length, (index) {
                                                                                        for (int i = 0; i < dashboardprovider.filterListModel!.languages!.length; i++) {
                                                                                          if (dashboardprovider.filterListModel!.languages!.elementAt(index).id.toString() == languageList) {
                                                                                            dashboardprovider.filterListModel!.languages!.elementAt(index).isSelected = true;
                                                                                            languageList = dashboardprovider.filterListModel!.languages!.elementAt(index).id!.toString();
                                                                                          }
                                                                                        }
                                                                                        return GestureDetector(
                                                                                          onTap: () {
                                                                                            stateSetter(() {
                                                                                              for (int i = 0; i < dashboardprovider.filterListModel!.languages!.length; i++) {
                                                                                                if (dashboardprovider.filterListModel!.languages!.elementAt(i).isSelected == true) {
                                                                                                  dashboardprovider.filterListModel!.languages!.elementAt(i).isSelected = false;
                                                                                                }
                                                                                                languageList = dashboardprovider.filterListModel!.languages!.elementAt(index).id.toString();
                                                                                                dashboardprovider.filterListModel!.languages!.elementAt(index).isSelected = true;
                                                                                              }
                                                                                            });
                                                                                          },
                                                                                          child: !dashboardprovider.filterListModel!.languages!.elementAt(index).isSelected!
                                                                                              ? Container(
                                                                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r), border: Border.all(color: Colorss.mainColor, width: 1.0.h)),
                                                                                                  padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                                                                                                  margin: EdgeInsets.all(3),
                                                                                                  child: Text(
                                                                                                    dashboardprovider.filterListModel!.languages!.elementAt(index).language,
                                                                                                    style: TextStyle(color: Colorss.mainColor, fontSize: 20.sp, fontFamily: "Avenir Heavy", fontWeight: FontWeight.w500),
                                                                                                  ),
                                                                                                )
                                                                                              : Container(
                                                                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r), color: Colorss.mainColor),
                                                                                                  padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                                                                                                  margin: EdgeInsets.all(3),
                                                                                                  child: Text(
                                                                                                    dashboardprovider.filterListModel!.languages!.elementAt(index).language,
                                                                                                    style: TextStyle(color: Colors.white, fontSize: 20.sp, fontFamily: "Avenir Heavy", fontWeight: FontWeight.w500),
                                                                                                  ),
                                                                                                ),
                                                                                        );
                                                                                      }),
                                                                                    ),
                                                                                  ],
                                                                                )
                                                                              : Container(),
                                                                          SizedBox(
                                                                            height:
                                                                                20.h,
                                                                          ),
                                                                          dashboardprovider.filterListModel!.drinkOptions!.isNotEmpty
                                                                              ? Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  mainAxisSize: MainAxisSize.min,
                                                                                  children: [
                                                                                    Text(
                                                                                      AppLocalizations.of(context)!.drink,
                                                                                      style: TextStyle(color: Colorss.mainColor, fontSize: 20.sp, fontFamily: "Avenir Black", fontWeight: FontWeight.w500),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 10.h,
                                                                                    ),
                                                                                    Wrap(
                                                                                      children: List.generate(dashboardprovider.filterListModel!.drinkOptions!.length, (index) {
                                                                                        for (int i = 0; i < dashboardprovider.filterListModel!.drinkOptions!.length; i++) {
                                                                                          if (dashboardprovider.filterListModel!.drinkOptions!.elementAt(index).id.toString() == do_you_drink) {
                                                                                            dashboardprovider.filterListModel!.drinkOptions!.elementAt(index).isSelected = true;
                                                                                            do_you_drink = dashboardprovider.filterListModel!.drinkOptions!.elementAt(index).id!.toString();
                                                                                          }
                                                                                        }
                                                                                        return GestureDetector(
                                                                                          onTap: () {
                                                                                            stateSetter(() {
                                                                                              for (int i = 0; i < dashboardprovider.filterListModel!.drinkOptions!.length; i++) {
                                                                                                if (dashboardprovider.filterListModel!.drinkOptions!.elementAt(i).isSelected == true) {
                                                                                                  dashboardprovider.filterListModel!.drinkOptions!.elementAt(i).isSelected = false;
                                                                                                }
                                                                                                do_you_drink = dashboardprovider.filterListModel!.drinkOptions!.elementAt(index).id.toString();
                                                                                                print(do_you_drink);
                                                                                                preferences!.setString("filterdo_you_drink", do_you_drink);
                                                                                                dashboardprovider.filterListModel!.drinkOptions!.elementAt(index).isSelected = true;
                                                                                              }
                                                                                            });
                                                                                          },
                                                                                          child: !dashboardprovider.filterListModel!.drinkOptions!.elementAt(index).isSelected!
                                                                                              ? Container(
                                                                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r), border: Border.all(color: Colorss.mainColor, width: 1.0.h)),
                                                                                                  padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                                                                                                  margin: EdgeInsets.all(3),
                                                                                                  child: Text(
                                                                                                    dashboardprovider.filterListModel!.drinkOptions!.elementAt(index).name,
                                                                                                    style: TextStyle(color: Colorss.mainColor, fontSize: 20.sp, fontFamily: "Avenir Heavy", fontWeight: FontWeight.w500),
                                                                                                  ),
                                                                                                )
                                                                                              : Container(
                                                                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r), color: Colorss.mainColor),
                                                                                                  padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                                                                                                  margin: EdgeInsets.all(3),
                                                                                                  child: Text(
                                                                                                    dashboardprovider.filterListModel!.drinkOptions!.elementAt(index).name,
                                                                                                    style: TextStyle(color: Colors.white, fontSize: 20.sp, fontFamily: "Avenir Heavy", fontWeight: FontWeight.w500),
                                                                                                  ),
                                                                                                ),
                                                                                        );
                                                                                      }),
                                                                                    ),
                                                                                  ],
                                                                                )
                                                                              : Container(),
                                                                          SizedBox(
                                                                            height:
                                                                                20.h,
                                                                          ),
                                                                          dashboardprovider.filterListModel!.religions!.isNotEmpty
                                                                              ? Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  mainAxisSize: MainAxisSize.min,
                                                                                  children: [
                                                                                    Text(
                                                                                      AppLocalizations.of(context)!.religion,
                                                                                      style: TextStyle(color: Colorss.mainColor, fontSize: 20.sp, fontFamily: "Avenir Black", fontWeight: FontWeight.w500),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 10.h,
                                                                                    ),
                                                                                    Wrap(
                                                                                      children: List.generate(
                                                                                        dashboardprovider.filterListModel!.religions!.length,
                                                                                        (index) {
                                                                                          for (int i = 0; i < dashboardprovider.filterListModel!.religions!.length; i++) {
                                                                                            if (dashboardprovider.filterListModel!.religions!.elementAt(index).id.toString() == religion) {
                                                                                              dashboardprovider.filterListModel!.religions!.elementAt(index).isSelected = true;
                                                                                              religion = dashboardprovider.filterListModel!.religions!.elementAt(index).id!.toString();
                                                                                            }
                                                                                          }
                                                                                          return GestureDetector(
                                                                                            onTap: () {
                                                                                              stateSetter(() {
                                                                                                for (int i = 0; i < dashboardprovider.filterListModel!.religions!.length; i++) {
                                                                                                  if (dashboardprovider.filterListModel!.religions!.elementAt(i).isSelected == true) {
                                                                                                    dashboardprovider.filterListModel!.religions!.elementAt(i).isSelected = false;
                                                                                                  }
                                                                                                  religion = dashboardprovider.filterListModel!.religions!.elementAt(index).id.toString();
                                                                                                  print(religion);
                                                                                                  preferences!.setString("filterreligion", religion);
                                                                                                  dashboardprovider.filterListModel!.religions!.elementAt(index).isSelected = true;
                                                                                                }
                                                                                              });
                                                                                            },
                                                                                            child: !dashboardprovider.filterListModel!.religions!.elementAt(index).isSelected!
                                                                                                ? Container(
                                                                                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r), border: Border.all(color: Colorss.mainColor, width: 1.0.h)),
                                                                                                    padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                                                                                                    margin: EdgeInsets.all(3),
                                                                                                    child: Text(
                                                                                                      dashboardprovider.filterListModel!.religions!.elementAt(index).name,
                                                                                                      style: TextStyle(color: Colorss.mainColor, fontSize: 20.sp, fontFamily: "Avenir Heavy", fontWeight: FontWeight.w500),
                                                                                                    ),
                                                                                                  )
                                                                                                : Container(
                                                                                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r), color: Colorss.mainColor),
                                                                                                    padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                                                                                                    margin: EdgeInsets.all(3),
                                                                                                    child: Text(
                                                                                                      dashboardprovider.filterListModel!.religions!.elementAt(index).name,
                                                                                                      style: TextStyle(color: Colors.white, fontSize: 20.sp, fontFamily: "Avenir Heavy", fontWeight: FontWeight.w500),
                                                                                                    ),
                                                                                                  ),
                                                                                          );
                                                                                        },
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                )
                                                                              : Container(),
                                                                          SizedBox(
                                                                            height:
                                                                                20.h,
                                                                          ),
                                                                          dashboardprovider.filterListModel!.havePets!.isNotEmpty
                                                                              ? Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  mainAxisSize: MainAxisSize.min,
                                                                                  children: [
                                                                                    Text(
                                                                                      AppLocalizations.of(context)!.pets,
                                                                                      style: TextStyle(color: Colorss.mainColor, fontSize: 20.sp, fontFamily: "Avenir Black", fontWeight: FontWeight.w500),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 10.h,
                                                                                    ),
                                                                                    Wrap(
                                                                                      children: List.generate(
                                                                                        dashboardprovider.filterListModel!.havePets!.length,
                                                                                        (index) {
                                                                                          for (int i = 0; i < dashboardprovider.filterListModel!.havePets!.length; i++) {
                                                                                            if (dashboardprovider.filterListModel!.havePets!.elementAt(index).id.toString() == have_pets) {
                                                                                              dashboardprovider.filterListModel!.havePets!.elementAt(index).isSelected = true;
                                                                                              have_pets = dashboardprovider.filterListModel!.havePets!.elementAt(index).id!.toString();
                                                                                            }
                                                                                          }
                                                                                          return GestureDetector(
                                                                                            onTap: () {
                                                                                              stateSetter(() {
                                                                                                for (int i = 0; i < dashboardprovider.filterListModel!.havePets!.length; i++) {
                                                                                                  if (dashboardprovider.filterListModel!.havePets!.elementAt(i).isSelected == true) {
                                                                                                    dashboardprovider.filterListModel!.havePets!.elementAt(i).isSelected = false;
                                                                                                  }
                                                                                                  have_pets = dashboardprovider.filterListModel!.havePets!.elementAt(index).id.toString();
                                                                                                  print(have_pets);
                                                                                                  preferences!.setString("filterhave_pets", have_pets);
                                                                                                  dashboardprovider.filterListModel!.havePets!.elementAt(index).isSelected = true;
                                                                                                }
                                                                                              });
                                                                                            },
                                                                                            child: !dashboardprovider.filterListModel!.havePets!.elementAt(index).isSelected!
                                                                                                ? Container(
                                                                                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r), border: Border.all(color: Colorss.mainColor, width: 1.0.h)),
                                                                                                    padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                                                                                                    margin: EdgeInsets.all(3),
                                                                                                    child: Text(
                                                                                                      dashboardprovider.filterListModel!.havePets!.elementAt(index).name,
                                                                                                      style: TextStyle(color: Colorss.mainColor, fontSize: 20.sp, fontFamily: "Avenir Heavy", fontWeight: FontWeight.w500),
                                                                                                    ),
                                                                                                  )
                                                                                                : Container(
                                                                                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r), color: Colorss.mainColor),
                                                                                                    padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                                                                                                    margin: EdgeInsets.all(3),
                                                                                                    child: Text(
                                                                                                      dashboardprovider.filterListModel!.havePets!.elementAt(index).name,
                                                                                                      style: TextStyle(color: Colors.white, fontSize: 20.sp, fontFamily: "Avenir Heavy", fontWeight: FontWeight.w500),
                                                                                                    ),
                                                                                                  ),
                                                                                          );
                                                                                        },
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                )
                                                                              : Container(),
                                                                          SizedBox(
                                                                            height:
                                                                                20.h,
                                                                          ),
                                                                          dashboardprovider.filterListModel!.sexualOrientations!.isNotEmpty
                                                                              ? Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  mainAxisSize: MainAxisSize.min,
                                                                                  children: [
                                                                                    Text(
                                                                                      AppLocalizations.of(context)!.sexualorientation,
                                                                                      style: TextStyle(color: Colorss.mainColor, fontSize: 20.sp, fontFamily: "Avenir Black", fontWeight: FontWeight.w500),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 10.h,
                                                                                    ),
                                                                                    Wrap(
                                                                                      children: List.generate(
                                                                                        dashboardprovider.filterListModel!.sexualOrientations!.length,
                                                                                        (index) {
                                                                                          for (int i = 0; i < dashboardprovider.filterListModel!.sexualOrientations!.length; i++) {
                                                                                            if (dashboardprovider.filterListModel!.sexualOrientations!.elementAt(index).id.toString() == sexual_orientation) {
                                                                                              dashboardprovider.filterListModel!.sexualOrientations!.elementAt(index).isSelected = true;
                                                                                              sexual_orientation = dashboardprovider.filterListModel!.sexualOrientations!.elementAt(index).id!.toString();
                                                                                            }
                                                                                          }
                                                                                          return GestureDetector(
                                                                                            onTap: () {
                                                                                              stateSetter(() {
                                                                                                for (int i = 0; i < dashboardprovider.filterListModel!.sexualOrientations!.length; i++) {
                                                                                                  if (dashboardprovider.filterListModel!.sexualOrientations!.elementAt(i).isSelected == true) {
                                                                                                    dashboardprovider.filterListModel!.sexualOrientations!.elementAt(i).isSelected = false;
                                                                                                  }
                                                                                                  sexual_orientation = dashboardprovider.filterListModel!.sexualOrientations!.elementAt(index).id.toString();
                                                                                                  print(sexual_orientation);
                                                                                                  preferences!.setString("filtersexual_orientation", sexual_orientation);
                                                                                                  dashboardprovider.filterListModel!.sexualOrientations!.elementAt(index).isSelected = true;
                                                                                                }
                                                                                              });
                                                                                            },
                                                                                            child: !dashboardprovider.filterListModel!.sexualOrientations!.elementAt(index).isSelected!
                                                                                                ? Container(
                                                                                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r), border: Border.all(color: Colorss.mainColor, width: 1.0.h)),
                                                                                                    padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                                                                                                    margin: EdgeInsets.all(3),
                                                                                                    child: Text(
                                                                                                      dashboardprovider.filterListModel!.sexualOrientations!.elementAt(index).name ?? "",
                                                                                                      style: TextStyle(color: Colorss.mainColor, fontSize: 20.sp, fontFamily: "Avenir Heavy", fontWeight: FontWeight.w500),
                                                                                                    ),
                                                                                                  )
                                                                                                : Container(
                                                                                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r), color: Colorss.mainColor),
                                                                                                    padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                                                                                                    margin: EdgeInsets.all(3),
                                                                                                    child: Text(
                                                                                                      dashboardprovider.filterListModel!.sexualOrientations!.elementAt(index).name ?? "",
                                                                                                      style: TextStyle(color: Colors.white, fontSize: 20.sp, fontFamily: "Avenir Heavy", fontWeight: FontWeight.w500),
                                                                                                    ),
                                                                                                  ),
                                                                                          );
                                                                                        },
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                )
                                                                              : Container(),
                                                                          SizedBox(
                                                                            height:
                                                                                20.h,
                                                                          ),
                                                                          dashboardprovider.filterListModel!.educationLevels!.isNotEmpty
                                                                              ? Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  mainAxisSize: MainAxisSize.min,
                                                                                  children: [
                                                                                    Text(
                                                                                      AppLocalizations.of(context)!.education,
                                                                                      style: TextStyle(color: Colorss.mainColor, fontSize: 20.sp, fontFamily: "Avenir Black", fontWeight: FontWeight.w500),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 10.h,
                                                                                    ),
                                                                                    Wrap(
                                                                                      children: List.generate(
                                                                                        dashboardprovider.filterListModel!.educationLevels!.length,
                                                                                        (index) {
                                                                                          for (int i = 0; i < dashboardprovider.filterListModel!.educationLevels!.length; i++) {
                                                                                            if (dashboardprovider.filterListModel!.educationLevels!.elementAt(index).id.toString() == education) {
                                                                                              dashboardprovider.filterListModel!.educationLevels!.elementAt(index).isSelected = true;
                                                                                              education = dashboardprovider.filterListModel!.educationLevels!.elementAt(index).id!.toString();
                                                                                            }
                                                                                          }
                                                                                          return GestureDetector(
                                                                                            onTap: () {
                                                                                              stateSetter(() {
                                                                                                for (int i = 0; i < dashboardprovider.filterListModel!.educationLevels!.length; i++) {
                                                                                                  if (dashboardprovider.filterListModel!.educationLevels!.elementAt(i).isSelected == true) {
                                                                                                    dashboardprovider.filterListModel!.educationLevels!.elementAt(i).isSelected = false;
                                                                                                  }
                                                                                                  education = dashboardprovider.filterListModel!.educationLevels!.elementAt(index).id.toString();
                                                                                                  print(education);
                                                                                                  preferences!.setString("filtereducation", education);
                                                                                                  dashboardprovider.filterListModel!.educationLevels!.elementAt(index).isSelected = true;
                                                                                                }
                                                                                              });
                                                                                            },
                                                                                            child: !dashboardprovider.filterListModel!.educationLevels!.elementAt(index).isSelected!
                                                                                                ? Container(
                                                                                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r), border: Border.all(color: Colorss.mainColor, width: 1.0.h)),
                                                                                                    padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                                                                                                    margin: EdgeInsets.all(3),
                                                                                                    child: Text(
                                                                                                      dashboardprovider.filterListModel!.educationLevels!.elementAt(index).name,
                                                                                                      style: TextStyle(color: Colorss.mainColor, fontSize: 20.sp, fontFamily: "Avenir Heavy", fontWeight: FontWeight.w500),
                                                                                                    ),
                                                                                                  )
                                                                                                : Container(
                                                                                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r), color: Colorss.mainColor),
                                                                                                    padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                                                                                                    margin: EdgeInsets.all(3),
                                                                                                    child: Text(
                                                                                                      dashboardprovider.filterListModel!.educationLevels!.elementAt(index).name,
                                                                                                      style: TextStyle(color: Colors.white, fontSize: 20.sp, fontFamily: "Avenir Heavy", fontWeight: FontWeight.w500),
                                                                                                    ),
                                                                                                  ),
                                                                                          );
                                                                                        },
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                )
                                                                              : Container(),
                                                                          SizedBox(
                                                                            height:
                                                                                20.h,
                                                                          ),
                                                                          dashboardprovider.filterListModel!.introvertOrExtroverts!.isNotEmpty
                                                                              ? Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  mainAxisSize: MainAxisSize.min,
                                                                                  children: [
                                                                                    Text(
                                                                                      AppLocalizations.of(context)!.introextro,
                                                                                      style: TextStyle(color: Colorss.mainColor, fontSize: 20.sp, fontFamily: "Avenir Black", fontWeight: FontWeight.w500),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 10.h,
                                                                                    ),
                                                                                    Wrap(
                                                                                      children: List.generate(
                                                                                        dashboardprovider.filterListModel!.introvertOrExtroverts!.length,
                                                                                        (index) {
                                                                                          for (int i = 0; i < dashboardprovider.filterListModel!.introvertOrExtroverts!.length; i++) {
                                                                                            if (dashboardprovider.filterListModel!.introvertOrExtroverts!.elementAt(index).id.toString() == introvert_or_extrovert) {
                                                                                              dashboardprovider.filterListModel!.introvertOrExtroverts!.elementAt(index).isSelected = true;
                                                                                              introvert_or_extrovert = dashboardprovider.filterListModel!.introvertOrExtroverts!.elementAt(index).id!.toString();
                                                                                            }
                                                                                          }
                                                                                          return GestureDetector(
                                                                                            onTap: () {
                                                                                              stateSetter(() {
                                                                                                for (int i = 0; i < dashboardprovider.filterListModel!.introvertOrExtroverts!.length; i++) {
                                                                                                  if (dashboardprovider.filterListModel!.introvertOrExtroverts!.elementAt(i).isSelected == true) {
                                                                                                    dashboardprovider.filterListModel!.introvertOrExtroverts!.elementAt(i).isSelected = false;
                                                                                                  }
                                                                                                  introvert_or_extrovert = dashboardprovider.filterListModel!.introvertOrExtroverts!.elementAt(index).id.toString();
                                                                                                  print(introvert_or_extrovert);
                                                                                                  preferences!.setString("filterintrovert_or_extrovert", introvert_or_extrovert);
                                                                                                  dashboardprovider.filterListModel!.introvertOrExtroverts!.elementAt(index).isSelected = true;
                                                                                                }
                                                                                              });
                                                                                            },
                                                                                            child: !dashboardprovider.filterListModel!.introvertOrExtroverts!.elementAt(index).isSelected!
                                                                                                ? Container(
                                                                                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r), border: Border.all(color: Colorss.mainColor, width: 1.0.h)),
                                                                                                    padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                                                                                                    margin: EdgeInsets.all(3),
                                                                                                    child: Text(
                                                                                                      dashboardprovider.filterListModel!.introvertOrExtroverts!.elementAt(index).name,
                                                                                                      style: TextStyle(color: Colorss.mainColor, fontSize: 20.sp, fontFamily: "Avenir Heavy", fontWeight: FontWeight.w500),
                                                                                                    ),
                                                                                                  )
                                                                                                : Container(
                                                                                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r), color: Colorss.mainColor),
                                                                                                    padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                                                                                                    margin: EdgeInsets.all(3),
                                                                                                    child: Text(
                                                                                                      dashboardprovider.filterListModel!.introvertOrExtroverts!.elementAt(index).name,
                                                                                                      style: TextStyle(color: Colors.white, fontSize: 20.sp, fontFamily: "Avenir Heavy", fontWeight: FontWeight.w500),
                                                                                                    ),
                                                                                                  ),
                                                                                          );
                                                                                        },
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                )
                                                                              : Container(),
                                                                          SizedBox(
                                                                            height:
                                                                                20.h,
                                                                          ),
                                                                          dashboardprovider.filterListModel!.starSigns!.isNotEmpty
                                                                              ? Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  mainAxisSize: MainAxisSize.min,
                                                                                  children: [
                                                                                    Text(
                                                                                      AppLocalizations.of(context)!.starsign,
                                                                                      style: TextStyle(color: Colorss.mainColor, fontSize: 20.sp, fontFamily: "Avenir Black", fontWeight: FontWeight.w500),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 10.h,
                                                                                    ),
                                                                                    Wrap(
                                                                                      children: List.generate(
                                                                                        dashboardprovider.filterListModel!.starSigns!.length,
                                                                                        (index) {
                                                                                          for (int i = 0; i < dashboardprovider.filterListModel!.starSigns!.length; i++) {
                                                                                            if (dashboardprovider.filterListModel!.starSigns!.elementAt(index).id.toString() == star_sign) {
                                                                                              dashboardprovider.filterListModel!.starSigns!.elementAt(index).isSelected = true;
                                                                                              star_sign = dashboardprovider.filterListModel!.starSigns!.elementAt(index).id!.toString();
                                                                                            }
                                                                                          }
                                                                                          return GestureDetector(
                                                                                            onTap: () {
                                                                                              stateSetter(() {
                                                                                                for (int i = 0; i < dashboardprovider.filterListModel!.starSigns!.length; i++) {
                                                                                                  if (dashboardprovider.filterListModel!.starSigns!.elementAt(i).isSelected == true) {
                                                                                                    dashboardprovider.filterListModel!.starSigns!.elementAt(i).isSelected = false;
                                                                                                  }
                                                                                                  star_sign = dashboardprovider.filterListModel!.starSigns!.elementAt(index).id.toString();
                                                                                                  print(star_sign);
                                                                                                  preferences!.setString("filterstar_sign", star_sign);
                                                                                                  dashboardprovider.filterListModel!.starSigns!.elementAt(index).isSelected = true;
                                                                                                }
                                                                                              });
                                                                                            },
                                                                                            child: !dashboardprovider.filterListModel!.starSigns!.elementAt(index).isSelected!
                                                                                                ? Container(
                                                                                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r), border: Border.all(color: Colorss.mainColor, width: 1.0.h)),
                                                                                                    padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                                                                                                    margin: EdgeInsets.all(3),
                                                                                                    child: Text(
                                                                                                      dashboardprovider.filterListModel!.starSigns!.elementAt(index).name,
                                                                                                      style: TextStyle(color: Colorss.mainColor, fontSize: 20.sp, fontFamily: "Avenir Heavy", fontWeight: FontWeight.w500),
                                                                                                    ),
                                                                                                  )
                                                                                                : Container(
                                                                                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r), color: Colorss.mainColor),
                                                                                                    padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                                                                                                    margin: EdgeInsets.all(3),
                                                                                                    child: Text(
                                                                                                      dashboardprovider.filterListModel!.starSigns!.elementAt(index).name,
                                                                                                      style: TextStyle(color: Colors.white, fontSize: 20.sp, fontFamily: "Avenir Heavy", fontWeight: FontWeight.w500),
                                                                                                    ),
                                                                                                  ),
                                                                                          );
                                                                                        },
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                )
                                                                              : Container(),
                                                                          SizedBox(
                                                                            height:
                                                                                20.h,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    )
                                                                  : Container()),
                                                    ],
                                                  )
                                                : Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .height,
                                                            style: TextStyle(
                                                                color: Color(
                                                                        0xFF2A2627)
                                                                    .withOpacity(
                                                                        0.10),
                                                                fontSize: 20.sp,
                                                                fontFamily:
                                                                    "Avenir Black",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                          Text(
                                                            '${startheight.toStringAsFixed(0)}-${endheight.toStringAsFixed(0)}cm',
                                                            style: TextStyle(
                                                                color: Color(
                                                                        0xFF2A2627)
                                                                    .withOpacity(
                                                                        0.10),
                                                                fontSize: 20.sp,
                                                                fontFamily:
                                                                    "Avenir Black",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                        ],
                                                      ),
                                                      SfRangeSlider(
                                                          min: 130.0,
                                                          max: 270.0,
                                                          values: _heightvalues,
                                                          interval: 1.0,
                                                          showTicks: false,
                                                          showLabels: false,
                                                          stepSize: 1.0,
                                                          activeColor:
                                                              Color(0xFF2A2627)
                                                                  .withOpacity(
                                                                      0.10),
                                                          inactiveColor:
                                                              Color(0xFF2A2627)
                                                                  .withOpacity(
                                                                      0.10),
                                                          startThumbIcon: Icon(
                                                            Icons.circle,
                                                            color: Color(
                                                                0xFFF5F5F5),
                                                            size: 20,
                                                          ),
                                                          endThumbIcon: Icon(
                                                            Icons.circle,
                                                            color: Color(
                                                                0xFFF5F5F5),
                                                            size: 20,
                                                          ),
                                                          minorTicksPerInterval:
                                                              1,
                                                          onChanged: null),
                                                      Consumer<
                                                              DashboardProvider>(
                                                          builder: (context,
                                                                  dashboardprovider,
                                                                  child) =>
                                                              dashboardprovider
                                                                          .filterListModel !=
                                                                      null
                                                                  ? Container(
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          dashboardprovider.filterListModel!.feelAboutKids!.isNotEmpty
                                                                              ? Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  mainAxisSize: MainAxisSize.min,
                                                                                  children: [
                                                                                    Text(
                                                                                      AppLocalizations.of(context)!.kid,
                                                                                      style: TextStyle(color: Color(0xFF2A2627).withOpacity(0.10), fontSize: 20.sp, fontFamily: "Avenir Black", fontWeight: FontWeight.w500),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 10.h,
                                                                                    ),
                                                                                    Wrap(
                                                                                      children: List.generate(
                                                                                          dashboardprovider.filterListModel!.feelAboutKids!.length,
                                                                                          (index) => Container(
                                                                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r), border: Border.all(color: Color(0xFF2A2627).withOpacity(0.10), width: 1.0.h)),
                                                                                                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                                                                                                margin: EdgeInsets.all(3),
                                                                                                child: Text(
                                                                                                  dashboardprovider.filterListModel!.feelAboutKids!.elementAt(index).name,
                                                                                                  style: TextStyle(color: Color(0xFF2A2627).withOpacity(0.10), fontSize: 20.sp, fontFamily: "Avenir Heavy", fontWeight: FontWeight.w500),
                                                                                                ),
                                                                                              )),
                                                                                    ),
                                                                                  ],
                                                                                )
                                                                              : Container(),
                                                                          SizedBox(
                                                                            height:
                                                                                20.h,
                                                                          ),
                                                                          dashboardprovider.filterListModel!.smokeOptions!.isNotEmpty
                                                                              ? Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  mainAxisSize: MainAxisSize.min,
                                                                                  children: [
                                                                                    Text(
                                                                                      AppLocalizations.of(context)!.smoke,
                                                                                      style: TextStyle(color: Color(0xFF2A2627).withOpacity(0.10), fontSize: 20.sp, fontFamily: "Avenir Black", fontWeight: FontWeight.w500),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 10.h,
                                                                                    ),
                                                                                    Wrap(
                                                                                      children: List.generate(
                                                                                          dashboardprovider.filterListModel!.smokeOptions!.length,
                                                                                          (index) => Container(
                                                                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r), border: Border.all(color: Color(0xFF2A2627).withOpacity(0.10), width: 1.0.h)),
                                                                                                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                                                                                                margin: EdgeInsets.all(3),
                                                                                                child: Text(
                                                                                                  dashboardprovider.filterListModel!.smokeOptions!.elementAt(index).name,
                                                                                                  style: TextStyle(color: Color(0xFF2A2627).withOpacity(0.10), fontSize: 20.sp, fontFamily: "Avenir Heavy", fontWeight: FontWeight.w500),
                                                                                                ),
                                                                                              )),
                                                                                    ),
                                                                                  ],
                                                                                )
                                                                              : Container(),
                                                                          SizedBox(
                                                                            height:
                                                                                20.h,
                                                                          ),
                                                                          dashboardprovider.filterListModel!.languages!.isNotEmpty
                                                                              ? Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  mainAxisSize: MainAxisSize.min,
                                                                                  children: [
                                                                                    Text(
                                                                                      AppLocalizations.of(context)!.langugaes,
                                                                                      style: TextStyle(color: Color(0xFF2A2627).withOpacity(0.10), fontSize: 20.sp, fontFamily: "Avenir Black", fontWeight: FontWeight.w500),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 10.h,
                                                                                    ),
                                                                                    Wrap(
                                                                                      children: List.generate(
                                                                                          dashboardprovider.filterListModel!.languages!.length,
                                                                                          (index) => Container(
                                                                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r), border: Border.all(color: Color(0xFF2A2627).withOpacity(0.10), width: 1.0.h)),
                                                                                                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                                                                                                margin: EdgeInsets.all(3),
                                                                                                child: Text(
                                                                                                  dashboardprovider.filterListModel!.languages!.elementAt(index).language,
                                                                                                  style: TextStyle(color: Color(0xFF2A2627).withOpacity(0.10), fontSize: 20.sp, fontFamily: "Avenir Heavy", fontWeight: FontWeight.w500),
                                                                                                ),
                                                                                              )),
                                                                                    ),
                                                                                  ],
                                                                                )
                                                                              : Container(),
                                                                          SizedBox(
                                                                            height:
                                                                                20.h,
                                                                          ),
                                                                          dashboardprovider.filterListModel!.drinkOptions!.isNotEmpty
                                                                              ? Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  mainAxisSize: MainAxisSize.min,
                                                                                  children: [
                                                                                    Text(
                                                                                      AppLocalizations.of(context)!.drink,
                                                                                      style: TextStyle(color: Color(0xFF2A2627).withOpacity(0.10), fontSize: 20.sp, fontFamily: "Avenir Black", fontWeight: FontWeight.w500),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 10.h,
                                                                                    ),
                                                                                    Wrap(
                                                                                      children: List.generate(
                                                                                          dashboardprovider.filterListModel!.drinkOptions!.length,
                                                                                          (index) => Container(
                                                                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r), border: Border.all(color: Color(0xFF2A2627).withOpacity(0.10), width: 1.0.h)),
                                                                                                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                                                                                                margin: EdgeInsets.all(3),
                                                                                                child: Text(
                                                                                                  dashboardprovider.filterListModel!.drinkOptions!.elementAt(index).name,
                                                                                                  style: TextStyle(color: Color(0xFF2A2627).withOpacity(0.10), fontSize: 20.sp, fontFamily: "Avenir Heavy", fontWeight: FontWeight.w500),
                                                                                                ),
                                                                                              )),
                                                                                    ),
                                                                                  ],
                                                                                )
                                                                              : Container(),
                                                                          SizedBox(
                                                                            height:
                                                                                20.h,
                                                                          ),
                                                                          dashboardprovider.filterListModel!.religions!.isNotEmpty
                                                                              ? Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  mainAxisSize: MainAxisSize.min,
                                                                                  children: [
                                                                                    Text(
                                                                                      AppLocalizations.of(context)!.religion,
                                                                                      style: TextStyle(color: Color(0xFF2A2627).withOpacity(0.10), fontSize: 20.sp, fontFamily: "Avenir Black", fontWeight: FontWeight.w500),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 10.h,
                                                                                    ),
                                                                                    Wrap(
                                                                                      children: List.generate(
                                                                                          dashboardprovider.filterListModel!.religions!.length,
                                                                                          (index) => Container(
                                                                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r), border: Border.all(color: Color(0xFF2A2627).withOpacity(0.10), width: 1.0.h)),
                                                                                                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                                                                                                margin: EdgeInsets.all(3),
                                                                                                child: Text(
                                                                                                  dashboardprovider.filterListModel!.religions!.elementAt(index).name,
                                                                                                  style: TextStyle(color: Color(0xFF2A2627).withOpacity(0.10), fontSize: 20.sp, fontFamily: "Avenir Heavy", fontWeight: FontWeight.w500),
                                                                                                ),
                                                                                              )),
                                                                                    ),
                                                                                  ],
                                                                                )
                                                                              : Container(),
                                                                          SizedBox(
                                                                            height:
                                                                                20.h,
                                                                          ),
                                                                          dashboardprovider.filterListModel!.havePets!.isNotEmpty
                                                                              ? Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  mainAxisSize: MainAxisSize.min,
                                                                                  children: [
                                                                                    Text(
                                                                                      AppLocalizations.of(context)!.pets,
                                                                                      style: TextStyle(color: Color(0xFF2A2627).withOpacity(0.10), fontSize: 20.sp, fontFamily: "Avenir Black", fontWeight: FontWeight.w500),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 10.h,
                                                                                    ),
                                                                                    Wrap(
                                                                                      children: List.generate(
                                                                                          dashboardprovider.filterListModel!.havePets!.length,
                                                                                          (index) => Container(
                                                                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r), border: Border.all(color: Color(0xFF2A2627).withOpacity(0.10), width: 1.0.h)),
                                                                                                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                                                                                                margin: EdgeInsets.all(3),
                                                                                                child: Text(
                                                                                                  dashboardprovider.filterListModel!.havePets!.elementAt(index).name,
                                                                                                  style: TextStyle(color: Color(0xFF2A2627).withOpacity(0.10), fontSize: 20.sp, fontFamily: "Avenir Heavy", fontWeight: FontWeight.w500),
                                                                                                ),
                                                                                              )),
                                                                                    ),
                                                                                  ],
                                                                                )
                                                                              : Container(),
                                                                          SizedBox(
                                                                            height:
                                                                                20.h,
                                                                          ),
                                                                          dashboardprovider.filterListModel!.sexualOrientations!.isNotEmpty
                                                                              ? Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  mainAxisSize: MainAxisSize.min,
                                                                                  children: [
                                                                                    Text(
                                                                                      AppLocalizations.of(context)!.sexualorientation,
                                                                                      style: TextStyle(color: Color(0xFF2A2627).withOpacity(0.10), fontSize: 20.sp, fontFamily: "Avenir Black", fontWeight: FontWeight.w500),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 10.h,
                                                                                    ),
                                                                                    Wrap(
                                                                                      children: List.generate(
                                                                                          dashboardprovider.filterListModel!.sexualOrientations!.length,
                                                                                          (index) => Container(
                                                                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r), border: Border.all(color: Color(0xFF2A2627).withOpacity(0.10), width: 1.0.h)),
                                                                                                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                                                                                                margin: EdgeInsets.all(3),
                                                                                                child: Text(
                                                                                                  dashboardprovider.filterListModel!.sexualOrientations!.elementAt(index).name.toString(),
                                                                                                  style: TextStyle(color: Color(0xFF2A2627).withOpacity(0.10), fontSize: 20.sp, fontFamily: "Avenir Heavy", fontWeight: FontWeight.w500),
                                                                                                ),
                                                                                              )),
                                                                                    ),
                                                                                  ],
                                                                                )
                                                                              : Container(),
                                                                          SizedBox(
                                                                            height:
                                                                                20.h,
                                                                          ),
                                                                          dashboardprovider.filterListModel!.educationLevels!.isNotEmpty
                                                                              ? Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  mainAxisSize: MainAxisSize.min,
                                                                                  children: [
                                                                                    Text(
                                                                                      AppLocalizations.of(context)!.education,
                                                                                      style: TextStyle(color: Color(0xFF2A2627).withOpacity(0.10), fontSize: 20.sp, fontFamily: "Avenir Black", fontWeight: FontWeight.w500),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 10.h,
                                                                                    ),
                                                                                    Wrap(
                                                                                      children: List.generate(
                                                                                          dashboardprovider.filterListModel!.educationLevels!.length,
                                                                                          (index) => Container(
                                                                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r), border: Border.all(color: Color(0xFF2A2627).withOpacity(0.10), width: 1.0.h)),
                                                                                                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                                                                                                margin: EdgeInsets.all(3),
                                                                                                child: Text(
                                                                                                  dashboardprovider.filterListModel!.educationLevels!.elementAt(index).name,
                                                                                                  style: TextStyle(color: Color(0xFF2A2627).withOpacity(0.10), fontSize: 20.sp, fontFamily: "Avenir Heavy", fontWeight: FontWeight.w500),
                                                                                                ),
                                                                                              )),
                                                                                    ),
                                                                                  ],
                                                                                )
                                                                              : Container(),
                                                                          SizedBox(
                                                                            height:
                                                                                20.h,
                                                                          ),
                                                                          dashboardprovider.filterListModel!.introvertOrExtroverts!.isNotEmpty
                                                                              ? Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  mainAxisSize: MainAxisSize.min,
                                                                                  children: [
                                                                                    Text(
                                                                                      AppLocalizations.of(context)!.introextro,
                                                                                      style: TextStyle(color: Color(0xFF2A2627).withOpacity(0.10), fontSize: 20.sp, fontFamily: "Avenir Black", fontWeight: FontWeight.w500),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 10.h,
                                                                                    ),
                                                                                    Wrap(
                                                                                      children: List.generate(
                                                                                          dashboardprovider.filterListModel!.introvertOrExtroverts!.length,
                                                                                          (index) => Container(
                                                                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r), border: Border.all(color: Color(0xFF2A2627).withOpacity(0.10), width: 1.0.h)),
                                                                                                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                                                                                                margin: EdgeInsets.all(3),
                                                                                                child: Text(
                                                                                                  dashboardprovider.filterListModel!.introvertOrExtroverts!.elementAt(index).name,
                                                                                                  style: TextStyle(color: Color(0xFF2A2627).withOpacity(0.10), fontSize: 20.sp, fontFamily: "Avenir Heavy", fontWeight: FontWeight.w500),
                                                                                                ),
                                                                                              )),
                                                                                    ),
                                                                                  ],
                                                                                )
                                                                              : Container(),
                                                                          SizedBox(
                                                                            height:
                                                                                20.h,
                                                                          ),
                                                                          dashboardprovider.filterListModel!.starSigns!.isNotEmpty
                                                                              ? Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  mainAxisSize: MainAxisSize.min,
                                                                                  children: [
                                                                                    Text(
                                                                                      AppLocalizations.of(context)!.starsign,
                                                                                      style: TextStyle(color: Color(0xFF2A2627).withOpacity(0.10), fontSize: 20.sp, fontFamily: "Avenir Black", fontWeight: FontWeight.w500),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 10.h,
                                                                                    ),
                                                                                    Wrap(
                                                                                      children: List.generate(
                                                                                          dashboardprovider.filterListModel!.starSigns!.length,
                                                                                          (index) => Container(
                                                                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r), border: Border.all(color: Color(0xFF2A2627).withOpacity(0.10), width: 1.0.h)),
                                                                                                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                                                                                                margin: EdgeInsets.all(3),
                                                                                                child: Text(
                                                                                                  dashboardprovider.filterListModel!.starSigns!.elementAt(index).name,
                                                                                                  style: TextStyle(color: Color(0xFF2A2627).withOpacity(0.10), fontSize: 20.sp, fontFamily: "Avenir Heavy", fontWeight: FontWeight.w500),
                                                                                                ),
                                                                                              )),
                                                                                    ),
                                                                                  ],
                                                                                )
                                                                              : Container(),
                                                                          SizedBox(
                                                                            height:
                                                                                20.h,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    )
                                                                  : Container()),
                                                    ],
                                                  ),
                                            SizedBox(
                                              height: 40.h,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                if (searchController
                                                    .text.isNotEmpty) {
                                                  var dashboardProvider =
                                                      Provider.of<
                                                              DashboardProvider>(
                                                          context,
                                                          listen: false);
                                                  dashboardProvider.noUserdata =
                                                      false;
                                                  dashboardProvider
                                                      .resetStreams();
                                                  if (preferences!.getString(
                                                          "accesstoken") !=
                                                      null) {
                                                    int page = 1;
                                                    int limit = 20;
                                                    dashboardProvider
                                                        .fetchSearcUserList(
                                                            preferences!
                                                                .getString(
                                                                    "accesstoken")
                                                                .toString(),
                                                            searchController
                                                                .text,
                                                            page,
                                                            limit);
                                                    dashboardProvider.addUser();
                                                  }
                                                } else {
                                                  var dashboardProvider =
                                                      Provider.of<
                                                              DashboardProvider>(
                                                          context,
                                                          listen: false);
                                                  dashboardProvider.noUserdata =
                                                      false;
                                                  dashboardProvider
                                                      .resetStreams();
                                                  if (preferences!.getString(
                                                          "accesstoken") !=
                                                      null) {
                                                    dashboardProvider
                                                        .clearCurrentCard();
                                                    cardDeck = [];
                                                    dashboardProvider
                                                        .fetchUserList(
                                                            preferences!
                                                                .getString(
                                                                    "accesstoken")
                                                                .toString(),
                                                            1,
                                                            20,
                                                            startag,
                                                            endag,
                                                            datewith,
                                                            isPremium,
                                                            type,
                                                            search,
                                                            maritals,
                                                            looking_fors,
                                                            sexual_orientation,
                                                            startheigh,
                                                            endheigh,
                                                            do_you_drink,
                                                            do_you_smoke,
                                                            feel_about_kids,
                                                            education,
                                                            introvert_or_extrovert,
                                                            star_sign,
                                                            have_pets,
                                                            religion,
                                                            languageList
                                                                .toString()
                                                                .replaceAll(
                                                                    "[", "")
                                                                .replaceAll(
                                                                    "]", ""),
                                                            "0")
                                                        .whenComplete(() {
                                                      swipeItemInit(
                                                          dashboardProvider);
                                                    });
                                                    dashboardProvider.addUser();
                                                  }
                                                }
                                                Navigator.of(context).pop();
                                              },
                                              child: Align(
                                                alignment: Alignment.topCenter,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25.r),
                                                      border: Border.all(
                                                          color:
                                                              Colorss.mainColor,
                                                          width: 2)),
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 10.h,
                                                      horizontal: 25.w),
                                                  child: addSemiBoldText(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .apply,
                                                      16,
                                                      Colorss.mainColor),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 40.h,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  })),
            ));
  }

  bool likeuser = false;
  @override
  void dispose() {
    //  WidgetsBinding.instance.removeObserver(this);
    print("ajsgdjhasgdas");
    super.dispose();
  }

  // @override
  // Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
  //   print("state");
  //   print(state);
  //   if (state == AppLifecycleState.resumed) {
  //     print("this ap iss resumes");
  //     // var dashboardProvider =
  //     //     Provider.of<DashboardProvider>(context, listen: false);
  //     // dashboardProvider.noUserdata = false;
  //     // dashboardProvider.resetStreams();
  //     // dashboardProvider.fetchUserList(
  //     //     preferences!.getString("accesstoken").toString(),
  //     //     1,
  //     //     20,
  //     //     startag,
  //     //     endag,
  //     //     datewith,
  //     //     isPremium,
  //     //     type,
  //     //     search,
  //     //     maritals,
  //     //     looking_fors,
  //     //     sexual_orientation,
  //     //     startheigh,
  //     //     endheigh,
  //     //     do_you_drink,
  //     //     do_you_smoke,
  //     //     feel_about_kids,
  //     //     education,
  //     //     introvert_or_extrovert,
  //     //     star_sign,
  //     //     have_pets,
  //     //     religion,
  //     //     languageList.toString().replaceAll("[", "").replaceAll("]", ""),
  //     //     "");
  //     //dashboardProvider.addUser();
  //     print("ajsgdjhasgdas===");
  //   } else if (state == AppLifecycleState.paused) {
  //     var dashboardProvider =
  //         Provider.of<DashboardProvider>(context, listen: false);
  //     // dashboardProvider.noUserdata = false;
  //     // dashboardProvider.resetStreams();
  //     // dashboardProvider.fetchUserList(
  //     //     preferences!.getString("accesstoken").toString(),
  //     //     1,
  //     //     20,
  //     //     startag,
  //     //     endag,
  //     //     datewith,
  //     //     isPremium,
  //     //     type,
  //     //     search,
  //     //     maritals,
  //     //     looking_fors,
  //     //     sexual_orientation,
  //     //     startheigh,
  //     //     endheigh,
  //     //     do_you_drink,
  //     //     do_you_smoke,
  //     //     feel_about_kids,
  //     //     education,
  //     //     introvert_or_extrovert,
  //     //     star_sign,
  //     //     have_pets,
  //     //     religion,
  //     //     languageList.toString().replaceAll("[", "").replaceAll("]", ""),
  //     //     "");
  //     dashboardProvider.addUser();
  //     print("ajsgdjhasgdas===dsdgsd");
  //   } else if (state == AppLifecycleState.detached) {
  //     print("ajsgdjhasgdas===dsdgsdabcd");
  //   } else if (state == AppLifecycleState.inactive) {
  //     print("ajsgdjhasgdas===dsdgsdabcd===");
  //   } else if (state == AppLifecycleState.values) {
  //     print("ajsgdjhasgdas===dsdgsdabcd===");
  //   }
  // }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        // leadingWidth: MediaQuery.of(context).size.width * 0.5,
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                Get.to(ProfileScreen());
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClipOval(
                      child: (profileprovider
                                      ?.profiledetails?.data?.profile_image ??
                                  "")
                              .isEmpty
                          ? CircleAvatar(
                              radius: 25,
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
                                radius: 25.0,
                              ),
                            )),
                  SizedBox(width: 7.w),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        "assets/images/moorky2.png",
                        width: 75.w,
                        height: 25.h,
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Hey, ',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.black),
                            ),
                            TextSpan(
                              text:
                                  profileprovider?.profiledetails?.data?.name ??
                                      "",
                              style: TextStyle(
                                  fontSize: 12, color: Color(0xff6A00C1)),
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              )
              // SvgPicture.asset(
              //   "assets/images/profile.svg",
              //   fit: BoxFit.scaleDown,
              //   height: 45.h,
              //   width: 45.w,
              // )
              ),
        ),
        leadingWidth: 0,
        // title: Container(
        //     alignment: Alignment.center,
        //     margin: EdgeInsets.only(top: 10.h),
        //     child: Image.asset(
        //       "assets/images/moorky2.png",
        //       fit: BoxFit.scaleDown,
        //       height: 60.h,
        //       width: 100.w,
        //     )),

        actions: [
          // IconButton(
          //   iconSize: 35.r,
          //   padding: EdgeInsets.zero,
          //   onPressed: () {
          //     Get.to(Notification_Type_Screen());
          //   },
          //   icon: Icon(
          //     Icons.notifications_active_outlined,
          //     color: Color(0xFF6B00C3),
          //   ),
          // ),
          // IconButton(
          //   iconSize: 45,
          //   padding: EdgeInsets.zero,
          //   onPressed: () async {
          //     var profileProvider =
          //         Provider.of<ProfileProvider>(context, listen: false);
          //     await filterbottemsheet(context, profileProvider);
          //   },
          //   icon: SvgPicture.asset(
          //     "assets/images/drawer.svg",
          //     fit: BoxFit.scaleDown,
          //     height: 45.h,
          //     width: 45.w,
          //   ),
          // ),
          InkWell(
            onTap: () async {
              if (usertype.toString() != "normal") {
                if (userId != "") {
                  var dashboardprovider =
                      Provider.of<DashboardProvider>(context, listen: false);

                  if (dashboardprovider.undo_count == 1) {
                    var bool = await DashboardRepository.userUndo(
                        preferences!.getString("accesstoken").toString(),
                        userId);
                    if (bool) {
                      if (preferences!.getString("accesstoken") != null) {
                        dashboardprovider.resetStreams();
                        dashboardprovider.clearCurrentCard();
                        cardDeck = [];
                        dashboardprovider
                            .fetchUserList(
                                preferences!
                                    .getString("accesstoken")
                                    .toString(),
                                1,
                                20,
                                startag,
                                endag,
                                datewith,
                                isPremium,
                                type,
                                search,
                                maritals,
                                looking_fors,
                                sexual_orientation,
                                startheigh,
                                endheigh,
                                do_you_drink,
                                do_you_smoke,
                                feel_about_kids,
                                education,
                                introvert_or_extrovert,
                                star_sign,
                                have_pets,
                                religion,
                                languageList
                                    .toString()
                                    .replaceAll("[", "")
                                    .replaceAll("]", ""),
                                "0")
                            .whenComplete(() {
                          swipeItemInit(dashboardprovider);
                        });
                        dashboardprovider.addUser();
                      }
                    }
                  }
                }
              } else {
                Get.to(Premium_Screen());
              }
            },
            child: Container(
              height: 40.h,
              width: 40.w,
              padding: EdgeInsets.all(7),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage("assets/images/button_bg.png"),
                  )),
              child: Image.asset(
                "assets/images/undo.png",
                height: 18.h,
                width: 15.w,
              ),
            ),
          ),
          SizedBox(
            width: 7.w,
          ),
          InkWell(
            onTap: () {
              Get.to(Notification_Type_Screen());
            },
            child: Container(
              height: 40.h,
              width: 40.w,
              padding: EdgeInsets.all(7),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage("assets/images/button_bg.png"),
                  )),
              child: Image.asset(
                "assets/images/notification_icon.png",
                height: 18.h,
                width: 15.w,
              ),
            ),
          ),
          SizedBox(
            width: 7.w,
          ),
          InkWell(
            onTap: () async {
              var profileProvider =
                  Provider.of<ProfileProvider>(context, listen: false);
              await filterbottemsheet(context, profileProvider);
            },
            child: Container(
              height: 40.h,
              width: 40.w,
              padding: EdgeInsets.all(7),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage("assets/images/button_bg.png"),
                  )),
              child: Image.asset(
                "assets/images/filter_icon.png",
                height: 18.h,
                width: 15.w,
              ),
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
        ],
      ),
      body: Container(
          alignment: Alignment.center,
          child:
              Consumer<DashboardProvider>(builder: (context, newDash, child) {
            swipeItemInit(newDash);
            return !newDash.noUserdata
                ? newDash.userModelList.isNotEmpty
                    ? newDash.userModelList.isNotEmpty || cardDeck.isNotEmpty
                        ? Container(
                            height: MediaQuery.of(context).size.height * 0.8,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50)),
                            child:

              SwipingCardDeck(
              cardDeck: cardDeck,
              onDeckEmpty: () async {
                await DeckEmptyInit();
              },
              onLeftSwipe: (Card card, List<Card> cardDeck,
                  int cardsSwiped) async {
                newDash.scrollUp();
                newDash.updateCurrentCard(cardsSwiped);
                var profileprovider =
                Provider.of<ProfileProvider>(context,
                    listen: false);
                if (profileprovider?.user_type == "normal") {
// if (profileprovider?.swipecount < 100) {
// print("newDash.userModelList.length");

                  if (cardDeck.isEmpty ||
                      cardDeck.length <= 1) {
                    DeckEmptyInit();
                  } else {
                    userId = (newDash.userModelList
                        .elementAt(cardsSwiped - 1)
                        .id ??
                        "0")
                        .toString();
                    profileprovider?.flag = true;
                  }
// showLoader(context);

                  var isdislike =
                  await DashboardRepository.userdislike(
                      preferences!
                          .getString("accesstoken")!,
                      newDash.userModelList
                          .elementAt(cardsSwiped - 1)
                          .id
                          .toString());
                  if (isdislike.statusCode == 200) {
                    profileprovider?.swipecount =
                        isdislike.swipeCount;
                    if (cardDeck.isEmpty) {
                      await DeckEmptyInit();
                    }
                  }
// } else {
//   profileprovider?.flag = false;
//   Get.to(Premium_Screen());
// }
                } else {
                  userId = newDash.userModelList
                      .elementAt(cardsSwiped - 1)
                      .id
                      .toString();

                  profileprovider?.flag = true;
//showLoader(context);
                  var isdislike =
                  await DashboardRepository.userdislike(
                      preferences!
                          .getString("accesstoken")!,
                      newDash.userModelList
                          .elementAt(cardsSwiped - 1)
                          .id
                          .toString());
                  if (isdislike.statusCode == 200) {
                    if (cardDeck.isEmpty) {
                      await DeckEmptyInit();
                    }
                  }
                }
//newDash.updateCurrentCard();

//   newDash.removeUserFromDeck(cardsSwiped-1);
              },
              onRightSwipe: (Card card, List<Card> cardDeck,
                  int cardsSwiped) async {
                newDash.updateCurrentCard(cardsSwiped);
                newDash.scrollUp();
//newDash.updateCurrentCard();
//  newDash.removeUserFromDeck(cardsSwiped-1);
                var profileprovider =
                Provider.of<ProfileProvider>(context,
                    listen: false);
                if (profileprovider.user_type == "normal") {
                  if ((profileprovider.swipecount) < 20) {
                    userId = newDash.userModelList
                        .elementAt(cardsSwiped - 1)
                        .id
                        .toString();
                    profileprovider.flag = true;
//showLoader(context);
                    var islike =
                    await DashboardRepository.userlike(
                        preferences!
                            .getString("accesstoken")!,
                        newDash.userModelList
                            .elementAt(cardsSwiped - 1)
                            .id
                            .toString(),
                        "0");
                    if (islike.statusCode == 200) {
                      profileprovider.swipecount =
                          islike.swipeCount;

                      if (cardDeck.isEmpty) {
                        await DeckEmptyInit();
                      }
                    }
                  } else {
//Navigator.of(context).pop();
                    profileprovider.flag = false;
                    Get.to(Premium_Screen());
                  }
                } else {
                  userId = newDash.userModelList
                      .elementAt(cardsSwiped - 1)
                      .id
                      .toString();
                  profileprovider.flag = true;
//showLoader(context);
                  var islike =
                  await DashboardRepository.userlike(
                      preferences!
                          .getString("accesstoken")!,
                      newDash.userModelList
                          .elementAt(cardsSwiped - 1)
                          .id
                          .toString(),
                      "0");
                  if (islike.statusCode == 200) {
                    if (cardDeck.isEmpty) {
                      await DeckEmptyInit();
                    }
                  }
                }
              },
              cardWidth:
              MediaQuery.of(context).size.width * 0.85,
              swipeThreshold:
              MediaQuery.of(context).size.width / 3,
              minimumVelocity: 500,
              rotationFactor: 0.8 / 3.14,
              swipeAnimationDuration:
              const Duration(milliseconds: 100),
            )
                          )
                        : cardDeck.isEmpty
                            ? Center(
                                child: Column(
                                  children: [
                                    Text(
                                        "${AppLocalizations.of(context)!.nouserfound} 😔"),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.18,
                                      child: Column(
                                        children: [
                                          Container(
                                            alignment: Alignment.center,
                                            child: GestureDetector(
                                                onTap: () async {
                                                  var dashboardProvider =
                                                      Provider.of<
                                                              DashboardProvider>(
                                                          context,
                                                          listen: false);
                                                  dashboardProvider.noUserdata =
                                                      false;
                                                  dashboardProvider
                                                      .resetStreams();
                                                  dashboardProvider
                                                      .clearCurrentCard();
                                                  cardDeck = [];

                                                  cardDeck = [];
                                                  dashboardProvider
                                                      .fetchUserList(
                                                          preferences!
                                                              .getString(
                                                                  "accesstoken")
                                                              .toString(),
                                                          1,
                                                          20,
                                                          startag,
                                                          endag,
                                                          datewith,
                                                          isPremium,
                                                          type,
                                                          search,
                                                          maritals,
                                                          looking_fors,
                                                          sexual_orientation,
                                                          startheigh,
                                                          endheigh,
                                                          do_you_drink,
                                                          do_you_smoke,
                                                          feel_about_kids,
                                                          education,
                                                          introvert_or_extrovert,
                                                          star_sign,
                                                          have_pets,
                                                          religion,
                                                          languageList
                                                              .toString()
                                                              .replaceAll(
                                                                  "[", "")
                                                              .replaceAll(
                                                                  "]", ""),
                                                          "1")
                                                      .whenComplete(() {
                                                    swipeItemInit(newDash);
                                                  });
                                                  dashboardProvider.addUser();
                                                },
                                                child: SvgPicture.asset(
                                                    "assets/images/refresh.svg")),
                                          ),
                                          Container(
                                              alignment: Alignment.center,
                                              child: Divider(
                                                  height: 0,
                                                  thickness: 1.5,
                                                  color: Color(0xFFB73969)))
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : Center(
                                child: Column(
                                  children: [
                                    Text(
                                        "${AppLocalizations.of(context)!.nouserfound} 😔"),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.18,
                                      child: Column(
                                        children: [
                                          Container(
                                            alignment: Alignment.center,
                                            child: GestureDetector(
                                                onTap: () async {
                                                  var dashboardProvider =
                                                      Provider.of<
                                                              DashboardProvider>(
                                                          context,
                                                          listen: false);
                                                  dashboardProvider.noUserdata =
                                                      false;
                                                  dashboardProvider
                                                      .resetStreams();
                                                  dashboardProvider
                                                      .clearCurrentCard();
                                                  cardDeck = [];

                                                  cardDeck = [];
                                                  dashboardProvider
                                                      .fetchUserList(
                                                          preferences!
                                                              .getString(
                                                                  "accesstoken")
                                                              .toString(),
                                                          1,
                                                          20,
                                                          startag,
                                                          endag,
                                                          datewith,
                                                          isPremium,
                                                          type,
                                                          search,
                                                          maritals,
                                                          looking_fors,
                                                          sexual_orientation,
                                                          startheigh,
                                                          endheigh,
                                                          do_you_drink,
                                                          do_you_smoke,
                                                          feel_about_kids,
                                                          education,
                                                          introvert_or_extrovert,
                                                          star_sign,
                                                          have_pets,
                                                          religion,
                                                          languageList
                                                              .toString()
                                                              .replaceAll(
                                                                  "[", "")
                                                              .replaceAll(
                                                                  "]", ""),
                                                          "1")
                                                      .whenComplete(() {
                                                    swipeItemInit(newDash);
                                                  });
                                                  dashboardProvider.addUser();
                                                },
                                                child: SvgPicture.asset(
                                                    "assets/images/refresh.svg")),
                                          ),
                                          Container(
                                              alignment: Alignment.center,
                                              child: Divider(
                                                  height: 0,
                                                  thickness: 1.5,
                                                  color: Color(0xFFB73969)))
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                    : Center(
                        child: CircularProgressIndicator(),
                      )
                : Center(
                    child: InkWell(
                      onTap: () async {
                        var dashboardProvider = Provider.of<DashboardProvider>(
                            context,
                            listen: false);
                        dashboardProvider.noUserdata = false;
                        dashboardProvider.resetStreams();
                        dashboardProvider.clearCurrentCard();
                        cardDeck = [];
                        cardDeck = [];
                        dashboardProvider
                            .fetchUserList(
                                preferences!
                                    .getString("accesstoken")
                                    .toString(),
                                1,
                                20,
                                startag,
                                endag,
                                datewith,
                                isPremium,
                                type,
                                search,
                                maritals,
                                looking_fors,
                                sexual_orientation,
                                startheigh,
                                endheigh,
                                do_you_drink,
                                do_you_smoke,
                                feel_about_kids,
                                education,
                                introvert_or_extrovert,
                                star_sign,
                                have_pets,
                                religion,
                                languageList
                                    .toString()
                                    .replaceAll("[", "")
                                    .replaceAll("]", ""),
                                "1")
                            .whenComplete(() {
                          swipeItemInit(newDash);
                        });
                        dashboardProvider.addUser();
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  child: SvgPicture.asset(
                                      "assets/images/refresh.svg"),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              addMediumText(
                                  AppLocalizations.of(context)!.refresh,
                                  18.sp,
                                  Colorss.mainColor),
                              SizedBox(
                                width: 5,
                              ),
                              SvgPicture.asset("assets/images/refreshic.svg")
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
          })),
    );
  }

}
