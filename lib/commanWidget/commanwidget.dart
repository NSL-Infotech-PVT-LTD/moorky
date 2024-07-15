import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moorky/constant/color.dart';
Container loginwidget(String name,String svgIcon)
{
  return Container(
    height: 70.h,
    margin: EdgeInsets.only(top: 15.h,left: 25.w,right: 25.w),
    child: Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(50.r))),
      color: Color(0XFFFFFEFE),
      child: Row(
        children: [
          SizedBox(width: 70,),
          Container(
            width: 30.w,
            child: SvgPicture.asset(
              svgIcon,
              height: 20.h,
              width: 20.w,
              fit: BoxFit.contain,
            ),
          ),
          addMediumText(name,14,Colorss.mainColor)
        ],
      ),
    ),
  );
}


showSnakbar(String message,BuildContext context){
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message),backgroundColor: Colorss.mainColor,
    behavior: SnackBarBehavior.floating,
    margin: EdgeInsets.only(bottom: 10),
    duration: Duration(milliseconds: 1000),
  ));
}


Text addBoldText(text,double fontsize,color){
  return Text(text,textScaleFactor:1.0,style: GoogleFonts.poppins(
    fontWeight: FontWeight.w700,
    fontSize: fontsize,
    color: color
  ),);
}
Text addBoldCenterText(text,double fontsize,color){
  return Text(text,textScaleFactor:1.0,
    textAlign: TextAlign.center,
    style: GoogleFonts.poppins(
      fontWeight: FontWeight.w700,
      fontSize: fontsize,
      color: color
  ),);
}
Text addSemiBoldText(text,double fontsize,color){
  return Text(text,textScaleFactor:1.0,style: GoogleFonts.poppins(
      fontWeight: FontWeight.w600,
      fontSize: fontsize,
      color: color
  ),);
}
Text addSemiElipsBoldText(text,double fontsize,color){
  return Text(text,textScaleFactor:1.0,maxLines:1,
    overflow: TextOverflow.ellipsis,style: GoogleFonts.poppins(
      fontWeight: FontWeight.w600,
      fontSize: fontsize,
      color: color
  ),);
}
Text addSemiBoldCenterText(text,double fontsize,color){
  return Text(text,
    textAlign: TextAlign.center,
    textScaleFactor:1.0,style: GoogleFonts.poppins(
      fontWeight: FontWeight.w600,
      fontSize: fontsize,
      color: color,
  ),);
}
Text addMediumText(text,double fontsize,color){
  return Text(text,textScaleFactor:1.0,style: GoogleFonts.poppins(
      fontWeight: FontWeight.w500,
      fontSize: fontsize,
      color: color
  ),);
}
Text addMediumElipsText(text,double fontsize,color){
  return Text(text,textScaleFactor:1.0,
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
    style: GoogleFonts.poppins(
      fontWeight: FontWeight.w500,
      fontSize: fontsize,
      color: color
  ),);
}
Text addMediumUnderLineText(text,double fontsize,color){
  return Text(text,textScaleFactor:1.0,style: GoogleFonts.poppins(
      fontWeight: FontWeight.w500,
      decoration: TextDecoration.underline,
      fontSize: fontsize,
      color: color
  ),);
}
Text addMediumDecorationunderlineText(text,double fontsize,color){
  return Text(text,textScaleFactor:1.0,style: GoogleFonts.poppins(
      fontWeight: FontWeight.w500,
      decoration: TextDecoration.underline,
      fontSize: fontsize,
      color: color
  ),);
}
Text addLightText(text,double fontsize,color){
  return Text(text,textScaleFactor:1.0,style: GoogleFonts.poppins(
      fontWeight: FontWeight.w300,
      fontSize: fontsize,
      color: color
  ),);
}
Text addLightCenterText(text,double fontsize,color){
  return Text(text,textAlign: TextAlign.center,
    textScaleFactor:1.0,style: GoogleFonts.poppins(
      fontWeight: FontWeight.w300,
      fontSize: fontsize,
      color: color
  ),);
}
Text addBlackText(text,double fontsize,color){
  return Text(text,textScaleFactor:1.0,style: GoogleFonts.poppins(
      fontWeight: FontWeight.w900,
      fontSize: fontsize,
      color: color
  ),);
}
Text addRegularText(text,double fontsize,color){
  return Text(text,textScaleFactor:1.0,style: GoogleFonts.poppins(
      fontWeight: FontWeight.w400,
      fontSize: fontsize,
      color: color,
  ),
  overflow: TextOverflow.fade,maxLines: 2,);

}
Text addCenterRegularText(text,double fontsize,color){
  return Text(text??"",textScaleFactor:1.0,
    textAlign: TextAlign.center,
    style: GoogleFonts.poppins(
      fontWeight: FontWeight.w400,
      fontSize: fontsize,
      color: color,
  ),);

}
Text addunderlineRegularText(text,double fontsize,color,decoration){
  return Text(text,textScaleFactor:1.0,
    style: GoogleFonts.poppins(
      fontWeight: FontWeight.w400,
      decoration: decoration,
      fontSize: fontsize,
      color: color,
    ),);

}


