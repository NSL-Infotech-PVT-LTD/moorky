import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moorky/auth/view/emailsignin_screen.dart';
import 'package:moorky/auth/view/emailsignup_screen.dart';
import 'package:moorky/auth/view/forgetpassword_screen.dart';
import 'package:moorky/auth/view/resetpassword_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NewAccount_Screen extends StatefulWidget {
  const NewAccount_Screen({Key? key}) : super(key: key);

  @override
  State<NewAccount_Screen> createState() => _NewAccount_ScreenState();
}

class _NewAccount_ScreenState extends State<NewAccount_Screen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
            leading:
            InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: (){
                  Navigator.of(context).pop();
                },
                child: SvgPicture.asset("assets/images/cross.svg",fit: BoxFit.scaleDown,color: Color(0xFf000000),)),
          title: Container(
              child: Image.asset("assets/images/moorky2.png",fit: BoxFit.scaleDown,height: 60.h,width: 100.w,)),
          centerTitle: true,
          elevation: 0.0,
          bottom: TabBar(
            unselectedLabelColor: Color(0xFFAB60ED),
            indicatorColor: Color(0xFFAB60ED),
            labelColor: Color(0xFF6B18C3),
            labelStyle: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.w500),
            labelPadding: EdgeInsets.zero,
            tabs: [
              Tab(text: AppLocalizations.of(context)!.newaccount,),
              Tab(text: AppLocalizations.of(context)!.login,),
            ],
          ),
        ),

        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
           EmailSignup_Screen(),
            EmailSignIn_Screen()
          ],
        ),
      ),
    );
  }
}
