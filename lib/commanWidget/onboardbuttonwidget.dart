import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:moorky/constant/color.dart';

Widget onBoardProgress(double progress) {
  return Stack(
    children: [
      Container(
        width: 240.w,
        height: 8.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2.sp),
            color: Colorss.mainColor.withOpacity(0.2)),
      ),
      Container(
          height: 8.h,
          width: progress,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2.sp),
              color: Colorss.mainColor))
    ],
  );
}

Widget onBoardBackwardButton(ontap) {
  return GestureDetector(
      onTap: ontap,
      child: SvgPicture.asset('assets/images/backward.svg'));
}

Widget onBoardForwardButton(ontap) {
  return GestureDetector(
      onTap: ontap, child: SvgPicture.asset('assets/images/forward.svg'));
}


