import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_auth/local_auth.dart';
import 'package:moorky/commanWidget/commanwidget.dart';
import 'package:moorky/constant/color.dart';
import 'package:moorky/premiumscreen/view/premiumscreen.dart';
import 'package:moorky/profilecreate/provider/profileprovider.dart';
import 'package:moorky/profilecreate/repository/profileRepository.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class Confidentiality_Screen extends StatefulWidget {
  const Confidentiality_Screen({Key? key}) : super(key: key);

  @override
  State<Confidentiality_Screen> createState() => _Confidentiality_ScreenState();
}

class _Confidentiality_ScreenState extends State<Confidentiality_Screen> {
  bool enablefaceid=false;
  bool hidelocation=false;
  bool showonlinestatus=false;
  bool closeads=false;
  final LocalAuthentication auth = LocalAuthentication();
  _SupportState _supportState = _SupportState.unknown;
  bool _canCheckBiometrics=false;
  List<BiometricType>? _availableBiometrics;
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;
  SharedPreferences? preferences;
  @override
  void initState() {
    Init();
    super.initState();

    auth.isDeviceSupported().then(
          (bool isSupported) => setState(() => _supportState = isSupported
          ? _SupportState.supported
          : _SupportState.unsupported),
    );
    print(_supportState);
    _checkBiometrics();
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
  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticate(
        localizedReason: 'Let OS determine authentication method',
        options: const AuthenticationOptions(
          stickyAuth: true,

        ),
      );
      setState(() {
        _isAuthenticating = false;
        enablefaceid=false;
      });
    } on PlatformException catch (e) {
      print(e);
      setState(() {
        _isAuthenticating = false;
        enablefaceid=false;
        _authorized = 'Error - ${e.message}';
      });
      return;
    }
    if (!mounted) {
      return;
    }

