import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:moorky/commanWidget/commanwidget.dart';
import 'package:moorky/profilecreate/repository/profileRepository.dart';
import 'package:moorky/profilecreate/view/namescreen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:moorky/quizscreens/repository/quizrepository.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountCreatedScreen extends StatefulWidget {
  @override
  State<AccountCreatedScreen> createState() => _AccountCreatedScreenState();
}

class _AccountCreatedScreenState extends State<AccountCreatedScreen> {

  String city = '';
  String state = '';
  String country = '';
  String longitude = '';
  String latitude = '';
  bool isPremissionEnabled=false;
  SharedPreferences? preferences;
  int count=0;
  @override
  void initState() {
    Init();
    super.initState();
  }

  void Init() async {
    preferences = await SharedPreferences.getInstance();

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
    setState(() {
      isPremissionEnabled=true;
    });
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }
  Future<void> GetAddressFromLatLong(Position position)async {
    String? locallang = Platform.localeName;
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude,localeIdentifier: locallang);
    print(placemarks);
    Placemark place = placemarks[0];
    city = '${place.locality}';
    state = '${place.administrativeArea}';
    country = '${place.country}';
    setState(()  {
    });
  }
  Future<bool> _onBackPressed() async{
    return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.areyousure),
          content: Text(AppLocalizations.of(context)!.doyouwantto),
          actions: <Widget>[
            GestureDetector(
              onTap: (){
                Navigator.of(context).pop(false);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(AppLocalizations.of(context)!.no,style: TextStyle(fontSize: 16),),
              ),
            ),
            GestureDetector(
              onTap: (){
                Navigator.of(context).pop(true);
                SystemNavigator.pop();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(AppLocalizations.of(context)!.yes,style: TextStyle(fontSize: 16),),
              ),
            ),
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.transparent,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset("assets/images/checked.png",height: 110.h,width: 110.w,),
                    SizedBox(height: 80.h,),
                    Container(
                      child: Column(
                        children: [
                          SizedBox(height: 40.h,),
                          addMediumText(AppLocalizations.of(context)!.accountcreated, 20, Color(0xFFA04EFF)),
                          SizedBox(height: 30.h,),
                          addLightText(AppLocalizations.of(context)!.afewstep, 10, Color(0xFF3D4E6A).withOpacity(0.90)),
                          addLightText(AppLocalizations.of(context)!.wesetyourmatches, 10, Color(0xFF3D4E6A).withOpacity(0.90)),
                          SizedBox(height: 60.h,),
                          !isPremissionEnabled?InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: ()async{
                              Position position = await _getGeoLocationPosition();
                              print(position.longitude);
                              print(position.latitude);
                              latitude=position.latitude.toString();
                              longitude=position.longitude.toString();
                              String? locallang = Platform.localeName;
                              List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude,localeIdentifier: locallang);
                              print(placemarks);
                              Placemark place = placemarks[0];

                              setState(()  {
                                city = '${place.locality}';
                                state = '${place.administrativeArea}';
                                country = '${place.country}';
                              });
                              if(preferences!.getString("accesstoken")!=null)
                              {
                                if(latitude.toString()==null||latitude.toString()=="null"||latitude=="")
                                  {
                                    latitude="";
                                    longitude="";
                                    var model=await ProfileRepository.updateLocation(latitude,longitude,city,state,country,preferences!.getString("accesstoken").toString());
                                    if(model.statusCode==200)
                                    {
                                      setState(() {
                                        isPremissionEnabled=false;
                                      });
                                      Navigator.push(context,
                                          MaterialPageRoute(builder:
                                              (context) =>
                                              NameScreen(isEdit: false,name: "",isGhost:false)
                                          )
                                      );
                                    }
                                    else if(model.statusCode==422){
                                      setState(() {
                                        isPremissionEnabled=false;
                                      });
                                      showSnakbar(model.message!, context);
                                    }
                                    else {
                                      setState(() {
                                        isPremissionEnabled=false;
                                      });
                                      showSnakbar(model.message!, context);
                                    }

                                  }
                                else{
                                  var model=await ProfileRepository.updateLocation(latitude,longitude,city,state,country,preferences!.getString("accesstoken").toString());
                                  if(model.statusCode==200)
                                  {
                                    setState(() {
                                      isPremissionEnabled=false;
                                    });
                                    Navigator.push(context,
                                        MaterialPageRoute(builder:
                                            (context) =>
                                            NameScreen(isEdit: false,name: "",isGhost:false)
                                        )
                                    );
                                  }
                                  else if(model.statusCode==422){
                                    setState(() {
                                      isPremissionEnabled=false;
                                    });
                                    showSnakbar(model.message!, context);
                                  }
                                  else {
                                    setState(() {
                                      isPremissionEnabled=false;
                                    });
                                    showSnakbar(model.message!, context);
                                  }

                                }

                              }
                              else{
                                Navigator.push(context,
                                    MaterialPageRoute(builder:
                                        (context) =>
                                        NameScreen(isEdit: false,name: "",isGhost:false)
                                    )
                                );
                              }

                            },
                            child: Container(
                                height: 70.h,
                                margin: EdgeInsets.only(left: 25.w,right: 25.w),
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: <Color>[
                                        Color(0xFF570084),
                                        Color(0xFFA33BE5)
                                      ],
                                    ),
                                    boxShadow: [new BoxShadow(
                                      color: Color(0xFFFEEBF5),
                                      blurRadius: 20.0,
                                    ),],
                                    borderRadius: BorderRadius.circular(50.r)),
                                alignment: Alignment.center,
                                child: addMediumText(AppLocalizations.of(context)!.continues, 14,Color(0xFFFFFFFF) )
                            ),
                          ):Center(child: CircularProgressIndicator(),),
                          SizedBox(height: 40.h,),
                        ],
                      ),
                    ),

                    Container(
                      alignment: Alignment.bottomCenter,
                      margin: EdgeInsets.only(bottom: 15.h),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Image.asset("assets/images/moorky2.png",height: 45.h,width: 150.w,),
                          SizedBox(height: 5.h,),
                          Container(
                            height: 8.h,width: 140.w,),
                        ],
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
