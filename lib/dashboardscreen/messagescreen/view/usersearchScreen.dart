import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:moorky/commanWidget/commanwidget.dart';
import 'package:moorky/dashboardscreen/messagescreen/view/chat_screen.dart';
import 'package:moorky/dashboardscreen/provider/dashboardprovider.dart';
import 'package:moorky/dashboardscreen/repository/dashboardrepository.dart';
import 'package:moorky/profiledetailscreen/view/profiledetailscreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class UserSearch_Screen extends StatefulWidget {
  const UserSearch_Screen({Key? key}) : super(key: key);

  @override
  State<UserSearch_Screen> createState() => _UserSearch_ScreenState();
}

class _UserSearch_ScreenState extends State<UserSearch_Screen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(left: 15.w,right: 15.w),
        child: Column(
          children: [
            SizedBox(height: 2,),
            Consumer<DashboardProvider>(builder:
                (context,dataProvider,child){
              if(dataProvider.searchuserList != null)
              {
                return dataProvider.searchuserList!.length > 0
                    ?
                ListView.builder(
                  itemCount: dataProvider.searchuserList!.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: ScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: (){
                        Get.to(ProfileDetailScreen(user_id: dataProvider.searchuserList!.elementAt(index).id.toString(),isLike: false,isSelf: false,isSearch: true,));
                      },
                      child: Container(
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                        margin: EdgeInsets.only(bottom: 2.w,right: 2.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                    height: 60.h,
                                    width: 60.w,
                                    child: CircleAvatar(backgroundImage: NetworkImage(dataProvider.searchuserList!.elementAt(index).profile_image!.toString()),radius: 500,backgroundColor: Colors.white,)),
                                SizedBox(width: 15.w,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    addBoldText(dataProvider.searchuserList!.elementAt(index).name!.toString(), 12, Colors.black),
                                    SizedBox(height: 2.h,),
                                    addRegularText("#${dataProvider.searchuserList!.elementAt(index).id!.toString()}", 10, Colors.black),
                                    SizedBox(height: 2.h,),
                                    addRegularText("${dataProvider.searchuserList!.elementAt(index).city!.toString()}", 10, Colors.black)
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
                    :
                Center(child: Container(
                    child: Text("${AppLocalizations.of(context)!.nouserfound} 😔")
                ),);
              }
              return Center(child: CircularProgressIndicator(),);
            }),
          ],
        ),
      ),
    );
  }
}
