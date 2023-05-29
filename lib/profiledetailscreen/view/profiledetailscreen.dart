import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moorky/commanWidget/commanwidget.dart';
import 'package:moorky/dashboardscreen/provider/dashboardprovider.dart';
import 'package:moorky/dashboardscreen/repository/dashboardrepository.dart';
import 'package:moorky/dashboardscreen/view/dashboardscreen.dart';
import 'package:moorky/premiumscreen/view/premiumscreen.dart';
import 'package:moorky/profilecreate/provider/profileprovider.dart';
import 'package:moorky/profilecreate/repository/profileRepository.dart';
import 'package:moorky/profiledetailscreen/model/aboutme_model.dart';
import 'package:moorky/profiledetailscreen/view/writeyourreport_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:moorky/constant/color.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../dashboardscreen/homescreen/view/homescreen.dart';

class ProfileDetailScreen extends StatefulWidget {
  String user_id="";
  bool isSelf=false;
      bool isLike=false;
  bool isSearch=false;
  final String startheigh;
  final String endheigh;

  final String startag;
  final String endag;

  final String isPremium;
  final String datewith;


  final String type;
  final String search;


  final String maritals;
  final String looking_fors;


  final String sexual_orientation;
  final String do_you_drink;
  final String do_you_smoke;
  final String feel_about_kids;
  final String education;
  final String introvert_or_extrovert;
  final String star_sign;
  final String have_pets;
  final String religion;
  final String refresh;


  final String userIndex;
  final String languageList;
  final String languages;
  final String usertype;
  final int directchatcount;
  final String profileimage;
  ProfileDetailScreen(
      {
        required this.user_id,
        required this.isSelf,
        required this.isLike,
        required this.isSearch,
        this.startheigh="",
        this.endheigh="",
        this.startag="",
        this.endag="",
        this.isPremium="",
        this.datewith="",
        this.type="all",
        this.search="",
        this.maritals="",
        this.looking_fors="",
        this.sexual_orientation="",
        this.do_you_drink="",
        this.do_you_smoke="",
        this.feel_about_kids="",
        this.education="",
        this.introvert_or_extrovert="",
        this.star_sign="",
        this.have_pets="",
        this.religion="",
        this.userIndex="",
        this.languageList="",
        this.languages="",
        this.usertype="",
        this.directchatcount=0,
        this.profileimage="",
        this.refresh="",
      });
  @override
  State<ProfileDetailScreen> createState() => _ProfileDetailScreenState();
}

class _ProfileDetailScreenState extends State<ProfileDetailScreen> {
  double _initFabHeight = 120.0;
  double _fabHeight = 0;
  double _panelHeightOpen = 0;
  double _panelHeightClosed = 0;
  List<String> images = <String>[];
  String usertype = "";
  final  _imageController = PageController();
  int index = 0;
  int qindex = 0;
  bool isdrag=true;
  SharedPreferences? preferences;
  int count = 0;
  Aboutme_Model? aboutme_model;
  List<dynamic> aboutmelist = <dynamic>[];
  @override
  void initState() {
    _fabHeight = _initFabHeight;
    Init();
    super.initState();
  }

