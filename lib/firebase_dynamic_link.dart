import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:moorky/auth/view/resetpassword_screen.dart';

class FirebaseDynamiclink{
  static Future<void> initDynamicLink()async {
    FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
      final Uri deepLink = dynamicLinkData.link;
      //print(deepLink.path);
      //print(deepLink.toString().split("https://moorkyapp.page.link/resetpassword?token").last);
      var isnewpassword=deepLink.pathSegments.contains('resetpassword');
      if(isnewpassword)
      {
        String token = deepLink.queryParameters['token']!;
        print(token);
        //print(deepLink.toString().split("https://moorkyapp.page.link/newpassword?id"));
        //print(deepLink.pathSegments);
        Get.off(ResetPassword_Screen(token: token.toString(),));
      }
      }).onError((error) {
        print('onLink error');
        print(error.message);
      });
  }
}