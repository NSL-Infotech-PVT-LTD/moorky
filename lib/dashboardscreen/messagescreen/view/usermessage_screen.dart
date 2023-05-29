import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:moorky/commanWidget/commanwidget.dart';
import 'package:moorky/dashboardscreen/messagescreen/view/chat_screen.dart';
import 'package:moorky/dashboardscreen/messagescreen/view/hurraysupermatch_screen.dart';
import 'package:moorky/dashboardscreen/provider/dashboardprovider.dart';
import 'package:moorky/dashboardscreen/repository/dashboardrepository.dart';
import 'package:moorky/profilecreate/provider/profileprovider.dart';
import 'package:moorky/profiledetailscreen/view/matchprofiledetail.dart';
import 'package:moorky/zegocloud/peer/peer_chat_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constant/color.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class UserMessage_Screen extends StatefulWidget {
  const UserMessage_Screen({Key? key}) : super(key: key);

  @override
  State<UserMessage_Screen> createState() => _UserMessage_ScreenState();
}

class _UserMessage_ScreenState extends State<UserMessage_Screen> {
  int page=1;

  SharedPreferences? preferences;
  @override
  void initState() {
    Init();
    super.initState();
  }

  Init() async {
    preferences = await SharedPreferences.getInstance();
    var dashboardprovider=Provider.of<DashboardProvider>(context,listen: false);
    dashboardprovider.resetLikeUserList();
    dashboardprovider.resetChatlist();
    if(preferences!.getString("accesstoken")!=null)
    {
      dashboardprovider.fetchMatchesUserList(preferences!.getString("accesstoken").toString(),1,1000,"matches");
      dashboardprovider.fetchChatList(preferences!.getString("accesstoken").toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15.w,right: 15.w),
      child: Column(
        children: [
          SizedBox(height: 10.h,),
          addMediumText(AppLocalizations.of(context)!.matches, 16, Color(0xFF000000)),
          SizedBox(height: 15.h,),
          Container(
            height: 120.h,
            alignment: Alignment.topLeft,
            child: Consumer<DashboardProvider>(builder:
                (context,dataProvider,child){
              if(dataProvider.matchuserList != null)
              {
                return dataProvider.matchuserList!.length > 0
                    ?
                ListView.builder(
                  itemCount: dataProvider.matchuserList!.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: ScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: (){
                        var profileprovider = Provider.of<ProfileProvider>(context, listen: false);
                        profileprovider.UserProfileInit();
                        Get.to(MatchProfileDetailScreen(user_id: dataProvider.matchuserList!.elementAt(index).id.toString(),));
                       // Get.to(HurraySuperMatch_Screen(anotheruser: dataProvider.matchuserList!.elementAt(index).images!.elementAt(0).image,anotheruserId: dataProvider.matchuserList!.elementAt(index).id.toString(),));
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 20.w),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 85.w,
                              height: 85.h,
                              child:CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: SizedBox(
                                      height: 80.h,
                                      width: 80.w,
                                      child: CircleAvatar(backgroundImage: NetworkImage(dataProvider.matchuserList!.elementAt(index).images!.elementAt(0).image.toString()),radius: 500, backgroundColor: Colors.white,))),
                            ),
                            SizedBox(height: 8.h,),
                            addCenterRegularText(dataProvider.matchuserList!.elementAt(index).name!.toString(), 12, Colors.black)
                          ],
                        ),
                      ),
                    );
                  },
                )
                    :
                Center(child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset("assets/images/nomatches.svg"),
                    SizedBox(width: 30,),
                    Container(
                        child: addMediumText("${AppLocalizations.of(context)!.nomatches} 😔", 16.sp, Colors.black)
                    ),
                  ],
                ),);
              }
              return Center(child: CircularProgressIndicator(),);
            })

          ),
          SizedBox(height: 15.h,),
          Divider(color: Color(0xFFF2E7FA),thickness: 1.5,),
          SizedBox(height: 15.h,),
          Expanded(
            child: Consumer<DashboardProvider>(builder:
                (context,dataProvider,child){
              if(dataProvider.userChatListModel?.data != null)
              {
                return dataProvider.userChatListModel!.data!.length > 0
                    ?
                ListView.builder(
                  itemCount: dataProvider.userChatListModel!.data!.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: ScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 20.w,right: 10.w),
                      child: Row(
                        children: [
                          InkWell(
                            onTap:(){
                              var profilepro=Provider.of<ProfileProvider>(context,listen: false);
                              print("profilepro.activemonogomy");
                              print(profilepro.activemonogomy);
                              if(profilepro.activemonogomy)
                              {
                                if(profilepro.anotheruserID.toString()==dataProvider.userChatListModel!.data!.elementAt(index).userId.toString())
                                {
                                  Get.to(PeerChatPage(conversationID: dataProvider.userChatListModel!.data!.elementAt(index).userId.toString(), conversationName: dataProvider.userChatListModel!.data!.elementAt(index).user!.name.toString(),conversationImage: dataProvider.userChatListModel!.data!.elementAt(index).user!.profileImage.toString(),senderImage: profilepro.profileImage,));

                                  //Get.to(Chat(anotherUserId: ,username: , userimage: profilepro.profileImage, secondaryUserimage: ,));
                                }
                                else{
                                  showSnakbar(AppLocalizations.of(context)!.senderrormessage, context);
                                }
                              }
                              else{
                                if(dataProvider.userChatListModel!.data!.elementAt(index).user!.is_remove!)
                                  {
                                    showSnakbar(AppLocalizations.of(context)!.senderrormessage, context);
                                  }
                                else{
                                  Get.to(PeerChatPage(conversationID: dataProvider.userChatListModel!.data!.elementAt(index).userId.toString(), conversationName: dataProvider.userChatListModel!.data!.elementAt(index).user!.name.toString(),conversationImage: dataProvider.userChatListModel!.data!.elementAt(index).user!.profileImage.toString(),senderImage: profilepro.profileImage,));
                                }
                                // Get.to(Chat(anotherUserId: dataProvider.userChatListModel!.data!.elementAt(index).userId.toString(),username: dataProvider.userChatListModel!.data!.elementAt(index).user!.name.toString(), userimage: profilepro.profileImage, secondaryUserimage: dataProvider.userChatListModel!.data!.elementAt(index).user!.profileImage.toString(),));
                              }
                    },
                            child: SizedBox(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Stack(
                                    children: [
                                      SizedBox(
                                          height: 80.h,
                                          width: 80.w,
                                          child: CircleAvatar(backgroundImage: NetworkImage(dataProvider.userChatListModel!.data!.elementAt(index).user!.images!.elementAt(0).image.toString()),radius: 500,backgroundColor: Colors.white,)),
                                      dataProvider.userChatListModel!.data!.elementAt(index).user!.showLiveStatus?Container(
                                        height: 12,
                                        width: 12,
                                        margin: EdgeInsets.only(left: 53,top: 5),
                                        child: SvgPicture.asset("assets/images/onlinedot.svg"),
                                      ):Container(),
                                    ],
                                  ),
                                  SizedBox(width: 15.w,),
                                  Container(
                                    width: MediaQuery.of(context).size.width*0.50,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        addBoldText(dataProvider.userChatListModel!.data!.elementAt(index).user!.name, 12, Colors.black),
                                        SizedBox(height: 10.h,),
                                        addRegularText("${dataProvider.userChatListModel!.data!.elementAt(index).user!.latestMessage}", 10, Colors.black)
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              width: MediaQuery.of(context).size.width*0.83,
                            ),
                          ),
                          !dataProvider.userChatListModel!.data!.elementAt(index).isDeleteChat ? GestureDetector(
                            onTap: ()async{
                              setState(() {
                                dataProvider.userChatListModel!.data!.elementAt(index).isDeleteChat=true;
                              });
                              var isChatDelete=await DashboardRepository.userChatDelete(preferences!.getString("accesstoken").toString(),dataProvider.userChatListModel!.data!.elementAt(index).userId.toString());
                              if(isChatDelete)
                              {
                                setState(() {
                                  dataProvider.userChatListModel!.data!.elementAt(index).isDeleteChat=false;
                                  dataProvider.userChatListModel!.data!.removeAt(index);
                                });
                              }
                              else{
                                setState(() {
                                  dataProvider.userChatListModel!.data!.elementAt(index).isDeleteChat=false;
                                });
                              }
                            },
                              child: SvgPicture.asset("assets/images/notificationdelete.svg",height: 24.h,width: 24.w,)):CircularProgressIndicator(),

                        ],
                      ),
                    );
                  },
                )
                    :
                Center(child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset("assets/images/nomessage.svg"),
                    SizedBox(height: 20,),
                    Container(
                        child: addMediumText("${AppLocalizations.of(context)!.nomessage} 😔", 16.sp, Colors.black)
                    ),
                  ],
                ),);
              }
              return Center(child: CircularProgressIndicator(),);
            })
          ),
        ],
      ),
    );
  }
}