    setState(
            () => _authorized = authenticated ? 'Authorized' : 'Not Authorized');
    print(_authorized);
    setState(() {
      if(authenticated)
        {
          setState(() {
            enablefaceid=true;
            preferences!.setBool("enablefaceid", true);
          });
        }
    });
  }
  Future<void> _checkBiometrics() async {
    preferences = await SharedPreferences.getInstance();
    if(preferences!.getBool("enablefaceid")!=null)
      {
        enablefaceid= preferences!.getBool("enablefaceid")!;
      }
    late bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      canCheckBiometrics = false;
      print(e);
    }
    if (!mounted) {
      return;
    }

    setState(() {
      _canCheckBiometrics = canCheckBiometrics;
      print(_canCheckBiometrics);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: addMediumText(AppLocalizations.of(context)!.confidentaility, 18, Colorss.mainColor),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1.0,
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
      ),
      bottomNavigationBar: Container(
        alignment: Alignment.center,
        color: Colors.transparent,
        height: 80.h,
        padding: EdgeInsets.only(bottom: 10.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset("assets/images/moorky2.png",height: 45.h,width: 150.w,),
            Container(
              height: 8.h,width: 140.w,decoration: BoxDecoration(color: Color(0xFF751ACD),borderRadius: BorderRadius.circular(25.r)),),
          ],
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(20.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
           Divider(thickness: 1.5,color: Color(0xFff3f3f3),height: 3,),
            _canCheckBiometrics ? Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    addRegularText(AppLocalizations.of(context)!.enablefaceid, 12, Colorss.mainColor),
                    CupertinoSwitch(value: enablefaceid,
                        activeColor: Color(0xFFAB60ED),
                        onChanged: (value){
                          setState(() {
                            enablefaceid=value;
                            if(enablefaceid)
                            {
                              _authenticate();
                            }
                            else{
                              preferences!.setBool("enablefaceid", false);
                            }

                          });

                        })
                  ],
                ),
                Divider(thickness: 1.5,color: Color(0xFff3f3f3),height: 3,),
                SizedBox(height: 10.h,),
                Container(
                    width: 200,
                    alignment: Alignment.center,
                    child: addCenterRegularText(AppLocalizations.of(context)!.enablefaceidableto, 9, Color(0xFFA8A8A8),
                    )),
                SizedBox(height: 30.h,),
                Divider(thickness: 1.5,color: Color(0xFff3f3f3),height: 3,),
              ],
            ):Container(),
            Consumer<ProfileProvider>(
                builder: (context, profileProvider, child) {
                  return profileProvider.profiledetails?.data != null?
                  (profileProvider.user_type.toString()=="premium"||profileProvider.user_type.toString()=="basic")?Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          addRegularText(AppLocalizations.of(context)!.hideyourlocation, 12, Colorss.mainColor),
                          profileProvider.user_type.toString()=="premium"?
                          CupertinoSwitch(value: profileProvider.profiledetails!.data!.hideMyLocation,
                              activeColor: Color(0xFFAB60ED),
                              onChanged: (value)async{
                                String hideyourlocation="0";
                                setState(() {
                                  if(value==true)
                                  {
                                    setState(() {
                                      hideyourlocation="1";
                                    });
                                  }
                                  else{
                                    setState(() {
                                      hideyourlocation="0";
                                    });
                                  }


                                });
                                print("hideyourlocation");
                                print(hideyourlocation);


                                var model=await ProfileRepository.updateProfile(hideyourlocation, "hide_my_location", preferences!.getString("accesstoken")!);
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

                              }):CupertinoSwitch(value: false,
                              activeColor: Color(0xFFD3ACF5),
                              onChanged: (value){
                                Get.to(Premium_Screen());
                              })
                        ],
                      ),
                      Divider(thickness: 1.5,color: Color(0xFff3f3f3),height: 3,),
                      SizedBox(height: 10.h,),
                      Container(
                          width: 200,
                          alignment: Alignment.center,
                          child: addCenterRegularText(AppLocalizations.of(context)!.showlocationifyoushow, 9, Color(0xFFA8A8A8),
                          )),
                      SizedBox(height: 30.h,),
                      Divider(thickness: 1.5,color: Color(0xFff3f3f3),height: 3,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          addRegularText(AppLocalizations.of(context)!.showonlinestatus, 12, Colorss.mainColor),
                          profileProvider.user_type.toString()=="premium"?
                          CupertinoSwitch(value: profileProvider.profiledetails!.data!.showLiveStatus,
                              activeColor: Color(0xFFAB60ED),
                              onChanged: (value)async{
                                String showonlinestatus="0";
                                setState(() {
                                  if(value==true)
                                  {
                                    setState(() {
                                      showonlinestatus="1";
                                    });
                                  }
                                  else{
                                    setState(() {
                                      showonlinestatus="0";
                                    });
                                  }


                                });
                                print("hide_account");
                                print(showonlinestatus);


                                var model=await ProfileRepository.updateProfile(showonlinestatus, "show_live_status", preferences!.getString("accesstoken")!);
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
                              }):CupertinoSwitch(value: false,
                              activeColor: Color(0xFFD3ACF5),
                              onChanged: (value){
                                Get.to(Premium_Screen());
                              })
                        ],
                      ),
                      Divider(thickness: 1.5,color: Color(0xFff3f3f3),height: 3,),
                      SizedBox(height: 10.h,),
                      Container(
                          width: 200,
                          alignment: Alignment.center,
                          child: addCenterRegularText(AppLocalizations.of(context)!.ifyouwantshowonlinestatus, 9, Color(0xFFA8A8A8),
                          )),
                      SizedBox(height: 30.h,),
                      Divider(thickness: 1.5,color: Color(0xFff3f3f3),height: 3,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          addRegularText(AppLocalizations.of(context)!.closeads, 12, Colorss.mainColor),
                          profileProvider.user_type.toString()=="basic"?CupertinoSwitch(value: profileProvider.profiledetails!.data!.showAds,
                              activeColor: Color(0xFFAB60ED),
                              onChanged: (value)async{
                                String show_ads="0";
                                setState(() {
                                  if(value==true)
                                  {
                                    setState(() {
                                      show_ads="1";
                                    });
                                  }
                                  else{
                                    setState(() {
                                      show_ads="0";
                                    });
                                  }


                                });
                                print("hide_account");
                                print(show_ads);


                                var model=await ProfileRepository.updateProfile(show_ads, "show_ads", preferences!.getString("accesstoken")!);
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
                              }):CupertinoSwitch(value: true,
                  activeColor: Color(0xFFAB60ED),
                  onChanged: (value){

                  })
                        ],
                      ),
                      Divider(thickness: 1.5,color: Color(0xFff3f3f3),height: 3,),
                      SizedBox(height: 10.h,),
                      Container(
                          width: 200,
                          alignment: Alignment.center,
                          child: addCenterRegularText(AppLocalizations.of(context)!.youcanremoveads, 9, Color(0xFFA8A8A8),
                          )),

                    ],
                  ):Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          addRegularText(AppLocalizations.of(context)!.hideyourlocation, 12, Colorss.mainColor),
                          CupertinoSwitch(value: false,
                              activeColor: Color(0xFFD3ACF5),
                              onChanged: (value){
                                Get.to(Premium_Screen());
                              })
                        ],
                      ),
                      Divider(thickness: 1.5,color: Color(0xFff3f3f3),height: 3,),
                      SizedBox(height: 10.h,),
                      Container(
                          width: 200,
                          alignment: Alignment.center,
                          child: addCenterRegularText(AppLocalizations.of(context)!.showlocationifyoushow, 9, Color(0xFFA8A8A8),
                          )),
                      SizedBox(height: 30.h,),
                      Divider(thickness: 1.5,color: Color(0xFff3f3f3),height: 3,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          addRegularText(AppLocalizations.of(context)!.showonlinestatus, 12, Colorss.mainColor),
                          CupertinoSwitch(value: false,
                              activeColor: Color(0xFFD3ACF5),
                              onChanged: (value){
                                Get.to(Premium_Screen());
                              })
                        ],
                      ),
                      Divider(thickness: 1.5,color: Color(0xFff3f3f3),height: 3,),
                      SizedBox(height: 10.h,),
                      Container(
                          width: 200,
                          alignment: Alignment.center,
                          child: addCenterRegularText(AppLocalizations.of(context)!.ifyouwantshowonlinestatus, 9, Color(0xFFA8A8A8),
                          )),
                      SizedBox(height: 30.h,),
                      Divider(thickness: 1.5,color: Color(0xFff3f3f3),height: 3,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          addRegularText(AppLocalizations.of(context)!.closeads, 12, Colorss.mainColor),
                          CupertinoSwitch(value: false,
                              activeColor: Color(0xFFD3ACF5),
                              onChanged: (value){
                                Get.to(Premium_Screen());
                              })
                        ],
                      ),
                      Divider(thickness: 1.5,color: Color(0xFff3f3f3),height: 3,),
                      SizedBox(height: 10.h,),
                      Container(
                          width: 200,
                          alignment: Alignment.center,
                          child: addCenterRegularText(AppLocalizations.of(context)!.youcanremoveads, 9, Color(0xFFA8A8A8),
                          )),

                    ],
                  ):Center(child: CircularProgressIndicator(),);
                }
            ),
            SizedBox(height: 30.h,),
          ],
        ),
      ),
    );
  }

}
enum _SupportState {
  unknown,
  supported,
  unsupported,
}
