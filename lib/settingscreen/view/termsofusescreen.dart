import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../constant/app_url.dart';
import '../../constant/color.dart';

class TermsofUseScreen extends StatefulWidget {
  const TermsofUseScreen({Key? key}) : super(key: key);

  @override
  State<TermsofUseScreen> createState() => _TermsofUseScreenState();
}

class _TermsofUseScreenState extends State<TermsofUseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent,elevation: 0,leading:
      InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: (){
            Navigator.of(context).pop();
          },
          child: SvgPicture.asset("assets/images/arrowback.svg",fit: BoxFit.scaleDown,))),
      body: WebView(
        initialUrl: '${AppUrl.baseUrl}terms',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
