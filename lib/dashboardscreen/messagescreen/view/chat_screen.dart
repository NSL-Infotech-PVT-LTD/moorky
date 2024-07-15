import 'dart:io';

//import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:moorky/commanWidget/commanwidget.dart';
import 'package:moorky/constant/color.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:moorky/dashboardscreen/provider/dashboardprovider.dart';
import 'package:moorky/dashboardscreen/repository/dashboardrepository.dart';
import 'package:moorky/profilecreate/provider/profileprovider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Chat extends StatefulWidget {
  String anotherUserId="";
  String username="";
  String userimage="";
  String secondaryUserimage="";
  Chat({required this.anotherUserId,required this.username,required this.userimage,required this.secondaryUserimage});
  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  String message="";
  SharedPreferences? preferences;
  TextEditingController messageController=new TextEditingController();
  ScrollController scroll=ScrollController();
  bool emojiShowing = false;
  FocusNode focusNode=FocusNode();
  bool isSenderData=false;
  bool isRecevierData=false;
  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }
  @override
  void initState() {
    Init();
    focusNode.addListener(() {
      if(focusNode.hasFocus){
       setState(() {
         emojiShowing=false;
       });
      }
    });
    super.initState();
  }

  void Init() async {
    preferences = await SharedPreferences.getInstance();
    var profilepro = Provider.of<ProfileProvider>(context, listen: false);
    var dashboard = Provider.of<DashboardProvider>(context, listen: false);
    dashboard.chatreset();
    setState(() {
      if(widget.anotherUserId=="")
        {
          widget.anotherUserId = profilepro.anotheruserID.toString();
          widget.username = profilepro.anotheruserName.toString();
          widget.secondaryUserimage = profilepro.anotheruserImage.toString();
          widget.userimage = profilepro.profileImage.toString();
        }
      if(preferences!.getString("accesstoken") != null)
        {
          if(widget.anotherUserId!="")
            {
              dashboard.fetchChatLists(preferences!.getString("accesstoken").toString(), widget.anotherUserId);
            }
        }
    });
  }

  @override
  Widget build(BuildContext context) {
    var profile=Provider.of<ProfileProvider>(context);
    return Scaffold(
      body: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          toolbarHeight: 50,
          centerTitle: true,
          leadingWidth: 0,
          backgroundColor: Colors.white,elevation: 0,title:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    profile.profiledetails!.data!.is_super_monogamy!?InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: (){
                          Navigator.of(context).pop();
                        },
                        child: SvgPicture.asset("assets/images/arrowback.svg",fit: BoxFit.scaleDown,)):Container(),
                    SizedBox(width: 10,),
                    widget.username!=""?addMediumText(widget.username, 18, Colorss.mainColor):addMediumText(profile.anotheruserName, 18, Colorss.mainColor),
                  ],
                ),

                Container(),
                IconButton(onPressed: (){}, icon: Icon(Icons.add,color: Colors.black,size: 30,))
              ],
            ),
          ],
        ),
       ),
        body: Container(
          color: Color(0xFFF2E7FA),
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Expanded(
                child: Consumer<DashboardProvider>(builder:
                    (context,dataProvider,child){
                  if(dataProvider.chatList?.data != null)
                  {

                    print(dataProvider.chatList!.data!.length);
                    return dataProvider.chatList!.data!.length > 0
                        ?
                    ListView.builder(
                      reverse:true,
                      controller: scroll,
                      itemCount: dataProvider.chatList!.data!.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context,
                          int index) {
                        return chatLists(dataProvider.chatList!.data!.elementAt(index).message.toString(),dataProvider.chatList!.data!.elementAt(index).sender!,dataProvider.chatList!.data!.elementAt(index).type.toString(), dataProvider.chatList!.data!.elementAt(index).date!, context);
                      },
                    )
                        :
                    Center(child: Container(
                        child: Text("${AppLocalizations.of(context)!.nomessage} 😔")
                    ),);
                  }
                  return Center(child: CircularProgressIndicator(),);
                }),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 130.h,
                  color: Colors.white,
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      margin: EdgeInsets.only(bottom: 15.h,top: 30.h),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: (){

                                },
                                child: Container(
                                  child: Icon(Icons.add,color: Colors.white,),
                                  height: 25,
                                  width: 25,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colorss.mainColor
                                  ),
                                ),
                              ),
                              Container(
                                height: 40,
                                width: MediaQuery.of(context).size.width*0.70,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                    border: Border.all(color: Colorss.mainColor,width: 1)
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width*0.60,
                                      padding: EdgeInsets.only(left: 10),
                                      child: TextFormField(
                                        controller: messageController,
                                        focusNode: focusNode,
                                        onChanged: (value)
                                        {
                                          setState(() {
                                            message=value;
                                          });
                                        },
                                        textAlignVertical: TextAlignVertical.center,
                                        decoration: InputDecoration(
                                            hintText: AppLocalizations.of(context)!.entermesage,
                                            border:InputBorder.none,
                                            contentPadding: EdgeInsets.zero,
                                            isDense: true
                                        ),
                                      ),
                                    ),
                                    message != ""?GestureDetector(
                                        onTap: ()async{

                                          var issend=await DashboardRepository.chatcreate(preferences!.getString("accesstoken").toString(),widget.anotherUserId, "text", message);
                                          if(issend.statusCode ==200)
                                          {
                                            setState(() {
                                              message="";
                                              messageController.text="";
                                            });
                                            var provider=await Provider.of<DashboardProvider>(context,listen: false);
                                            provider.allchatlistremove();
                                            provider.addChat(issend);
                                            print("message send");
                                          }
                                        },
                                        child: SvgPicture.asset("assets/images/sendicon.svg",fit: BoxFit.scaleDown,height: 25,width: 25,color: Color(0xFF6B18C3),)):GestureDetector(
                                        onTap: (){
                                          setState(() {
                                            emojiShowing=true;
                                            focusNode.unfocus();
                                            focusNode.canRequestFocus=false;
                                          });
                                          // showDialog(context: context,
                                          //     builder: (context) => Material(
                                          //       color: Colors.transparent,
                                          //       child: Container(
                                          //         alignment: Alignment.center,
                                          //         color: Colors.transparent,
                                          //         child: Container(
                                          //           width: MediaQuery.of(context).size.width*0.80,
                                          //           margin: EdgeInsets.only(bottom: 30),
                                          //           decoration: BoxDecoration( color: Colors.white,
                                          //               borderRadius: BorderRadius.circular(20.w)),
                                          //           child: Column(
                                          //             mainAxisSize: MainAxisSize.min,
                                          //             mainAxisAlignment: MainAxisAlignment.start,
                                          //             crossAxisAlignment: CrossAxisAlignment.center,
                                          //             children: <Widget>[
                                          //               SizedBox(height: 20.h,),
                                          //               addBoldText(AppLocalizations.of(context)!.areyousure, 12, Color(0xFF4D4D4D)),
                                          //               SizedBox(height: 10.h,),
                                          //               Container(
                                          //                   margin: EdgeInsets.symmetric(horizontal: 20),
                                          //                   child: addCenterRegularText(AppLocalizations.of(context)!.ifypoureplythis, 10, Color(0xFF4D4D4D))),
                                          //               SizedBox(height: 30.h,),
                                          //               Row(
                                          //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          //                 children: [
                                          //                   GestureDetector(
                                          //                     onTap:(){
                                          //                       Navigator.of(context).pop();
                                          //         },
                                          //                     child: Container(
                                          //                       height:40,
                                          //                       alignment: Alignment.center,
                                          //                       width: 110,
                                          //                       child: addRegularText(AppLocalizations.of(context)!.cancel, 12, Color(0xFF4D4D4D)),decoration: BoxDecoration(
                                          //                         color: Color(0xFFF5F5F5),
                                          //                         borderRadius: BorderRadius.circular(5)
                                          //                     ),
                                          //                     ),
                                          //                   ),
                                          //                   Container(
                                          //                     height:40,
                                          //                     alignment: Alignment.center,
                                          //                     width: 110,
                                          //                     child: addRegularText(AppLocalizations.of(context)!.send, 12, Color(0xFFFFFFFF)),
                                          //                     decoration: BoxDecoration(color: Color(0xFF007AFF),borderRadius: BorderRadius.circular(5)),),
                                          //                 ],
                                          //               ),
                                          //               Row(
                                          //                 mainAxisAlignment: MainAxisAlignment.center,
                                          //                 children: [
                                          //                   Checkbox(
                                          //                       shape: RoundedRectangleBorder(
                                          //                           borderRadius: BorderRadius.all(
                                          //                               Radius.circular(5.0.r))),
                                          //                       activeColor: Colorss.mainColor,
                                          //                       side: MaterialStateBorderSide.resolveWith(
                                          //                             (states) => BorderSide(
                                          //                             width: 0.w, color: Colors.grey),
                                          //                       ),
                                          //                       value: false,
                                          //                       onChanged: (value) {
                                          //
                                          //                       }),
                                          //                   SizedBox(width: 2,),
                                          //                   addRegularText(AppLocalizations.of(context)!.dontaskagain, 12, Color(0xFF4D4D4D))
                                          //                 ],
                                          //               )
                                          //             ],
                                          //           ),
                                          //         ),
                                          //       ),
                                          //     )
                                          // );
                                        },
                                        child: SvgPicture.asset("assets/images/smile.svg",fit: BoxFit.scaleDown,height: 25,width: 25,))
                                  ],
                                ),
                              ),
                              SvgPicture.asset("assets/images/mic.svg",fit: BoxFit.scaleDown,),

                            ],
                          ),
                          SizedBox(height: 20.h,),
                          // Container(
                          //   height: 8.h,width: 160.w,decoration: BoxDecoration(color: Colorss.mainColor,borderRadius: BorderRadius.circular(25.r)),),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
        // Offstage(
        //   offstage: !emojiShowing,
        //   child: SizedBox(
        //       height: 250,
        //       child: EmojiPicker(
        //         onEmojiSelected: (category,emoji){
        //           setState(() {
        //             messageController.text=messageController.text+emoji.emoji;
        //             message=message+emoji.emoji;
        //           });
        //         },
        //         config: Config(
        //           columns: 7,
        //           // Issue: https://github.com/flutter/flutter/issues/28894
        //           emojiSizeMax: 20 * (Platform.isIOS ? 1.30 : 1.0),
        //           verticalSpacing: 0,
        //           horizontalSpacing: 0,
        //           gridPadding: EdgeInsets.zero,
        //           initCategory: Category.RECENT,
        //           bgColor: const Color(0xFFF2F2F2),
        //           indicatorColor: Colors.blue,
        //           iconColor: Colors.grey,
        //           iconColorSelected: Colors.blue,
        //           backspaceColor: Colors.blue,
        //           skinToneDialogBgColor: Colors.white,
        //           skinToneIndicatorColor: Colors.grey,
        //           enableSkinTones: true,
        //           showRecentsTab: true,
        //           recentsLimit: 28,
        //           replaceEmojiOnLimitExceed: false,
        //           noRecents: const Text(
        //             'No Recents',
        //             style: TextStyle(fontSize: 20, color: Colors.black26),
        //             textAlign: TextAlign.center,
        //           ),
        //           loadingIndicator: const SizedBox.shrink(),
        //           tabIndicatorAnimDuration: kTabScrollDuration,
        //           categoryIcons: const CategoryIcons(),
        //           buttonMode: ButtonMode.MATERIAL,
        //           checkPlatformCompatibility: true,
        //         ),
        //       )),),
            ],
          )
        ),
      ),
    );
  }

  Widget profileImage(context,image) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.width / 100),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: image.isNotEmpty
            ? Image.network(
          image,
          fit: BoxFit.cover,
          height: MediaQuery.of(context).size.width / 12,
          width: MediaQuery.of(context).size.width / 12,
        )
            : Image.asset(
          "assets/images/girl.jpg",
          fit: BoxFit.cover,
          height: MediaQuery.of(context).size.width / 12,
          width: MediaQuery.of(context).size.width / 12,
        ),
      ),
    );
  }

  Widget chatLists(String message,bool sender,String type,DateTime time,BuildContext context)
  {
    return type=="text"?Container(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 30,
            vertical: MediaQuery.of(context).size.width / 100),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment:
          sender ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Visibility(visible: !sender, child: profileImage(context,widget.secondaryUserimage)),
                SizedBox(width: MediaQuery.of(context).size.width / 60),
                Card(
                  elevation: 5,
                  color: !sender
                      ? const Color(0xffffffff)
                      : const Color(0xff6B00C3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topRight: const Radius.circular(15),
                        topLeft: const Radius.circular(15),
                        bottomLeft: sender
                            ? const Radius.circular(15)
                            : const Radius.circular(0),
                        bottomRight: sender
                            ? const Radius.circular(0)
                            : const Radius.circular(15)),
                  ),
                  child: Container(
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width / 1.5),
                    //width: MediaQuery.of(context).size.width/2,
                    decoration: BoxDecoration(
                      color: !sender
                          ? const Color(0xffffffff)
                          : const Color(0xff6B00C3),
                      borderRadius: BorderRadius.only(
                          topRight: const Radius.circular(15),
                          topLeft: const Radius.circular(15),
                          bottomLeft: sender
                              ? const Radius.circular(15)
                              : const Radius.circular(0),
                          bottomRight: sender
                              ? const Radius.circular(0)
                              : const Radius.circular(15)),
                    ),
                    child: Padding(
                      padding:
                      EdgeInsets.all(MediaQuery.of(context).size.width / 40),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (type == "text")
                            Flexible(fit: FlexFit.loose, child: Text(message,style: TextStyle(color: !sender?Colors.black:Colors.white),)),
                          !sender?Text(
                            "\t\t" + DateFormat.jm().format(time),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: MediaQuery.of(context).size.width / 35,
                            ),
                          ):Text(
                            "\t\t" + DateFormat.jm().format(time),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: MediaQuery.of(context).size.width / 35,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 60,
                ),
                Visibility(visible: sender, child: profileImage(context,widget.userimage)),
              ],
            ),
          ],
        ),
      ),
    ):Container(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 30,
            vertical: MediaQuery.of(context).size.width / 100),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment:
          sender ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Visibility(visible: !sender, child: profileImage(context,widget.secondaryUserimage)),
                SizedBox(width: MediaQuery.of(context).size.width / 60),
                Padding(
                  padding:
                  EdgeInsets.all(MediaQuery.of(context).size.width / 40),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      !sender?Text(
                        "\t\t" + DateFormat.jm().format(time),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: MediaQuery.of(context).size.width / 35,
                        ),
                      ):Text(
                        "\t\t" + DateFormat.jm().format(time),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.width / 35,
                        ),
                      ),
                        SizedBox(width: 5,),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: InkWell(
                            // onTap: () =>
                            //     pushTo(context, ImageViewer(url: message)),
                            child: Image.asset(
                              message,
                              height: 150,
                              width: 100,
                              fit: BoxFit.cover,
                              // loadingBuilder: (context, child, progress) =>
                              // progress == null
                              //     ? child
                              //     : const SizedBox(
                              //   height: 150,
                              //   width: 100,
                              //   child: Center(
                              //     child: CircularProgressIndicator
                              //         .adaptive(
                              //       backgroundColor: Colors.white,
                              //     ),
                              //   ),
                              // ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 60,
                ),
                Visibility(visible: sender, child: profileImage(context,widget.userimage)),
              ],
            ),
          ],
        ),
      ),
    );

  }

}
