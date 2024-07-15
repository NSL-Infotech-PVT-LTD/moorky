import 'package:flutter/cupertino.dart';
import 'package:moorky/dashboardscreen/view/dashboardscreen.dart';
import 'package:moorky/splashscreen/view/splashScreen.dart';

import 'auth/view/login_screen.dart';
final Map<String, WidgetBuilder> routes = {
  '/': (context) => SplashScreen(isNotification: false,),
  // '/': (context) => WebViewWidget(),
  '/login': (context) => Login_Screen(),
  '/home': (context) => DashBoardScreen(pageIndex: 1,isNotification: false,),
};