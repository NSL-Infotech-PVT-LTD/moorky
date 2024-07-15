import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:moorky/auth/provider/authprovider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:moorky/auth/view/email_screen.dart';
import 'package:moorky/auth/view/newaccount_screen.dart';
import 'package:moorky/auth/view/password_screen.dart';
import 'package:moorky/auth/view/phonelogin_screen.dart';
import 'package:moorky/dashboardscreen/view/dashboardscreen.dart';
import 'package:moorky/lang/provider/locale_provider.dart';
import 'package:moorky/profilecreate/repository/profileRepository.dart';
import 'package:moorky/settingscreen/view/privacypolicyscreen.dart';
import 'package:moorky/settingscreen/view/termsofusescreen.dart';
import 'package:moorky/zegocloud/model/user_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:zego_zim/zego_zim.dart';
import '../../commanWidget/commanwidget.dart';
import '../../constant/Images.dart';

String role = "";
String socialrole = "";

class Login_Screen extends StatefulWidget {
  const Login_Screen({Key? key}) : super(key: key);

  @override
  State<Login_Screen> createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen> {
  Future<bool> _onBackPressed() async {
    return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.areyousure),
          content: Text(AppLocalizations.of(context)!.doyouwantto),
          actions: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop(false);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  AppLocalizations.of(context)!.no,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop(true);
                SystemNavigator.pop();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  AppLocalizations.of(context)!.yes,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  SharedPreferences? preferences;
  @override
  void initState() {
    Init();
    super.initState();
  }

  void Init() async {
    preferences = await SharedPreferences.getInstance();
    var profileprovider=Provider.of<LocaleProvider>(context,listen: false);
    profileprovider.getLocaleFromSettings();
  }

  bool isLoad = false;
  bool appleisLoad = false;
  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);
    return WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  Image.asset(
                    AppLocalizations.of(context)!.loginbg,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fill,
                    height: MediaQuery.of(context).size.height,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (Platform.isIOS)
                          GestureDetector(
                              onTap: () async {
                                setState(() {
                                  appleisLoad = true;
                                });
                                socialrole = "social";
                                final _apple =
                                    await SignInWithApple.getAppleIDCredential(
                                        scopes: [
                                      AppleIDAuthorizationScopes.email,
                                      AppleIDAuthorizationScopes.fullName
                                    ]);
                                String appleemail="";
                                if(_apple.email==null)
                                  {
                                    setState(() {
                                      appleemail="";
                                    });
                                  }
                                else{
                                  setState(() {
                                    appleemail=_apple.email.toString();
                                  });
                                }
                                print(appleemail);
                                var passwordmodel = await auth.socialsignup(
                                    appleemail.toString(),
                                    "apple",
                                    _apple.userIdentifier.toString());
                                if (passwordmodel.statusCode == 200) {
                                  signInWithEmailAndPassword( appleemail.toString(),"12345678");
                                  setState(() {
                                    appleisLoad = false;
                                  });
                                  
                                  print(passwordmodel.data!.accessToken!);
                                  preferences!.setString("accesstoken",
                                      passwordmodel.data!.accessToken!);
                                  if (passwordmodel.alreadyRegister!) {
                                    preferences!
                                        .setString("realphoto", "realphoto");
                                    String? token = await FirebaseMessaging
                                        .instance
                                        .getToken();
                                    print("my device token");
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
                                        userInfo.userID=model.data!.id.toString();
                                        userInfo.userName=model.data!.name.toString();
                                     //  //await ZIM.getInstance()!.login(userInfo);
                                        Navigator.of(context).pop;
                                        print('success');
                                        UserModel.shared().userInfo = userInfo;
                                        final prefs = await SharedPreferences.getInstance();
                                        await prefs.setString('userID', model.data!.id.toString());
                                        await prefs.setString('userName', model.data!.name.toString());
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DashBoardScreen(pageIndex: 1,isNotification: false,)));
                                      } on PlatformException catch (onError) {
                                        Navigator.of(context).pop();
                                      }

                                    }
                                  } else {
                                    setState(() {
                                      appleisLoad = false;
                                    });
                                    String? token = await FirebaseMessaging
                                        .instance
                                        .getToken();
                                    print("my device token");
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
                                        userInfo.userID=model.data!.id.toString();
                                        userInfo.userName=model.data!.name.toString();
                                       //await ZIM.getInstance()!.login(userInfo);
                                        Navigator.of(context).pop;
                                        print('success');
                                        UserModel.shared().userInfo = userInfo;
                                        final prefs = await SharedPreferences.getInstance();
                                        await prefs.setString('userID', model.data!.id.toString());
                                        await prefs.setString('userName', model.data!.name.toString());
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    PhoneLogin_Screen()));
                                      } on PlatformException catch (onError) {
                                        Navigator.of(context).pop();
                                      }

                                    }
                                  }
                                }
                              },
                              child: loginwidget(
                                  AppLocalizations.of(context)!.signinapple,
                                  Images.apple)),
                        InkWell(
                            onTap: () async {
                              setState(() {
                                isLoad = true;
                              });
                              role = "";

                              final _google =
                                  GoogleSignIn.standard(scopes: ['email']);
                              await _google.signIn();
                              print(_google.currentUser.toString());
                              if (_google.currentUser!.email.isNotEmpty) {
                                setState(() {
                                  socialrole = "social";
                                });
                              }
                              GoogleSignInAuthentication googleAuth = await _google.currentUser!.authentication;
                              FirebaseFirestore firebasStorage=  FirebaseFirestore.instance;
                              final AuthCredential credential = GoogleAuthProvider.credential(
                                accessToken: googleAuth.accessToken,
                                idToken: googleAuth.idToken,
                              );
                              User? firebaseUser= (await FirebaseAuth.instance.signInWithCredential(credential)).user;

                              if (firebaseUser != null) {
                                signInWithEmailAndPassword( _google.currentUser!.email.toString(),"12345678");

                                // Check is already sign up
                                final QuerySnapshot result =
                                await firebasStorage.collection('users').where('id', isEqualTo: firebaseUser.uid).get();
                                final List < DocumentSnapshot > documents = result.docs;
                                print("========..........${documents.length}");
                                if (documents.length == 0) {
                                  // Update data to server if new user
                                  firebasStorage.collection('users').doc(firebaseUser.uid).set(
                                      { 'nickname': firebaseUser.displayName, 'photoUrl': firebaseUser.photoURL, 'id': firebaseUser.uid });
                                }
                              }

                              print(_google.currentUser!.email.toString());
                              print(socialrole);
                              print(_google.currentUser!.id.toString());
                              var passwordmodel = await auth.socialsignup(
                                  _google.currentUser!.email,
                                  "google",
                                  _google.currentUser!.id);
                              if (passwordmodel.statusCode == 200) {
                                setState(() {
                                  isLoad = false;
                                });
                                print(passwordmodel.data!.accessToken!);
                                preferences!.setString("accesstoken",
                                    passwordmodel.data!.accessToken!);
                                if (passwordmodel.alreadyRegister!) {
                                  preferences!
                                      .setString("realphoto", "realphoto");
                                  String? token = await FirebaseMessaging
                                      .instance
                                      .getToken();
                                  print("my device token");
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
                                      userInfo.userID=model.data!.id.toString();
                                      userInfo.userName=model.data!.name.toString();
                                     ////await ZIM.getInstance()!.login(userInfo);
                                      Navigator.of(context).pop;
                                      print('success');
                                      UserModel.shared().userInfo = userInfo;
                                      final prefs = await SharedPreferences.getInstance();
                                      await prefs.setString('userID', model.data!.id.toString());
                                      await prefs.setString('userName', model.data!.name.toString());
                                      await prefs.setString('email', model.data!.email.toString());
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DashBoardScreen(pageIndex: 1,isNotification: false,)));
                                    } on PlatformException catch (onError) {
                                      Navigator.of(context).pop();
                                    }

                                  }
                                } else {
                                  String? token = await FirebaseMessaging
                                      .instance
                                      .getToken();
                                  print("my device token");
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
                                      userInfo.userID=model.data!.id.toString();
                                      userInfo.userName=model.data!.name.toString();
                                     //await ZIM.getInstance()!.login(userInfo);
                                      Navigator.of(context).pop;
                                      print('success');
                                      UserModel.shared().userInfo = userInfo;
                                      final prefs = await SharedPreferences.getInstance();
                                      await prefs.setString('userID', model.data!.id.toString());
                                      await prefs.setString('userName', model.data!.name.toString());
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PasswordScreen()));
                                    } on PlatformException catch (onError) {
                                      Navigator.of(context).pop();
                                    }


                                  }
                                }
                              }
                            },
                            child: loginwidget(
                                AppLocalizations.of(context)!.signingoogle,
                                Images.google)),
                        InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            role = "phone";
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PhoneLogin_Screen()),
                            );
                          },
                          child: loginwidget(
                              AppLocalizations.of(context)!.signinnumber,
                              Images.phone),
                        ),
                        InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            role = "email";
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NewAccount_Screen()),
                            );
                          },
                          child: loginwidget(
                              AppLocalizations.of(context)!.signinmail,
                              Images.email),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.to(TermsofUseScreen());
                              },
                              child: Text(
                                  AppLocalizations.of(context)!.termsofuse,
                                  textScaleFactor: 1.0,
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: Color(0xFFFFFFFF),
                                          fontWeight: FontWeight.normal,
                                          decoration: TextDecoration.underline,
                                          fontSize: 12))),
                            ),
                            addRegularText(
                                " ${AppLocalizations.of(context)!.and} ",
                                12,
                                Color(0xFFFFFFFF)),
                            GestureDetector(
                              onTap: () {
                                Get.to(PrivacyPolicyScreen());
                              },
                              child: Text(
                                  AppLocalizations.of(context)!.privacypolicy,
                                  textScaleFactor: 1.0,
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: Color(0xFFFFFFFF),
                                          decoration: TextDecoration.underline,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 12))),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        // Container(
                        //   height: 8.h,
                        //   width: 140.w,
                        //   decoration: BoxDecoration(
                        //       color: Colors.black,
                        //       borderRadius: BorderRadius.circular(25.r)),
                        // ),
                        SizedBox(
                          height: 15.h,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
  Future<String?> signInWithEmailAndPassword(String email,String password) async {
    String errorMessage;
    User? user;
    FirebaseFirestore firebasStorage=  FirebaseFirestore.instance;
    try {

      final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
      preferences!.setString("email",email);
      if(user!.uid.isNotEmpty){
        if (user != null) {
          print("hrlooooo");
          // Check is already sign up
          final QuerySnapshot result =
          await firebasStorage.collection('users').where('id', isEqualTo: user.uid).get();
          final List < DocumentSnapshot > documents = result.docs;
          print("========..........${documents.length}");
          if (documents.length == 0) {
            // Update data to server if new user
            firebasStorage.collection('users').doc(user.uid).set(
                { 'nickname':email, 'photoUrl': user.photoURL, 'id': user.uid });
          }
        }

        return 'Success';
      }

    }
    on FirebaseAuthException catch (error) {
      switch (error.code) {
        case "ERROR_EMAIL_ALREADY_IN_USE":
        case "account-exists-with-different-credential":
        case "email-already-in-use":
          errorMessage = "Email already used. Go to login page.";
          break;
        case "ERROR_WRONG_PASSWORD":
        case "wrong-password":
          errorMessage =  "Wrong email/password combination.";
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
          errorMessage =  "Email address is invalid.";
          break;
        default:
          errorMessage =  "Login failed. Please try again.";
          break;
      }

      return errorMessage;
    }

    return null;

  }
  Future<String?> createAccountWithEmail(String email,String password) async{
    String errorMessage;
    User? user;
    FirebaseFirestore firebasStorage=  FirebaseFirestore.instance;
    try{

      final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      user = userCredential.user;
      if(user!.uid.isNotEmpty){

         firebasStorage.collection('users').doc(user.uid).set(
            {'nickname': email, 'photoUrl': user.photoURL, 'id': user.uid,"isTyping":false});

        return 'Success';
      }
    }
    on FirebaseAuthException catch (error){

      switch (error.code) {
        case "EMAIL_ALREADY_IN_USE":
        case "email-already-in-use":
          errorMessage = "Email already used. Go to login page.";
          break;
        default:
          errorMessage =  "Login failed. Please try again.";
          break;
      }

      return errorMessage;
    }

    return null;
  }
}
