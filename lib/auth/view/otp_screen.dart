import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moorky/accountcreatedscreen/view/accountcreatedscreen.dart';
import 'package:moorky/commanWidget/commanwidget.dart';
import 'package:moorky/dashboardscreen/view/dashboardscreen.dart';
import 'package:moorky/profilecreate/repository/profileRepository.dart';
import 'package:moorky/zegocloud/model/user_model.dart';
import 'package:otp_autofill/otp_autofill.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:zego_zim/zego_zim.dart';
import 'email_screen.dart';
import '../provider/authprovider.dart';
import 'package:moorky/constant/color.dart';

import 'login_screen.dart';

String mobileNumber = "";
String countrycode = "";

class OtpScreen extends StatefulWidget {
  bool already_register, msg_status;
  String otp = "";
  OtpScreen(
      {required this.already_register,
      required this.otp,
      required this.msg_status});
  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  SharedPreferences? preferences;
  String code = "";
  String codeValue = "";
  var _scaKey = GlobalKey<ScaffoldState>();
  TextEditingController textEditingController = TextEditingController();

  late OTPTextEditController controller;
  late OTPInteractor _otpInteractor;
  // ..text = "123456";

  // ignore: close_sinks
  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    _otpInteractor = OTPInteractor();
    _otpInteractor
        .getAppSignature()
        //ignore: avoid_print
        .then((value) => print('signature - $value'));

    controller = OTPTextEditController(
      codeLength: 4,
      //ignore: avoid_print
      onCodeReceive: (code) {
        setState(() {
          textEditingController.text = code;
        });
      },
      otpInteractor: _otpInteractor,
    )..startListenUserConsent(
        (code) {
          final exp = RegExp(r'(\d{4})');
          return exp.stringMatch(code ?? '') ?? '';
        },
        strategies: [
          SampleStrategy(),
        ],
      );
    Init();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();

