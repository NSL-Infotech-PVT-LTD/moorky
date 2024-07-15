import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moorky/auth/provider/authprovider.dart';
import 'package:moorky/auth/view/phonelogin_screen.dart';
import 'package:moorky/commanWidget/commanwidget.dart';
import 'package:moorky/constant/color.dart';
import 'package:moorky/dashboardscreen/provider/chat_provider.dart';
import 'package:moorky/dashboardscreen/view/dashboardscreen.dart';
import 'package:moorky/profilecreate/repository/profileRepository.dart';
import 'package:moorky/zegocloud/model/user_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zego_zim/zego_zim.dart';

class EmailSignup_Screen extends StatefulWidget {
  const EmailSignup_Screen({Key? key}) : super(key: key);

  @override
  State<EmailSignup_Screen> createState() => _EmailSignup_ScreenState();
}

class _EmailSignup_ScreenState extends State<EmailSignup_Screen> {
  var _formKey = GlobalKey<FormState>();
  var _scaKey = GlobalKey<ScaffoldState>();
  bool isTrue=false;
  bool isPassword=false;
  bool ispasswordmatch=false;
  bool iseyevisible=false;
  bool isLoad=false;
  bool validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }
  bool validatePassword(String value)
  {
    String pattern =
        ''r'^(?=.*?[A-Za-z])(?=.*?[0-9]).{8,}$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;

  }
  bool _obscureText = true;
  String email="";
  String password="";
  TextEditingController emailController=new TextEditingController();
  TextEditingController passwordController=new TextEditingController();
  SharedPreferences? preferences;
  @override
  void initState() {
    Init();
    super.initState();
  }
  void Init()async{
    preferences=await SharedPreferences.getInstance();
  }
  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);
    return Scaffold(
      key: _scaKey,
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: Container(
        height: 200.h,
        margin: EdgeInsets.only(left: 25.w,right: 25.w),
        child:  Column(
          children: [
            (isTrue&&isPassword)?!isLoad?InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: ()async{
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  setState(() {
                    isLoad=true;
                  });
                  var passwordmodel=await auth.emailsignup(email, password,"signup");

                  if(passwordmodel.statusCode==200)
                  {
                    String? res =await  createAccountWithEmail(
                        email
                            .toString(),
                        "12345678");
                    if (res ==
                        "Email already used. Go to login page.") {
                      String? res =
                      await signInWithEmailAndPassword(
                          email
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
                            email
                                .toString(),
                            "12345678");

                        print("dhdhdhdhdh$res");
                      }
                    }
                  //  preferences!.setBool("accountcreated", true);

                    setState(() {
                      isLoad=false;
                    });
                    preferences!.setString("accesstoken",passwordmodel.data!.accessToken!);
                    if(passwordmodel.alreadyRegister!)
                    {
                      preferences!.setString("realphoto","realphoto");
                      showSnakbar(passwordmodel.message.toString(), context);
                    }
                    else{
                      String? token = await FirebaseMessaging.instance.getToken();
                      print("my device token");
                      print(token);
                      var model=await ProfileRepository.updateProfile(token.toString(),"device_token", passwordmodel.data!.accessToken!);
                    if(model.statusCode==200)
                      {
                        try {
                          ZIMUserInfo userInfo = ZIMUserInfo();
                          userInfo.userID=model.data!.id.toString();
                          userInfo.userName=model.data!.name.toString();
                          print(userInfo.userID);
                          print(userInfo.userName);

                          Navigator.of(context).pop;
                          print('success');


                          UserModel.shared().userInfo = userInfo;
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.setString('userID', model.data!.id.toString());
                          await prefs.setString('userName', model.data!.name.toString());

                          Navigator.push(context,
                              MaterialPageRoute(builder:
                                  (context) =>
                                  PhoneLogin_Screen()
                              )
                          );
                         // await ZIM.getInstance()!.login(userInfo);

                        } on PlatformException catch (onError) {
                          Navigator.of(context).pop();
                        }

                      }
                    }
                  }
                  else if(passwordmodel.statusCode==422){
                    setState(() {
                      isLoad=false;
                    });
                    showSnakbar(passwordmodel.message.toString(), context);
                  }
                  else {
                    setState(() {
                      isLoad=false;
                    });
                    showSnakbar(passwordmodel.message.toString(), context);
                  }
                }
              },
              child: Container(
                  height: 70.h,
                  margin: EdgeInsets.only(top: 20.h),
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: <Color>[
                          Color(0xFF570084),
                          Color(0xFFA33BE5)
                        ],
                      ),
                      borderRadius: BorderRadius.circular(50.r)),
                  alignment: Alignment.center,
                  child: addMediumText(AppLocalizations.of(context)!.continues,14,
                      const Color(0xFFFFFFFF))
              ),
            ):Container(alignment: Alignment.topCenter,child: const CircularProgressIndicator(),):Container(
                height: 70.h,
                margin: EdgeInsets.only(top: 20.h),
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFC2A3DD),width: 1.0),

                    borderRadius: BorderRadius.circular(50.r)),
                alignment: Alignment.center,
                child:  addMediumText(AppLocalizations.of(context)!.continues,14,
                    const Color(0xFFC2A3DD))
            ),
            SizedBox(height: 10.h,),
            Text.rich(
                // textAlign:TextAlign.center,
                TextSpan(
                    text: "${AppLocalizations.of(context)!.weuseyouremail}\n",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                          color:
                          const Color(0xFF15294B).withOpacity(0.90)),
                    ),
                    children: <InlineSpan>[
                      TextSpan(
                        text: '${AppLocalizations.of(context)!.termsofuse} ${AppLocalizations.of(context)!.and} ',
                        style: GoogleFonts.poppins(
                          textStyle:
                          TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              color: Colorss.mainColor.withOpacity(0.90)
                          ),
                        ),
                      ),
                      TextSpan(
                        text: AppLocalizations.of(context)!.privacyplovy,
                        style: GoogleFonts.poppins(
                          textStyle:
                          TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              color: Colorss.mainColor.withOpacity(0.90)),
                        ),
                      ),
                    ]
                )
            ),

            // you can also use RichText

            // RichText(
            //     text: TextSpan(
            //               text: "${AppLocalizations.of(context)!.weuseyouremail}\n",
            //               style: GoogleFonts.poppins(
            //                 textStyle: TextStyle(
            //                     fontSize: 12,
            //                     fontWeight: FontWeight.w300,
            //                     color:
            //                     Color(0xFF15294B).withOpacity(0.90)),
            //               ),
            //       children: <InlineSpan>[
            //         TextSpan(
            //                     text: '${AppLocalizations.of(context)!.termsofuse} ${AppLocalizations.of(context)!.and} ',
            //                     style: GoogleFonts.poppins(
            //                       textStyle:
            //                       TextStyle(
            //                           fontSize: 12,
            //                           fontWeight: FontWeight.w300,
            //                           color: Colorss.mainColor.withOpacity(0.90)
            //                       ),
            //                     ),
            //                   ),
            //                   TextSpan(
            //                     text: AppLocalizations.of(context)!.privacyplovy,
            //                     style: GoogleFonts.poppins(
            //                       textStyle:
            //                       TextStyle(
            //                           fontSize: 12,
            //                           fontWeight: FontWeight.w300,
            //                           color: Colorss.mainColor.withOpacity(0.90)),
            //                     ),
            //                   ),
            //       ]
            // )),
          ],
        ),
      ),
      body: SizedBox(

        width:  MediaQuery.of(context).size.width,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const SizedBox(height: 30,),
                  Container(
                    margin: EdgeInsets.only(bottom: 15.h,left: 25.w,right: 25.w),
                    height: 60.h,
                    decoration: BoxDecoration( borderRadius: BorderRadius.circular(10.0),border: Border.all(color: const Color(0xFFEAE0F3),width: 0.5),
                        color: const Color(0xFFC2A3DD).withOpacity(0.20)),
                    alignment: Alignment.center,
                    child: TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!.youremail,
                          labelText: AppLocalizations.of(context)!.youremail,
                          labelStyle: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFFC2A3DD),
                              fontSize: 18.sp),
                          contentPadding: EdgeInsets.only(left: 10.w),
                          hintStyle: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFFC2A3DD),
                              fontSize: 18.sp),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(color: Color(0xFFEAE0F3),width: 0.5)
                          ),
                          border: InputBorder.none
                      ),
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value){
                        setState(() {
                          if(value.isEmpty)
                          {
                            isTrue=false;
                          }
                          else if(value.length>6){
                            isTrue=true;
                          }
                          else{
                            isTrue=false;
                          }
                          email=value;
                        });
                      },
                      validator: (value){
                        if(value!.isEmpty)
                        {
                          return AppLocalizations.of(context)!.pleaseenteremail;
                        }
                        else if(!validateEmail(value)){
                          return AppLocalizations.of(context)!.plesecorectemail;
                        }
                        else if(value.length>31)
                        {
                          return AppLocalizations.of(context)!.pleaseentermaxium30;
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 15.h,left: 25.w,right: 25.w),
                    height: 60.h,
                    decoration: BoxDecoration( borderRadius: BorderRadius.circular(10.0),border: Border.all(color: const Color(0xFFEAE0F3),width: 0.5),
                        color: const Color(0xFFC2A3DD).withOpacity(0.20)),
                    alignment: Alignment.center,
                    child: TextFormField(
                      controller: passwordController,
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!.passwordeight,
                          labelText: AppLocalizations.of(context)!.password,
                          labelStyle: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFFC2A3DD),
                              fontSize: 18.sp),
                          hintStyle: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFFC2A3DD),
                              fontSize: 18.sp),
                          contentPadding: EdgeInsets.only(left: 10.w),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(color: Color(0xFFEAE0F3),width: 0.5)
                          ),
                          border: InputBorder.none,
                        suffixIcon: SizedBox(
                          width: 60.w,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              isPassword?ispasswordmatch?SizedBox(width:20,height:20,child: SvgPicture.asset("assets/images/passwordchecked.svg",height: 15.h,width: 15.w,fit: BoxFit.scaleDown,)):Container(width:20,height:20,child: SvgPicture.asset("assets/images/passwordalert.svg",height: 20.h,width: 20.w,fit: BoxFit.scaleDown,)):Container(height: 20.h,width: 20.w,),
                              iseyevisible?GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                  child: Icon(_obscureText ? Icons.visibility : Icons.visibility_off,color: Color(0xFFAB60ED),size: 16,)
                              ):Container(),
                            ],
                          ),
                        )
                      ),
                      keyboardType: TextInputType.text,
                      onChanged: (value){
                        setState(() {
                          if(value.isNotEmpty)
                          {
                            iseyevisible=true;
                          }
                          if(value.isEmpty)
                          {
                            isPassword=false;
                          }
                          else if(value.length>6){
                            isPassword=true;
                          }

                          else{
                            isPassword=false;
                          }
                          if(validatePassword(value)){
                            ispasswordmatch=true;
                          }
                          else{
                            ispasswordmatch=false;
                          }

                          password=value;
                        });
                      },
                      validator: (value){
                        if(value!.isEmpty)
                        {
                          return AppLocalizations.of(context)!.pleaseenterpassword;
                        }
                        else if(value.length<8)
                        {
                          return AppLocalizations.of(context)!.pleasemimi8digit;
                        }
                        else if(!validatePassword(value)){
                          return AppLocalizations.of(context)!.pleasepasswordshuould;
                        }
                        else if(value.length>32)
                        {
                          return AppLocalizations.of(context)!.pleasemaximum32;
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
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
