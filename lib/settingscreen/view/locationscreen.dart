import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:moorky/commanWidget/commanwidget.dart';
import 'package:moorky/constant/color.dart';
import 'package:moorky/profilecreate/provider/profileprovider.dart';
import 'package:moorky/profilecreate/repository/profileRepository.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationScreen extends StatefulWidget {
  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  SharedPreferences? preferences;
  String city = '';
  String state = '';
  String country = '';
  String longitude = '';
  String latitude = '';
  @override
  void initState() {
    Init();
    super.initState();
  }

  void Init() async {
    preferences = await SharedPreferences.getInstance();
  }
  bool isLoad=false;
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
      isLoad=true;
    });
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }
  Future<void> GetAddressFromLatLong(Position position)async {
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    city = '${place.locality} ${place.subLocality} ${place.subAdministrativeArea} ${place.name} ${place.postalCode}';
    state = '${place.locality}';
    country = '${place.country}';
    setState(()  {
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
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
    ))),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/images/location.svg",height: 150,width: 150,color: Colorss.mainColor,),
        SizedBox(height: 200,),

        !isLoad?InkWell(
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
            List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
            print(placemarks);
            Placemark place = placemarks[0];
            setState(()  {
              city = '${place.locality} ${place.subLocality} ${place.subAdministrativeArea} ${place.name} ${place.postalCode}';
              state = '${place.administrativeArea}';
              country = '${place.country}';
            });
            print(city);
            print(state);
            print(country);
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
            isLoad=false;
            });

            var provider=await Provider.of<ProfileProvider>(context,listen: false);
            provider.resetStreams();
            provider.adddetails(model);
            Navigator.of(context).pop();
            }
            else if(model.statusCode==422){
            setState(() {
            isLoad=false;
            });
            showSnakbar(model.message!, context);
            }
            else {
            setState(() {
            isLoad=false;
            });
            showSnakbar(model.message!, context);
            }

              }
              else{

                var model=await ProfileRepository.updateLocation(latitude,longitude,city,state,country,preferences!.getString("accesstoken").toString());
                if(model.statusCode==200)
                {
                  setState(() {
                    isLoad=false;
                  });
                  var provider=await Provider.of<ProfileProvider>(context,listen: false);
                  print('herrerer2');
                  provider.resetStreams();
                  provider.adddetails(model);
                  Navigator.of(context).pop();
                }
                else if(model.statusCode==422){
                  setState(() {
                    isLoad=false;
                  });
                  showSnakbar(model.message!, context);
                }
                else {
                  setState(() {
                    isLoad=false;
                  });
                  showSnakbar(model.message!, context);
                }
              }

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
                  borderRadius: BorderRadius.circular(50.r)),
              alignment: Alignment.center,
              child: addMediumText("Get Current Location", 14, Color(0xFFFFFFFF))
          ),
        ):Container(child: CircularProgressIndicator(),alignment: Alignment.topCenter,)
          ],
        ),
      ),
    );
  }
}
