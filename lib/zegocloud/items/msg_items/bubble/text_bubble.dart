import 'dart:ui';

import 'package:flutter/material.dart';

Widget TextBubble(String content,Color colors,Color txtColor,double bottomleft,double bottomRight,bool sender,String time){
  return ConstrainedBox(
    constraints: BoxConstraints(
        maxWidth: 250
    ),
    child: Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: const Radius.circular(15),
            topLeft: const Radius.circular(15),
            bottomLeft: sender
                ? const Radius.circular(15)
                : const Radius.circular(0),
            bottomRight: sender
                ? const Radius.circular(0)
                : const Radius.circular(15)),
        color: colors,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(fit: FlexFit.loose, child: Text(content,style: TextStyle(color: !sender?Colors.black:Colors.white),)),
         // Text(content,style: TextStyle(color:txtColor,fontSize: 18),),
          SizedBox(height: 3,),
          Text(time,style: TextStyle(color:txtColor,fontSize: 10)),
        ],
      ),
    ),
  );
}