    super.dispose();
  }

  void Init() async {
    preferences = await SharedPreferences.getInstance();
    if (!widget.msg_status) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(AppLocalizations.of(context)!.yourotpis,
                textScaleFactor: 1.0, style: TextStyle(fontSize: 10)),
            content: Text(widget.otp,
                textScaleFactor: 1.0, style: TextStyle(fontSize: 10)),
            actions: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop(true);
                },
                child: Text(AppLocalizations.of(context)!.ok),
              ),
            ],
          );
        },
      );
      setState(() {
        textEditingController.text = widget.otp;
      });
    }
  }

  bool isTrue = false;
  bool isLoad = false;
  bool isreLoad = false;
  @override
  Widget build(BuildContext context) {
    print(widget.otp);
    AuthProvider auth = Provider.of<AuthProvider>(context);
    return Scaffold(
      key: _scaKey,
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
          title: addMediumText(
              AppLocalizations.of(context)!.entercode, 18, Colorss.mainColor),
          centerTitle: true,
          backgroundColor: Colors.transparent,
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
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 120.h,
                  ),
                  !isreLoad
                      ? InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            setState(() {
                              isreLoad = true;
                            });
                            var signupModel =
                                await auth.login(countrycode, mobileNumber);
                            if (signupModel.statusCode == 200) {
                              setState(() {
                                isreLoad = false;
                                widget.otp =
                                    signupModel.data!.otp_text.toString();
                              });
                              showSnakbar(signupModel.message!, context);
                              if (!widget.msg_status) {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text(
                                        AppLocalizations.of(context)!.yourotpis,
                                        textScaleFactor: 1.0,
                                      ),
                                      content: Text(
                                        signupModel.data!.otp_text.toString(),
                                        textScaleFactor: 1.0,
                                      ),
                                      actions: <Widget>[
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).pop(true);
                                          },
                                          child: Text(
                                              AppLocalizations.of(context)!.ok),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            } else if (signupModel.statusCode == 422) {
                              setState(() {
                                isreLoad = false;
                              });
                              showSnakbar(signupModel.message!, context);
                            } else {
                              setState(() {
                                isreLoad = false;
                              });
                              showSnakbar(signupModel.message!, context);
                            }
                          },
                          child: addBoldText(
                              AppLocalizations.of(context)!.resend,
                              14,
                              Colorss.mainColor))
                      : Container(
                          child: CircularProgressIndicator(),
                          alignment: Alignment.topCenter,
                        ),
                  SizedBox(
                    height: 50.h,
                  ),
                  PinCodeTextField(
                    appContext: context,
                    pastedTextStyle: TextStyle(
                      color: Colorss.mainColor,
                      fontWeight: FontWeight.w500,
                    ),
                    length: 4,
                    obscureText: false,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderWidth: 1,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 50,
                        fieldWidth: 70.w,
                        activeFillColor: Colors.white,
                        inactiveFillColor: Color(0xFFFDFAFF),
                        activeColor: Colorss.mainColor,
                        inactiveColor: Color(0xFFFDFAFF),
                        selectedColor: Colorss.mainColor,
                        selectedFillColor: Color(0xFFFDFAFF)),
                    autoFocus: true,
                    cursorColor: Colorss.mainColor,
                    animationDuration: const Duration(milliseconds: 300),
                    enableActiveFill: true,
                    errorAnimationController: errorController,
                    controller: textEditingController,
                    keyboardType: TextInputType.number,
                    showCursor: false,
                    onCompleted: (v) async {
                      String? token =
                          await FirebaseMessaging.instance.getToken();

                      setState(() {
                        code = v;
                        print(code);
                      });
                      print("gvhjbkl;" + token!);
                      isTrue = true;
                      if (isTrue) {
                        setState(() {
                          isLoad = true;
                        });
                        if (role == "email") {
                          var signupverifymodel = await auth.updateotpVerify(
                              preferences!.getString("token").toString(),
                              code.toString(),
                              preferences!.getString("accesstoken")!);

                          if (signupverifymodel.statusCode == 200) {
                            setState(() {
                              isLoad = false;
                            });
                            preferences!.setBool("accountcreated", true);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        AccountCreatedScreen()));

                          }
                          else if (signupverifymodel.statusCode == 422) {
                            setState(() {
                              isLoad = false;
                            });
                            showSnakbar(signupverifymodel.message!, context);
                          } else {
                            setState(() {
                              isLoad = false;
                            });
                            showSnakbar(signupverifymodel.message!, context);
                          }
                        } else {
                          if (widget.already_register) {
                            print(
                                'otpVerify token=${preferences!.getString("token").toString()}');

                            var signupverifymodel = await auth.otpVerify(
                                preferences!.getString("token").toString(),
                                code.toString());
                            if (signupverifymodel.statusCode == 200) {
                              print(
                                  '11111111${signupverifymodel.data!.accessToken!}');
                              preferences!.setString("accesstoken",
                                  signupverifymodel.data!.accessToken!);
                              preferences!.setString("realphoto", "realphoto");
                              preferences!.setString("user_id",
                                  signupverifymodel.data!.id.toString());
                              // String? token = await FirebaseMessaging.instance.getToken();
                              print("my device token 1");
                              print("ashdfoahjfoji");
                              print(token);
                              var model = await ProfileRepository.updateProfile(
                                  token.toString(),
                                  "device_token",
                                  preferences!.getString("accesstoken")!);
                              print("ashdfoahjfoji${model.statusCode}");

                              if (model.statusCode == 200) {
                                setState(() {
                                  isLoad = false;
                                });
                                try {
                                  ZIMUserInfo userInfo = ZIMUserInfo();
                                  userInfo.userID = model.data!.id.toString();
                                  userInfo.userName =
                                      model.data!.name.toString();
                                  print(userInfo.userID);
                                  print(userInfo.userName);
                                  print("userInfo.userName");
                                  preferences!
                                      .setString("email", model.data!.email!);

                                  // await ZIM.getInstance()!.login(userInfo);
                                  // Navigator.of(context).pop;
                                  //  fi
                                  //  nal signupCredential =await FirebaseAuth.instance.createUserWithEmailAndPassword(email: model.data!.email, password: "12345678");
                                  var fb = FirebaseAuth.instance;
if(model.data!.email!=null) {
  print("Nul emial null nddemial");
  signInWithEmailAndPassword(
      model.data!.email, "12345678");
}
else{
  print("Nul emial null nemial");
}
                                  print("djsflasjdfl");
                                  Navigator.of(context).pop;
                                  print('success');
                                  UserModel.shared().userInfo = userInfo;
                                  final prefs =
                                      await SharedPreferences.getInstance();
                                  await prefs.setString(
                                      'userID', model.data!.id.toString());
                                  await prefs.setString(
                                      'userName', model.data!.name.toString());
                                  await prefs.setString(
                                      'email', model.data!.email.toString());

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DashBoardScreen(
                                                pageIndex: 1,
                                                isNotification: false,
                                              )));

                                  /// Check after check
                                  // await ZIM.getInstance()!.login(userInfo);

                                } catch (onError) {
                                  print("hjvkl;$onError");
                                  Navigator.of(context).pop();
                                }
                              }
                            }
                            else if (signupverifymodel.statusCode == 422) {
                              setState(() {
                                print('sdhfksdhf');
                                isLoad = false;
                              });
                              showSnakbar(signupverifymodel.message!, context);
                            } else {
                              setState(() {
                                print('sdfghsh');
                                isLoad = false;
                              });
                              showSnakbar(signupverifymodel.message!, context);
                            }
                          }
                          else if (socialrole == "social") {
                            print('socialrole');
                            var signupverifymodel = await auth.otpVerify(
                                preferences!.getString("token").toString(),
                                code.toString());
                            if (signupverifymodel.statusCode == 200) {
                              preferences!.setBool("accountcreated", true);
                              setState(() {
                                isLoad = false;
                              });
                              preferences!.setString("accesstoken",
                                  signupverifymodel.data!.accessToken!);
                              preferences!.setString("user_id",
                                  signupverifymodel.data!.id.toString());
                              String? token =
                                  await FirebaseMessaging.instance.getToken();
                              print("my device token 2");
                              print(token);
                              var model = await ProfileRepository.updateProfile(
                                  token.toString(),
                                  "device_token",
                                  preferences!.getString("accesstoken")!);
                              if (model.statusCode == 200) {
                                print("fasjdfoiaejrfh");
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AccountCreatedScreen()));
                                try {
                                  ZIMUserInfo userInfo = ZIMUserInfo();
                                  userInfo.userID = model.data!.id.toString();
                                  userInfo.userName =
                                      model.data!.name.toString();
                                 // await ZIM.getInstance()!.login(userInfo);
                                  Navigator.of(context).pop;
                                  print('success');
                                  UserModel.shared().userInfo = userInfo;
                                  final prefs =
                                      await SharedPreferences.getInstance();
                                  await prefs.setString(
                                      'userID', model.data!.id.toString());
                                  await prefs.setString(
                                      'userName', model.data!.name.toString());
                                } on PlatformException catch (onError) {
                                  Navigator.of(context).pop();
                                }
                              }
                            } else if (signupverifymodel.statusCode == 422) {
                              setState(() {
                                isLoad = false;
                              });
                              showSnakbar(signupverifymodel.message!, context);
                            } else {
                              setState(() {
                                isLoad = false;
                              });
                              showSnakbar(signupverifymodel.message!, context);
                            }
                          }
                          else {
                            print('else condition');
                            var signupverifymodel = await auth.otpVerify(
                                preferences!.getString("token").toString(),
                                code.toString());
                            if (signupverifymodel.statusCode == 200) {
                              setState(() {
                                isLoad = false;
                              });
                              preferences!.setString("accesstoken",
                                  signupverifymodel.data!.accessToken!);
                              preferences!.setString("user_id",
                                  signupverifymodel.data!.id.toString());
                              String? token =
                                  await FirebaseMessaging.instance.getToken();
                              print("my device token 3");
                              print(token);
                              var model = await ProfileRepository.updateProfile(
                                  token.toString(),
                                  "device_token",
                                  preferences!.getString("accesstoken")!);
                              if (model.statusCode == 200) {
                                try {
                                  ZIMUserInfo userInfo = ZIMUserInfo();
                                  userInfo.userID = model.data!.id.toString();
                                  userInfo.userName =
                                      model.data!.name.toString();
                                  print('success${userInfo.userID}');
                                  print('success${userInfo.userName}');

                                  //  Navigator.of(context).pop;
                                  print('success');
                                  //UserModel.shared().userInfo = userInfo;
                                  final prefs =
                                      await SharedPreferences.getInstance();
                                  await prefs.setString(
                                      'userID', model.data!.id.toString());
                                  await prefs.setString(
                                      'userName', model.data!.name.toString());
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => EmailScreen()));

                                  ///Change after check
                                 // await ZIM.getInstance()?.login(userInfo);
                                } on PlatformException catch (onError) {
                                  Navigator.of(context).pop();
                                }
                              }
                            } else if (signupverifymodel.statusCode == 422) {
                              setState(() {
                                isLoad = false;
                              });
                              showSnakbar(signupverifymodel.message!, context);
                            } else {
                              setState(() {
                                isLoad = false;
                              });
                              showSnakbar(signupverifymodel.message!, context);
                            }
                          }
                        }
                      }
                    },
                    onChanged: (value) {
                      setState(() {
                        isTrue = false;
                        code = value;
                        print(code);
                      });
                    },
                  ),
                  // OtpTextField(
                  //   numberOfFields: 4,
                  //   borderColor: Colors.white,
                  //   cursorColor: Colorss.mainColor,
                  //   showFieldAsBox: true,
                  //   fillColor: Color(0xFFFDFAFF),
                  //   filled: true,
                  //   autoFocus: true,
                  //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //   borderWidth: 0.0,
                  //   fieldWidth: 70.w,
                  //   showCursor: false,
                  //   focusedBorderColor: Colorss.mainColor,
                  //   onCodeChanged: (String cod) {
                  //     print(cod);
                  //     setState(() {
                  //       isTrue = false;
                  //       code = cod;
                  //       print(code);
                  //     });
                  //     //handle validation or checks here
                  //   },
                  //   //runs when every textfield is filled
                  //   onSubmit: (String verificationCode) {
                  //     setState(() {
                  //       code = verificationCode;
                  //       print(code);
                  //     });
                  //     isTrue = true;
                  //   }, // end onSubmit
                  // ),
                ],
              ),
              Column(
                children: [
                  isTrue
                      ? !isLoad
                          ? InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                setState(() {
                                  isLoad = true;
                                });
                                if (role == "email") {
                                  var signupverifymodel =
                                      await auth.updateotpVerify(
                                          preferences!
                                              .getString("token")
                                              .toString(),
                                          code.toString(),
                                          preferences!
                                              .getString("accesstoken")!);
                                  if (signupverifymodel.statusCode == 200) {
                                    setState(() {
                                      isLoad = false;
                                    });
                                    preferences!
                                        .setBool("accountcreated", true);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AccountCreatedScreen()));
                                  } else if (signupverifymodel.statusCode ==
                                      422) {
                                    setState(() {
                                      isLoad = false;
                                    });
                                    showSnakbar(
                                        signupverifymodel.message!, context);
                                  } else {
                                    setState(() {
                                      isLoad = false;
                                    });
                                    showSnakbar(
                                        signupverifymodel.message!, context);
                                  }
                                } else {
                                  if (widget.already_register) {
                                    var signupverifymodel =
                                        await auth.otpVerify(
                                            preferences!
                                                .getString("token")
                                                .toString(),
                                            code.toString());
                                    if (signupverifymodel.statusCode == 200) {
                                      preferences!.setString("accesstoken",
                                          signupverifymodel.data!.accessToken!);
                                      preferences!
                                          .setString("realphoto", "realphoto");
                                      preferences!.setString(
                                          "user_id",
                                          signupverifymodel.data!.id
                                              .toString());
                                      String? token = await FirebaseMessaging
                                          .instance
                                          .getToken();
                                      print("my device token 4");
                                      print(token);
                                      var model =
                                          await ProfileRepository.updateProfile(
                                              token.toString(),
                                              "device_token",
                                              preferences!
                                                  .getString("accesstoken")!);
                                      if (model.statusCode == 200) {
                                        setState(() {
                                          isLoad = false;
                                        });
                                        try {
                                          ZIMUserInfo userInfo = ZIMUserInfo();
                                          userInfo.userID =
                                              model.data!.id.toString();
                                          userInfo.userName =
                                              model.data!.name.toString();
                                          await ZIM
                                              .getInstance()!
                                              .login(userInfo);
                                          Navigator.of(context).pop;
                                          print('success');
                                          UserModel.shared().userInfo =
                                              userInfo;
                                          final prefs = await SharedPreferences
                                              .getInstance();
                                          await prefs.setString('userID',
                                              model.data!.id.toString());
                                          await prefs.setString('userName',
                                              model.data!.name.toString());
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DashBoardScreen(
                                                        pageIndex: 1,
                                                        isNotification: false,
                                                      )));
                                        } on PlatformException catch (onError) {
                                          Navigator.of(context).pop();
                                        }
                                      }
                                    } else if (signupverifymodel.statusCode ==
                                        422) {
                                      setState(() {
                                        isLoad = false;
                                      });
                                      showSnakbar(
                                          signupverifymodel.message!, context);
                                    } else {
                                      setState(() {
                                        isLoad = false;
                                      });
                                      showSnakbar(
                                          signupverifymodel.message!, context);
                                    }
                                  } else if (socialrole == "social") {
                                    var signupverifymodel =
                                        await auth.otpVerify(
                                            preferences!
                                                .getString("token")
                                                .toString(),
                                            code.toString());
                                    if (signupverifymodel.statusCode == 200) {
                                      preferences!
                                          .setBool("accountcreated", true);
                                      setState(() {
                                        isLoad = false;
                                      });
                                      preferences!.setString("accesstoken",
                                          signupverifymodel.data!.accessToken!);
                                      preferences!.setString(
                                          "user_id",
                                          signupverifymodel.data!.id
                                              .toString());
                                      String? token = await FirebaseMessaging
                                          .instance
                                          .getToken();
                                      print("my device token 5");
                                      print(token);
                                      var model =
                                          await ProfileRepository.updateProfile(
                                              token.toString(),
                                              "device_token",
                                              preferences!
                                                  .getString("accesstoken")!);
                                      if (model.statusCode == 200) {
                                        try {
                                          ZIMUserInfo userInfo = ZIMUserInfo();
                                          userInfo.userID =
                                              model.data!.id.toString();
                                          userInfo.userName =
                                              model.data!.name.toString();
                                          await ZIM
                                              .getInstance()!
                                              .login(userInfo);
                                          Navigator.of(context).pop;
                                          print('success');
                                          UserModel.shared().userInfo =
                                              userInfo;
                                          final prefs = await SharedPreferences
                                              .getInstance();
                                          await prefs.setString('userID',
                                              model.data!.id.toString());
                                          await prefs.setString('userName',
                                              model.data!.name.toString());
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AccountCreatedScreen()));
                                        } on PlatformException catch (onError) {
                                          Navigator.of(context).pop();
                                        }
                                      }
                                    } else if (signupverifymodel.statusCode ==
                                        422) {
                                      setState(() {
                                        isLoad = false;
                                      });
                                      showSnakbar(
                                          signupverifymodel.message!, context);
                                    } else {
                                      setState(() {
                                        isLoad = false;
                                      });
                                      showSnakbar(
                                          signupverifymodel.message!, context);
                                    }
                                  } else {
                                    print(
                                        'otp token=${preferences!.getString("token").toString()}');
                                    print('22222222');
                                    var signupverifymodel =
                                        await auth.otpVerify(
                                            preferences!
                                                .getString("token")
                                                .toString(),
                                            code.toString());
                                    if (signupverifymodel.statusCode == 200) {
                                      setState(() {
                                        isLoad = false;
                                      });
                                      preferences!.setString("accesstoken",
                                          signupverifymodel.data!.accessToken!);
                                      preferences!.setString(
                                          "user_id",
                                          signupverifymodel.data!.id
                                              .toString());
                                      String? token = await FirebaseMessaging
                                          .instance
                                          .getToken();
                                      print("my device token 6");
                                      print(token);
                                      var model =
                                          await ProfileRepository.updateProfile(
                                              token.toString(),
                                              "device_token",
                                              preferences!
                                                  .getString("accesstoken")!);
                                      if (model.statusCode == 200) {
                                        print('statusCode == 200');
                                        try {
                                          ZIMUserInfo userInfo = ZIMUserInfo();
                                          userInfo.userID =
                                              model.data!.id.toString();
                                          userInfo.userName =
                                              model.data!.name.toString();
                                          await ZIM
                                              .getInstance()!
                                              .login(userInfo);
                                          Navigator.of(context).pop;
                                          print('success');
                                          UserModel.shared().userInfo =
                                              userInfo;
                                          final prefs = await SharedPreferences
                                              .getInstance();
                                          await prefs.setString('userID',
                                              model.data!.id.toString());
                                          await prefs.setString('userName',
                                              model.data!.name.toString());
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      EmailScreen()));
                                        } on PlatformException catch (onError) {
                                          Navigator.of(context).pop();
                                        }
                                      }
                                    } else if (signupverifymodel.statusCode ==
                                        422) {
                                      setState(() {
                                        isLoad = false;
                                      });
                                      print('statusCode == 422');
                                      showSnakbar(
                                          signupverifymodel.message!, context);
                                    } else {
                                      setState(() {
                                        isLoad = false;
                                      });
                                      showSnakbar(
                                          signupverifymodel.message!, context);
                                    }
                                  }
                                }
                              },
                              child: Container(
                                  height: 70.h,
                                  margin: EdgeInsets.only(
                                      left: 25.w, right: 25.w, bottom: 15.h),
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: <Color>[
                                          Color(0xFF570084),
                                          Color(0xFFA33BE5)
                                        ],
                                      ),
                                      borderRadius:
                                          BorderRadius.circular(50.r)),
                                  alignment: Alignment.center,
                                  child: addMediumText(
                                      AppLocalizations.of(context)!.continues,
                                      14,
                                      Color(0xFFFFFFFF))),
                            )
                          : Container(
                              child: CircularProgressIndicator(),
                              alignment: Alignment.topCenter,
                            )
                      : Container(
                          height: 70.h,
                          margin: EdgeInsets.only(
                              top: 90.h, left: 25.w, right: 25.w, bottom: 15.h),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color(0xFFC2A3DD), width: 1.0),
                              borderRadius: BorderRadius.circular(50.r)),
                          alignment: Alignment.center,
                          child: addMediumText(
                              AppLocalizations.of(context)!.continues,
                              14,
                              Color(0xFFC2A3DD)),
                        ),
                  // Container(
                  //   margin: EdgeInsets.only(bottom: 15.h),
                  //   child: Container(
                  //     height: 8.h,
                  //     width: 140.w,
                  //     decoration: BoxDecoration(
                  //         color: Colors.black,
                  //         borderRadius: BorderRadius.circular(25.r)),
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<String?> signInWithEmailAndPassword(
      String email, String password) async {
    String errorMessage;
    User? user;
    FirebaseFirestore firebasStorage = FirebaseFirestore.instance;
    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      user = userCredential.user;
      if (user!.uid.isNotEmpty) {
        if (user != null) {
          print("hrlooooo");
          // Check is already sign up
          final QuerySnapshot result = await firebasStorage
              .collection('users')
              .where('id', isEqualTo: user.uid)
              .get();
          final List<DocumentSnapshot> documents = result.docs;
          print("========..........${documents.length}");
          if (documents.length == 0) {
            // Update data to server if new user
            firebasStorage.collection('users').doc(user.uid).set(
                {'nickname': email, 'photoUrl': user.photoURL, 'id': user.uid});
          }
        }

        return 'Success';
      }
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case "ERROR_EMAIL_ALREADY_IN_USE":
        case "account-exists-with-different-credential":
        case "email-already-in-use":
          errorMessage = "Email already used. Go to login page.";
          break;
        case "ERROR_WRONG_PASSWORD":
        case "wrong-password":
          errorMessage = "Wrong email/password combination.";
          break;
        case "ERROR_USER_NOT_FOUND":
        case "user-not-found":
          errorMessage = "No user found with this email.";
          print("herererer");
          createAccountWithEmail(email, "12345678");
          break;
        case "ERROR_USER_DISABLED":
        case "user-disabled":
          errorMessage = "User disabled.";
          break;
        case "ERROR_TOO_MANY_REQUESTS":
        case "operation-not-allowed":
          errorMessage = "Too many requests to log into this account.";
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
        case "operation-not-allowed":
          errorMessage = "Server error, please try again later.";
          break;
        case "ERROR_INVALID_EMAIL":
        case "invalid-email":
          errorMessage = "Email address is invalid.";
          break;
        default:
          errorMessage = "Login failed. Please try again.";
          break;
      }

      return errorMessage;
    }

    return null;
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
}

class SampleStrategy extends OTPStrategy {
  @override
  Future<String> listenForCode() {
    return Future.delayed(
      const Duration(seconds: 4),
      () => '',
    );
  }
}
