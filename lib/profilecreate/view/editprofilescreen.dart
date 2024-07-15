import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moorky/premiumscreen/view/premiumscreen.dart';
import 'package:moorky/profilecreate/repository/profileRepository.dart';
import 'package:moorky/quizscreens/view/languages_screen.dart';
import 'package:moorky/settingscreen/view/accountscreen.dart';
import 'package:moorky/commanWidget/commanwidget.dart';
import 'package:moorky/constant/color.dart';
import 'package:moorky/profilecreate/provider/profileprovider.dart';
import 'package:moorky/profilecreate/view/biographyscreen.dart';
import 'package:moorky/profilecreate/view/interestedscreen.dart';
import 'package:moorky/profilecreate/view/lookingforscreen.dart';
import 'package:moorky/profilecreate/view/martialstatusscreen.dart';
import 'package:moorky/profilecreate/view/photoscreen.dart';
import 'package:moorky/profiledetailscreen/view/profiledetailscreen.dart';
import 'package:moorky/quizscreens/model/questionupdatemodel.dart';
import 'package:moorky/quizscreens/view/drinkscreen.dart';
import 'package:moorky/quizscreens/view/educationhavescreen.dart';
import 'package:moorky/quizscreens/view/extrovertintrovertscreen.dart';
import 'package:moorky/quizscreens/view/feelkidsscreen.dart';
import 'package:moorky/quizscreens/view/heightpickerscreen.dart';
import 'package:moorky/quizscreens/view/petscreen.dart';
import 'package:moorky/quizscreens/view/questionscreen.dart';
import 'package:moorky/quizscreens/view/religionscreen.dart';
import 'package:moorky/quizscreens/view/schoolscreen.dart';
import 'package:moorky/quizscreens/view/smokescreen.dart';
import 'package:moorky/quizscreens/view/starsignscreen.dart';
import 'package:moorky/quizscreens/view/workscreen.dart';
import 'package:moorky/quizscreens/view/sexualorientationscreen.dart';
import 'package:moorky/settingscreen/view/languagescreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'genderscreen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditprofileScreen extends StatefulWidget {
  bool viewprofile = false;
  String percentage = "";
  EditprofileScreen({required this.viewprofile, required this.percentage});
  @override
  State<EditprofileScreen> createState() => _EditprofileScreenState();
}

class _EditprofileScreenState extends State<EditprofileScreen> {
  bool _switchValue = true;
  bool _hideage = false;
  bool _hidelocation = false;
  bool isaddmoreactive = false;
  List<dynamic> questionList = [];
  SharedPreferences? preferences;
  bool questiondelete=false;
  @override
  void initState() {
    Init();
    super.initState();
  }

