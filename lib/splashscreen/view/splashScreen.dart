import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:moorky/accountcreatedscreen/view/accountcreatedscreen.dart';
import 'package:moorky/dashboardscreen/messagescreen/view/messagescreen.dart';
import 'package:moorky/dashboardscreen/view/dashboardscreen.dart';
import 'package:moorky/lang/provider/locale_provider.dart';
import 'package:moorky/quizscreens/view/questionscreen.dart';
import 'package:moorky/quizscreens/view/startquizscreen.dart';
import 'package:moorky/splashscreen/view/LocalAuthApi.dart';
import 'package:moorky/zegocloud/04_token_plugin/04_token_plugin.dart';
import 'package:moorky/zegocloud/model/user_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import 'package:zego_zim/zego_zim.dart';
import '../../auth/view/login_screen.dart';
import '../../profilecreate/view/namescreen.dart';

class SplashScreen extends StatefulWidget {
  bool isNotification=false;
  SplashScreen({required this.isNotification});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SharedPreferences? preferences;
  var hasfacelock=false;
  var isUserAuthenticated=false;
  final LocalAuthentication auth = LocalAuthentication();
  _SupportState _supportState = _SupportState.unknown;
  bool _canCheckBiometrics=false;
  List<BiometricType>? _availableBiometrics;
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;
  bool isaccountcreated = false;
  bool isinterested = false;
  String isRealPhoto = "";
  bool is_ghost = false;
  bool ghostactivate = false;

  Timer? _countTimer;
  int _countDown = 1;
  bool isResetZIM = false;
  static const int appID = 2092916647;

  static String appSign = '30594cb0fcb89d3b5b95a4503f32f53b300f379963868c18d6d22f703a642c5e';

  ///[VideoPlayerController]
  VideoPlayerController? _controller;
  @override
  void initState() {
    super.initState();
    var profileprovider=Provider.of<LocaleProvider>(context,listen: false);
    profileprovider.getLocaleFromSettings();
    _controller = VideoPlayerController.asset("assets/images/moorkysplash.mp4");
    _controller?.initialize().then((value)async{
      await _controller?.setVolume(0);
     await _controller?.play();
    });
    Init();
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
      });
    } on PlatformException catch (e) {
      print(e);
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Error - ${e.message}';
      });
      return;
    }
    if (!mounted) {
      return;
    }

    setState(
            () => _authorized = authenticated ? 'Authorized' : 'Not Authorized');
    setState(() {
      if(authenticated)
      {
        setState(() {
          Timer(Duration(seconds: 4), () {
            if (isRealPhoto != "") {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => DashBoardScreen(pageIndex: 1,isNotification: false,)));
            } else {
              if(isinterested)
              {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => StartQuizScreen(isGhostMode: is_ghost,)));
              }else{
                if(isaccountcreated)
                {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => NameScreen(name: "", isEdit: false,isGhost:ghostactivate)));
                }
                else{
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Login_Screen()));
                }

              }

            }
          });
        });
      }
    });
  }
  Future<void> _checkBiometrics() async {
    preferences = await SharedPreferences.getInstance();
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
      if(_canCheckBiometrics)
        {
          _authenticate();
        }
      print(_canCheckBiometrics);
    });
  }


  void Init() async {
    ZIMAppConfig appConfig = ZIMAppConfig();
    appConfig.appID = appID;
    appConfig.appSign = appSign;
    ZIM zim = ZIM.create(appConfig)!;
    bool isAuth=false;
    preferences = await SharedPreferences.getInstance();
    String userID='';
    String userName='';
    if(preferences!.getString("userID")!=null)
    {
      userID = preferences!.getString("userID")!;
    }

    if(preferences!.getString("userName")!=null)
    {
      userName = preferences!.getString("userName")!;
    }
    if(preferences!.getBool("enablefaceid")!=null)
      {
        isAuth = preferences!.getBool("enablefaceid")!;
      }
    if (preferences!.getBool("accountcreated") != null) {
      isaccountcreated = preferences!.getBool("accountcreated")!;
    }
    if (preferences!.getBool("inter") != null) {
      isinterested = preferences!.getBool("inter")!;
    }
    if (preferences!.getString("realphoto") != null) {
      isRealPhoto = preferences!.getString("realphoto")!;
    }
    if (preferences!.getBool("is_ghost") != null) {
      is_ghost = preferences!.getBool("is_ghost")!;
    }
    if (preferences!.getBool("ghostactivate") != null) {
      ghostactivate = preferences!.getBool("ghostactivate")!;
    }
    if(isAuth)
    {
      _checkBiometrics();
    }
    else{
      Timer(Duration(seconds: 4), () async{
        if (isRealPhoto != "") {
          if (userID != null && userID != '' && isResetZIM == false) {
            ZIM.getInstance()!.destroy();
            print('destory');
            ZIM.create(appConfig);
            print('create');
            isResetZIM = true;
          }
          if (userID != null && userID != '') {
            ZIMUserInfo userInfo = ZIMUserInfo();
            userInfo.userID = userID;
            if (userName != null) {
              userInfo.userName = userName;
            }
            try {
              String token = await TokenPlugin.makeToken(userInfo.userID);

              _countTimer?.cancel();
              _countTimer = null;
              UserModel.shared().userInfo = userInfo;
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => DashBoardScreen(pageIndex: 1,isNotification: false,)));
              await ZIM.getInstance()!.login(userInfo, token);
            } on PlatformException catch (onError) {
              _countTimer?.cancel();
              _countTimer = null;
            }
          }
          // Navigator.pushReplacement(
          //     context, MaterialPageRoute(builder: (context) => DashBoardScreen()));
        } else {
          if(isinterested)
          {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => StartQuizScreen(isGhostMode: is_ghost,)));
          }else{
            if(isaccountcreated)
            {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => NameScreen(name: "", isEdit: false,isGhost:ghostactivate)));
            }
            else{
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => Login_Screen()));
            }

          }

        }
      });
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        // child: VideoPlayer(_controller!)
        child: VideoPlayer(_controller!)
      ),
    );
  }
  @override
  void dispose() {

    _controller?.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}

enum _SupportState {
  unknown,
  supported,
  unsupported,
}