  void Init() async {
    print("widget.user_id");
    print(widget.user_id);
    preferences = await SharedPreferences.getInstance();

    var profileprovider = Provider.of<ProfileProvider>(context, listen: false);
    profileprovider.iniresetuser();
    if (preferences!.getString("accesstoken") != null) {
      print(preferences!.getString("accesstoken").toString());
      profileprovider.fetchUserProfileDetails(
          preferences!.getString("accesstoken").toString(), widget.user_id);
      profileprovider.fetchUserReportReason(
          preferences!.getString("accesstoken").toString());
    }
    if (preferences!.getString("usertype") != null) {
      usertype = preferences!.getString("usertype")!.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    _panelHeightOpen = MediaQuery.of(context).size.height * 0.95;
    _panelHeightClosed = MediaQuery.of(context).size.height * 0.40;
    aboutmelist = [];
    return Scaffold(
        appBar: AppBar(
          leading: InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                print(!widget.isSelf);
                if (widget.isSearch) {
                  print("fasfasfasf");
                  Navigator.pop(context);
                } else {
                  if (widget.isLike) {
                    print("fasfasfasf==");
                    Navigator.pop(context);
                  } else {
                    print("sfsfsfsfsfsfsf");
                    Get.back();
                  }
                }
              },
              child: SvgPicture.asset(
                "assets/images/arrowback.svg",
                fit: BoxFit.scaleDown,
              )),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Consumer<ProfileProvider>(
            builder: (context, profileProvider, child) {
          if (profileProvider.userprofiledetails?.data != null) {
            if (profileProvider.userprofiledetails!.data!.distance == "") {
              profileProvider.userprofiledetails!.data!.distance = 0;
            }
            for (int i = 0;
                i < profileProvider.userprofiledetails!.data!.images!.length;
                i++) {
              if (profileProvider.userprofiledetails!.data!.images!
                      .elementAt(i)
                      .image !=
                  "") {
                print(profileProvider.userprofiledetails!.data!.images!
                    .elementAt(i)
                    .image);
                if (count == 0) {
                  images.add(profileProvider.userprofiledetails!.data!.images!
                      .elementAt(i)
                      .image);
                }
              }
            }
            count++;
          }
          if (profileProvider.userprofiledetails?.data != null) {
            print(aboutmelist);
            print(profileProvider.userprofiledetails!.data!.hideMyAge);
            print(profileProvider
                .userprofiledetails!.data!.userQuestions!.length);
            var data = profileProvider.userprofiledetails!.data!;
            if (data.sexualOrientation != "") {
              aboutme_model = Aboutme_Model(
                  icon: data.sexual_orientation_icon,
                  name: data.sexualOrientation);
              aboutmelist.add(aboutme_model!.toJson());
            }
            if (data.tallAreYou != "") {
              aboutme_model = Aboutme_Model(
                  icon: data.tall_are_you_icon, name: data.tallAreYou);
              aboutmelist.add(aboutme_model!.toJson());
            }
            if (data.school != "") {
              aboutme_model =
                  Aboutme_Model(icon: data.school_icon, name: data.school);
              aboutmelist.add(aboutme_model!.toJson());
            }
            if (data.jobTitle != "") {
              aboutme_model =
                  Aboutme_Model(icon: data.job_title_icon, name: data.jobTitle);
              aboutmelist.add(aboutme_model!.toJson());
            }
            if (data.companyName != "") {
              aboutme_model = Aboutme_Model(
                  icon: data.company_name_icon, name: data.companyName);
              aboutmelist.add(aboutme_model!.toJson());
            }
            if (data.doYouDrink != "") {
              aboutme_model = Aboutme_Model(
                  icon: data.do_you_smoke_icon, name: data.doYouDrink);
              aboutmelist.add(aboutme_model!.toJson());
            }
            if (data.doYouSmoke != "") {
              aboutme_model = Aboutme_Model(
                  icon: data.do_you_smoke_icon, name: data.doYouSmoke);
              aboutmelist.add(aboutme_model!.toJson());
            }
            if (data.feelAboutKids != "") {
              aboutme_model = Aboutme_Model(
                  icon: data.feel_about_kids_icon, name: data.feelAboutKids);
              aboutmelist.add(aboutme_model!.toJson());
            }
            if (data.education != "") {
              aboutme_model = Aboutme_Model(
                  icon: data.education_icon, name: data.education);
              aboutmelist.add(aboutme_model!.toJson());
            }
            if (data.introvertOrExtrovert != "") {
              aboutme_model = Aboutme_Model(
                  icon: data.introvert_or_extrovert_icon,
                  name: data.introvertOrExtrovert);
              aboutmelist.add(aboutme_model!.toJson());
            }
            if (data.starSign != "") {
              aboutme_model =
                  Aboutme_Model(icon: data.star_sign_icon, name: data.starSign);
              aboutmelist.add(aboutme_model!.toJson());
            }
            if (data.havePets != "") {
              aboutme_model =
                  Aboutme_Model(icon: data.have_pets_icon, name: data.havePets);
              aboutmelist.add(aboutme_model!.toJson());
            }
            if (data.religion != "") {
              aboutme_model = Aboutme_Model(
                  icon: data.religion_icon, name: data.sexualOrientation);
              aboutmelist.add(aboutme_model!.toJson());
            }
          }

          return profileProvider.userprofiledetails?.data != null
              ? SlidingUpPanel(
                  maxHeight: _panelHeightOpen,
                  minHeight: _panelHeightClosed,
                  parallaxEnabled: true,
                  parallaxOffset: .5,
                  isDraggable: isdrag,
                  controller: PanelController(),
                  panelBuilder: (sc) => MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: ListView(
                        controller: sc,
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        children: [
                          SizedBox(
                            height: 20.h,
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              height: 5.h,
                              width: 40.w,
                              decoration: BoxDecoration(
                                  color: Colorss.mainColor,
                                  borderRadius:
                                      BorderRadius.circular(5.r)),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Padding(
                            padding: EdgeInsets.all(20.r),
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                profileProvider.userprofiledetails!
                                        .data!.hideMyAge!
                                    ? addBoldText(
                                        '${profileProvider.userprofiledetails!.data!.name}',
                                        16,
                                        Colorss.mainColor)
                                    : addBoldText(
                                        '${profileProvider.userprofiledetails!.data!.name}, ${profileProvider.userprofiledetails!.data!.age}',
                                        16,
                                        Colorss.mainColor),
                                profileProvider.userprofiledetails!
                                        .data!.hideMyLocation
                                    ? Container()
                                    : SizedBox(
                                        height: 5.h,
                                      ),
                                profileProvider.userprofiledetails!
                                        .data!.hideMyLocation
                                    ? Container()
                                    : addLightText(
                                        '${AppLocalizations.of(context)!.from} ${profileProvider.userprofiledetails!.data!.city} ${AppLocalizations.of(context)!.region} (${double.parse(profileProvider.userprofiledetails!.data!.distance.toString()).toStringAsFixed(2)} ${AppLocalizations.of(context)!.kmaway})',
                                        12,
                                        Colorss.mainColor),
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
                                addSemiBoldText(
                                    "${AppLocalizations.of(context)!.aboutme}",
                                    13,
                                    Colorss.mainColor),
                                SizedBox(
                                  height: 5.h,
                                ),
                                profileProvider.userprofiledetails!
                                            .data!.biography !=
                                        ""
                                    ? addLightText(
                                        '${profileProvider.userprofiledetails!.data!.biography}',
                                        11,
                                        Colorss.mainColor)
                                    : Container(),
                                SizedBox(
                                  height: 15.h,
                                ),
                                aboutmelist.isNotEmpty
                                    ? Wrap(
                                        children: List.generate(
                                            aboutmelist.length,
                                            (index) => Container(
                                                height: 40.h,
                                                padding:
                                                    EdgeInsets.all(2.r),
                                                margin:
                                                    EdgeInsets.all(5.r),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                20.r)),
                                                    border: Border.all(
                                                        color: Colorss
                                                            .mainColor,
                                                        width: 1)),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .center,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    SizedBox(
                                                      width: 10.w,
                                                    ),
                                                    SvgPicture.network(
                                                      aboutmelist[index]
                                                          ['icon'],
                                                      fit: BoxFit
                                                          .scaleDown,
                                                      height: 20.h,
                                                      width: 20.w,
                                                    ),
                                                    SizedBox(
                                                      width: 10.w,
                                                    ),
                                                    addCenterRegularText(
                                                        aboutmelist[
                                                                index]
                                                            ['name'],
                                                        11,
                                                        Colorss
                                                            .mainColor),
                                                    SizedBox(
                                                      width: 10.w,
                                                    ),
                                                  ],
                                                ))),
                                      )
                                    : Container(),
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
                                addSemiBoldText(
                                    "${profileProvider.userprofiledetails!.data!.name} ${AppLocalizations.of(context)!.photos}",
                                    13,
                                    Colorss.mainColor),
                              ],
                            ),
                          ),
                          images.isNotEmpty
                              ?
                                Container(
                                  height: MediaQuery.of(context)
                                      .size
                                      .height *
                                      0.50,
                                  child: PageView.builder(
                            controller: _imageController,
                            physics: ScrollPhysics(),
                            onPageChanged: (i){
                              setState(() {
                                index=i;
                              });
                                  },
                            itemCount: images.length,
                            itemBuilder: (context, i) => CachedNetworkImage(
                                  imageUrl: images
                                      .elementAt(index)
                                      .toString(),
                                  height: MediaQuery.of(context)
                                      .size
                                      .height *
                                      0.50,
                                  width:
                                  MediaQuery.of(context).size.width,
                                  fit: BoxFit.cover,
                                  progressIndicatorBuilder: (context,
                                      url, downloadProgress) =>
                                      Container(
                                        child: CircularProgressIndicator(
                                            value:
                                            downloadProgress.progress),
                                        alignment: Alignment.center,
                                      ),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                            ),
                          ),
                                )
                              : Container(),
                          images.length > 1
                              ? images.isNotEmpty
                                  ? Align(
                                      alignment: Alignment.topCenter,
                                      child: Container(
                                        width: 250.w,
                                        child: SfSlider(
                                          max: images.length - 1,
                                          value: index,
                                          thumbIcon: Center(
                                              child: Icon(
                                            Icons.circle,
                                            color: Colors.white,
                                            size: 12,
                                          )),
                                          inactiveColor:
                                              Color(0xFFD3ACF5),
                                          interval: 1,
                                          showTicks: false,
                                          showLabels: false,
                                          minorTicksPerInterval: 1,
                                          activeColor:
                                              Colorss.mainColor,
                                          onChanged: (value) {
                                            setState(() {
                                              index = value.toInt();
                                              print(index);
                                            });
                                          },
                                          onChangeEnd: (value) {
                                            print(value);
                                          },
                                        ),
                                      ),
                                    )
                                  : Container()
                              : Container(),
                          profileProvider.userprofiledetails!.data!
                                      .lookingFor !=
                                  ""
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
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.w),
                                      child: Row(
                                        children: [
                                          SvgPicture.network(
                                            profileProvider
                                                .userprofiledetails!
                                                .data!
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
                                              AppLocalizations.of(
                                                      context)!
                                                  .lookingfor,
                                              13,
                                              Color(0xFFB38AE0)),
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          addLightText(
                                              "${profileProvider.userprofiledetails!.data!.lookingFor}",
                                              13,
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
                          Divider(
                            height: 1,
                            thickness: 0.5,
                            color: Color(0xFF6B00C3),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          profileProvider.userprofiledetails!.data!
                                      .interests!.length >
                                  0
                              ? Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20.r),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      addSemiBoldText(
                                          AppLocalizations.of(context)!
                                              .interset,
                                          13,
                                          Colorss.mainColor),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Wrap(
                                        children: List.generate(
                                            profileProvider
                                                .userprofiledetails!
                                                .data!
                                                .interests!
                                                .length,
                                            (index) => !(profileProvider
                                                    .userprofiledetails!
                                                    .data!
                                                    .interests!
                                                    .elementAt(index)
                                                    .intrestmatch!)
                                                ? Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    mainAxisSize:
                                                        MainAxisSize
                                                            .min,
                                                    children: [
                                                      Stack(
                                                        children: [
                                                          Align(
                                                            alignment:
                                                                Alignment
                                                                    .bottomCenter,
                                                            child:
                                                                Container(
                                                              height:
                                                                  40.h,
                                                              padding: EdgeInsets.symmetric(
                                                                  horizontal:
                                                                      10,
                                                                  vertical:
                                                                      5),
                                                              margin: EdgeInsets
                                                                  .all(5
                                                                      .r),
                                                              decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.all(Radius.circular(20
                                                                      .r)),
                                                                  border: Border.all(
                                                                      color: Colorss.mainColor,
                                                                      width: 1.5)),
                                                              child:
                                                                  Text(
                                                                profileProvider
                                                                    .userprofiledetails!
                                                                    .data!
                                                                    .interests!
                                                                    .elementAt(index)
                                                                    .name
                                                                    .toString(),
                                                                style: GoogleFonts
                                                                    .poppins(
                                                                  textStyle: TextStyle(
                                                                      fontWeight: FontWeight.w500,
                                                                      fontSize: 18.sp,
                                                                      color: Colorss.mainColor),
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
                                                        MainAxisSize
                                                            .min,
                                                    children: [
                                                      Container(
                                                        height: 50.h,
                                                        child: Stack(
                                                          children: [
                                                            Align(
                                                              alignment:
                                                                  Alignment
                                                                      .bottomCenter,
                                                              child:
                                                                  Container(
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.all(Radius.circular(20.r)),
                                                                    color: Colorss.mainColor),
                                                                padding: EdgeInsets.symmetric(
                                                                    horizontal:
                                                                        15,
                                                                    vertical:
                                                                        5),
                                                                margin:
                                                                    EdgeInsets.all(5.r),
                                                                height:
                                                                    60.h,
                                                                child:
                                                                    Text(
                                                                  profileProvider
                                                                      .userprofiledetails!
                                                                      .data!
                                                                      .interests!
                                                                      .elementAt(index)
                                                                      .name
                                                                      .toString(),
                                                                  style:
                                                                      GoogleFonts.poppins(
                                                                    textStyle: TextStyle(
                                                                        fontWeight: FontWeight.w500,
                                                                        fontSize: 18.sp,
                                                                        color: Color(0xFFFFFFFF)),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                      borderRadius: BorderRadius.circular(500)),
                                                              child:
                                                                  CircleAvatar(
                                                                radius:
                                                                    12.r,
                                                                backgroundImage:
                                                                    CachedNetworkImageProvider(
                                                                  profileProvider
                                                                      .profileImage,
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
                          profileProvider.userprofiledetails!.data!
                                      .userQuestions!.length >
                                  0
                              ? Column(
                                  children: [
                                    Divider(
                                      thickness: 1.5.h,
                                      color: Color(0xFFD3ACF5),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.w),
                                      child: Material(
                                        elevation: 1,
                                        borderRadius:
                                            BorderRadius.circular(15.r),
                                        color: Colors.white,
                                        shadowColor: Colors.white,
                                        child: Container(
                                          width: MediaQuery.of(context)
                                              .size
                                              .width,
                                          padding: EdgeInsets.all(15.r),
                                          child: Column(
                                            mainAxisSize:
                                                MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .start,
                                            children: [
                                              addBoldText(
                                                  "${profileProvider.userprofiledetails!.data!.userQuestions![qindex].question!.question.toString()}",
                                                  14,
                                                  Colorss.mainColor),
                                              SizedBox(
                                                height: 15.h,
                                              ),
                                              addRegularText(
                                                  profileProvider
                                                      .userprofiledetails!
                                                      .data!
                                                      .userQuestions![
                                                          qindex]
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
                          profileProvider.userprofiledetails!.data!
                                      .userQuestions!.length >
                                  1
                              ? Align(
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                    width: 250.w,
                                    child: SfSlider(
                                      max: profileProvider
                                              .userprofiledetails!
                                              .data!
                                              .userQuestions!
                                              .length -
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
                                      onChanged: (value) {
                                        setState(() {
                                          qindex = value.toInt();
                                          print(qindex);
                                        });
                                      },
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
                          profileProvider.userprofiledetails!.data!
                                      .languages!.length >
                                  0
                              ? Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20.r),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      addSemiBoldText(
                                          AppLocalizations.of(context)!
                                              .langugaes,
                                          13,
                                          Colorss.mainColor),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Container(
                                        height: 40.h,
                                        child: ListView.builder(
                                          itemCount: profileProvider
                                              .userprofiledetails!
                                              .data!
                                              .languages!
                                              .length,
                                          shrinkWrap: true,
                                          scrollDirection:
                                              Axis.horizontal,
                                          physics: ScrollPhysics(),
                                          itemBuilder:
                                              (BuildContext context,
                                                  int index) {
                                            return Container(
                                                height: 40.h,
                                                padding:
                                                    EdgeInsets.all(2.r),
                                                margin:
                                                    EdgeInsets.all(5.r),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                20.r)),
                                                    border: Border.all(
                                                        color: Colorss
                                                            .mainColor,
                                                        width: 1)),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .center,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    SizedBox(
                                                      width: 10.w,
                                                    ),
                                                    SvgPicture.network(
                                                      profileProvider
                                                          .userprofiledetails!
                                                          .data!
                                                          .languages![
                                                              index]
                                                          .icon,
                                                      fit: BoxFit
                                                          .scaleDown,
                                                      height: 20.h,
                                                      width: 20.w,
                                                    ),
                                                    SizedBox(
                                                      width: 10.w,
                                                    ),
                                                    addCenterRegularText(
                                                        profileProvider
                                                            .userprofiledetails!
                                                            .data!
                                                            .languages![
                                                                index]
                                                            .language,
                                                        11,
                                                        Colorss
                                                            .mainColor),
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
                          Divider(
                            thickness: 1.5.h,
                            color: Color(0xFFD3ACF5),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.r, vertical: 5.h),
                            child: Column(
                              children: [
                                // Row(
                                //   children: [
                                //     SvgPicture.asset(
                                //       "assets/images/spotify.svg",
                                //       fit: BoxFit.scaleDown,
                                //     ),
                                //     SizedBox(
                                //       width: 10.w,
                                //     ),
                                //     addBoldText(
                                //         AppLocalizations.of(context)!
                                //             .spotify,
                                //         20,
                                //         Colors.black)
                                //   ],
                                // ),
                                // SizedBox(
                                //   height: 20.h,
                                // ),
                                // Container(
                                //   height: 60.h,
                                //   decoration: BoxDecoration(
                                //       borderRadius:
                                //           BorderRadius.circular(5.r),
                                //       border: Border.all(
                                //           color: Color(0xFFD3ACF5),
                                //           width: 1.0.w)),
                                //   child: Row(
                                //     children: [
                                //       SizedBox(
                                //         width: 10.w,
                                //       ),
                                //       SvgPicture.asset(
                                //         "assets/images/spotify.svg",
                                //         fit: BoxFit.scaleDown,
                                //       ),
                                //       SizedBox(
                                //         width: 10.w,
                                //       ),
                                //       addSemiBoldText(
                                //           AppLocalizations.of(context)!
                                //               .spotifyanthem,
                                //           13,
                                //           Color(0xFFD3ACF5))
                                //     ],
                                //   ),
                                // ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                !widget.isSelf
                                    ? Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment
                                                    .center,
                                            children: [
                                              GestureDetector(
                                                onTap: () async {
                                                  if (usertype ==
                                                      "normal") {
                                                    var proprovider =
                                                        Provider.of<
                                                                ProfileProvider>(
                                                            context,
                                                            listen:
                                                                false);
                                                    if (proprovider.swipecount < 20) {
                                                      var isdislike = await DashboardRepository.userdislike(preferences!.getString("accesstoken")!, widget.user_id);
                                                      if (isdislike.statusCode == 200) {
                                                        if (widget.isLike) {
                                                          var dashboardprovider = Provider.of<DashboardProvider>(context, listen: false);
                                                          dashboardprovider.resetInitStreamLike();
                                                          if (preferences!.getString("accesstoken") != null) {
                                                            dashboardprovider.fetchLikeUserList(preferences!.getString("accesstoken").toString(), 1, 20, "likes");
                                                            dashboardprovider.addUser();
                                                            Navigator.pop(context);
                                                          }
                                                        } else {
                                                          var dashboardprovider = Provider.of<DashboardProvider>(context, listen: false);
                                                          dashboardprovider.resetStreams();
                                                          if (preferences!.getString("accesstoken") !=null) {
                                                            dashboardprovider.fetchUserList(
                                                                preferences!.getString("accesstoken").toString(),
                                                                1,
                                                                20,
                                                                widget.startag,
                                                                widget.endag,
                                                                widget.datewith,
                                                                widget.isPremium,
                                                                widget.type,
                                                                widget.search,
                                                                widget.maritals,
                                                                widget.looking_fors,
                                                                widget.sexual_orientation,
                                                                widget.startheigh,
                                                                widget.endheigh,
                                                                widget.do_you_drink,
                                                                widget.do_you_smoke,
                                                                widget.feel_about_kids,
                                                                widget.education,
                                                                widget.introvert_or_extrovert,
                                                                widget.star_sign,
                                                                widget.have_pets,
                                                                widget.religion,
                                                                widget.languageList.toString().replaceAll("[", "").replaceAll("]", ""),
                                                                widget.refresh);
                                                            dashboardprovider
                                                                .addUser();
                                                            Navigator.pop(
                                                                context);
                                                          }
                                                        }
                                                      }
                                                    } else {
                                                      Navigator.pop(
                                                          context);
                                                      Get.to(
                                                          Premium_Screen());
                                                    }
                                                  } else {
                                                    var islike = await DashboardRepository
                                                        .userdislike(
                                                            preferences!
                                                                .getString(
                                                                    "accesstoken")!,
                                                            widget
                                                                .user_id);
                                                    if (islike
                                                            .statusCode ==
                                                        200) {
                                                      if (widget
                                                          .isLike) {
                                                        var dashboardprovider =
                                                            Provider.of<
                                                                    DashboardProvider>(
                                                                context,
                                                                listen:
                                                                    false);
                                                        dashboardprovider
                                                            .resetInitStreamLike();
                                                        if (preferences!
                                                                .getString(
                                                                    "accesstoken") !=
                                                            null) {
                                                          print(
                                                              "sdgfahs");
                                                          print(preferences!
                                                              .getString(
                                                                  "accesstoken"));
                                                          dashboardprovider.fetchLikeUserList(
                                                              preferences!
                                                                  .getString(
                                                                      "accesstoken")
                                                                  .toString(),
                                                              1,
                                                              20,
                                                              "likes");
                                                          dashboardprovider
                                                              .addUser();
                                                          Navigator.pop(
                                                              context);
                                                        }
                                                      } else {
                                                        var dashboardprovider =
                                                            Provider.of<
                                                                    DashboardProvider>(
                                                                context,
                                                                listen:
                                                                    false);
                                                        dashboardprovider
                                                            .resetStreams();
                                                        if (preferences!
                                                                .getString(
                                                                    "accesstoken") !=
                                                            null) {
                                                          print(
                                                              "sdgfahs");
                                                          print(preferences!
                                                              .getString(
                                                                  "accesstoken"));
                                                          dashboardprovider.fetchUserList(
                                                              preferences!.getString("accesstoken").toString(),
                                                              1,
                                                              20,
                                                              widget.startag,
                                                              widget.endag,
                                                              widget.datewith,
                                                              widget.isPremium,
                                                              widget.type,
                                                              widget.search,
                                                              widget.maritals,
                                                              widget.looking_fors,
                                                              widget.sexual_orientation,
                                                              widget.startheigh,
                                                              widget.endheigh,
                                                              widget.do_you_drink,
                                                              widget.do_you_smoke,
                                                              widget.feel_about_kids,
                                                              widget.education,
                                                              widget.introvert_or_extrovert,
                                                              widget.star_sign,
                                                              widget.have_pets,
                                                              widget.religion,
                                                              widget.languageList.toString().replaceAll("[", "").replaceAll("]", ""),
                                                              widget.refresh);
                                                          dashboardprovider
                                                              .addUser();
                                                          Navigator.pop(
                                                              context);
                                                        }
                                                      }
                                                    }
                                                  }
                                                },
                                                child: Container(
                                                  height: 60.h,
                                                  width: 60.w,
                                                  decoration:
                                                      BoxDecoration(
                                                          gradient:
                                                              LinearGradient(
                                                            begin: Alignment
                                                                .topCenter,
                                                            end: Alignment
                                                                .bottomCenter,
                                                            colors: <
                                                                Color>[
                                                              Color(
                                                                  0xFFA33BE5),
                                                              Color(
                                                                  0xFF570084),
                                                            ],
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15.r)),
                                                  alignment:
                                                      Alignment.center,
                                                  child: SvgPicture.asset(
                                                      "assets/images/cross.svg"),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 20.w,
                                              ),
                                              GestureDetector(
                                                onTap: () async {
                                                  if (usertype == "normal") {
                                                    var proprovider =
                                                        Provider.of<ProfileProvider>(context, listen: false);
                                                    if (proprovider.swipecount < 100) {
                                                      var islike = await DashboardRepository.userlike(
                                                          preferences!.getString("accesstoken")!,
                                                          widget.user_id, "1");
                                                      if (islike.statusCode == 200) {
                                                        if (widget.isLike) {
                                                          Get.off(
                                                              DashBoardScreen(pageIndex: 1,isNotification: false,));
                                                        } else {
                                                          var dashboardprovider = Provider.of<DashboardProvider>(context, listen: false);
                                                          dashboardprovider.resetStreams();
                                                          if (preferences!.getString("accesstoken") != null) {
                                                            dashboardprovider.fetchUserList(
                                                                preferences!.getString("accesstoken").toString(),
                                                                1,
                                                                20,
                                                                widget.startag,
                                                                widget.endag,
                                                                widget.datewith,
                                                                widget.isPremium,
                                                                widget.type,
                                                                widget.search,
                                                                widget.maritals,
                                                                widget.looking_fors,
                                                                widget.sexual_orientation,
                                                                widget.startheigh,
                                                                widget.endheigh,
                                                                widget.do_you_drink,
                                                                widget.do_you_smoke,
                                                                widget.feel_about_kids,
                                                                widget.education,
                                                                widget.introvert_or_extrovert,
                                                                widget.star_sign,
                                                                widget.have_pets,
                                                                widget.religion,
                                                                widget.languageList.toString().replaceAll("[", "").replaceAll("]", ""),
                                                                widget.refresh);
                                                            dashboardprovider
                                                                .addUser();
                                                            Navigator.pop(
                                                                context);
                                                          }
                                                        }
                                                      }
                                                    } else {
                                                      Navigator.pop(
                                                          context);
                                                      Get.to(
                                                          Premium_Screen());
                                                    }
                                                  } else {
                                                    var islike = await DashboardRepository.userlike(preferences!.getString("accesstoken")!, widget.user_id, "1");
                                                    if (islike.statusCode == 200) {
                                                      if (widget.isLike) {
                                                        Get.off(
                                                            DashBoardScreen(pageIndex: 1,isNotification: false,));
                                                      } else {
                                                        var dashboardprovider = Provider.of<DashboardProvider>(context, listen: false);
                                                        dashboardprovider.resetStreams();
                                                        if (preferences!.getString("accesstoken") != null) {
                                                          dashboardprovider.fetchUserList(
                                                              preferences!.getString("accesstoken").toString(),
                                                              1,
                                                              20,
                                                              widget.startag,
                                                              widget.endag,
                                                              widget.datewith,
                                                              widget.isPremium,
                                                              widget.type,
                                                              widget.search,
                                                              widget.maritals,
                                                              widget.looking_fors,
                                                              widget.sexual_orientation,
                                                              widget.startheigh,
                                                              widget.endheigh,
                                                              widget.do_you_drink,
                                                              widget.do_you_smoke,
                                                              widget.feel_about_kids,
                                                              widget.education,
                                                              widget.introvert_or_extrovert,
                                                              widget.star_sign,
                                                              widget.have_pets,
                                                              widget.religion,
                                                              widget.languageList.toString().replaceAll("[", "").replaceAll("]", ""),
                                                              widget.refresh);
                                                          dashboardprovider.addUser();
                                                          Navigator.pop(context);
                                                        }
                                                      }
                                                    }
                                                  }
                                                },
                                                child: Container(
                                                  height: 80.h,
                                                  width: 80.w,
                                                  decoration:
                                                      BoxDecoration(
                                                          gradient:
                                                              LinearGradient(
                                                            begin: Alignment
                                                                .topCenter,
                                                            end: Alignment
                                                                .bottomCenter,
                                                            colors: <
                                                                Color>[
                                                              Color(
                                                                  0xFFA33BE5),
                                                              Color(
                                                                  0xFF570084),
                                                            ],
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15.r)),
                                                  alignment:
                                                      Alignment.center,
                                                  child: SvgPicture.asset(
                                                      "assets/images/slike.svg"),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 20.w,
                                              ),
                                              GestureDetector(
                                                onTap: () async {
                                                  if (usertype == "normal") {
                                                    var proprovider = Provider.of<ProfileProvider>(context, listen: false);
                                                    if (proprovider.swipecount < 100) {
                                                      var islike = await DashboardRepository.userlike(
                                                          preferences!.getString("accesstoken")!, widget.user_id, "0");
                                                      if (islike.statusCode ==
                                                          200) {
                                                        if (widget.isLike) {
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

                                                          Get.off(
                                                              DashBoardScreen(pageIndex: 1,isNotification: false,));
                                                        } else {
                                                          var dashboardprovider = Provider.of<DashboardProvider>(context, listen: false);
                                                          dashboardprovider.resetStreams();
                                                          if (preferences!.getString("accesstoken") != null) {
                                                            dashboardprovider.fetchUserList(
                                                                preferences!.getString("accesstoken").toString(),
                                                                1,
                                                                20,
                                                                widget.startag,
                                                                widget.endag,
                                                                widget.datewith,
                                                                widget.isPremium,
                                                                widget.type,
                                                                widget.search,
                                                                widget.maritals,
                                                                widget.looking_fors,
                                                                widget.sexual_orientation,
                                                                widget.startheigh,
                                                                widget.endheigh,
                                                                widget.do_you_drink,
                                                                widget.do_you_smoke,
                                                                widget.feel_about_kids,
                                                                widget.education,
                                                                widget.introvert_or_extrovert,
                                                                widget.star_sign,
                                                                widget.have_pets,
                                                                widget.religion,
                                                                widget.languageList.toString().replaceAll("[", "").replaceAll("]", ""),
                                                                widget.refresh);
                                                            dashboardprovider
                                                                .addUser();
                                                            Navigator.pop(
                                                                context);
                                                          }
                                                        }
                                                      }
                                                    } else {
                                                      Navigator.pop(
                                                          context);
                                                      Get.to(
                                                          Premium_Screen());
                                                    }
                                                  } else {
                                                    var islike = await DashboardRepository.userlike(preferences!.getString("accesstoken")!, widget.user_id, "0");
                                                    if (islike.statusCode == 200) {
                                                      if (widget.isLike) {
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


                                                        Get.off(
                                                            DashBoardScreen(pageIndex: 1,isNotification: false,));
                                                      } else {
                                                        var dashboardprovider =
                                                            Provider.of<
                                                                    DashboardProvider>(
                                                                context,
                                                                listen:
                                                                    false);
                                                        dashboardprovider
                                                            .resetStreams();
                                                        if (preferences!
                                                                .getString(
                                                                    "accesstoken") !=
                                                            null) {
                                                          print(
                                                              "sdgfahs");
                                                          print(preferences!
                                                              .getString(
                                                                  "accesstoken"));
                                                          dashboardprovider.fetchUserList(
                                                              preferences!.getString("accesstoken").toString(),
                                                              1,
                                                              20,
                                                              widget.startag,
                                                              widget.endag,
                                                              widget.datewith,
                                                              widget.isPremium,
                                                              widget.type,
                                                              widget.search,
                                                              widget.maritals,
                                                              widget.looking_fors,
                                                              widget.sexual_orientation,
                                                              widget.startheigh,
                                                              widget.endheigh,
                                                              widget.do_you_drink,
                                                              widget.do_you_smoke,
                                                              widget.feel_about_kids,
                                                              widget.education,
                                                              widget.introvert_or_extrovert,
                                                              widget.star_sign,
                                                              widget.have_pets,
                                                              widget.religion,
                                                              widget.languageList.toString().replaceAll("[", "").replaceAll("]", ""),
                                                              widget.refresh);
                                                          dashboardprovider
                                                              .addUser();
                                                          Navigator.pop(
                                                              context);
                                                        }
                                                      }
                                                    }
                                                  }
                                                },
                                                child: Container(
                                                  height: 60.h,
                                                  width: 60.w,
                                                  decoration:
                                                      BoxDecoration(
                                                          gradient:
                                                              LinearGradient(
                                                            begin: Alignment
                                                                .topCenter,
                                                            end: Alignment
                                                                .bottomCenter,
                                                            colors: <
                                                                Color>[
                                                              Color(
                                                                  0xFFA33BE5),
                                                              Color(
                                                                  0xFF570084),
                                                            ],
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15.r)),
                                                  alignment:
                                                      Alignment.center,
                                                  child: SvgPicture.asset(
                                                      "assets/images/heart.svg"),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 15.h,
                                          ),
                                          GestureDetector(
                                              onTap: () {
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (context) =>
                                                            Align(
                                                              alignment:
                                                                  Alignment
                                                                      .bottomCenter,
                                                              child:
                                                                  Container(
                                                                padding:
                                                                    EdgeInsets.symmetric(vertical: 10.h),
                                                                width: MediaQuery.of(context).size.width *
                                                                    0.80,
                                                                margin: EdgeInsets.only(
                                                                    bottom:
                                                                        30),
                                                                decoration: BoxDecoration(
                                                                    color:
                                                                        Colors.white,
                                                                    borderRadius: BorderRadius.circular(20.w)),
                                                                child:
                                                                    Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize.min,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment.center,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment.center,
                                                                  children: <
                                                                      Widget>[
                                                                    GestureDetector(
                                                                        onTap: () {
                                                                          Navigator.pop(context);
                                                                          showDialog(
                                                                              context: context,
                                                                              builder: (context) => Align(
                                                                                    alignment: Alignment.bottomCenter,
                                                                                    child: Container(
                                                                                      width: MediaQuery.of(context).size.width * 0.80,
                                                                                      margin: EdgeInsets.only(bottom: 30),
                                                                                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20.w)),
                                                                                      child: Column(
                                                                                        mainAxisSize: MainAxisSize.min,
                                                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                        children: <Widget>[
                                                                                          Container(
                                                                                            decoration: BoxDecoration(color: Color(0xFFAB60ED), borderRadius: BorderRadius.only(topRight: Radius.circular(20.w), topLeft: Radius.circular(20.w))),
                                                                                            child: Column(
                                                                                              mainAxisSize: MainAxisSize.min,
                                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                                              children: [
                                                                                                SizedBox(
                                                                                                  height: 20.h,
                                                                                                ),
                                                                                                addBlackText(AppLocalizations.of(context)!.hidethisperson, 15, Colors.white),
                                                                                                SizedBox(
                                                                                                  height: 20.h,
                                                                                                ),
                                                                                                addCenterRegularText(AppLocalizations.of(context)!.whenhideswiping, 15, Colors.white),
                                                                                                SizedBox(
                                                                                                  height: 20.h,
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                          GestureDetector(
                                                                                              onTap: () async {
                                                                                                var isReport = await ProfileRepository.userHide(preferences!.getString("accesstoken").toString(), profileProvider.userprofiledetails!.data!.id.toString());
                                                                                                if (isReport) {
                                                                                                  Navigator.of(context).pop();
                                                                                                  Get.offNamedUntil('/home', (route) => false);
                                                                                                }
                                                                                              },
                                                                                              child: addMediumText(AppLocalizations.of(context)!.hide, 15, Color(0xFF15294B))),
                                                                                          Divider(
                                                                                            thickness: 0.5,
                                                                                          ),
                                                                                          GestureDetector(
                                                                                              onTap: () {
                                                                                                Navigator.pop(context);
                                                                                                showDialog(
                                                                                                    context: context,
                                                                                                    builder: (context) => Align(
                                                                                                          alignment: Alignment.bottomCenter,
                                                                                                          child: Container(
                                                                                                            width: MediaQuery.of(context).size.width * 0.80,
                                                                                                            margin: EdgeInsets.only(bottom: 30),
                                                                                                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20.w)),
                                                                                                            child: Column(
                                                                                                              mainAxisSize: MainAxisSize.min,
                                                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                              children: <Widget>[
                                                                                                                Container(
                                                                                                                  decoration: BoxDecoration(color: Color(0xFFAB60ED), borderRadius: BorderRadius.only(topRight: Radius.circular(20.w), topLeft: Radius.circular(20.w))),
                                                                                                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                                                                                                  child: Column(
                                                                                                                    mainAxisSize: MainAxisSize.min,
                                                                                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                                                                                    children: [
                                                                                                                      SizedBox(
                                                                                                                        height: 20.h,
                                                                                                                      ),
                                                                                                                      addBlackText(AppLocalizations.of(context)!.blockreport, 14, Colors.white),
                                                                                                                      SizedBox(
                                                                                                                        height: 20.h,
                                                                                                                      ),
                                                                                                                      addCenterRegularText(AppLocalizations.of(context)!.dontwerryyourfeedback, 12, Colors.white),
                                                                                                                      SizedBox(
                                                                                                                        height: 10.h,
                                                                                                                      ),
                                                                                                                    ],
                                                                                                                  ),
                                                                                                                ),
                                                                                                                Container(
                                                                                                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                                                                                                  child: Consumer<ProfileProvider>(
                                                                                                                      builder: (context, profileprovider, child) => profileprovider.reportReasonListModel?.data != null
                                                                                                                          ? ListView.builder(
                                                                                                                              itemCount: profileprovider.reportReasonListModel!.data!.length,
                                                                                                                              shrinkWrap: true,
                                                                                                                              scrollDirection: Axis.vertical,
                                                                                                                              physics: NeverScrollableScrollPhysics(),
                                                                                                                              itemBuilder: (BuildContext context, int index) {
                                                                                                                                return GestureDetector(
                                                                                                                                    onTap: () {
                                                                                                                                      Navigator.pop(context);
                                                                                                                                      Get.to(WriteYourReport_Screen(
                                                                                                                                        reasonId: profileprovider.reportReasonListModel!.data!.elementAt(index).id.toString(),
                                                                                                                                        userId: profileProvider.userprofiledetails!.data!.id.toString(),
                                                                                                                                      ));
                                                                                                                                    },
                                                                                                                                    child: Column(
                                                                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                                                      mainAxisSize: MainAxisSize.min,
                                                                                                                                      children: [
                                                                                                                                        SizedBox(
                                                                                                                                          height: 10.h,
                                                                                                                                        ),
                                                                                                                                        addMediumText(profileprovider.reportReasonListModel!.data!.elementAt(index).reason, 12, Color(0xFF15294B)),
                                                                                                                                        Divider(
                                                                                                                                          thickness: 0.5,
                                                                                                                                        ),
                                                                                                                                      ],
                                                                                                                                    ));
                                                                                                                              },
                                                                                                                            )
                                                                                                                          : Center(
                                                                                                                              child: Text("No Reasons"),
                                                                                                                            )),
                                                                                                                ),
                                                                                                                SizedBox(
                                                                                                                  height: 10.h,
                                                                                                                ),
                                                                                                              ],
                                                                                                            ),
                                                                                                          ),
                                                                                                        ));
                                                                                              },
                                                                                              child: addMediumText(AppLocalizations.of(context)!.hidereport, 15, Color(0xFF15294B))),
                                                                                          SizedBox(
                                                                                            height: 10.h,
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ));
                                                                        },
                                                                        child: addMediumText(AppLocalizations.of(context)!.hide, 15, Color(0xFF15294B))),
                                                                    Divider(
                                                                      thickness: 0.5,
                                                                    ),
                                                                    GestureDetector(
                                                                        onTap: () {
                                                                          Navigator.pop(context);
                                                                          showDialog(
                                                                              context: context,
                                                                              builder: (context) => Align(
                                                                                    alignment: Alignment.bottomCenter,
                                                                                    child: Container(
                                                                                      width: MediaQuery.of(context).size.width * 0.80,
                                                                                      margin: EdgeInsets.only(bottom: 30),
                                                                                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20.w)),
                                                                                      child: Column(
                                                                                        mainAxisSize: MainAxisSize.min,
                                                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                        children: <Widget>[
                                                                                          Container(
                                                                                            decoration: BoxDecoration(color: Color(0xFFAB60ED), borderRadius: BorderRadius.only(topRight: Radius.circular(20.w), topLeft: Radius.circular(20.w))),
                                                                                            padding: EdgeInsets.symmetric(horizontal: 15),
                                                                                            child: Column(
                                                                                              mainAxisSize: MainAxisSize.min,
                                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                                              children: [
                                                                                                SizedBox(
                                                                                                  height: 20.h,
                                                                                                ),
                                                                                                addBlackText(AppLocalizations.of(context)!.blockreport, 14, Colors.white),
                                                                                                SizedBox(
                                                                                                  height: 20.h,
                                                                                                ),
                                                                                                addCenterRegularText(AppLocalizations.of(context)!.dontwerryyourfeedback, 12, Colors.white),
                                                                                                SizedBox(
                                                                                                  height: 10.h,
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                          Container(
                                                                                            padding: EdgeInsets.symmetric(horizontal: 15),
                                                                                            child: Consumer<ProfileProvider>(
                                                                                                builder: (context, profileprovider, child) => profileprovider.reportReasonListModel?.data != null
                                                                                                    ? ListView.builder(
                                                                                                        itemCount: profileprovider.reportReasonListModel!.data!.length,
                                                                                                        shrinkWrap: true,
                                                                                                        scrollDirection: Axis.vertical,
                                                                                                        physics: NeverScrollableScrollPhysics(),
                                                                                                        itemBuilder: (BuildContext context, int index) {
                                                                                                          return GestureDetector(
                                                                                                              onTap: () {
                                                                                                                Navigator.pop(context);
                                                                                                                Get.to(WriteYourReport_Screen(
                                                                                                                  reasonId: profileprovider.reportReasonListModel!.data!.elementAt(index).id.toString(),
                                                                                                                  userId: profileProvider.userprofiledetails!.data!.id.toString(),
                                                                                                                ));
                                                                                                              },
                                                                                                              child: Column(
                                                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                                mainAxisSize: MainAxisSize.min,
                                                                                                                children: [
                                                                                                                  SizedBox(
                                                                                                                    height: 10.h,
                                                                                                                  ),
                                                                                                                  addMediumText(profileprovider.reportReasonListModel!.data!.elementAt(index).reason, 12, Color(0xFF15294B)),
                                                                                                                  Divider(
                                                                                                                    thickness: 0.5,
                                                                                                                  ),
                                                                                                                ],
                                                                                                              ));
                                                                                                        },
                                                                                                      )
                                                                                                    : Center(
                                                                                                        child: Text("No Reasons"),
                                                                                                      )),
                                                                                          ),
                                                                                          SizedBox(
                                                                                            height: 10.h,
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ));
                                                                        },
                                                                        child: addMediumText(AppLocalizations.of(context)!.hidereport, 15, Color(0xFF15294B))),
                                                                  ],
                                                                ),
                                                              ),
                                                            ));
                                              },
                                              child: addSemiBoldText(
                                                  AppLocalizations.of(
                                                          context)!
                                                      .hidereport,
                                                  14,
                                                  Colorss.mainColor)),
                                          SizedBox(
                                            height: 70.h,
                                          ),
                                        ],
                                      )
                                    : Container(
                                        height: 50,
                                      ),
                                //SizedBox(height: 100,),
                              ],
                            ),
                          ),
                        ],
                      )),
                  body: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.topCenter,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.6,
                        width:
                        MediaQuery.of(context).size.width,
                        child: PageView.builder(
                          controller: _imageController,
                          physics: ScrollPhysics(),
                          itemCount: images.length,
                          itemBuilder: (context, i) => CachedNetworkImage(
                            imageUrl: images
                                .elementAt(i)
                                .toString(),
                            height: MediaQuery.of(context).size.height * 0.6,
                            width:
                            MediaQuery.of(context).size.width,
                            fit: BoxFit.cover,
                            progressIndicatorBuilder: (context,
                                url, downloadProgress) =>
                                Container(
                                  child: CircularProgressIndicator(
                                      value:
                                      downloadProgress.progress),
                                  alignment: Alignment.center,
                                ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                      )),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(18.0.r),
                      topRight: Radius.circular(18.0.r)),
                  onPanelSlide: (double pos) => setState(() {
                    _fabHeight = pos * (_panelHeightOpen - _panelHeightClosed) +
                        _initFabHeight;
                  }),
                )
              : Center(
                  child: CircularProgressIndicator(),
                );
        }));
  }
}
