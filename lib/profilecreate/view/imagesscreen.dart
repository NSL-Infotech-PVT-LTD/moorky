import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moorky/commanWidget/commanwidget.dart';
import 'package:moorky/profilecreate/repository/profileRepository.dart';
import 'package:moorky/profilecreate/view/genderscreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../provider/profileprovider.dart';
import 'namescreen.dart';
import 'package:moorky/constant/color.dart';

class ImageScreen extends StatefulWidget {
  // bool isEdit=false;
  // String imagefile1="";
  // String imagefile2="";
  // String imagefile3="";
  // String imagefile4="";
  // String imagefile5="";
  // String imagefile6="";
  // String imageid1="";
  // String imageid2="";
  // String imageid3="";
  // String imageid4="";
  // String imageid5="";
  // String imageid6="";
  // ImageScreen({required this.isEdit,required this.imagefile1,
  //   required this.imagefile2,required this.imagefile3,
  //   required this.imagefile4,required this.imagefile5,required this.imagefile6,
  //   required this.imageid1,required this.imageid2,required this.imageid3,required this.imageid4,required this.imageid5,required this.imageid6});

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {


  final picker = ImagePicker();
  List<String> images=[];
  Future<String> imgFromGallery(String imagepath) async {
    XFile? image =
    await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
    if (image == null) "";
    await cropSelectedImage(image!.path)
        .then((croppedFile) {
      // Step #4: Check if we actually cropped an image. Otherwise -> stop;
      if (croppedFile == null) return;

      // Step #5: Display image on screen
      setState(() {
        imagepath = croppedFile.path;
      });
    });
    return imagepath;
  }
  static Future<CroppedFile?> cropSelectedImage(String filePath) async {
    return await ImageCropper.platform.cropImage(
      sourcePath: filePath,
      aspectRatio: const CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
    );
  }
  Future<String> imgFromCamera(String imagepath) async {
    XFile? image =
    await picker.pickImage(source: ImageSource.camera, imageQuality: 100);
    setState(() {
      imagepath=image!.path;
    });
    return imagepath;
  }
  Future<String> _showImagePicker(context,String imagepath)async {
    await showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        ),
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
              child: Container(
                child: new Wrap(
                  children: <Widget>[
                    new ListTile(
                        leading: new Icon(
                          Icons.photo_library,
                          color: Colorss.mainColor,
                        ),
                        title: Text(AppLocalizations.of(context)!.gallery),
                        onTap: () async{
                          imagepath=await imgFromGallery(imagepath);
                          Navigator.of(context).pop();
                        }),
                    new ListTile(
                      leading: new Icon(Icons.photo_camera,
                        color: Colorss.mainColor,),
                      title: Text(AppLocalizations.of(context)!.camera),
                      onTap: ()async {
                        imagepath=await imgFromCamera(imagepath);
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ));
        });
    return imagepath;
  }
  var _scaKey = GlobalKey<ScaffoldState>();
  SharedPreferences? preferences;
  @override
  void initState() {
    Init();
    super.initState();
  }
  void Init()async{
    preferences=await SharedPreferences.getInstance();
  }
  String imagefile1="";
  String imagefile2="";
  String imagefile3="";
  String imagefile4="";
  String imagefile5="";
  String imagefile6="";
  bool isLoad=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        height: 180.h,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: Column(
            children: [
              // !widget.isEdit?InkWell(
              //   splashColor: Colors.transparent,
              //   focusColor: Colors.transparent,
              //   hoverColor: Colors.transparent,
              //   highlightColor: Colors.transparent,
              //   onTap: ()async{
              //     print(images);
              //     print(images.length);
              //     if(images.length>1)
              //     {
              //       print(images);
              //       preferences!.setStringList("photo",images);
              //       Navigator.push(context,
              //           MaterialPageRoute(builder:
              //               (context) =>
              //               GenderScreen(gender: "",isEdit:false,showGender: false,)
              //           )
              //       );
              //     }
              //     else{
              //       print(images);
              //       showSnakbar(AppLocalizations.of(context)!.mimum2photo, context);
              //     }
              //   },
              //   child: Container(
              //       height: 70.h,
              //       margin: EdgeInsets.only(left: 25.w,right: 25.w),
              //       decoration: BoxDecoration(
              //           gradient: LinearGradient(
              //             begin: Alignment.centerLeft,
              //             end: Alignment.centerRight,
              //             colors: <Color>[
              //               Color(0xFF570084),
              //               Color(0xFFA33BE5)
              //             ],
              //           ),
              //           borderRadius: BorderRadius.circular(50.r)),
              //       alignment: Alignment.center,
              //       child: addMediumText(AppLocalizations.of(context)!.continues, 14, Color(0xFFFFFFFF))
              //   ),
              // ):!isLoad?InkWell(
              //   splashColor: Colors.transparent,
              //   focusColor: Colors.transparent,
              //   hoverColor: Colors.transparent,
              //   highlightColor: Colors.transparent,
              //   onTap: ()async{
              //     setState(() {
              //       isLoad=true;
              //     });
              //     print(images);
              //
              //     print(images.length);
              //     preferences!.setStringList("photo",images);
              //     var model=await ProfileRepository.updateProfileImage(images,preferences!.getString("accesstoken")!);
              //     if(model.statusCode==200)
              //     {
              //       setState(() {
              //         isLoad=false;
              //       });
              //       var provider=await Provider.of<ProfileProvider>(context,listen: false);
              //       // provider.resetStreams();
              //
              //       print("hello all${model.data?.phoneNumber}");
              //       provider.adddetails(model);
              //       Navigator.of(context).pop();
              //     }
              //     else if(model.statusCode==422){
              //       setState(() {
              //         isLoad=false;
              //       });
              //       showSnakbar(model.message!, context);
              //     }
              //     else {
              //       setState(() {
              //         isLoad=false;
              //       });
              //       showSnakbar(model.message!, context);
              //     }
              //
              //
              //
              //   },
              //   child: Container(
              //       height: 70.h,
              //       margin: EdgeInsets.only(left: 25.w,right: 25.w),
              //       decoration: BoxDecoration(
              //           gradient: LinearGradient(
              //             begin: Alignment.centerLeft,
              //             end: Alignment.centerRight,
              //             colors: <Color>[
              //               Color(0xFF570084),
              //               Color(0xFFA33BE5)
              //             ],
              //           ),
              //           borderRadius: BorderRadius.circular(50.r)),
              //       alignment: Alignment.center,
              //       child: addMediumText(AppLocalizations.of(context)!.update, 14, Color(0xFFFFFFFF))
              //   ),
              // ):Container(child: CircularProgressIndicator(),alignment: Alignment.topCenter,),
              // Container(
              //   alignment: Alignment.bottomCenter,
              //   margin: EdgeInsets.only(bottom: 15.h,top: 30.h),
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.end,
              //     children: [
              //       Image.asset("assets/images/moorky2.png",height: 45.h,width: 150.w,),
              //       SizedBox(height: 5.h,),
              //       Container(
              //         height: 8.h,width: 140.w,),),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
      appBar: AppBar(title: addMediumText(AppLocalizations.of(context)!.photos, 18,Colorss.mainColor),centerTitle: true,backgroundColor: Colors.transparent,elevation: 0,leading:
      InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: (){
            Navigator.of(context).pop();
          },
          child: SvgPicture.asset("assets/images/arrowback.svg",fit: BoxFit.scaleDown,)),),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      flex: 2,
                      child: DragTarget<String>(
                        builder: (context,data,rejecteddata){
                          return InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: ()async{
                              images.remove(imagefile1);
                              imagefile1=await _showImagePicker(context,imagefile1);
                              if(imagefile1!="")
                              {
                                images.add(imagefile1);
                              }
                            },
                            child: imagefile1!=""?Draggable(
                              data: imagefile1,
                              onDragCompleted: (){
                                setState(() {
                                  imagefile1="";
                                });
                              },
                              childWhenDragging: Container(
                                height: 275,
                                margin: EdgeInsets.all(8),
                                decoration: BoxDecoration(color: Color(0xFFFDFAFF),borderRadius: BorderRadius.circular(15.r),),
                                child: Container(
                                  decoration: BoxDecoration(color: Color(0xFFFDFAFF),borderRadius: BorderRadius.circular(15.r),),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15.r),
                                    child: imagefile1.contains("http")?Image.network(
                                      imagefile1,
                                      fit: BoxFit.cover,
                                    ):Image.file(
                                      File(imagefile1),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              feedback: Container(
                                height: 275,
                                margin: EdgeInsets.all(8),
                                decoration: BoxDecoration(color: Color(0xFFFDFAFF),borderRadius: BorderRadius.circular(15.r),),
                                child: Container(
                                  decoration: BoxDecoration(color: Color(0xFFFDFAFF),borderRadius: BorderRadius.circular(15.r),),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15.r),
                                    child: imagefile1.contains("http")?Image.network(
                                      imagefile1,
                                      fit: BoxFit.cover,
                                    ):Image.file(
                                      File(imagefile1),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              child: Container(
                                height: 275,
                                margin: EdgeInsets.all(8),
                                decoration: BoxDecoration(color: Color(0xFFFDFAFF),borderRadius: BorderRadius.circular(15.r),),
                                child: Stack(
                                  children: [
                                    Positioned.fill(
                                      child: Container(
                                        decoration: BoxDecoration(color: Color(0xFFFDFAFF),borderRadius: BorderRadius.circular(15.r),),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(15.r),
                                          child: imagefile1.contains("http")?Image.network(
                                            imagefile1,
                                            fit: BoxFit.cover,
                                          ):Image.file(
                                            File(imagefile1),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),),
                                    InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: ()async{
                                        // if(imagefile2.contains("http"))
                                        // {
                                        //   bool isImageDelete=await ProfileRepository.imageDelete(preferences!.getString("accesstoken")!, widget.imageid2);
                                        //   if(isImageDelete)
                                        //   {
                                        //     var profileprovider = Provider.of<ProfileProvider>(context, listen: false);
                                        //     profileprovider.resetStreams();
                                        //     if (preferences!.getString("accesstoken") != null) {
                                        //       profileprovider.fetchProfileDetails(
                                        //           preferences!.getString("accesstoken").toString());
                                        //     }
                                        //     setState(() {
                                        //       images.remove(imagefile2);
                                        //       print(images);
                                        //       imagefile2="";
                                        //     });
                                        //   }
                                        //
                                        //
                                        // }
                                        // else{
                                        //   setState(() {
                                        //     images.remove(imagefile2);
                                        //     print(images);
                                        //     imagefile2="";
                                        //   });
                                        // }
                                      },
                                      child: Container(
                                          margin: EdgeInsets.only(top: 5,left: 5),
                                          child: SvgPicture.asset("assets/images/delete.svg",fit: BoxFit.scaleDown,)),
                                    )
                                  ],
                                ),
                              ),
                            ):photoaddcontainer(275),
                          );
                        },
                        onAccept: (data){
                          print("sjajsfxcjashfcjasc");
                          setState(() {
                            imagefile1=data;
                          });
                        },
                      ),),
                  Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                         DragTarget<String>(
                            builder: (context,data,rejecteddata){
                              return InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: ()async{
                                  images.remove(imagefile2);
                                  imagefile2=await _showImagePicker(context,imagefile2);
                                  if(imagefile2!="")
                                  {
                                    images.add(imagefile2);
                                  }
                                },
                                child: imagefile2!=""?Draggable(
                                  data: imagefile2,
                                  onDragCompleted: (){
                                    setState(() {
                                      imagefile2="";
                                    });
                                  },
                                  childWhenDragging: Container(
                                    height: 129,
                                    margin: EdgeInsets.all(8),
                                    decoration: BoxDecoration(color: Color(0xFFFDFAFF),borderRadius: BorderRadius.circular(15.r),),
                                    child: Container(
                                      decoration: BoxDecoration(color: Color(0xFFFDFAFF),borderRadius: BorderRadius.circular(15.r),),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15.r),
                                        child: imagefile2.contains("http")?Image.network(
                                          imagefile2,
                                          fit: BoxFit.cover,
                                        ):Image.file(
                                          File(imagefile2),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  feedback: Container(
                                    height: 129,
                                    margin: EdgeInsets.all(8),
                                    decoration: BoxDecoration(color: Color(0xFFFDFAFF),borderRadius: BorderRadius.circular(15.r),),
                                    child: Container(
                                      decoration: BoxDecoration(color: Color(0xFFFDFAFF),borderRadius: BorderRadius.circular(15.r),),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15.r),
                                        child: imagefile2.contains("http")?Image.network(
                                          imagefile2,
                                          fit: BoxFit.cover,
                                        ):Image.file(
                                          File(imagefile2),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  child: Container(
                                    height: 129,
                                    margin: EdgeInsets.all(8),
                                    decoration: BoxDecoration(color: Color(0xFFFDFAFF),borderRadius: BorderRadius.circular(15.r),),
                                    child: Stack(
                                      children: [
                                        Positioned.fill(
                                          child: Container(
                                            decoration: BoxDecoration(color: Color(0xFFFDFAFF),borderRadius: BorderRadius.circular(15.r),),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(15.r),
                                              child: imagefile2.contains("http")?Image.network(
                                                imagefile2,
                                                fit: BoxFit.cover,
                                              ):Image.file(
                                                File(imagefile2),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),),
                                        InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: ()async{
                                            // if(imagefile2.contains("http"))
                                            // {
                                            //   bool isImageDelete=await ProfileRepository.imageDelete(preferences!.getString("accesstoken")!, widget.imageid2);
                                            //   if(isImageDelete)
                                            //   {
                                            //     var profileprovider = Provider.of<ProfileProvider>(context, listen: false);
                                            //     profileprovider.resetStreams();
                                            //     if (preferences!.getString("accesstoken") != null) {
                                            //       profileprovider.fetchProfileDetails(
                                            //           preferences!.getString("accesstoken").toString());
                                            //     }
                                            //     setState(() {
                                            //       images.remove(imagefile2);
                                            //       print(images);
                                            //       imagefile2="";
                                            //     });
                                            //   }
                                            //
                                            //
                                            // }
                                            // else{
                                            //   setState(() {
                                            //     images.remove(imagefile2);
                                            //     print(images);
                                            //     imagefile2="";
                                            //   });
                                            // }
                                          },
                                          child: Container(
                                              margin: EdgeInsets.only(top: 5,left: 5),
                                              child: SvgPicture.asset("assets/images/delete.svg",fit: BoxFit.scaleDown,)),
                                        )
                                      ],
                                    ),
                                  ),
                                ):photoaddcontainer(129),
                              );
                            },
                            onAccept: (data){
                              print("sjajsfxcjashfcjasc");
                              setState(() {
                                imagefile2=data;
                              });
                            },
                          ),
                          DragTarget<String>(
                            builder: (context,data,rejecteddata){
                              return InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: ()async{
                                  images.remove(imagefile3);
                                  imagefile3=await _showImagePicker(context,imagefile3);
                                  if(imagefile3!="")
                                  {
                                    images.add(imagefile3);
                                  }
                                },
                                child: imagefile3!=""?Draggable(
                                  data: imagefile3,
                                  onDragCompleted: (){
                                    setState(() {
                                      imagefile3="";
                                    });
                                  },
                                  childWhenDragging: Container(
                                    height: 129,
                                    margin: EdgeInsets.all(8),
                                    decoration: BoxDecoration(color: Color(0xFFFDFAFF),borderRadius: BorderRadius.circular(15.r),),
                                    child: Container(
                                      decoration: BoxDecoration(color: Color(0xFFFDFAFF),borderRadius: BorderRadius.circular(15.r),),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15.r),
                                        child: imagefile3.contains("http")?Image.network(
                                          imagefile3,
                                          fit: BoxFit.cover,
                                        ):Image.file(
                                          File(imagefile3),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  feedback: Container(
                                    height: 129,
                                    margin: EdgeInsets.all(8),
                                    decoration: BoxDecoration(color: Color(0xFFFDFAFF),borderRadius: BorderRadius.circular(15.r),),
                                    child: Container(
                                      decoration: BoxDecoration(color: Color(0xFFFDFAFF),borderRadius: BorderRadius.circular(15.r),),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15.r),
                                        child: imagefile3.contains("http")?Image.network(
                                          imagefile3,
                                          fit: BoxFit.cover,
                                        ):Image.file(
                                          File(imagefile3),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  child: Container(
                                    height: 129,
                                    margin: EdgeInsets.all(8),
                                    decoration: BoxDecoration(color: Color(0xFFFDFAFF),borderRadius: BorderRadius.circular(15.r),),
                                    child: Stack(
                                      children: [
                                        Positioned.fill(
                                          child: Container(
                                            decoration: BoxDecoration(color: Color(0xFFFDFAFF),borderRadius: BorderRadius.circular(15.r),),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(15.r),
                                              child: imagefile3.contains("http")?Image.network(
                                                imagefile3,
                                                fit: BoxFit.cover,
                                              ):Image.file(
                                                File(imagefile3),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),),
                                        InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: ()async{
                                            // if(imagefile2.contains("http"))
                                            // {
                                            //   bool isImageDelete=await ProfileRepository.imageDelete(preferences!.getString("accesstoken")!, widget.imageid2);
                                            //   if(isImageDelete)
                                            //   {
                                            //     var profileprovider = Provider.of<ProfileProvider>(context, listen: false);
                                            //     profileprovider.resetStreams();
                                            //     if (preferences!.getString("accesstoken") != null) {
                                            //       profileprovider.fetchProfileDetails(
                                            //           preferences!.getString("accesstoken").toString());
                                            //     }
                                            //     setState(() {
                                            //       images.remove(imagefile2);
                                            //       print(images);
                                            //       imagefile2="";
                                            //     });
                                            //   }
                                            //
                                            //
                                            // }
                                            // else{
                                            //   setState(() {
                                            //     images.remove(imagefile2);
                                            //     print(images);
                                            //     imagefile2="";
                                            //   });
                                            // }
                                          },
                                          child: Container(
                                              margin: EdgeInsets.only(top: 5,left: 5),
                                              child: SvgPicture.asset("assets/images/delete.svg",fit: BoxFit.scaleDown,)),
                                        )
                                      ],
                                    ),
                                  ),
                                ):photoaddcontainer(129),
                              );
                            },
                            onAccept: (data){
                              print("sjajsfxcjashfcjasc");
                              setState(() {
                                imagefile3=data;
                              });
                            },
                          ),
                        ],
                      )),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: DragTarget<String>(
                      builder: (context,data,rejecteddata){
                        return InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: ()async{
                            images.remove(imagefile4);
                            imagefile4=await _showImagePicker(context,imagefile4);
                            if(imagefile4!="")
                            {
                              images.add(imagefile4);
                            }
                          },
                          child: imagefile4!=""?Draggable(
                            data: imagefile4,
                            onDragCompleted: (){
                              setState(() {
                                imagefile4="";
                              });
                            },
                            childWhenDragging: Container(
                              height: 129,
                              margin: EdgeInsets.all(8),
                              decoration: BoxDecoration(color: Color(0xFFFDFAFF),borderRadius: BorderRadius.circular(15.r),),
                              child: Container(
                                decoration: BoxDecoration(color: Color(0xFFFDFAFF),borderRadius: BorderRadius.circular(15.r),),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15.r),
                                  child: imagefile4.contains("http")?Image.network(
                                    imagefile4,
                                    fit: BoxFit.cover,
                                  ):Image.file(
                                    File(imagefile4),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            feedback: Container(
                              height: 129,
                              margin: EdgeInsets.all(8),
                              decoration: BoxDecoration(color: Color(0xFFFDFAFF),borderRadius: BorderRadius.circular(15.r),),
                              child: Container(
                                decoration: BoxDecoration(color: Color(0xFFFDFAFF),borderRadius: BorderRadius.circular(15.r),),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15.r),
                                  child: imagefile4.contains("http")?Image.network(
                                    imagefile4,
                                    fit: BoxFit.cover,
                                  ):Image.file(
                                    File(imagefile4),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            child: Container(
                              height: 129,
                              margin: EdgeInsets.all(8),
                              decoration: BoxDecoration(color: Color(0xFFFDFAFF),borderRadius: BorderRadius.circular(15.r),),
                              child: Stack(
                                children: [
                                  Positioned.fill(
                                    child: Container(
                                      decoration: BoxDecoration(color: Color(0xFFFDFAFF),borderRadius: BorderRadius.circular(15.r),),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15.r),
                                        child: imagefile4.contains("http")?Image.network(
                                          imagefile4,
                                          fit: BoxFit.cover,
                                        ):Image.file(
                                          File(imagefile4),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),),
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: ()async{
                                      // if(imagefile2.contains("http"))
                                      // {
                                      //   bool isImageDelete=await ProfileRepository.imageDelete(preferences!.getString("accesstoken")!, widget.imageid2);
                                      //   if(isImageDelete)
                                      //   {
                                      //     var profileprovider = Provider.of<ProfileProvider>(context, listen: false);
                                      //     profileprovider.resetStreams();
                                      //     if (preferences!.getString("accesstoken") != null) {
                                      //       profileprovider.fetchProfileDetails(
                                      //           preferences!.getString("accesstoken").toString());
                                      //     }
                                      //     setState(() {
                                      //       images.remove(imagefile2);
                                      //       print(images);
                                      //       imagefile2="";
                                      //     });
                                      //   }
                                      //
                                      //
                                      // }
                                      // else{
                                      //   setState(() {
                                      //     images.remove(imagefile2);
                                      //     print(images);
                                      //     imagefile2="";
                                      //   });
                                      // }
                                    },
                                    child: Container(
                                        margin: EdgeInsets.only(top: 5,left: 5),
                                        child: SvgPicture.asset("assets/images/delete.svg",fit: BoxFit.scaleDown,)),
                                  )
                                ],
                              ),
                            ),
                          ):photoaddcontainer(129),
                        );
                      },
                      onAccept: (data){
                        print("sjajsfxcjashfcjasc");
                        setState(() {
                          imagefile4=data;
                        });
                      },
                    ),),
                  Expanded(
                    flex: 1,
                    child: DragTarget<String>(
                      builder: (context,data,rejecteddata){
                        return InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: ()async{
                            images.remove(imagefile5);
                            imagefile5=await _showImagePicker(context,imagefile5);
                            if(imagefile5!="")
                            {
                              images.add(imagefile5);
                            }
                          },
                          child: imagefile5!=""?Draggable(
                            data: imagefile5,
                            onDragCompleted: (){
                              setState(() {
                                imagefile5="";
                              });
                            },
                            childWhenDragging: Container(
                              height: 129,
                              margin: EdgeInsets.all(8),
                              decoration: BoxDecoration(color: Color(0xFFFDFAFF),borderRadius: BorderRadius.circular(15.r),),
                              child: Container(
                                decoration: BoxDecoration(color: Color(0xFFFDFAFF),borderRadius: BorderRadius.circular(15.r),),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15.r),
                                  child: imagefile5.contains("http")?Image.network(
                                    imagefile5,
                                    fit: BoxFit.cover,
                                  ):Image.file(
                                    File(imagefile5),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            feedback: Container(
                              height: 129,
                              margin: EdgeInsets.all(8),
                              decoration: BoxDecoration(color: Color(0xFFFDFAFF),borderRadius: BorderRadius.circular(15.r),),
                              child: Container(
                                decoration: BoxDecoration(color: Color(0xFFFDFAFF),borderRadius: BorderRadius.circular(15.r),),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15.r),
                                  child: imagefile5.contains("http")?Image.network(
                                    imagefile5,
                                    fit: BoxFit.cover,
                                  ):Image.file(
                                    File(imagefile5),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            child: Container(
                              height: 129,
                              margin: EdgeInsets.all(8),
                              decoration: BoxDecoration(color: Color(0xFFFDFAFF),borderRadius: BorderRadius.circular(15.r),),
                              child: Stack(
                                children: [
                                  Positioned.fill(
                                    child: Container(
                                      decoration: BoxDecoration(color: Color(0xFFFDFAFF),borderRadius: BorderRadius.circular(15.r),),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15.r),
                                        child: imagefile5.contains("http")?Image.network(
                                          imagefile5,
                                          fit: BoxFit.cover,
                                        ):Image.file(
                                          File(imagefile5),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),),
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: ()async{
                                      // if(imagefile2.contains("http"))
                                      // {
                                      //   bool isImageDelete=await ProfileRepository.imageDelete(preferences!.getString("accesstoken")!, widget.imageid2);
                                      //   if(isImageDelete)
                                      //   {
                                      //     var profileprovider = Provider.of<ProfileProvider>(context, listen: false);
                                      //     profileprovider.resetStreams();
                                      //     if (preferences!.getString("accesstoken") != null) {
                                      //       profileprovider.fetchProfileDetails(
                                      //           preferences!.getString("accesstoken").toString());
                                      //     }
                                      //     setState(() {
                                      //       images.remove(imagefile2);
                                      //       print(images);
                                      //       imagefile2="";
                                      //     });
                                      //   }
                                      //
                                      //
                                      // }
                                      // else{
                                      //   setState(() {
                                      //     images.remove(imagefile2);
                                      //     print(images);
                                      //     imagefile2="";
                                      //   });
                                      // }
                                    },
                                    child: Container(
                                        margin: EdgeInsets.only(top: 5,left: 5),
                                        child: SvgPicture.asset("assets/images/delete.svg",fit: BoxFit.scaleDown,)),
                                  )
                                ],
                              ),
                            ),
                          ):photoaddcontainer(129),
                        );
                      },
                      onAccept: (data){
                        print("sjajsfxcjashfcjasc");
                        setState(() {
                          imagefile5=data;
                        });
                      },
                    ),),
                  Expanded(
                    flex: 1,
                    child: DragTarget<String>(
                      builder: (context,data,rejecteddata){
                        return InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: ()async{
                            images.remove(imagefile6);
                            imagefile6=await _showImagePicker(context,imagefile6);
                            if(imagefile6!="")
                            {
                              images.add(imagefile6);
                            }
                          },
                          child: imagefile6!=""?Draggable(
                            data: imagefile6,
                            onDragCompleted: (){
                              setState(() {
                                imagefile6="";
                              });
                            },
                            childWhenDragging: Container(
                              height: 129,
                              margin: EdgeInsets.all(8),
                              decoration: BoxDecoration(color: Color(0xFFFDFAFF),borderRadius: BorderRadius.circular(15.r),),
                              child: Container(
                                decoration: BoxDecoration(color: Color(0xFFFDFAFF),borderRadius: BorderRadius.circular(15.r),),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15.r),
                                  child: imagefile6.contains("http")?Image.network(
                                    imagefile6,
                                    fit: BoxFit.cover,
                                  ):Image.file(
                                    File(imagefile6),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            feedback: Container(
                              height: 129,
                              margin: EdgeInsets.all(8),
                              decoration: BoxDecoration(color: Color(0xFFFDFAFF),borderRadius: BorderRadius.circular(15.r),),
                              child: Container(
                                decoration: BoxDecoration(color: Color(0xFFFDFAFF),borderRadius: BorderRadius.circular(15.r),),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15.r),
                                  child: imagefile6.contains("http")?Image.network(
                                    imagefile6,
                                    fit: BoxFit.cover,
                                  ):Image.file(
                                    File(imagefile6),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            child: Container(
                              height: 129,
                              margin: EdgeInsets.all(8),
                              decoration: BoxDecoration(color: Color(0xFFFDFAFF),borderRadius: BorderRadius.circular(15.r),),
                              child: Stack(
                                children: [
                                  Positioned.fill(
                                    child: Container(
                                      decoration: BoxDecoration(color: Color(0xFFFDFAFF),borderRadius: BorderRadius.circular(15.r),),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15.r),
                                        child: imagefile6.contains("http")?Image.network(
                                          imagefile6,
                                          fit: BoxFit.cover,
                                        ):Image.file(
                                          File(imagefile6),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),),
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: ()async{
                                      // if(imagefile2.contains("http"))
                                      // {
                                      //   bool isImageDelete=await ProfileRepository.imageDelete(preferences!.getString("accesstoken")!, widget.imageid2);
                                      //   if(isImageDelete)
                                      //   {
                                      //     var profileprovider = Provider.of<ProfileProvider>(context, listen: false);
                                      //     profileprovider.resetStreams();
                                      //     if (preferences!.getString("accesstoken") != null) {
                                      //       profileprovider.fetchProfileDetails(
                                      //           preferences!.getString("accesstoken").toString());
                                      //     }
                                      //     setState(() {
                                      //       images.remove(imagefile2);
                                      //       print(images);
                                      //       imagefile2="";
                                      //     });
                                      //   }
                                      //
                                      //
                                      // }
                                      // else{
                                      //   setState(() {
                                      //     images.remove(imagefile2);
                                      //     print(images);
                                      //     imagefile2="";
                                      //   });
                                      // }
                                    },
                                    child: Container(
                                        margin: EdgeInsets.only(top: 5,left: 5),
                                        child: SvgPicture.asset("assets/images/delete.svg",fit: BoxFit.scaleDown,)),
                                  )
                                ],
                              ),
                            ),
                          ):photoaddcontainer(129),
                        );
                      },
                      onAccept: (data){
                        print("sjajsfxcjashfcjasc");
                        setState(() {
                          imagefile6=data;
                        });
                      },
                    ),),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container photoaddcontainer(double height)
  {
    return Container(
      height: height,
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(color: Color(0xFFFDFAFF),borderRadius: BorderRadius.circular(15.r),
          border: Border.all(color: Colorss.mainColor,width: 1)),
      child: SvgPicture.asset("assets/images/add.svg",fit:BoxFit.scaleDown,color: Colorss.mainColor),
    );
  }
}
