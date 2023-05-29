import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moorky/commanWidget/commanwidget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:moorky/constant/color.dart';
import '../provider/authprovider.dart';
import 'login_screen.dart';
import 'otp_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PhoneLogin_Screen extends StatefulWidget {
  @override
  State<PhoneLogin_Screen> createState() => _PhoneLogin_ScreenState();
}

class _PhoneLogin_ScreenState extends State<PhoneLogin_Screen> {
  String countryCode="90";
  String countryShortName="TR";
  SharedPreferences? preferences;
  TextEditingController phoneController=new TextEditingController();
  var _scaKey = GlobalKey<ScaffoldState>();

  bool isLoad=false;

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    preferences=await SharedPreferences.getInstance();
  }
  void _onPressedShowDialog() async {
    showCountryPicker(
        context: context,
        showPhoneCode: true,
        countryListTheme: CountryListThemeData(
          flagSize: 25,
          backgroundColor: Colors.white,
          textStyle: TextStyle(fontSize: 16, color: Colors.blueGrey),
          bottomSheetHeight: 500, // Optional. Country list modal height
          //Optional. Sets the border radius for the bottomsheet.
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          //Optional. Styles the search field.
          inputDecoration: InputDecoration(
            labelText: AppLocalizations.of(context)!.search,
            hintText: AppLocalizations.of(context)!.starttypingtosearch,
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: const Color(0xFF8C98A8).withOpacity(0.2),
              ),
            ),
          ),
        ),
        onSelect: (Country country){
          setState(() {
            countryCode=country.phoneCode;
            countryShortName=country.countryCode;
          });
        });
  }
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    print(role);
    AuthProvider auth = Provider.of<AuthProvider>(context);
    return Scaffold(
      key: _scaKey,
      backgroundColor: Colors.white,
      appBar: AppBar(title:  addMediumText(AppLocalizations.of(context)!.phonenumber, 18, Colorss.mainColor),centerTitle: true,backgroundColor: Colors.transparent,elevation: 0,leading:   InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: (){
            Navigator.of(context).pop();
          },
          child: SvgPicture.asset("assets/images/arrowback.svg",fit: BoxFit.scaleDown,))),
      body: Form(
        key: _formKey,
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 80.h,),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: (){
                            _onPressedShowDialog();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 10.h),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.r),color: Color(0xFFFDFAFF)),
                            child: Row(
                              children: [
                                Text("${countryShortName}  +${countryCode}",textScaleFactor:1,style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      color: Color(0xFF606060),
                                      fontSize: 10,
                                    fontWeight: FontWeight.w600
                                  )
                                )),
                                SizedBox(width: 30.w,),
                                SvgPicture.asset("assets/images/arrowdown.svg",fit: BoxFit.scaleDown,)
                              ],
                            ),

                          ),
                        ),
                        SizedBox(width: 5.w,),
                        Expanded(child: TextFormField(
                          style:  GoogleFonts.roboto(textStyle: TextStyle(fontSize: 16)),
                          controller: phoneController,
                          onChanged: (value){
                            setState(() {
                              mobileNumber=value;
                            });
                          },
                          decoration: InputDecoration(contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 2),
                            isDense: true,
                            hintText: AppLocalizations.of(context)!.enteranumber,
                            hintStyle: TextStyle(color: Colorss.mainColor,fontSize: 14),
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value){
                            if(value!.isEmpty)
                              {
                                return AppLocalizations.of(context)!.pleaseentermobile;
                              }
                            else if(value.length<7){
                              return AppLocalizations.of(context)!.plesemimimum7digit;
                            }
                            else if(value.length>15)
                              {
                                return AppLocalizations.of(context)!.plesemaximm15digit;
                              }
                            return null;
                          },

                        ))
                      ],
                    ),
                    SizedBox(height: 50.h,),
                    Text.rich(TextSpan(
                        text:
                        "${AppLocalizations.of(context)!.wewillsendtotext}\n",
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              color:
                              Color(0xFF15294B).withOpacity(0.90)),
                        ),
                        children: <InlineSpan>[
                          TextSpan(
                            text: AppLocalizations.of(context)!.whenyournumber,
                            style: GoogleFonts.poppins(
                              textStyle:
                              TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                  color: Colorss.mainColor.withOpacity(0.90)),
                            ),
                          ),
                        ])),
                  ],
                ),
                Column(
                  children: [
                    !isLoad?InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: ()async{
                        if (_formKey.currentState!.validate()) {
                          print('countryCode${countryCode}');
                          _formKey.currentState!.save();
                          countrycode=countryCode;
                          setState(() {
                            isLoad=true;
                          });
                          if(role=="email")
                            {
                              var signupModel=await auth.updatephone(countryCode, phoneController.text,preferences!.getString("accesstoken")!);
                              if(signupModel.statusCode==200)
                              {
                                setState(() {
                                  isLoad=false;
                                });
                                  preferences!.setString("token",signupModel.data!.token!);
                                  preferences!.setString("otp",signupModel.data!.otp!);
                                
                                  Navigator.push(context,
                                      MaterialPageRoute(builder:
                                          (context) =>
                                          OtpScreen(already_register: false,otp: signupModel.data!.otp_text.toString(),msg_status: signupModel.data!.msg_status!,)
                                      )
                                  );
                              }
                              else if(signupModel.statusCode==422){
                                setState(() {
                                  isLoad=false;
                                });
                                showSnakbar(signupModel.message!, context);
                              }
                              else {
                                setState(() {
                                  isLoad=false;
                                });
                                showSnakbar(signupModel.message!, context);
                              }
                            }
                          else if(socialrole=="social")
                            {
                              var signupModel=await auth.updatephone(countryCode, phoneController.text,preferences!.getString("accesstoken")!);
                              if(signupModel.statusCode==200)
                              {
                                setState(() {
                                  isLoad=false;
                                });
                                preferences!.setString("token",signupModel.data!.token!);
                                preferences!.setString("otp",signupModel.data!.otp!);
                                
                                Navigator.push(context,
                                    MaterialPageRoute(builder:
                                        (context) =>
                                        OtpScreen(already_register: false,otp: signupModel.data!.otp_text.toString(),msg_status: signupModel.data!.msg_status!)
                                    )
                                );
                              }
                              else if(signupModel.statusCode==422){
                                setState(() {
                                  isLoad=false;
                                });
                                showSnakbar(signupModel.message!, context);
                              }
                              else {
                                setState(() {
                                  isLoad=false;
                                });
                                showSnakbar(signupModel.message!, context);
                              }
                            }
                          else{
                            print(phoneController.text);
                            var signupModel=await auth.login(countryCode, phoneController.text);
                            if(signupModel.statusCode==200)
                            {
                              setState(() {
                                isLoad=false;
                              });

                              if(signupModel.already_register)
                              {
                                print("in if ${signupModel.already_register}");
                                preferences!.setString("token",signupModel.data!.token!);
                                preferences!.setString("otp",signupModel.data!.otp!);
                                
                                Navigator.push(context,
                                    MaterialPageRoute(builder:
                                        (context) =>
                                        OtpScreen(already_register: signupModel.already_register,otp: signupModel.data!.otp_text.toString(),msg_status: signupModel.data!.msg_status!)
                                    )
                                );
                              }
                              else{
                                print("in else ${signupModel.already_register}");
                                preferences!.setString("token",signupModel.data!.token!);
                                preferences!.setString("otp",signupModel.data!.otp!);

                                Navigator.push(context,
                                    MaterialPageRoute(builder:
                                        (context) =>
                                        OtpScreen(already_register: signupModel.already_register,otp: signupModel.data!.otp_text.toString(),msg_status: signupModel.data!.msg_status!)
                                    )
                                );
                              }

                            }
                            else if(signupModel.statusCode==422){
                              setState(() {
                                isLoad=false;
                              });
                              showSnakbar(signupModel.message!, context);
                            }
                            else {
                              setState(() {
                                isLoad=false;
                              });
                              showSnakbar(signupModel.message!, context);
                            }
                          }
                        }
                      },
                      child: Container(
                        height: 70.h,
                        margin: EdgeInsets.only(left: 25.w,right: 25.w,bottom: 15.h),
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
                        child: addMediumText(AppLocalizations.of(context)!.continues, 14, Color(0xFFFFFFFF))
                      ),
                    ):Container(child: CircularProgressIndicator(),alignment: Alignment.topCenter,),
                    Container(
                      margin: EdgeInsets.only(bottom: 15.h),
                      child: Container(
                        height: 8.h,width: 140.w,decoration: BoxDecoration(color: Colors.black,borderRadius: BorderRadius.circular(25.r)),),
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
