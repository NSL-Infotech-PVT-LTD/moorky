import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moorky/accountcreatedscreen/view/accountcreatedscreen.dart';
import 'package:moorky/auth/provider/authprovider.dart';
import 'package:moorky/auth/view/password_screen.dart';
import 'package:moorky/auth/view/phonelogin_screen.dart';
import 'package:moorky/commanWidget/commanwidget.dart';
import 'package:moorky/constant/color.dart';
import 'package:moorky/dashboardscreen/provider/chat_provider.dart';
import 'package:moorky/dashboardscreen/view/dashboardscreen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_screen.dart';

class PasswordScreen extends StatefulWidget {
  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  bool _obscureText = true;
  String password = "";
  var _formKey = GlobalKey<FormState>();
  var _scaKey = GlobalKey<ScaffoldState>();
  bool isTrue = false;
  bool isLoad = false;
  TextEditingController passwordController = new TextEditingController();
  SharedPreferences? preferences;
  @override
  void initState() {
    Init();
    super.initState();
  }

  void Init() async {
    preferences = await SharedPreferences.getInstance();
  }

  bool validatePassword(String value) {
    String pattern = '' r'^(?=.*?[A-Za-z])(?=.*?[0-9]).{8,}$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);
    return Scaffold(
      key: _scaKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: addMediumText(
            AppLocalizations.of(context)!.password,
            18,
            Colorss.mainColor,
          ),
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
                    SizedBox(
                      height: 120.h,
                    ),
                    Container(
                        padding: EdgeInsets.only(left: 20.w, right: 60.w),
                        child: addLightText(
                            AppLocalizations.of(context)!.setapassword,
                            12,
                            Color(0xFF15294B))),
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20.w),
                      child: TextFormField(
                        controller: passwordController,
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(fontSize: 16)),
                        textCapitalization: TextCapitalization.sentences,
                        maxLength: 32,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(top: 25.h),
                          isDense: true,
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFC2A3DD)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFC2A3DD)),
                          ),
                          hintText: AppLocalizations.of(context)!.passwordeight,
                          hintStyle: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  color: Color(0xFFC2A3DD), fontSize: 14)),
                          suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                              child: Padding(
                                padding: EdgeInsets.only(top: 15),
                                child: Icon(
                                  _obscureText
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.grey,
                                ),
                              )),
                        ),
                        obscureText: _obscureText,
                        keyboardType: TextInputType.text,
                        onChanged: (value) {
                          setState(() {
                            if (value.isEmpty) {
                              isTrue = false;
                            } else if (value.length > 6) {
                              isTrue = true;
                            } else {
                              isTrue = false;
                            }
                            password = value;
                          });
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppLocalizations.of(context)!
                                .pleaseenterpassword;
                          } else if (value.length < 8) {
                            return AppLocalizations.of(context)!
                                .pleasemimi8digit;
                          } else if (!validatePassword(value)) {
                            return AppLocalizations.of(context)!
                                .pleasepasswordshuould;
                          } else if (value.length > 32) {
                            return AppLocalizations.of(context)!
                                .pleasemaximum32;
                          }
                          return null;
                        },
                      ),
                    ),
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
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    setState(() {
                                      isLoad = true;
                                    });
                                    if (role == "email") {
                                      var passwordmodel =
                                          await auth.emailsignup(
                                              preferences!
                                                  .getString("email")
                                                  .toString(),
                                              password,
                                              "signup");
                                      if (passwordmodel.statusCode == 200) {
                                        setState(() {
                                          isLoad = false;
                                        });
                                        preferences!.setString("accesstoken",
                                            passwordmodel.data!.accessToken!);
                                        if (passwordmodel.alreadyRegister!) {
                                          createAccountWithEmail(
                                              preferences!
                                                  .getString("email")
                                                  .toString(),
                                              "12345678");
                                          preferences!.setString(
                                              "realphoto", "realphoto");
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DashBoardScreen(
                                                        pageIndex: 1,
                                                        isNotification: false,
                                                      )));
                                        } else {
                                          createAccountWithEmail(
                                              preferences!
                                                  .getString("email")
                                                  .toString(),
                                              "12345678");
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      PhoneLogin_Screen()));
                                        }
                                      } else if (passwordmodel.statusCode ==
                                          422) {
                                        setState(() {
                                          isLoad = false;
                                        });
                                        showSnakbar(
                                            passwordmodel.message!, context);
                                      } else {
                                        setState(() {
                                          isLoad = false;
                                        });
                                        showSnakbar(
                                            passwordmodel.message!, context);
                                      }
                                    } else {
                                      print("jkfkjdasgfasdf");
                                      var passwordmodel =
                                          await auth.updatePassword(
                                              password,
                                              preferences!
                                                  .getString("accesstoken")
                                                  .toString());
                                      if (passwordmodel.statusCode == 200) {
                                        setState(() {
                                          isLoad = false;
                                        });
                                        if (socialrole == "social") {
                                          String? res =await  createAccountWithEmail(
                                              preferences!
                                                  .getString("email")
                                                  .toString(),
                                              "12345678");
                                          if (res ==
                                              "Email already used. Go to login page.") {
                                            String? res =
                                            await signInWithEmailAndPassword(
                                                preferences!
                                                    .getString("email")
                                                    .toString(),
                                                "12345678");

                                            print("truurrr$res");
                                            late final ChatProvider
                                            chatProvider =
                                            context.read<ChatProvider>();
                                            String? newValue =
                                            await chatProvider
                                                .getUserCHatList(
                                                localId: res);
                                            print("newValuenewValue$newValue");
                                            if (newValue == "success") {
                                              print("hfdjdjdjdd");
                                              String? res =
                                              await createAccountWithEmail(
                                                  preferences!
                                                      .getString("email")
                                                      .toString(),
                                                  "12345678");

                                              print("dhdhdhdhdh$res");
                                            }
                                          }
                                          preferences!.setBool("accountcreated", true);
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      PhoneLogin_Screen()));
                                        }
                                        else {
                                          print("hbjkfvf");
                                          setState(() {
                                            isLoad = true;
                                          });
                                          String? res =
                                              await createAccountWithEmail(
                                                  preferences!
                                                      .getString("email")
                                                      .toString(),
                                                  "12345678");
                                          print("ghjkl;$res");

                                          if (res ==
                                              "Email already used. Go to login page.") {
                                            String? res =
                                                await signInWithEmailAndPassword(
                                                    preferences!
                                                        .getString("email")
                                                        .toString(),
                                                    "12345678");

                                            print("truurrr$res");
                                            late final ChatProvider
                                                chatProvider =
                                                context.read<ChatProvider>();
                                            String? newValue =
                                                await chatProvider
                                                    .getUserCHatList(
                                                        localId: res);
                                            print("newValuenewValue$newValue");
                                            if (newValue == "success") {
                                              print("hfdjdjdjdd");
                                              String? res =
                                                  await createAccountWithEmail(
                                                      preferences!
                                                          .getString("email")
                                                          .toString(),
                                                      "12345678");

                                              print("dhdhdhdhdh$res");
                                            }
                                          }
                                          preferences!.setBool("accountcreated", true);
                                          setState(() {
                                            isLoad = false;
                                          });
                                          Navigator.push(context,
                                              MaterialPageRoute(builder:
                                                  (context) =>
                                                  AccountCreatedScreen()
                                              )
                                          );
                                        }
                                      }
                                      else if (passwordmodel.statusCode ==
                                          422) {
                                        setState(() {
                                          isLoad = false;
                                        });
                                        showSnakbar(
                                            passwordmodel.message!, context);
                                      }
                                      else {
                                        setState(() {
                                          isLoad = false;
                                        });
                                        showSnakbar(
                                            passwordmodel.message!, context);
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
                                top: 90.h,
                                left: 25.w,
                                right: 25.w,
                                bottom: 15.h),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color(0xFFC2A3DD), width: 1.0),
                                borderRadius: BorderRadius.circular(50.r)),
                            alignment: Alignment.center,
                            child: addMediumText(
                                AppLocalizations.of(context)!.continues,
                                14,
                                Color(0xFFC2A3DD))),
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
      ),
    );
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
          print("hrlooooo${user.uid}");
          if (documents.length == 0) {
            // Update data to server if new user
            firebasStorage.collection('users').doc(user.uid).set(
                {'nickname': email, 'photoUrl': user.photoURL, 'id': user.uid});
          }
        }

        return '${user.uid}';
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
}
