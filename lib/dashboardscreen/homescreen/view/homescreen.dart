import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:moorky/commanWidget/commanwidget.dart';
import 'package:moorky/dashboardscreen/provider/dashboardprovider.dart';
import 'package:moorky/dashboardscreen/repository/dashboardrepository.dart';
import 'package:moorky/premiumscreen/view/premiumscreen.dart';
import 'package:moorky/profilecreate/provider/profileprovider.dart';
import 'package:moorky/profiledetailscreen/view/profiledetailscreen.dart';
import 'package:moorky/profilescreen/view/profilescreen.dart';
import 'package:moorky/settingscreen/Swipecard.dart';
import 'package:moorky/settingscreen/view/notification_type_screen.dart';
import 'package:moorky/zegocloud/peer/peer_chat_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  bool left = false;
  bool right = false;

  SfRangeValues _values = SfRangeValues(18.0, 100.0);
  SfRangeValues _heightvalues = SfRangeValues(140.0, 150.0);

  bool _switchValue = false;
  double startage = 18.0;
  double endage= 100.0;
  String userId = "";

  double startheight = 130.0;
  double endheight = 270.0;
  bool isPremiums = true;

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
  TextEditingController searchController = new TextEditingController();
  int count = 0;

  String city = '';
  String state = '';
  String country = '';
  String longitude = '';
  String latitude = '';
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    Init();
    super.initState();
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
    city = '${place.locality} ${place.subLocality} ${place.subAdministrativeArea} ${place.name} ${place.postalCode}';
    state = '${place.locality}';
    country = '${place.country}';
    setState(() {});
  }

  Init() async {
    preferences = await SharedPreferences.getInstance();
    Position position = await _getGeoLocationPosition();
    print(position.longitude);
    print(position.latitude);
    latitude = position.latitude.toString();
    longitude = position.longitude.toString();
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];

    setState(() {
      city = '${place.locality} ${place.subLocality} ${place.subAdministrativeArea} ${place.name} ${place.postalCode}';
      state = '${place.administrativeArea}';
      country = '${place.country}';
    });
    print(city);
    print(state);
    print(country);
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

    var profileprovider = Provider.of<ProfileProvider>(context, listen: false);
    profileprovider.resetStreams();
    profileprovider
        .fetchProfileDetails(preferences!.getString("accesstoken").toString());
    var dashboardprovider =
        Provider.of<DashboardProvider>(context, listen: false);
    dashboardprovider.resetStreams();
    dashboardprovider.resetFilter();
    dashboardprovider
        .fetchFilterList(preferences!.getString("accesstoken").toString());

    setState(() {
      if (profileprovider.start_tall_are_you != "") {
        _heightvalues = SfRangeValues(
            double.parse(profileprovider.start_tall_are_you), 150.0);
        startheight = double.parse(profileprovider.start_tall_are_you);
        startheigh = profileprovider.start_tall_are_you;
      }
      if (profileprovider.end_tall_are_you != "") {
        _heightvalues = SfRangeValues(
            130.0, double.parse(profileprovider.end_tall_are_you));
        endheight = double.parse(profileprovider.end_tall_are_you);
        endheigh = profileprovider.end_tall_are_you;
      }

      if (profileprovider.end_tall_are_you != "" &&
          profileprovider.start_tall_are_you != "") {
        _heightvalues = SfRangeValues(
            double.parse(profileprovider.start_tall_are_you),
            double.parse(profileprovider.end_tall_are_you));
        endheight = double.parse(profileprovider.end_tall_are_you);
        startheight = double.parse(profileprovider.start_tall_are_you);
        startheigh = profileprovider.start_tall_are_you;
        endheigh = profileprovider.end_tall_are_you;
      }

      if (profileprovider.age_from != "") {
        _values = SfRangeValues(double.parse(profileprovider.age_from), 30.0);
        startage = double.parse(profileprovider.age_from);
        startag = profileprovider.age_from;
      }
      if (profileprovider.age_to != "") {
        _values = SfRangeValues(130.0, double.parse(profileprovider.age_to));
        endage = double.parse(profileprovider.age_to);
        endag = profileprovider.age_to;
      }

      if (profileprovider.age_from != "" && profileprovider.age_to != "") {
        _values = SfRangeValues(double.parse(profileprovider.age_from),
            double.parse(profileprovider.age_to));
        startage = double.parse(profileprovider.age_from);
        startag = profileprovider.age_from;
        endage = double.parse(profileprovider.age_to);
        endag = profileprovider.age_to;
      }

      datewith = profileprovider.datewith;
      isPremium = profileprovider.only_premium_member;
      if (profileprovider.only_premium_member == "0") {
        _switchValue = false;
      } else if (profileprovider.only_premium_member == "1") {
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
      maritals = profileprovider.maritals;

      looking_fors = profileprovider.looking_fors;
      sexual_orientation = profileprovider.sexual_orientation;
      do_you_drink = profileprovider.do_you_drink;
      do_you_smoke = profileprovider.do_you_smoke;
      feel_about_kids = profileprovider.feel_about_kids;
      education = profileprovider.educationfilter;
      introvert_or_extrovert = profileprovider.introvert_or_extrovert;
      star_sign = profileprovider.star_sign;
      have_pets = profileprovider.have_pets;
      religion = profileprovider.religionfilter;
      languageList = profileprovider.languages;
      usertype = profileprovider.user_type;
      directchatcount = profileprovider.direct_chat_count;
      profileimage = profileprovider.profileImage;
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
        dashboardprovider.fetchUserList(
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
            refresh);
      });
    }
  }

  DeckEmptyInit() async {
    print("asdasdasd sdasdasdasd");
    preferences = await SharedPreferences.getInstance();
    var dashboardprovider =
        Provider.of<DashboardProvider>(context, listen: false);
    dashboardprovider.resetStreams();
    var profileprovider = Provider.of<ProfileProvider>(context, listen: false);
    setState(() {
      usertype = profileprovider.user_type;
      directchatcount = profileprovider.direct_chat_count;
      profileimage = profileprovider.profileImage;
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
      dashboardprovider.fetchUserList(
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
          refresh);
      // profileprovider.fetchProfileDetails(
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
                          FocusScope.of(context).requestFocus(new FocusNode());
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
                                          } else {
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
                                              dashboardProvider.fetchUserList(
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
                                                  "0");
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
                                              _values = SfRangeValues(18.0, 100);
                                              startheight = 130.0;
                                              endheight = 270.0;
                                              _heightvalues =
                                                  SfRangeValues(130.0, 270);
                                              isPremium = "";
                                              datewith =
                                                  profileProvider.datewith;
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
                                                dashboardProvider.fetchUserList(
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
                                                    "0");
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
                                                    child: addMediumText(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .showonlypremium,
                                                        14,
                                                        Colorss.mainColor),
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.60),
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
                                    (profileProvider.user_type.toString() ==
                                                "normal" ||
                                            profileProvider.user_type
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
                                                    child: addRegularText(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .getabetterresult,
                                                        10,
                                                        Colorss.mainColor),
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.50,
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
                                            profileProvider.profiledetails?.data?.user_plan.toString() ==
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
                                                                          dashboardprovider.filterListModel!.feelAboutKids!.length > 0
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
                                                                          dashboardprovider.filterListModel!.smokeOptions!.length > 0
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
                                                                          dashboardprovider.filterListModel!.languages!.length > 0
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
                                                                          dashboardprovider.filterListModel!.drinkOptions!.length > 0
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
                                                                          dashboardprovider.filterListModel!.religions!.length > 0
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
                                                                          dashboardprovider.filterListModel!.havePets!.length > 0
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
                                                                          dashboardprovider.filterListModel!.sexualOrientations!.length > 0
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
                                                                          dashboardprovider.filterListModel!.educationLevels!.length > 0
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
                                                                          dashboardprovider.filterListModel!.introvertOrExtroverts!.length > 0
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
                                                                          dashboardprovider.filterListModel!.starSigns!.length > 0
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
                                                                          dashboardprovider.filterListModel!.feelAboutKids!.length > 0
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
                                                                          dashboardprovider.filterListModel!.smokeOptions!.length > 0
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
                                                                          dashboardprovider.filterListModel!.languages!.length > 0
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
                                                                          dashboardprovider.filterListModel!.drinkOptions!.length > 0
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
                                                                          dashboardprovider.filterListModel!.religions!.length > 0
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
                                                                          dashboardprovider.filterListModel!.havePets!.length > 0
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
                                                                          dashboardprovider.filterListModel!.sexualOrientations!.length > 0
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
                                                                          dashboardprovider.filterListModel!.educationLevels!.length > 0
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
                                                                          dashboardprovider.filterListModel!.introvertOrExtroverts!.length > 0
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
                                                                          dashboardprovider.filterListModel!.starSigns!.length > 0
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
                                                    dashboardProvider.fetchUserList(
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
                                                        "0");
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
    WidgetsBinding.instance.removeObserver(this);
    print("ajsgdjhasgdas");
    super.dispose();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    print("state");
    print(state);
    if (state == AppLifecycleState.resumed) {
      print("this ap iss resumes");
      var dashboardProvider =
          Provider.of<DashboardProvider>(context, listen: false);
      dashboardProvider.noUserdata = false;
      dashboardProvider.resetStreams();
      dashboardProvider.fetchUserList(
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
          "");
      dashboardProvider.addUser();
      print("ajsgdjhasgdas===");
    } else if (state == AppLifecycleState.paused) {
      var dashboardProvider =
          Provider.of<DashboardProvider>(context, listen: false);
      dashboardProvider.noUserdata = false;
      dashboardProvider.resetStreams();
      dashboardProvider.fetchUserList(
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
          "");
      dashboardProvider.addUser();
      print("ajsgdjhasgdas===dsdgsd");
    } else if (state == AppLifecycleState.detached) {
      print("ajsgdjhasgdas===dsdgsdabcd");
    } else if (state == AppLifecycleState.inactive) {
      print("ajsgdjhasgdas===dsdgsdabcd===");
    } else if (state == AppLifecycleState.values) {
      print("ajsgdjhasgdas===dsdgsdabcd===");
    }
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<LocaleProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: MediaQuery.of(context).size.width * 0.27,
        title: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 10.h),
            child: Image.asset(
              "assets/images/moorky2.png",
              fit: BoxFit.scaleDown,
              height: 60.h,
              width: 100.w,
            )),
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  Get.to(ProfileScreen());
                },
                child: SvgPicture.asset(
                  "assets/images/profile.svg",
                  fit: BoxFit.scaleDown,
                  height: 45.h,
                  width: 45.w,
                )),
            SizedBox(
              width: 10.w,
            ),
            usertype.toString() != "normal"
                ? GestureDetector(
                    onTap: () async {
                      if (userId != "") {
                        var dashboardprovider = Provider.of<DashboardProvider>(
                            context,
                            listen: false);
                        print("dashboardprovider.undo_count");
                        print(dashboardprovider.undo_count);
                        if (dashboardprovider.undo_count == 1) {
                          var bool = await DashboardRepository.userUndo(
                              preferences!.getString("accesstoken").toString(),
                              userId);
                          if (bool) {
                            if (preferences!.getString("accesstoken") != null) {
                              dashboardprovider.resetStreams();
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
                                  "0");
                              dashboardprovider.addUser();
                            }
                          }
                        }
                      }
                    },
                    child: SvgPicture.asset(
                      "assets/images/undo.svg",
                      fit: BoxFit.scaleDown,
                      height: 45.h,
                      width: 45.w,
                    ))
                : GestureDetector(
                    onTap: () {
                      Get.to(Premium_Screen());
                    },
                    child: SvgPicture.asset(
                      "assets/images/undo.svg",
                      fit: BoxFit.scaleDown,
                      height: 45.h,
                      width: 45.w,
                    )),
          ],
        ),
        actions: [
          IconButton(
            iconSize: 35.r,
            padding: EdgeInsets.zero,
            onPressed: () {
              Get.to(Notification_Type_Screen());
            },
            icon: Icon(
              Icons.notifications_active_outlined,
              color: Color(0xFF6B00C3),
            ),
          ),
          IconButton(
            iconSize: 45,
            padding: EdgeInsets.zero,
            onPressed: () async {
              var profileProvider =
                  Provider.of<ProfileProvider>(context, listen: false);
              await filterbottemsheet(context, profileProvider);
            },
            icon: SvgPicture.asset(
              "assets/images/drawer.svg",
              fit: BoxFit.scaleDown,
              height: 45.h,
              width: 45.w,
            ),
          ),
        ],
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.center,
          child: Consumer<DashboardProvider>(
              builder: (context, dashboardprovider, child) {
            return !dashboardprovider.noUserdata
                ? dashboardprovider.userModelList.isNotEmpty
                    ? dashboardprovider.userModelList.length > 0
                        ? SwipingCardDeck(
                            cardDeck: List<Card>.generate(
                                dashboardprovider.userModelList.length,
                                (index) {
                              return Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                child: Stack(
                                  alignment: Alignment.topCenter,
                                  children: [
                                    ClipRRect(
                                      child: dashboardprovider.userModelList
                                                  .elementAt(index)
                                                  .profile_image !=
                                              ""
                                          ? CachedNetworkImage(
                                              fit: dashboardprovider.userModelList.elementAt(index).is_ghost!
                                                  ? BoxFit.contain
                                                  : BoxFit.cover,
                                              imageUrl: dashboardprovider.userModelList.elementAt(index).profile_image.toString(),
                                              height: dashboardprovider
                                                      .userModelList
                                                      .elementAt(index)
                                                      .is_ghost!
                                                  ? MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.75
                                                  : MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.75,
                                              width: dashboardprovider
                                                      .userModelList
                                                      .elementAt(index)
                                                      .is_ghost!
                                                  ? MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.50
                                                  : MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.85,
                                              progressIndicatorBuilder:
                                                  (context, url,
                                                          downloadProgress) =>
                                                      Container(
                                                child:
                                                    CircularProgressIndicator(
                                                        value: downloadProgress
                                                            .progress),
                                                alignment: Alignment.center,
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
                                            )
                                          : Image.asset(
                                              "assets/images/imgavtar.png",
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.75,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.85,
                                              fit: BoxFit.fill,
                                            ),
                                      borderRadius: BorderRadius.circular(43),
                                    ),
                                    Container(
                                      width: 250,
                                      height: 8,
                                      alignment: Alignment.topCenter,
                                      margin: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                    ),
                                    Image.asset(
                                      "assets/images/aboverect.png",
                                      fit: BoxFit.fill,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.75,
                                      width: MediaQuery.of(context).size.width *
                                          0.85,
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      child: Container(
                                        alignment: Alignment.bottomCenter,
                                        margin: EdgeInsets.symmetric(
                                            vertical: 25.h, horizontal: 25.w),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.55,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  dashboardprovider
                                                          .userModelList
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
                                                  dashboardprovider
                                                          .userModelList
                                                          .elementAt(index)
                                                          .hide_my_location!
                                                      ? Container()
                                                      : (dashboardprovider
                                                                      .userModelList
                                                                      .elementAt(
                                                                          index)
                                                                      .city !=
                                                                  "" &&
                                                              dashboardprovider
                                                                      .userModelList
                                                                      .elementAt(
                                                                          index)
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
                                                  dashboardprovider
                                                              .userModelList
                                                              .elementAt(index)
                                                              .lookingFor !=
                                                          ""
                                                      ? Container(
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              color: Color(
                                                                  0xFFa3a3a3)),
                                                          height: 20,
                                                          width: 100,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              SvgPicture
                                                                  .network(
                                                                dashboardprovider
                                                                    .userModelList
                                                                    .elementAt(
                                                                        index)
                                                                    .looking_for_icon,
                                                                fit: BoxFit
                                                                    .scaleDown,
                                                                height: 8,
                                                                width: 8,
                                                                color: Colors
                                                                    .white,
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
                                            Row(
                                              children: [
                                                directchatcount != 0
                                                    ? InkWell(
                                                        splashColor:
                                                            Colors.transparent,
                                                        focusColor:
                                                            Colors.transparent,
                                                        hoverColor:
                                                            Colors.transparent,
                                                        highlightColor:
                                                            Colors.transparent,
                                                        child: SvgPicture.asset(
                                                          "assets/images/send.svg",
                                                          height: 40.h,
                                                          width: 40.w,
                                                        ),
                                                        onTap: () {
                                                          dashboardprovider
                                                              .chatreset();
                                                          Get.to(PeerChatPage(
                                                            conversationID:
                                                                dashboardprovider
                                                                    .userModelList
                                                                    .elementAt(
                                                                        index)
                                                                    .id
                                                                    .toString(),
                                                            conversationName:
                                                                dashboardprovider
                                                                    .userModelList
                                                                    .elementAt(
                                                                        index)
                                                                    .name
                                                                    .toString(),
                                                            conversationImage:
                                                                dashboardprovider
                                                                    .userModelList
                                                                    .elementAt(
                                                                        index)
                                                                    .profile_image
                                                                    .toString(),
                                                            senderImage:
                                                                profileimage,
                                                          ));
                                                        },
                                                      )
                                                    : Container(),
                                                SizedBox(
                                                  width: 10.w,
                                                ),
                                                InkWell(
                                                  splashColor:
                                                      Colors.transparent,
                                                  focusColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  child: SvgPicture.asset(
                                                    "assets/images/profiledetails.svg",
                                                    height: 40.h,
                                                    width: 40.w,
                                                  ),
                                                  onTap: () {
                                                    print(
                                                        "in click ptofilr detail");
                                                    var profileprovider =
                                                        Provider.of<
                                                                ProfileProvider>(
                                                            context,
                                                            listen: false);
                                                    profileprovider
                                                        .UserProfileInit();
                                                    Get.to(ProfileDetailScreen(
                                                      user_id: dashboardprovider
                                                          .userModelList
                                                          .elementAt(index)
                                                          .id
                                                          .toString(),
                                                      isSelf: false,
                                                      isLike: false,
                                                      isSearch: false,
                                                      search: search,
                                                      introvert_or_extrovert:
                                                          introvert_or_extrovert,
                                                      isPremium: isPremium,
                                                      sexual_orientation:
                                                          sexual_orientation,
                                                      star_sign: star_sign,
                                                      startag: startag,
                                                      startheigh: startheigh,
                                                      refresh: refresh,
                                                      religion: religion,
                                                      have_pets: have_pets,
                                                      education: education,
                                                      endag: endag,
                                                      endheigh: endheigh,
                                                      datewith: datewith,
                                                      directchatcount:
                                                          directchatcount,
                                                      do_you_drink:
                                                          do_you_drink,
                                                      do_you_smoke:
                                                          do_you_smoke,
                                                      feel_about_kids:
                                                          feel_about_kids,
                                                      languageList:
                                                          languageList,
                                                      languages: languages,
                                                      looking_fors:
                                                          looking_fors,
                                                      maritals: maritals,
                                                      profileimage:
                                                          profileimage,
                                                      type: type,
                                                      userIndex: userIndex,
                                                      usertype: usertype,
                                                    ));
                                                  },
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                            onDeckEmpty: () async {
                              //sawait DeckEmptyInit();
                            },
                            onLeftSwipe: (Card card, List<Card> cardDeck,
                                int cardsSwiped) async {
                              print("cardDeck.length");
                              print(cardDeck.length);
                              var profileprovider =
                                  Provider.of<ProfileProvider>(context,
                                      listen: false);
                              if (profileprovider.user_type == "normal") {
                                // if (profileprovider.swipecount < 100) {
                                userId = dashboardprovider.userModelList
                                    .elementAt(cardsSwiped - 1)
                                    .id
                                    .toString();
                                profileprovider.flag = true;
                                // showLoader(context);
                                var isdislike =
                                    await DashboardRepository.userdislike(
                                        preferences!.getString("accesstoken")!,
                                        dashboardprovider.userModelList
                                            .elementAt(cardsSwiped - 1)
                                            .id
                                            .toString());
                                if (isdislike.statusCode == 200) {
                                  profileprovider.swipecount =
                                      isdislike.swipeCount;
                                  if (cardDeck.isEmpty) {
                                    await DeckEmptyInit();
                                  }
                                }
                                // } else {
                                //   profileprovider.flag = false;
                                //   Get.to(Premium_Screen());
                                // }
                              } else {
                                print("profileprovider.user_type");
                                print(profileprovider.user_type);
                                userId = dashboardprovider.userModelList
                                    .elementAt(cardsSwiped - 1)
                                    .id
                                    .toString();
                                print(userId);
                                print("userId===hhdhd");
                                profileprovider.flag = true;
                                //showLoader(context);
                                var isdislike =
                                    await DashboardRepository.userdislike(
                                        preferences!.getString("accesstoken")!,
                                        dashboardprovider.userModelList
                                            .elementAt(cardsSwiped - 1)
                                            .id
                                            .toString());
                                if (isdislike.statusCode == 200) {
                                  if (cardDeck.isEmpty) {
                                    await DeckEmptyInit();
                                  }
                                }
                              }
                            },
                            onRightSwipe: (Card card, List<Card> cardDeck,
                                int cardsSwiped) async {
                              var profileprovider =
                                  Provider.of<ProfileProvider>(context,
                                      listen: false);
                              if (profileprovider.user_type == "normal") {
                                if (profileprovider.swipecount < 20) {
                                  userId = dashboardprovider.userModelList
                                      .elementAt(cardsSwiped - 1)
                                      .id
                                      .toString();
                                  profileprovider.flag = true;
                                  //showLoader(context);
                                  var islike =
                                      await DashboardRepository.userlike(
                                          preferences!
                                              .getString("accesstoken")!,
                                          dashboardprovider.userModelList
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
                                userId = dashboardprovider.userModelList
                                    .elementAt(cardsSwiped - 1)
                                    .id
                                    .toString();
                                profileprovider.flag = true;
                                //showLoader(context);
                                var islike = await DashboardRepository.userlike(
                                    preferences!.getString("accesstoken")!,
                                    dashboardprovider.userModelList
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
                            cardWidth: MediaQuery.of(context).size.width * 0.85,
                            swipeThreshold:
                                MediaQuery.of(context).size.width / 3,
                            minimumVelocity: 500,
                            rotationFactor: 0.8 / 3.14,
                            swipeAnimationDuration:
                                const Duration(milliseconds: 100),
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.18,
                                  child: Column(
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        child: GestureDetector(
                                            onTap: () async {
                                              var dashboardProvider = Provider.of<DashboardProvider>(
                                                      context,
                                                      listen: false);
                                              dashboardProvider.noUserdata =
                                                  false;
                                              dashboardProvider.resetStreams();
                                              dashboardProvider.fetchUserList(
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
                                                  "1");
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
                        dashboardProvider.fetchUserList(
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
                            languageList
                                .toString()
                                .replaceAll("[", "")
                                .replaceAll("]", ""),
                            "1");
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