  void Init() async {
    preferences = await SharedPreferences.getInstance();
    var profileprovider = Provider.of<ProfileProvider>(context, listen: false);
    profileprovider.resetStreams();
    if (preferences!.getString("accesstoken") != null) {
      profileprovider.fetchProfileDetails(
          preferences!.getString("accesstoken").toString());
    }
  }
  Widget quickquizrow(ontap,icon,name){
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: ontap,
      child: Row(
        mainAxisAlignment:
        MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                  height: 26.w,
                  width: 40.w,
                  child: SvgPicture.asset(
                    icon,
                    height: 24.h,
                    width: 24.w,
                  )),
              SizedBox(
                width: 20.w,
              ),
              addRegularText(name,12,Color(0xFFAB60ED))
            ],
          ),
          SvgPicture.asset(
            "assets/images/arrowforword.svg",
            height: 15.h,
            width: 15.w,
            color: Color(0xFF828282),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: addMediumText("%${widget.percentage} ${AppLocalizations.of(context)!.complete}", 18, Colorss.mainColor),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0.5,
          leading: InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
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
              onPressed: () {
                var profileprovider = Provider.of<ProfileProvider>(context, listen: false);
                profileprovider.UserProfileInit();
                Get.to(ProfileDetailScreen(
                  user_id: "",
                  isSelf: true,
                  isLike:false,
                  isSearch: false,
                ));
              },
              icon: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: addMediumElipsText(AppLocalizations.of(context)!.preview, 12, Color(0xFF4E4B66)),
              )
            )
          ],
        ),
        bottomNavigationBar: Container(
          height: 10.h,
          alignment: Alignment.center,
          margin: EdgeInsets.only(bottom: 10.h),
          child: Container(
            height: 8.h,
            width: 140.w,
            decoration: BoxDecoration(
             // color: Color(0xFF751ACD),
                borderRadius: BorderRadius.circular(25.r)),
          ),
        ),
        body: SingleChildScrollView(

          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Consumer<ProfileProvider>(
                builder: (context, profileProvider, child) => profileProvider
                            .profiledetails?.data !=
                        null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(
                            height: 10.h,
                          ),
                          !profileProvider
                              .profiledetails!.data!.is_ghost!?
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: profileProvider
                                            .profiledetails!.data!.realImages!
                                            .elementAt(0)
                                            .image ==
                                        ""
                                    ? GestureDetector(
                                  onTap: (){
                                    Get.to(PhotoScreen(
                                      isEdit: true,
                                      imagefile1: profileProvider
                                          .profiledetails!.data!.realImages![0].image!,
                                      imagefile2: profileProvider
                                          .profiledetails!.data!.realImages![1].image!,
                                      imagefile3: profileProvider
                                          .profiledetails!.data!.realImages![2].image!,
                                      imagefile4: profileProvider
                                          .profiledetails!.data!.realImages![3].image!,
                                      imagefile5: profileProvider
                                          .profiledetails!.data!.realImages![4].image!,
                                      imagefile6: profileProvider
                                          .profiledetails!.data!.realImages![5].image!,
                                      imageid1: profileProvider
                                          .profiledetails!.data!.realImages![0].id
                                          .toString(),
                                      imageid2: profileProvider
                                          .profiledetails!.data!.realImages![1].id
                                          .toString(),
                                      imageid3: profileProvider
                                          .profiledetails!.data!.realImages![2].id
                                          .toString(),
                                      imageid4: profileProvider
                                          .profiledetails!.data!.realImages![3].id
                                          .toString(),
                                      imageid5: profileProvider
                                          .profiledetails!.data!.realImages![4].id
                                          .toString(),
                                      imageid6: profileProvider
                                          .profiledetails!.data!.realImages![5].id
                                          .toString(),
                                    ));
                                  },
                                      child: Container(
                                          height: 280.h,
                                          margin: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              color: Color(0xFFFDFAFF),
                                              borderRadius:
                                                  BorderRadius.circular(15.r),
                                              border: Border.all(
                                                  color: Colorss.mainColor,
                                                  width: 1)),
                                          child: SvgPicture.asset(
                                              "assets/images/add.svg",
                                              fit: BoxFit.scaleDown,
                                              color: Colorss.mainColor),
                                        ),
                                    )
                                    : GestureDetector(
                                  onTap: (){
                                    Get.to(PhotoScreen(
                                      isEdit: true,
                                      imagefile1: profileProvider
                                          .profiledetails!.data!.realImages![0].image!,
                                      imagefile2: profileProvider
                                          .profiledetails!.data!.realImages![1].image!,
                                      imagefile3: profileProvider
                                          .profiledetails!.data!.realImages![2].image!,
                                      imagefile4: profileProvider
                                          .profiledetails!.data!.realImages![3].image!,
                                      imagefile5: profileProvider
                                          .profiledetails!.data!.realImages![4].image!,
                                      imagefile6: profileProvider
                                          .profiledetails!.data!.realImages![5].image!,
                                      imageid1: profileProvider
                                          .profiledetails!.data!.realImages![0].id
                                          .toString(),
                                      imageid2: profileProvider
                                          .profiledetails!.data!.realImages![1].id
                                          .toString(),
                                      imageid3: profileProvider
                                          .profiledetails!.data!.realImages![2].id
                                          .toString(),
                                      imageid4: profileProvider
                                          .profiledetails!.data!.realImages![3].id
                                          .toString(),
                                      imageid5: profileProvider
                                          .profiledetails!.data!.realImages![4].id
                                          .toString(),
                                      imageid6: profileProvider
                                          .profiledetails!.data!.realImages![5].id
                                          .toString(),
                                    ));
                                  },
                                      child: Container(
                                          height: 280.h,
                                          margin: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: Color(0xFFFDFAFF),
                                            borderRadius:
                                                BorderRadius.circular(15.r),
                                          ),
                                          child: Stack(
                                            children: [
                                              Positioned.fill(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFFFDFAFF),
                                                    borderRadius:
                                                        BorderRadius.circular(15.r),
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(15.r),
                                                    child: CachedNetworkImage(
                                                      imageUrl:profileProvider
                                                          .profiledetails!
                                                          .data!
                                                          .realImages![0]
                                                          .image!,
                                                      fit: BoxFit.cover,
                                                      progressIndicatorBuilder: (context, url, downloadProgress) =>
                                                          Container(child: CircularProgressIndicator(value: downloadProgress.progress),alignment: Alignment.center,),
                                                      errorWidget: (context, url, error) => Icon(Icons.error),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                    ),
                              ),
                              Expanded(
                                  flex: 1,
                                  child: GestureDetector(
                                    onTap: (){
                                      Get.to(PhotoScreen(
                                        isEdit: true,
                                        imagefile1: profileProvider
                                            .profiledetails!.data!.realImages![0].image!,
                                        imagefile2: profileProvider
                                            .profiledetails!.data!.realImages![1].image!,
                                        imagefile3: profileProvider
                                            .profiledetails!.data!.realImages![2].image!,
                                        imagefile4: profileProvider
                                            .profiledetails!.data!.realImages![3].image!,
                                        imagefile5: profileProvider
                                            .profiledetails!.data!.realImages![4].image!,
                                        imagefile6: profileProvider
                                            .profiledetails!.data!.realImages![5].image!,
                                        imageid1: profileProvider
                                            .profiledetails!.data!.realImages![0].id
                                            .toString(),
                                        imageid2: profileProvider
                                            .profiledetails!.data!.realImages![1].id
                                            .toString(),
                                        imageid3: profileProvider
                                            .profiledetails!.data!.realImages![2].id
                                            .toString(),
                                        imageid4: profileProvider
                                            .profiledetails!.data!.realImages![3].id
                                            .toString(),
                                        imageid5: profileProvider
                                            .profiledetails!.data!.realImages![4].id
                                            .toString(),
                                        imageid6: profileProvider
                                            .profiledetails!.data!.realImages![5].id
                                            .toString(),
                                      ));
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        profileProvider
                                                    .profiledetails!.data!.realImages!
                                                    .elementAt(1)
                                                    .image ==
                                                ""
                                            ? Container(
                                                height: 130.h,
                                                margin: EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                    color: Color(0xFFFDFAFF),
                                                    borderRadius:
                                                        BorderRadius.circular(15.r),
                                                    border: Border.all(
                                                        color: Colorss.mainColor,
                                                        width: 1)),
                                                child: SvgPicture.asset(
                                                    "assets/images/add.svg",
                                                    fit: BoxFit.scaleDown,
                                                    color: Colorss.mainColor),
                                              )
                                            : Container(
                                                height: 130.h,
                                                margin: EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                  color: Color(0xFFFDFAFF),
                                                  borderRadius:
                                                      BorderRadius.circular(15.r),
                                                ),
                                                child: Stack(
                                                  children: [
                                                    Positioned.fill(
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          color: Color(0xFFFDFAFF),
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  15.r),
                                                        ),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  15.r),
                                                          child: CachedNetworkImage(
                                                            imageUrl:profileProvider
                                                                .profiledetails!
                                                                .data!
                                                                .realImages![1]
                                                                .image!,
                                                            fit: BoxFit.cover,
                                                            progressIndicatorBuilder: (context, url, downloadProgress) =>
                                                                Container(child: CircularProgressIndicator(value: downloadProgress.progress),alignment: Alignment.center,),
                                                            errorWidget: (context, url, error) => Icon(Icons.error),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                        profileProvider
                                                .profiledetails!.data!.realImages!
                                                .elementAt(2)
                                                .image!
                                                .isEmpty
                                            ? Container(
                                                height: 130.h,
                                                margin: EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                    color: Color(0xFFFDFAFF),
                                                    borderRadius:
                                                        BorderRadius.circular(15.r),
                                                    border: Border.all(
                                                        color: Colorss.mainColor,
                                                        width: 1)),
                                                child: SvgPicture.asset(
                                                    "assets/images/add.svg",
                                                    fit: BoxFit.scaleDown,
                                                    color: Colorss.mainColor),
                                              )
                                            : Container(
                                                height: 130.h,
                                                margin: EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                  color: Color(0xFFFDFAFF),
                                                  borderRadius:
                                                      BorderRadius.circular(15.r),
                                                ),
                                                child: Stack(
                                                  children: [
                                                    Positioned.fill(
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          color: Color(0xFFFDFAFF),
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  15.r),
                                                        ),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  15.r),
                                                          child: CachedNetworkImage(
                                                            imageUrl:profileProvider
                                                                .profiledetails!
                                                                .data!
                                                                .realImages![2]
                                                                .image!,
                                                            fit: BoxFit.cover,
                                                            progressIndicatorBuilder: (context, url, downloadProgress) =>
                                                                Container(child: CircularProgressIndicator(value: downloadProgress.progress),alignment: Alignment.center,),
                                                            errorWidget: (context, url, error) => Icon(Icons.error),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                      ],
                                    ),
                                  ))
                            ],
                          ):Container(),
                          !profileProvider
                              .profiledetails!.data!.is_ghost!?
                          Row(
                            children: [
                              profileProvider.profiledetails!.data!.realImages!
                                          .elementAt(3)
                                          .image ==
                                      ""
                                  ? Expanded(
                                      flex: 1,
                                      child: Container(),
                                    )
                                  : Expanded(
                                      flex: 1,
                                      child: GestureDetector(
                                        onTap: (){
                                          Get.to(PhotoScreen(
                                            isEdit: true,
                                            imagefile1: profileProvider
                                                .profiledetails!.data!.realImages![0].image!,
                                            imagefile2: profileProvider
                                                .profiledetails!.data!.realImages![1].image!,
                                            imagefile3: profileProvider
                                                .profiledetails!.data!.realImages![2].image!,
                                            imagefile4: profileProvider
                                                .profiledetails!.data!.realImages![3].image!,
                                            imagefile5: profileProvider
                                                .profiledetails!.data!.realImages![4].image!,
                                            imagefile6: profileProvider
                                                .profiledetails!.data!.realImages![5].image!,
                                            imageid1: profileProvider
                                                .profiledetails!.data!.realImages![0].id
                                                .toString(),
                                            imageid2: profileProvider
                                                .profiledetails!.data!.realImages![1].id
                                                .toString(),
                                            imageid3: profileProvider
                                                .profiledetails!.data!.realImages![2].id
                                                .toString(),
                                            imageid4: profileProvider
                                                .profiledetails!.data!.realImages![3].id
                                                .toString(),
                                            imageid5: profileProvider
                                                .profiledetails!.data!.realImages![4].id
                                                .toString(),
                                            imageid6: profileProvider
                                                .profiledetails!.data!.realImages![5].id
                                                .toString(),
                                          ));
                                        },
                                        child: Container(
                                          height: 130.h,
                                          margin: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: Color(0xFFFDFAFF),
                                            borderRadius:
                                                BorderRadius.circular(15.r),
                                          ),
                                          child: Stack(
                                            children: [
                                              Positioned.fill(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFFFDFAFF),
                                                    borderRadius:
                                                        BorderRadius.circular(15.r),
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(15.r),
                                                    child: CachedNetworkImage(
                                                      imageUrl:profileProvider
                                                          .profiledetails!
                                                          .data!
                                                          .realImages![3]
                                                          .image!,
                                                      fit: BoxFit.cover,
                                                      progressIndicatorBuilder: (context, url, downloadProgress) =>
                                                          Container(child: CircularProgressIndicator(value: downloadProgress.progress),alignment: Alignment.center,),
                                                      errorWidget: (context, url, error) => Icon(Icons.error),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                              profileProvider.profiledetails!.data!.realImages!
                                      .elementAt(4)
                                      .image!
                                      .isEmpty
                                  ? Expanded(
                                      flex: 1,
                                      child: Container(),
                                    )
                                  : Expanded(
                                      flex: 1,
                                      child: GestureDetector(
                                        onTap: (){
                                          Get.to(PhotoScreen(
                                            isEdit: true,
                                            imagefile1: profileProvider
                                                .profiledetails!.data!.realImages![0].image!,
                                            imagefile2: profileProvider
                                                .profiledetails!.data!.realImages![1].image!,
                                            imagefile3: profileProvider
                                                .profiledetails!.data!.realImages![2].image!,
                                            imagefile4: profileProvider
                                                .profiledetails!.data!.realImages![3].image!,
                                            imagefile5: profileProvider
                                                .profiledetails!.data!.realImages![4].image!,
                                            imagefile6: profileProvider
                                                .profiledetails!.data!.realImages![5].image!,
                                            imageid1: profileProvider
                                                .profiledetails!.data!.realImages![0].id
                                                .toString(),
                                            imageid2: profileProvider
                                                .profiledetails!.data!.realImages![1].id
                                                .toString(),
                                            imageid3: profileProvider
                                                .profiledetails!.data!.realImages![2].id
                                                .toString(),
                                            imageid4: profileProvider
                                                .profiledetails!.data!.realImages![3].id
                                                .toString(),
                                            imageid5: profileProvider
                                                .profiledetails!.data!.realImages![4].id
                                                .toString(),
                                            imageid6: profileProvider
                                                .profiledetails!.data!.realImages![5].id
                                                .toString(),
                                          ));
                                        },
                                        child: Container(
                                          height: 130.h,
                                          margin: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: Color(0xFFFDFAFF),
                                            borderRadius:
                                                BorderRadius.circular(15.r),
                                          ),
                                          child: Stack(
                                            children: [
                                              Positioned.fill(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFFFDFAFF),
                                                    borderRadius:
                                                        BorderRadius.circular(15.r),
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(15.r),
                                                    child: CachedNetworkImage(
                                                      imageUrl:profileProvider
                                                          .profiledetails!
                                                          .data!
                                                          .realImages![4]
                                                          .image!,
                                                      fit: BoxFit.cover,
                                                      progressIndicatorBuilder: (context, url, downloadProgress) =>
                                                          Container(child: CircularProgressIndicator(value: downloadProgress.progress),alignment: Alignment.center,),
                                                      errorWidget: (context, url, error) => Icon(Icons.error),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                              profileProvider.profiledetails!.data!.realImages!
                                          .elementAt(5)
                                          .image ==
                                      ""
                                  ? Expanded(
                                      flex: 1,
                                      child: Container(),
                                    )
                                  : Expanded(
                                      flex: 1,
                                      child: GestureDetector(
                                        onTap: (){
                                          Get.to(PhotoScreen(
                                            isEdit: true,
                                            imagefile1: profileProvider
                                                .profiledetails!.data!.realImages![0].image!,
                                            imagefile2: profileProvider
                                                .profiledetails!.data!.realImages![1].image!,
                                            imagefile3: profileProvider
                                                .profiledetails!.data!.realImages![2].image!,
                                            imagefile4: profileProvider
                                                .profiledetails!.data!.realImages![3].image!,
                                            imagefile5: profileProvider
                                                .profiledetails!.data!.realImages![4].image!,
                                            imagefile6: profileProvider
                                                .profiledetails!.data!.realImages![5].image!,
                                            imageid1: profileProvider
                                                .profiledetails!.data!.realImages![0].id
                                                .toString(),
                                            imageid2: profileProvider
                                                .profiledetails!.data!.realImages![1].id
                                                .toString(),
                                            imageid3: profileProvider
                                                .profiledetails!.data!.realImages![2].id
                                                .toString(),
                                            imageid4: profileProvider
                                                .profiledetails!.data!.realImages![3].id
                                                .toString(),
                                            imageid5: profileProvider
                                                .profiledetails!.data!.realImages![4].id
                                                .toString(),
                                            imageid6: profileProvider
                                                .profiledetails!.data!.realImages![5].id
                                                .toString(),
                                          ));
                                        },
                                        child: Container(
                                          height: 130.h,
                                          margin: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: Color(0xFFFDFAFF),
                                            borderRadius:
                                                BorderRadius.circular(15.r),
                                          ),
                                          child: Stack(
                                            children: [
                                              Positioned.fill(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFFFDFAFF),
                                                    borderRadius:
                                                        BorderRadius.circular(15.r),
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(15.r),
                                                    child: CachedNetworkImage(
                                                      imageUrl:profileProvider
                                                          .profiledetails!
                                                          .data!
                                                          .realImages![5]
                                                          .image!,
                                                      fit: BoxFit.cover,
                                                      progressIndicatorBuilder: (context, url, downloadProgress) =>
                                                          Container(child: CircularProgressIndicator(value: downloadProgress.progress),alignment: Alignment.center,),
                                                      errorWidget: (context, url, error) => Icon(Icons.error),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                            ],
                          ):
                          Container(),
                          !profileProvider
                              .profiledetails!.data!.is_ghost!?
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              Get.to(PhotoScreen(
                                isEdit: true,
                                imagefile1: profileProvider
                                    .profiledetails!.data!.realImages![0].image!,
                                imagefile2: profileProvider
                                    .profiledetails!.data!.realImages![1].image!,
                                imagefile3: profileProvider
                                    .profiledetails!.data!.realImages![2].image!,
                                imagefile4: profileProvider
                                    .profiledetails!.data!.realImages![3].image!,
                                imagefile5: profileProvider
                                    .profiledetails!.data!.realImages![4].image!,
                                imagefile6: profileProvider
                                    .profiledetails!.data!.realImages![5].image!,
                                imageid1: profileProvider
                                    .profiledetails!.data!.realImages![0].id
                                    .toString(),
                                imageid2: profileProvider
                                    .profiledetails!.data!.realImages![1].id
                                    .toString(),
                                imageid3: profileProvider
                                    .profiledetails!.data!.realImages![2].id
                                    .toString(),
                                imageid4: profileProvider
                                    .profiledetails!.data!.realImages![3].id
                                    .toString(),
                                imageid5: profileProvider
                                    .profiledetails!.data!.realImages![4].id
                                    .toString(),
                                imageid6: profileProvider
                                    .profiledetails!.data!.realImages![5].id
                                    .toString(),
                              ));
                            },
                            child: Container(
                              height: 70.h,
                              margin: EdgeInsets.only(
                                  top: 8.h, left: 8.w, right: 8.w),
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: <Color>[
                                      Color(0xFF570084),
                                      Color(0xFFA33BE5)
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(20.r)),
                              alignment: Alignment.center,
                              child: !widget.viewprofile
                                  ? addLightText(AppLocalizations.of(context)!.addmorephoto, 15, Color(0xFFFFFFFF))
                                  : addLightText(AppLocalizations.of(context)!.managephoto, 15, Color(0xFFFFFFFF))
                            ),
                          ):Container(),
                          !profileProvider
                              .profiledetails!.data!.is_ghost!?SizedBox(
                            height: 10.h,
                          ):Container(),
                          GestureDetector(
                            onTap: () {
                              Get.to(AccountScreen());
                            },
                            child: Card(
                              elevation: 0.5,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15.w, vertical: 20.h),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(width: 250.w,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          addSemiBoldText("${profileProvider.profiledetails!.data!.name}, ${profileProvider.profiledetails!.data!.age}", 16, Colorss.mainColor),
                                          SizedBox(
                                            height: 8.h,
                                          ),
                                          (profileProvider.profiledetails!.data!.city!=""&&profileProvider.profiledetails!.data!.state!="")?addRegularText("${profileProvider.profiledetails!.data!.city}, ${profileProvider.profiledetails!.data!.state},", 12, Color(0xFFAB60ED)):Container()
                                        ],
                                      ),
                                    ),
                                    SvgPicture.asset(
                                      "assets/images/arrowforword.svg",
                                      height: 15.h,
                                      width: 15.w,
                                      color: Color(0xFF828282),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(BiographyScreen(
                                isEdit: true,
                                biographytext: profileProvider
                                    .profiledetails!.data!.biography
                                    .toString(),
                              ));
                            },
                            child: Card(
                              elevation: 0.5,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15.w, vertical: 20.h),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        addSemiBoldText(AppLocalizations.of(context)!.whataboutyou, 16, Colorss.mainColor),
                                        SizedBox(
                                          height: 8.h,
                                        ),
                                        (profileProvider.profiledetails!.data!.biography!="")?
                                        SizedBox(
                                            width: Get.width*0.8,
                                            child: addRegularText("${profileProvider.profiledetails!.data!.biography}", 12, Color(0xFFAB60ED))):Container()
                                      ],
                                    ),
                                    SvgPicture.asset(
                                      "assets/images/arrowforword.svg",
                                      height: 15.h,
                                      width: 15.w,
                                      color: Color(0xFF828282),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          Card(
                            elevation: 0.5,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15.w, vertical: 20.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  addSemiBoldText(AppLocalizations.of(context)!.quickquiz, 16, Colorss.mainColor),
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  quickquizrow((){
                                    Get.to(HeightPicker(
                                      isEdit: true,
                                      distanceValue: profileProvider
                                          .profiledetails!.data!.tallAreYou
                                          .toString()
                                          .split("cm")
                                          .first,
                                      back: false,
                                    ));
                                  }, "assets/images/ruler.svg",AppLocalizations.of(context)!.height),
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  quickquizrow((){
                                    Get.to(SmokeScreen(
                                        isEdit: true,
                                        smoketext: profileProvider
                                            .profiledetails!.data!.doYouSmoke
                                            .toString(),back: false,));
                                  }, "assets/images/cigarrete.svg",AppLocalizations.of(context)!.smoke),
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  quickquizrow((){
                                    Get.to(Drink(
                                        isEdit: true,
                                        drinktext: profileProvider
                                            .profiledetails!.data!.doYouDrink
                                            .toString(),back: false,));
                                  }, "assets/images/drink.svg",AppLocalizations.of(context)!.drink),
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  quickquizrow((){
                                    Get.to(SexualOrientation(
                                      isEdit: true,
                                      sexualtext: profileProvider
                                          .profiledetails!
                                          .data!
                                          .sexualOrientation
                                          .toString(),
                                      back: false,
                                    ));
                                  }, "assets/images/sexual_orentation.svg",AppLocalizations.of(context)!.sexualorientation),
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  quickquizrow((){
                                    Get.to(School(
                                      isEdit: true,
                                      schoolText: profileProvider
                                          .profiledetails!.data!.school
                                          .toString(),back: false,
                                    ));
                                  }, "assets/images/school.svg",AppLocalizations.of(context)!.school),
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  quickquizrow((){
                                    Get.to(Work(
                                        isEdit: true,
                                        jobtitle: profileProvider
                                            .profiledetails!.data!.jobTitle
                                            .toString(),
                                        companynametext: profileProvider
                                            .profiledetails!.data!.companyName
                                            .toString(),back: false,));
                                  }, "assets/images/work.svg",AppLocalizations.of(context)!.job),
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  quickquizrow((){
                                    String languagesId="";
                                    if(profileProvider
                                        .profiledetails!.data!.languages!.length>0)
                                      {
                                        languagesId=profileProvider.profiledetails!.data!.languages!.elementAt(0).id.toString();
                                      }
                                    Get.to(LanguageListScreen(
                                        isEdit: true,
                                        langugaesId: languagesId,back: false,));
                                  }, "assets/images/languages.svg",AppLocalizations.of(context)!.langugaes),
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  quickquizrow((){
                                    Get.to(FeelkidsScreen(
                                        isEdit: true,
                                        feelkidstext: profileProvider
                                            .profiledetails!.data!.feelAboutKids
                                            .toString(),back: false,));
                                  }, "assets/images/feelkids.svg",AppLocalizations.of(context)!.kid),
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  quickquizrow((){
                                    Get.to(EducationHaveScreen(
                                        isEdit: true,
                                        educationtext: profileProvider
                                            .profiledetails!.data!.education
                                            .toString(),back: false,));
                                  }, "assets/images/educationhave.svg",AppLocalizations.of(context)!.education),
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  quickquizrow((){
                                    Get.to(ExtrovertIntrovertScreen(
                                        isEdit: true,
                                        introextrotext: profileProvider
                                            .profiledetails!
                                            .data!
                                            .introvertOrExtrovert
                                            .toString(),back: false,));
                                  }, "assets/images/extrovertintrovert.svg",AppLocalizations.of(context)!.introextro),
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  quickquizrow((){
                                    Get.to(StarSignScreen(
                                        isEdit: true,
                                        starsigntext: profileProvider
                                            .profiledetails!.data!.starSign
                                            .toString(),back: false,));
                                  }, "assets/images/starsign.svg",AppLocalizations.of(context)!.starsign),
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  quickquizrow((){
                                    Get.to(PetScreen(
                                        isEdit: true,
                                        petstext: profileProvider
                                            .profiledetails!.data!.havePets
                                            .toString(),back: false,));
                                  }, "assets/images/pet.svg",AppLocalizations.of(context)!.pets),
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  quickquizrow((){
                                    Get.to(ReligionScreen(
                                        isEdit: true,
                                        religiontext: profileProvider
                                            .profiledetails!.data!.religion
                                            .toString(),back: false,));
                                  }, "assets/images/pray.svg",AppLocalizations.of(context)!.religion),
                                  SizedBox(
                                    height: 15.h,
                                  )
                                ],
                              ),
                            ),
                          ),
                          Card(
                            elevation: 0.5,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15.w, vertical: 20.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  addSemiBoldText(AppLocalizations.of(context)!.datewith, 16, Colorss.mainColor),
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  Row(
                                    children: [
                                      profileProvider
                                          .profiledetails!.data!.dateWith
                                          .toString()=="Man"?Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20.r)),
                                            color: Colorss.mainColor),
                                        alignment: Alignment.center,
                                        height: 40.h,
                                          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                        margin: EdgeInsets.only(right: 5.w),
                                        child: addMediumText(AppLocalizations.of(context)!.man, 13, Color(0xFFFFFFFF))
                                      ):Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colorss.mainColor,
                                          width: 1.0),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20.r)),
                                        ),
                                        alignment: Alignment.center,
                                        height: 40.h,
                                          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                        margin: EdgeInsets.only(right: 5.w),
                                        child: addMediumText(AppLocalizations.of(context)!.man, 13, Colorss.mainColor)
                                      ),
                                      SizedBox(width: 2.w,),
                                      profileProvider
                                          .profiledetails!.data!.dateWith
                                          .toString()=="Woman"?Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20.r)),
                                            color: Colorss.mainColor),
                                        alignment: Alignment.center,
                                        height: 40.h,
                                          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                        margin: EdgeInsets.only(right: 5.w),
                                        child: addMediumText(AppLocalizations.of(context)!.woman, 13, Color(0xFFFFFFFF))
                                      ):Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colorss.mainColor,
                                              width: 1.0),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20.r)),
                                        ),
                                        alignment: Alignment.center,
                                        height: 40.h,
                                          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                        margin: EdgeInsets.only(right: 5.w),
                                        child: addMediumText(AppLocalizations.of(context)!.woman, 13, Colorss.mainColor)
                                      ),
                                      SizedBox(width: 2.w,),
                                      profileProvider
                                          .profiledetails!.data!.dateWith
                                          .toString()=="Everyone"?Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20.r)),
                                            color: Colorss.mainColor),
                                        alignment: Alignment.center,
                                        height: 40.h,
                                          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                        margin: EdgeInsets.only(right: 5.w),
                                        child: addMediumText(AppLocalizations.of(context)!.both, 13, Color(0xFFFFFFFF))
                                      ):Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colorss.mainColor,
                                              width: 1.0),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20.r)),
                                        ),
                                        alignment: Alignment.center,
                                        height: 40.h,
                                          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                        margin: EdgeInsets.only(right: 5.w),
                                        child: addMediumText(AppLocalizations.of(context)!.both, 13, Colorss.mainColor)
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          Card(
                            elevation: 0.5,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15.w, vertical: 20.h),
                              child: GestureDetector(
                                onTap: () {
                                  Get.to(MaritalStatus(
                                    isEdit: true,
                                    maritalStatus: profileProvider
                                        .profiledetails!.data!.maritalStatus
                                        .toString(),
                                  ));
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        addSemiBoldText(AppLocalizations.of(context)!.maritalstatus, 16, Colorss.mainColor),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        (profileProvider.profiledetails!.data!.maritalStatus!="")?addRegularText("${profileProvider.profiledetails!.data!.maritalStatus}", 12, Color(0xFFAB60ED)):Container()
                                      ],
                                    ),
                                    SvgPicture.asset(
                                      "assets/images/arrowforword.svg",
                                      height: 15.h,
                                      width: 15.w,
                                      color: Color(0xFF828282),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Card(
                            elevation: 0.5,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15.w, vertical: 20.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  addSemiBoldText(AppLocalizations.of(context)!.interset, 16, Colorss.mainColor),
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      List<String> intrestlist = <String>[];
                                      for (int i = 0;
                                          i <
                                              profileProvider.profiledetails!
                                                  .data!.interests!.length;
                                          i++) {
                                        intrestlist.add(profileProvider
                                            .profiledetails!.data!.interests!
                                            .elementAt(i)
                                            .id
                                            .toString());
                                      }
                                      print(intrestlist);

                                      Get.to(InterstedScreen(
                                        isEdit: true,
                                        intrestlist: intrestlist,
                                      ));
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        profileProvider.profiledetails!
                                            .data!.interests!.length!=0?Container(
                                          width:
                                              MediaQuery.of(context).size.width *
                                                  0.80,
                                          height: 40.h,
                                          child: ListView.builder(
                                            itemCount: profileProvider
                                                .profiledetails!
                                                .data!
                                                .interests!
                                                .length,
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            physics: ScrollPhysics(),
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                20.r)),
                                                    color: Colorss.mainColor),
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                                margin:
                                                    EdgeInsets.only(right: 5.w),
                                                child: addMediumText(profileProvider.profiledetails!
                                                    .data!.interests!
                                                    .elementAt(index)
                                                    .name
                                                    .toString().toLowerCase()=="theater"?AppLocalizations.of(context)!.theater:profileProvider.profiledetails!
                                                    .data!.interests!
                                                    .elementAt(index)
                                                    .name
                                                    .toString(), 13, Color(0xFFFFFFFF))
                                              );
                                            },
                                          ),
                                        ):Container(),
                                        SvgPicture.asset(
                                          "assets/images/arrowforword.svg",
                                          height: 15.h,
                                          width: 15.w,
                                          color: Color(0xFF828282),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Card(
                            elevation: 0.5,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15.w, vertical: 20.h),
                              child: GestureDetector(
                                onTap: () {
                                  Get.to(LookingForScreen(
                                  isEdit: true,
                                  lookingfor: profileProvider
                                      .profiledetails!.data!.lookingFor
                                      .toString(),
                                ));
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        addSemiBoldText(AppLocalizations.of(context)!.lookingfor, 16, Colorss.mainColor),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        (profileProvider.profiledetails!.data!.lookingFor!="")?Row(
                                          children: [
                                            SvgPicture.network(profileProvider
                                                .profiledetails!.data!.looking_for_icon
                                                .toString(),height: 20.h,width: 20.w,color: Color(0xFFAB60ED),),
                                            SizedBox(width: 10.w,),
                                            addRegularText("${profileProvider.profiledetails!.data!.lookingFor}", 12, Color(0xFFAB60ED))
                                          ],
                                        ):Container(),
                                      ],
                                    ),
                                    SvgPicture.asset(
                                      "assets/images/arrowforword.svg",
                                      height: 15.h,
                                      width: 15.w,
                                      color: Color(0xFF828282),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Card(
                            elevation: 0.5,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 20.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  addSemiBoldText(AppLocalizations.of(context)!.profilequestion, 16, Colorss.mainColor),
                                  SizedBox(height: 8.h,),
                                  addRegularText(AppLocalizations.of(context)!.whatmakespecial, 12, Color(0xFFAB60ED)),
                                  SizedBox(height: 15.h,),
                                  profileProvider.profiledetails!.data!.userQuestions!.length > 0?
                                      ListView.builder(
                                        itemCount: profileProvider.profiledetails!.data!.userQuestions!.length,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemBuilder: (BuildContext context, int index) {
                                          return  Container(
                                            margin: EdgeInsets.only(bottom: 10),
                                            child: Material(
                                              elevation: 1,
                                              borderRadius: BorderRadius.circular(15.r),
                                              color: Colors.white,
                                              shadowColor: Colors.white,
                                              child: Container(
                                                width: MediaQuery.of(context).size.width,
                                                padding: EdgeInsets.all(15.r),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Container(
                                                          width:MediaQuery.of(context).size.width*0.65,
                                                            child: addBoldText(profileProvider.profiledetails!.data!.userQuestions!.elementAt(index).question!.question.toString(), 14, Color(0xFF6B18C3))),
                                                        !profileProvider.profiledetails!.data!.userQuestions!.elementAt(index).isDelete! ?GestureDetector(
                                                          onTap: ()async{
                                                            setState(() {
                                                              profileProvider.profiledetails!.data!.userQuestions!.elementAt(index).isDelete=true;
                                                            });
                                                            var model=await ProfileRepository.userQuestionDelete(preferences!.getString("accesstoken").toString(),profileProvider.profiledetails!.data!.userQuestions!.elementAt(index).question!.id.toString());
                                                            if(model.statusCode==200)
                                                              {

                                                                setState(() {
                                                                  profileProvider.profiledetails!.data!.userQuestions!.elementAt(index).isDelete=false;
                                                                  profileProvider.profiledetails!.data!.userQuestions!.removeAt(index);
                                                                });
                                                                profileProvider.resetStreams();
                                                                profileProvider.adddetails(model);
                                                                print(profileProvider.profiledetails!.data!.userQuestions!.length);
                                                              }
                                                            else{
                                                              setState(() {
                                                                profileProvider.profiledetails!.data!.userQuestions!.elementAt(index).isDelete=false;
                                                              });
                                                            }
                                                          },
                                                            child: SvgPicture.asset("assets/images/editdelete.svg")):CircularProgressIndicator()
                                                      ],
                                                    ),
                                                    addRegularText(profileProvider.profiledetails!.data!.userQuestions!.elementAt(index).answer, 12, Color(0xFFAB60ED)),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ):Container(),
                                  SizedBox(height: 15.h,),
                                  GestureDetector(
                                    onTap: (){
                                      print("profileProvider.profiledetails!.data!.userQuestions!.length");
                                      print(profileProvider.profiledetails!.data!.userQuestions!.length);
                                          if (profileProvider.profiledetails!.data!
                                                  .userQuestions!.length !=
                                              0) {
                                            print("shgdjhasgdjhasd");
                                            for (int i = 0;
                                                i <
                                                    profileProvider.profiledetails!
                                                        .data!.userQuestions!.length;
                                                i++) {
                                              QuestionUpdateModel questionmodel =
                                                  QuestionUpdateModel(
                                                      question_id: profileProvider
                                                          .profiledetails!
                                                          .data!
                                                          .userQuestions!
                                                          .elementAt(i)
                                                          .questionId!
                                                          .toString(),
                                                      answer: profileProvider
                                                          .profiledetails!
                                                          .data!
                                                          .userQuestions!
                                                          .elementAt(i)
                                                          .answer!);
                                              questionList
                                                  .add(questionmodel.toJson());
                                            }
                                            Get.to(QuestionScreen(
                                              isEdit: true,
                                              questionList: questionList,back: false,));
                                          }
                                          else{
                                            print("sajhdjshadgasjhdgasjhdgasd");
                                            Get.to(QuestionScreen(
                                              isEdit: true,
                                              questionList: [],back: false,));
                                          }

                                    },
                                    child: Container(
                                      height: 90.h,
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.r),
                                          border: Border.all(color: Color(0xFFAB60ED),width: 1.w)),
                                      width: MediaQuery.of(context).size.width,
                                      alignment: Alignment.center,
                                      child: addRegularText(AppLocalizations.of(context)!.createprofilequestion, 12, Color(0xFFAB60ED)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Card(
                            elevation: 0.5,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15.w, vertical: 20.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      addSemiBoldText(AppLocalizations.of(context)!.privacy, 16, Colorss.mainColor),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Container(
                                        height: 20.h,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15.w),
                                        decoration: BoxDecoration(
                                            color: Color(0xFFA7924D),
                                            borderRadius:
                                                BorderRadius.circular(12.r)),
                                        alignment: Alignment.center,
                                        child: addBlackText(AppLocalizations.of(context)!.moorkypremi, 7, Color(0xFFFFFFFF))
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  profileProvider.profiledetails!.data!.user_plan.toString() == "premium" ?Column(
                                    children: [
                                      Container(
                                        height: 60.h,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5.r),
                                            border: Border.all(
                                                color: Color(0xFFAB60ED),
                                                width: 1.0.w)),
                                        padding: EdgeInsets.all(10.r),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                SvgPicture.asset(
                                                  "assets/images/incog.svg",
                                                  fit: BoxFit.scaleDown,
                                                ),
                                                SizedBox(
                                                  width: 6.w,
                                                ),
                                                addBoldText(AppLocalizations.of(context)!.inconitomode, 14, Color(0xFFAB60ED)),
                                                SizedBox(
                                                  width: 6.w,
                                                ),
                                                SvgPicture.asset(
                                                  "assets/images/info.svg",
                                                  fit: BoxFit.scaleDown,
                                                  color: Color(0xFFAB60ED),
                                                ),
                                              ],
                                            ),
                                            CupertinoSwitch(
                                              trackColor: Color(0xFFf1f1f1),
                                              activeColor: Color(0xFFAB60ED),
                                              value: profileProvider.profiledetails!.data!.incognitoMode,
                                              onChanged: (value)async {
                                                print(value);
                                                String incognitoMode="0";
                                                setState(() {
                                                  if(value==true)
                                                  {
                                                    setState(() {
                                                      incognitoMode="1";
                                                    });
                                                  }
                                                  else{
                                                    setState(() {
                                                      incognitoMode="0";
                                                    });
                                                  }


                                                });
                                                print("incognito_mode");
                                                print(incognitoMode);


                                                var model=await ProfileRepository.updateProfile(incognitoMode, "incognito_mode", preferences!.getString("accesstoken")!);
                                                if(model.statusCode==200)
                                                {

                                                  var provider=await Provider.of<ProfileProvider>(context,listen: false);
                                                  provider.resetStreams();
                                                  provider.adddetails(model);
                                                }
                                                else if(model.statusCode==422){
                                                   showSnakbar(model.message!, context);
                                                }
                                                else {
                                                   showSnakbar(model.message!, context);
                                                }
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15.h,
                                      ),
                                      Container(
                                        height: 60.h,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5.r),
                                            border: Border.all(
                                                color: Color(0xFFAB60ED),
                                                width: 1.0.w)),
                                        padding: EdgeInsets.all(10.r),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                SvgPicture.asset(
                                                  "assets/images/age.svg",
                                                  fit: BoxFit.scaleDown,
                                                  color: Color(0xFFAB60ED),
                                                ),
                                                SizedBox(
                                                  width: 6.w,
                                                ),
                                                addSemiBoldText(AppLocalizations.of(context)!.hidemyage, 14, Color(0xFFAB60ED)),
                                              ],
                                            ),
                                            CupertinoSwitch(
                                              trackColor: Color(0xFFf1f1f1),
                                              activeColor: Color(0xFFAB60ED),
                                              value: profileProvider.profiledetails!.data!.hideMyAge!,
                                              onChanged: (value) async{
                                                print(value);
                                                String hidemyage="0";
                                                setState(() {
                                                  if(value==true)
                                                  {
                                                    setState(() {
                                                      hidemyage="1";
                                                    });
                                                  }
                                                  else{
                                                    setState(() {
                                                      hidemyage="0";
                                                    });
                                                  }


                                                });
                                                print("hidemyage");
                                                print(hidemyage);


                                                var model=await ProfileRepository.updateProfile(hidemyage, "hide_my_age", preferences!.getString("accesstoken")!);
                                                if(model.statusCode==200)
                                                {

                                                  var provider=await Provider.of<ProfileProvider>(context,listen: false);
                                                  provider.resetStreams();
                                                  provider.adddetails(model);
                                                }
                                                else if(model.statusCode==422){
                                                   showSnakbar(model.message!, context);
                                                }
                                                else {
                                                   showSnakbar(model.message!, context);
                                                }
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15.h,
                                      ),
                                      Container(
                                        height: 60.h,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5.r),
                                            border: Border.all(
                                                color: Color(0xFFAB60ED),
                                                width: 1.0.w)),
                                        padding: EdgeInsets.all(10.r),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                SvgPicture.asset(
                                                  "assets/images/location.svg",
                                                  fit: BoxFit.scaleDown,
                                                  color: Color(0xFFAB60ED),
                                                ),
                                                SizedBox(
                                                  width: 6.w,
                                                ),
                                                addSemiBoldText(AppLocalizations.of(context)!.hidemylocation, 14, Color(0xFFAB60ED)),
                                              ],
                                            ),
                                            CupertinoSwitch(
                                              trackColor: Color(0xFFf1f1f1),
                                              activeColor: Color(0xFFAB60ED),
                                              value: profileProvider.profiledetails!.data!.hideMyLocation,
                                              onChanged: (value)async {
                                                print(value);
                                                String hide_my_location="0";
                                                setState(() {
                                                  if(value==true)
                                                  {
                                                    setState(() {
                                                      hide_my_location="1";
                                                    });
                                                  }
                                                  else{
                                                    setState(() {
                                                      hide_my_location="0";
                                                    });
                                                  }


                                                });
                                                print("hide_my_location");
                                                print(hide_my_location);


                                                var model=await ProfileRepository.updateProfile(hide_my_location, "hide_my_location", preferences!.getString("accesstoken")!);
                                                if(model.statusCode==200)
                                                {

                                                  var provider=await Provider.of<ProfileProvider>(context,listen: false);
                                                  provider.resetStreams();
                                                  provider.adddetails(model);
                                                }
                                                else if(model.statusCode==422){
                                                   showSnakbar(model.message!, context);
                                                }
                                                else {
                                                   showSnakbar(model.message!, context);
                                                }

                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ):
                                  Column(
                                    children: [
                                      Container(
                                        height: 60.h,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5.r),
                                            border: Border.all(
                                                color: Color(0xFFD3ACF5),
                                                width: 1.0.w)),
                                        padding: EdgeInsets.all(10.r),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                SvgPicture.asset(
                                                  "assets/images/incog.svg",
                                                  fit: BoxFit.scaleDown,
                                                  color: Color(0xFFD3ACF5),
                                                ),
                                                SizedBox(
                                                  width: 6.w,
                                                ),
                                                addBoldText(AppLocalizations.of(context)!.inconitomode, 14, Color(0xFFD3ACF5)),
                                                SizedBox(
                                                  width: 6.w,
                                                ),
                                                SvgPicture.asset(
                                                  "assets/images/info.svg",
                                                  fit: BoxFit.scaleDown,
                                                ),
                                              ],
                                            ),
                                            CupertinoSwitch(
                                              trackColor: Color(0xFFf1f1f1),
                                              activeColor: Color(0xFFD3ACF5),
                                              value: false,
                                              onChanged: (value) {
                                                Get.to(Premium_Screen());
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15.h,
                                      ),
                                      Container(
                                        height: 60.h,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5.r),
                                            border: Border.all(
                                                color: Color(0xFFD3ACF5),
                                                width: 1.0.w)),
                                        padding: EdgeInsets.all(10.r),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                SvgPicture.asset(
                                                  "assets/images/age.svg",
                                                  fit: BoxFit.scaleDown,
                                                ),
                                                SizedBox(
                                                  width: 6.w,
                                                ),
                                                addSemiBoldText(AppLocalizations.of(context)!.hidemyage, 14, Color(0xFFD3ACF5)),
                                              ],
                                            ),
                                            CupertinoSwitch(
                                              trackColor: Color(0xFFf1f1f1),
                                              activeColor: Color(0xFFD3ACF5),
                                              value: false,
                                              onChanged: (value) {
                                                Get.to(Premium_Screen());
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15.h,
                                      ),
                                      Container(
                                        height: 60.h,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5.r),
                                            border: Border.all(
                                                color: Color(0xFFD3ACF5),
                                                width: 1.0.w)),
                                        padding: EdgeInsets.all(10.r),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                SvgPicture.asset(
                                                  "assets/images/location.svg",
                                                  fit: BoxFit.scaleDown,
                                                ),
                                                SizedBox(
                                                  width: 6.w,
                                                ),
                                                addSemiBoldText(AppLocalizations.of(context)!.hidemylocation, 14, Color(0xFFD3ACF5)),
                                              ],
                                            ),
                                            CupertinoSwitch(
                                              trackColor: Color(0xFFf1f1f1),
                                              activeColor: Color(0xFFD3ACF5),
                                              value: false,
                                              onChanged: (value) {
                                                Get.to(Premium_Screen());
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      )),
          ),
        ),
      ),
    );
  }
}
