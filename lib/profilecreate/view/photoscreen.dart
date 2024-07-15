import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
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

class PhotoScreen extends StatefulWidget {
  bool isEdit=false;
  String imagefile1="";
  String imagefile2="";
  String imagefile3="";
  String imagefile4="";
  String imagefile5="";
  String imagefile6="";
  String imageid1="";
  String imageid2="";
  String imageid3="";
  String imageid4="";
  String imageid5="";
  String imageid6="";
  PhotoScreen({required this.isEdit,required this.imagefile1,
    required this.imagefile2,required this.imagefile3,
    required this.imagefile4,required this.imagefile5,required this.imagefile6,
    required this.imageid1,required this.imageid2,required this.imageid3,required this.imageid4,required this.imageid5,required this.imageid6});

  @override
  State<PhotoScreen> createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {
  bool isImage1=false;
  bool isImage2=false;
  bool isImage3=false;
  bool isImage4=false;
  bool isImage5=false;
  bool isImage6=false;
  String tempa="";
  String tempb="";


  final picker = ImagePicker();
  List<String> images=[];
  List<String> imagesindex=[];
  List<String> httpImages=[];
  List<String> httpImageIndex=[];

  Future<String> imgFromGallery(String imagepath) async {
    XFile? image =
    await picker.pickImage(source: ImageSource.gallery);
    var compressImage= await compress(image: File(image!.path),quality:70,percentage: 70);
    if (image != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: compressImage.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colorss.mainColor,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Cropper',
          ),
          WebUiSettings(
            context: context,
            presentStyle: CropperPresentStyle.dialog,
            boundary: const CroppieBoundary(
              width: 520,
              height: 520,
            ),
            viewPort:
            const CroppieViewPort(width: 480, height: 480, type: 'circle'),
            enableExif: true,
            enableZoom: true,
            showZoomer: true,
          ),
        ],
      );
      if (croppedFile != null) {
        setState(() {
          imagepath = croppedFile.path;
        });
      }
    }
    return imagepath;
  }
  Future<String> imgFromCamera(String imagepath) async {
    XFile? image =
    await picker.pickImage(source: ImageSource.camera,maxHeight: 500,maxWidth: 500);
    var compressImage= await compress(image: File(image!.path),quality:90,percentage: 90);
    setState(() {
      imagepath=compressImage.path;
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
  Future<bool> _onBackPressed() async{
    if(widget.isEdit)
    {
      if((httpImages.length)>1)
      {
        return true;
      }
      else{
        showSnakbar(AppLocalizations.of(context)!.mimum2photo, context);
        return false;
      }
    }
    else{
      return true;
    }
  }
  void Init()async{
    preferences=await SharedPreferences.getInstance();
    if(widget.imagefile1 !="")
    {
      if(widget.imagefile1.contains("http"))
      {
        httpImages.add(widget.imagefile1);

        httpImageIndex.add("0");
      }
    }
    if(widget.imagefile2 !="")
    {
      if(widget.imagefile2.contains("http"))
      {

        httpImages.add(widget.imagefile2);
        httpImageIndex.add("1");
      }
    }
    if(widget.imagefile3 !="")
    {
      if(widget.imagefile3.contains("http"))
      {

        httpImages.add(widget.imagefile3);
        httpImageIndex.add("2");
      }
    }
    if(widget.imagefile4 !="")
    {
      if(widget.imagefile4.contains("http"))
      {

        httpImages.add(widget.imagefile4);
        httpImageIndex.add("3");
      }
    }
    if(widget.imagefile5 !="")
    {
      if(widget.imagefile5.contains("http"))
      {

        httpImages.add(widget.imagefile5);
        httpImageIndex.add("4");
      }
    }
    if(widget.imagefile6 !="")
    {
      if(widget.imagefile6.contains("http"))
      {

        httpImages.add(widget.imagefile6);
        httpImageIndex.add("5");
      }
    }
    print("httpImages.length");
    print(httpImages.length);
    print("fileimage.length");
    print(images.length);
    print(httpImageIndex.length);
    print(httpImageIndex);
    print(httpImageIndex.length);

  }
  bool isLoad=false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        key: _scaKey,
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        bottomNavigationBar: Container(
          height: 180.h,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: Column(
              children: [
                !widget.isEdit?InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: ()async{
                    if(images.length>1)
                    {
                      print(images);
                      print(images.length);
                      print(imagesindex);
                      print(imagesindex.length);
                      preferences!.setStringList("photo",images);
                      preferences!.setStringList("imagesindex",imagesindex);
                      Navigator.push(context,
                          MaterialPageRoute(builder:
                              (context) =>
                              GenderScreen(gender: "",isEdit:false,showGender: false,)
                          )
                      );
                    }
                    else{
                      print(images);
                      showSnakbar(AppLocalizations.of(context)!.mimum2photo, context);
                    }
                  },
                  child: Container(
                      height: 70.h,
                      margin: EdgeInsets.only(left: 25.w,right: 25.w),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: <Color>[
                              Color(0xFF570084),
                              Color(0xFFA33BE5)
                            ],
                          ),
                          borderRadius: BorderRadius.circular(50.r)),
                      alignment: Alignment.center,
                      child: addMediumText(AppLocalizations.of(context)!.continues, 14, Color(0xFFFFFFFF))
                  ),
                ):!isLoad?InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: ()async{
                    setState(() {
                      isLoad=true;
                    });
                    if((httpImages.length+images.length)>1)
                    {
                      preferences!.setStringList("photo",images);
                      var model = await ProfileRepository.updateProfileImage(images,preferences!.getString("accesstoken")!,imagesindex,httpImageIndex,httpImages);
                      if(model.statusCode==200)
                      {
                        print('updateProfileImage');
                        setState(() {
                          isLoad=false;
                        });
                        print("httpImages.length====");
                        print(httpImages.length);
                        print("fileimage.length====");
                        print(images.length);
                        print("httpImages.length+images.length");
                        print(httpImages.length+images.length);
                        var provider=await Provider.of<ProfileProvider>(context,listen: false);
                        // provider.resetStreams();

                        print("hello all${model.data?.phoneNumber}");
                        provider.adddetails(model);
                        Navigator.of(context).pop();
                      }
                      else if(model.statusCode==422){
                        setState(() {
                          isLoad=false;
                        });
                        showSnakbar(model.message!, context);
                      }
                      else {
                        setState(() {
                          isLoad=false;
                        });
                        showSnakbar(model.message!, context);
                      }
                    }
                    else{
                      setState(() {
                        isLoad=false;
                      });
                      print(images);
                      showSnakbar(AppLocalizations.of(context)!.mimum2photo, context);
                    }




                  },
                  child: Container(
                      height: 70.h,
                      margin: EdgeInsets.only(left: 25.w,right: 25.w),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: <Color>[
                              Color(0xFF570084),
                              Color(0xFFA33BE5)
                            ],
                          ),
                          borderRadius: BorderRadius.circular(50.r)),
                      alignment: Alignment.center,
                      child: addMediumText(AppLocalizations.of(context)!.update, 14, Color(0xFFFFFFFF))
                  ),
                ):Container(child: CircularProgressIndicator(),alignment: Alignment.topCenter,),
                Container(
                  alignment: Alignment.bottomCenter,
                  margin: EdgeInsets.only(bottom: 15.h,top: 30.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Image.asset("assets/images/moorky2.png",height: 45.h,width: 150.w,),
                      SizedBox(height: 5.h,),
                      Container(
                        height: 8.h,width: 140.w,),
                    ],
                  ),
                ),
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
              if((httpImages.length)>1)
              {
                Navigator.of(context).pop();
              }
              else{
                showSnakbar(AppLocalizations.of(context)!.mimum2photo, context);
              }
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
                      child: DragTarget<ImagesIndex>(
                        builder: (context,data,rejecteddata){
                          return InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: ()async{
                              if(widget.imagefile1.contains('http'))
                              {
                                httpImages.remove(widget.imagefile1);
                                httpImageIndex.remove("0");
                              }
                              else{
                                images.remove(widget.imagefile1);
                                imagesindex.remove("0");
                              }

                              widget.imagefile1=await _showImagePicker(context,widget.imagefile1);
                              if(widget.imagefile1!="")
                              {
                                images.add(widget.imagefile1);
                                imagesindex.add("0");
                              }
                            },
                            child: widget.imagefile1!=""?Draggable<ImagesIndex>(
                              data: ImagesIndex(index:"1",image: widget.imagefile1),
                              onDragCompleted: (){
                                if(isImage1)
                                {
                                  print("in this not drag completed");
                                }
                                else{

                                  // images.remove(widget.imagefile1);
                                  // // widget.imagefile1="";
                                  // imagesindex.remove("0");
                                }

                              },
                              childWhenDragging: Container(
                                height: 275,
                                margin: EdgeInsets.all(8),
                                decoration: BoxDecoration(color: Color(0xFFFDFAFF),borderRadius: BorderRadius.circular(15.r),),
                                child: Container(
                                  decoration: BoxDecoration(color: Color(0xFFFDFAFF),borderRadius: BorderRadius.circular(15.r),),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15.r),
                                    child: widget.imagefile1.contains("http")?CachedNetworkImage(
                                      imageUrl:widget.imagefile1,
                                      fit: BoxFit.cover,
                                      progressIndicatorBuilder: (context, url, downloadProgress) =>
                                          Container(child: CircularProgressIndicator(value: downloadProgress.progress),alignment: Alignment.center,),
                                      errorWidget: (context, url, error) => Icon(Icons.error),
                                    ):Image.file(
                                      File(widget.imagefile1),
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
                                    child: widget.imagefile1.contains("http")?CachedNetworkImage(
                                      imageUrl:widget.imagefile1,
                                      fit: BoxFit.cover,
                                      progressIndicatorBuilder: (context, url, downloadProgress) =>
                                          Container(child: CircularProgressIndicator(value: downloadProgress.progress),alignment: Alignment.center,),
                                      errorWidget: (context, url, error) => Icon(Icons.error),
                                    ):Image.file(
                                      File(widget.imagefile1.toString()),
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
                                          child: widget.imagefile1.contains("http")?CachedNetworkImage(
                                            imageUrl:widget.imagefile1,
                                            fit: BoxFit.cover,
                                            progressIndicatorBuilder: (context, url, downloadProgress) =>
                                                Container(child: CircularProgressIndicator(value: downloadProgress.progress),alignment: Alignment.center,),
                                            errorWidget: (context, url, error) => Icon(Icons.error),
                                          ):Image.file(
                                            File(widget.imagefile1),
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
                                        if(widget.imagefile1.contains("http"))
                                        {
                                          bool isImageDelete=await ProfileRepository.imageDelete(preferences!.getString("accesstoken")!, widget.imageid1);
                                          if(isImageDelete)
                                          {
                                            var profileprovider = Provider.of<ProfileProvider>(context, listen: false);
                                            profileprovider.resetStreams();
                                            if (preferences!.getString("accesstoken") != null) {
                                              profileprovider.fetchProfileDetails(
                                                  preferences!.getString("accesstoken").toString());
                                            }
                                            setState(() {
                                              httpImages.remove(widget.imagefile1);
                                              httpImageIndex.remove("0");
                                              widget.imagefile1="";
                                            });
                                          }

                                        }
                                        else{
                                          setState(() {
                                            images.remove(widget.imagefile1);
                                            print(images);
                                            imagesindex.remove("0");
                                            widget.imagefile1="";
                                          });
                                        }
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
                          if(data.image==widget.imagefile1)
                          {
                            print("widget.imagefile1");
                            print(widget.imagefile1);
                            setState(() {
                              isImage1=true;
                            });
                          }
                          else{
                            setState(() {
                              print("widget.imagefile1===");

                              if(data.index=="2")
                              {
                                if(widget.imagefile2.contains('http'))
                                {
                                  httpImages.remove(widget.imagefile2);

                                  httpImageIndex.remove("1");
                                  widget.imagefile2=widget.imagefile1;
                                  if(widget.imagefile2 != "")
                                  {
                                    if(widget.imagefile2.contains('http'))
                                    {
                                      httpImages.add(widget.imagefile2);

                                      httpImageIndex.add("1");
                                    }
                                    else{
                                      images.add(widget.imagefile2);
                                      imagesindex.add("1");
                                      images.remove(widget.imagefile1);
                                      imagesindex.remove("0");
                                    }
                                  }
                                  httpImages.remove(widget.imagefile1);

                                  httpImageIndex.remove("0");
                                }
                                else{
                                  images.remove(widget.imagefile2);
                                  imagesindex.remove("1");
                                  widget.imagefile2=widget.imagefile1;
                                  if(widget.imagefile2 != "")
                                  {
                                    if(widget.imagefile2.contains('http'))
                                    {
                                      httpImages.add(widget.imagefile2);

                                      httpImageIndex.add("1");
                                      httpImages.remove(widget.imagefile1);

                                      httpImageIndex.remove("0");
                                    }
                                    else{
                                      images.add(widget.imagefile2);
                                      imagesindex.add("1");
                                    }
                                  }
                                  images.remove(widget.imagefile1);
                                  imagesindex.remove("0");
                                }

                                //imagesindex.add("1");
                              }
                              else if(data.index=="3")
                              {
                                if(widget.imagefile3.contains('http')) {
                                  httpImages.remove(widget.imagefile3);

                                  httpImageIndex.remove("2");
                                  widget.imagefile3 = widget.imagefile1;
                                  if(widget.imagefile3!="")
                                  {
                                    if(widget.imagefile3.contains('http'))
                                    {
                                      httpImages.add(widget.imagefile3);

                                      httpImageIndex.add("2");
                                    }
                                    else{
                                      images.add(widget.imagefile3);
                                      imagesindex.add("2");
                                      images.remove(widget.imagefile1);
                                      imagesindex.remove("0");
                                    }
                                  }
                                  httpImages.remove(widget.imagefile1);

                                  httpImageIndex.remove("0");
                                }
                                else{
                                  images.remove(widget.imagefile3);
                                  imagesindex.remove("2");
                                  widget.imagefile3 = widget.imagefile1;
                                  if(widget.imagefile3!="")
                                  {
                                    if(widget.imagefile3.contains('http'))
                                    {
                                      httpImages.add(widget.imagefile3);

                                      httpImageIndex.add("2");
                                      httpImages.remove(widget.imagefile1);

                                      httpImageIndex.remove("0");
                                    }
                                    else{
                                      images.add(widget.imagefile3);
                                      imagesindex.add("2");
                                    }
                                  }
                                  images.remove(widget.imagefile1);
                                  imagesindex.remove("0");
                                  //imagesindex.remove("2");
                                }
                                //imagesindex.add("2");
                              }
                              else if(data.index=="4")
                              {
                                if(widget.imagefile4.contains('http')) {
                                  httpImages.remove(widget.imagefile4);

                                  httpImageIndex.remove("3");
                                  widget.imagefile4 = widget.imagefile1;
                                  if(widget.imagefile4!="")
                                  {
                                    if(widget.imagefile4.contains('http'))
                                    {
                                      httpImages.add(widget.imagefile4);

                                      httpImageIndex.add("3");
                                    }
                                    else{
                                      images.add(widget.imagefile4);
                                      imagesindex.add("3");
                                      images.remove(widget.imagefile1);
                                      imagesindex.remove("0");
                                    }
                                  }
                                  httpImages.remove(widget.imagefile1);

                                  httpImageIndex.remove("0");
                                }
                                else {
                                  images.remove(widget.imagefile4);
                                  imagesindex.remove("3");
                                  widget.imagefile4 = widget.imagefile1;
                                  if(widget.imagefile4!="")
                                  {
                                    if(widget.imagefile4.contains('http'))
                                    {
                                      httpImages.add(widget.imagefile4);

                                      httpImageIndex.add("3");
                                      httpImages.remove(widget.imagefile1);

                                      httpImageIndex.remove("0");
                                    }
                                    else{
                                      images.add(widget.imagefile4);
                                      imagesindex.add("3");
                                    }
                                  }
                                  images.remove(widget.imagefile1);
                                  imagesindex.remove("0");
                                  //imagesindex.remove("3");
                                }
                                //imagesindex.add("3");
                              }
                              else if(data.index=="5")
                              {
                                if(widget.imagefile5.contains('http'))
                                {
                                  httpImages.remove(widget.imagefile5);

                                  httpImageIndex.remove("4");
                                  widget.imagefile5=widget.imagefile1;
                                  if(widget.imagefile5!="")
                                  {
                                    if(widget.imagefile5.contains('http'))
                                    {
                                      httpImages.add(widget.imagefile5);

                                      httpImageIndex.add("4");
                                    }
                                    else{
                                      images.add(widget.imagefile5);
                                      imagesindex.add("4");
                                      images.remove(widget.imagefile1);
                                      imagesindex.remove("0");
                                    }
                                  }
                                  httpImages.remove(widget.imagefile1);

                                  httpImageIndex.remove("0");
                                }
                                else{
                                  images.remove(widget.imagefile5);
                                  imagesindex.remove("4");
                                  widget.imagefile5=widget.imagefile1;
                                  if(widget.imagefile5!="")
                                  {
                                    if(widget.imagefile5.contains('http'))
                                    {
                                      httpImages.add(widget.imagefile5);

                                      httpImageIndex.add("4");
                                      httpImages.remove(widget.imagefile1);

                                      httpImageIndex.remove("0");
                                    }
                                    else{
                                      images.add(widget.imagefile5);
                                      imagesindex.add("4");
                                    }
                                  }
                                  images.remove(widget.imagefile1);
                                  imagesindex.remove("0");
                                  // imagesindex.remove("4");
                                }

                                //imagesindex.add("4");
                              }
                              else if(data.index=="6")
                              {
                                if(widget.imagefile6.contains('http')) {
                                  httpImages.remove(widget.imagefile6);

                                  httpImageIndex.remove("5");
                                  widget.imagefile6 = widget.imagefile1;
                                  if(widget.imagefile6!="")
                                  {
                                    if(widget.imagefile6.contains('http'))
                                    {
                                      httpImages.add(widget.imagefile6);

                                      httpImageIndex.add("5");
                                    }
                                    else{
                                      images.add(widget.imagefile6);
                                      imagesindex.add("5");
                                      images.remove(widget.imagefile1);
                                      imagesindex.remove("0");
                                    }
                                  }

                                  httpImages.remove(widget.imagefile1);

                                  httpImageIndex.remove("0");
                                }
                                else{

                                  images.remove(widget.imagefile6);
                                  imagesindex.remove("5");
                                  widget.imagefile6 = widget.imagefile1;
                                  if(widget.imagefile6!="")
                                  {
                                    if(widget.imagefile6.contains('http'))
                                    {
                                      httpImages.add(widget.imagefile6);

                                      httpImageIndex.add("5");
                                      httpImages.remove(widget.imagefile1);

                                      httpImageIndex.remove("0");
                                    }
                                    else{
                                      images.add(widget.imagefile6);
                                      imagesindex.add("5");
                                    }
                                  }

                                  images.remove(widget.imagefile1);
                                  imagesindex.remove("0");
                                  //imagesindex.remove("5");
                                }
                                // imagesindex.add("5");
                              }
                              widget.imagefile1=data.image;
                              isImage1=false;
                              isImage2=false;
                              isImage3=false;
                              isImage4=false;
                              isImage5=false;
                              isImage6=false;
                              if(widget.imagefile1 != "")
                              {
                                if(widget.imagefile1.contains('http'))
                                {
                                  httpImageIndex.add("0");
                                  print("abcdefgh");
                                  httpImages.add(widget.imagefile1);

                                }
                                else{
                                  imagesindex.add("0");
                                  print("abcdefgh");
                                  images.add(widget.imagefile1);
                                }
                              }
                            });
                          }

                        },
                      ),),
                    Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            DragTarget<ImagesIndex>(
                              builder: (context,data,rejecteddata){
                                return InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: ()async{
                                    if(widget.imagefile2.contains('http'))
                                    {
                                      httpImages.remove(widget.imagefile2);
                                      httpImageIndex.remove("1");
                                    }
                                    else{
                                      images.remove(widget.imagefile2);
                                      imagesindex.remove("1");
                                    }
                                    widget.imagefile2=await _showImagePicker(context,widget.imagefile2);
                                    if(widget.imagefile2!="")
                                    {
                                      imagesindex.add("1");
                                      images.add(widget.imagefile2);
                                    }
                                  },
                                  child: widget.imagefile2!=""?Draggable<ImagesIndex>(
                                    data: ImagesIndex(index: "2",image: widget.imagefile2),
                                    onDragCompleted: (){
                                      if(isImage2)
                                      {
                                        print("in this not drag completed");

                                      }
                                      else{
                                        // print(widget.imagefile2);
                                        // images.remove(widget.imagefile2);
                                        // imagesindex.remove("1");
                                        // print(images);
                                        // widget.imagefile2="";
                                        // print("widget.imagefile1");
                                        // print(widget.imagefile2);
                                      }

                                    },
                                    childWhenDragging: Container(
                                      height: 129,
                                      margin: EdgeInsets.all(8),
                                      decoration: BoxDecoration(color: Color(0xFFFDFAFF),borderRadius: BorderRadius.circular(15.r),),
                                      child: Container(
                                        decoration: BoxDecoration(color: Color(0xFFFDFAFF),borderRadius: BorderRadius.circular(15.r),),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(15.r),
                                          child: widget.imagefile2.contains("http")?CachedNetworkImage(
                                            imageUrl:widget.imagefile2,
                                            fit: BoxFit.cover,
                                            progressIndicatorBuilder: (context, url, downloadProgress) =>
                                                Container(child: CircularProgressIndicator(value: downloadProgress.progress),alignment: Alignment.center,),
                                            errorWidget: (context, url, error) => Icon(Icons.error),
                                          ):Image.file(
                                            File(widget.imagefile2),
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
                                          child: widget.imagefile2.contains("http")?CachedNetworkImage(
                                            imageUrl:widget.imagefile2,
                                            fit: BoxFit.cover,
                                            progressIndicatorBuilder: (context, url, downloadProgress) =>
                                                Container(child: CircularProgressIndicator(value: downloadProgress.progress),alignment: Alignment.center,),
                                            errorWidget: (context, url, error) => Icon(Icons.error),
                                          ):Image.file(
                                            File(widget.imagefile2),
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
                                                child: widget.imagefile2.contains("http")?CachedNetworkImage(
                                                  imageUrl:widget.imagefile2,
                                                  fit: BoxFit.cover,
                                                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                                                      Container(child: CircularProgressIndicator(value: downloadProgress.progress),alignment: Alignment.center,),
                                                  errorWidget: (context, url, error) => Icon(Icons.error),
                                                ):Image.file(
                                                  File(widget.imagefile2),
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
                                              if(widget.imagefile2.contains("http"))
                                              {
                                                bool isImageDelete=await ProfileRepository.imageDelete(preferences!.getString("accesstoken")!, widget.imageid2);
                                                if(isImageDelete)
                                                {
                                                  var profileprovider = Provider.of<ProfileProvider>(context, listen: false);
                                                  profileprovider.resetStreams();
                                                  if (preferences!.getString("accesstoken") != null) {
                                                    profileprovider.fetchProfileDetails(
                                                        preferences!.getString("accesstoken").toString());
                                                  }
                                                  setState(() {
                                                    httpImages.remove(widget.imagefile2);
                                                    httpImageIndex.remove("1");
                                                    widget.imagefile2="";
                                                  });
                                                }


                                              }
                                              else{
                                                setState(() {
                                                  images.remove(widget.imagefile2);
                                                  imagesindex.remove("1");
                                                  print(images);
                                                  widget.imagefile2="";
                                                });
                                              }
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
                                if(data.image==widget.imagefile2)
                                {
                                  print("image 1");
                                  print(data);
                                  print("widget.imagefile1");
                                  print(widget.imagefile2);
                                  setState(() {
                                    isImage2=true;
                                  });
                                }
                                else{
                                  setState(() {
                                    print("image 1gdgdfgfg");
                                    print(data);
                                    print("widget.imagefile1fgdfgdfgd");
                                    if(data.index=="1")
                                    {
                                      if(widget.imagefile1.contains('http')) {
                                        httpImages.remove(widget.imagefile1);

                                        httpImageIndex.remove("0");
                                        widget.imagefile1 = widget.imagefile2;
                                        if(widget.imagefile1!="")
                                        {
                                          if(widget.imagefile1.contains('http'))
                                          {
                                            httpImages.add(widget.imagefile1);

                                            httpImageIndex.add("0");
                                          }
                                          else{
                                            images.add(widget.imagefile1);
                                            imagesindex.add("0");
                                            images.remove(widget.imagefile2);
                                            imagesindex.remove("1");
                                          }
                                        }
                                        httpImages.remove(widget.imagefile2);

                                        httpImageIndex.remove("1");
                                      }
                                      else{
                                        images.remove(widget.imagefile1);
                                        imagesindex.remove("0");
                                        widget.imagefile1 = widget.imagefile2;
                                        if(widget.imagefile1!="")
                                        {
                                          if(widget.imagefile1.contains('http'))
                                          {
                                            httpImages.add(widget.imagefile1);

                                            httpImageIndex.add("0");
                                            httpImages.remove(widget.imagefile2);

                                            httpImageIndex.remove("1");
                                          }
                                          else{
                                            images.add(widget.imagefile1);
                                            imagesindex.add("0");
                                          }
                                        }
                                        images.remove(widget.imagefile2);
                                        imagesindex.remove("1");
                                        // imagesindex.remove("0");
                                      }
                                      //imagesindex.add("0");
                                    }
                                    else if(data.index=="3")
                                    {
                                      if(widget.imagefile3.contains('http')) {
                                        httpImageIndex.remove("2");
                                        httpImages.remove(widget.imagefile3);

                                        widget.imagefile3 = widget.imagefile2;
                                        if(widget.imagefile3!="")
                                        {
                                          if(widget.imagefile3.contains('http'))
                                          {
                                            httpImages.add(widget.imagefile3);

                                            httpImageIndex.add("2");
                                          }
                                          else{
                                            images.add(widget.imagefile3);
                                            imagesindex.add("2");
                                            images.remove(widget.imagefile2);
                                            imagesindex.remove("1");
                                          }
                                        }

                                        httpImages.remove(widget.imagefile2);

                                        httpImageIndex.remove("1");
                                      }
                                      else{
                                        imagesindex.remove("2");
                                        images.remove(widget.imagefile3);
                                        widget.imagefile3 = widget.imagefile2;
                                        if(widget.imagefile3!="")
                                        {
                                          if(widget.imagefile3.contains('http'))
                                          {
                                            httpImages.add(widget.imagefile3);

                                            httpImageIndex.add("2");
                                            httpImages.remove(widget.imagefile2);

                                            httpImageIndex.remove("1");
                                          }
                                          else{
                                            images.add(widget.imagefile3);
                                            imagesindex.add("2");
                                          }
                                        }

                                        images.remove(widget.imagefile2);
                                        imagesindex.remove("1");
                                        //imagesindex.remove("2");
                                      }

                                      //imagesindex.add("2");
                                    }
                                    else if(data.index=="4")
                                    {
                                      if(widget.imagefile4.contains('http')) {
                                        httpImages.remove(widget.imagefile4);

                                        httpImageIndex.remove("3");
                                        widget.imagefile4 = widget.imagefile2;
                                        if(widget.imagefile4!="")
                                        {
                                          if(widget.imagefile4.contains('http'))
                                          {

                                            httpImages.add(widget.imagefile4);
                                            httpImageIndex.add("3");
                                          }
                                          else{
                                            images.add(widget.imagefile4);
                                            imagesindex.add("3");
                                            images.remove(widget.imagefile2);
                                            imagesindex.remove("1");
                                          }
                                        }

                                        httpImages.remove(widget.imagefile2);
                                        httpImageIndex.remove("1");
                                      }
                                      else{
                                        images.remove(widget.imagefile4);
                                        imagesindex.remove("3");
                                        widget.imagefile4 = widget.imagefile2;
                                        if(widget.imagefile4!="")
                                        {
                                          if(widget.imagefile4.contains('http'))
                                          {

                                            httpImages.add(widget.imagefile4);
                                            httpImageIndex.add("3");

                                            httpImages.remove(widget.imagefile2);
                                            httpImageIndex.remove("1");
                                          }
                                          else{
                                            images.add(widget.imagefile4);
                                            imagesindex.add("3");
                                          }
                                        }
                                        images.remove(widget.imagefile2);
                                        imagesindex.remove("1");
                                        //imagesindex.remove("3");
                                      }
                                      //imagesindex.add("3");
                                    }
                                    else if(data.index=="5")
                                    {
                                      if(widget.imagefile5.contains('http')) {
                                        httpImages.remove(widget.imagefile5);

                                        httpImageIndex.remove("4");
                                        widget.imagefile5 = widget.imagefile2;
                                        if(widget.imagefile5!="")
                                        {
                                          if(widget.imagefile5.contains('http'))
                                          {
                                            httpImages.add(widget.imagefile5);

                                            httpImageIndex.add("4");
                                          }
                                          else{
                                            images.add(widget.imagefile5);
                                            imagesindex.add("4");
                                            images.remove(widget.imagefile2);
                                            imagesindex.remove("1");
                                          }
                                        }

                                        httpImages.remove(widget.imagefile2);

                                        httpImageIndex.remove("1");
                                      }
                                      else{
                                        images.remove(widget.imagefile5);
                                        imagesindex.remove("4");
                                        widget.imagefile5 = widget.imagefile2;
                                        if(widget.imagefile5!="")
                                        {
                                          if(widget.imagefile5.contains('http'))
                                          {
                                            httpImages.add(widget.imagefile5);

                                            httpImageIndex.add("4");
                                            httpImages.remove(widget.imagefile2);

                                            httpImageIndex.remove("1");
                                          }
                                          else{
                                            images.add(widget.imagefile5);
                                            imagesindex.add("4");
                                          }
                                        }

                                        images.remove(widget.imagefile2);
                                        imagesindex.remove("1");

                                        //imagesindex.remove("4");
                                      }
                                      //imagesindex.add("4");
                                    }
                                    else if(data.index=="6")
                                    {
                                      if(widget.imagefile6.contains('http')) {

                                        httpImages.remove(widget.imagefile6);
                                        httpImageIndex.remove("5");
                                        widget.imagefile6 = widget.imagefile2;
                                        if(widget.imagefile6!="")
                                        {
                                          if(widget.imagefile6.contains('http'))
                                          {
                                            httpImages.add(widget.imagefile6);

                                            httpImageIndex.add("5");
                                          }
                                          else{
                                            images.add(widget.imagefile6);
                                            imagesindex.add("5");
                                            images.remove(widget.imagefile2);
                                            imagesindex.remove("1");
                                          }
                                        }

                                        httpImages.remove(widget.imagefile2);

                                        httpImageIndex.remove("1");
                                      }
                                      else{
                                        images.remove(widget.imagefile6);
                                        imagesindex.remove("5");
                                        widget.imagefile6 = widget.imagefile2;
                                        if(widget.imagefile6!="")
                                        {
                                          if(widget.imagefile6.contains('http'))
                                          {
                                            httpImages.add(widget.imagefile6);

                                            httpImageIndex.add("5");
                                            httpImages.remove(widget.imagefile2);

                                            httpImageIndex.remove("1");
                                          }
                                          else{
                                            images.add(widget.imagefile6);
                                            imagesindex.add("5");
                                          }
                                        }

                                        images.remove(widget.imagefile2);
                                        imagesindex.remove("1");
                                        // imagesindex.remove("5");
                                      }
                                      //imagesindex.add("5");
                                    }
                                    print(widget.imagefile2);
                                    widget.imagefile2=data.image;
                                    print(widget.imagefile2);
                                    isImage1=false;
                                    isImage2=false;
                                    isImage3=false;
                                    isImage4=false;
                                    isImage5=false;
                                    isImage6=false;
                                    if(widget.imagefile2 != "")
                                    {
                                      if(widget.imagefile2.contains('http'))
                                      {
                                        httpImageIndex.add("1");
                                        print("abcdefgh");
                                        httpImages.add(widget.imagefile2);

                                      }
                                      else{
                                        imagesindex.add("1");
                                        print("abcdefgh");
                                        images.add(widget.imagefile2);
                                      }
                                    }
                                  });
                                }

                              },
                            ),
                            DragTarget<ImagesIndex>(
                              builder: (context,data,rejecteddata){
                                return InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: ()async{
                                    if(widget.imagefile3.contains('http'))
                                    {
                                      httpImages.remove(widget.imagefile3);
                                      httpImageIndex.remove("2");
                                    }
                                    else{
                                      images.remove(widget.imagefile3);
                                      imagesindex.remove("2");
                                    }

                                    widget.imagefile3=await _showImagePicker(context,widget.imagefile3);
                                    if(widget.imagefile3!="")
                                    {
                                      imagesindex.add("2");
                                      images.add(widget.imagefile3);
                                    }
                                  },
                                  child: widget.imagefile3!=""?Draggable<ImagesIndex>(
                                    data: ImagesIndex(index: "3",image: widget.imagefile3),
                                    onDragCompleted: (){
                                      if(isImage3)
                                      {
                                        print("in this not drag completed");

                                      }
                                      else{
                                        // print(widget.imagefile3);
                                        // images.remove(widget.imagefile3);
                                        // // print(images);
                                        // imagesindex.remove("2");
                                        // widget.imagefile3="";
                                        // print("widget.imagefile1");
                                        // print(widget.imagefile3);
                                      }

                                    },
                                    childWhenDragging: Container(
                                      height: 129,
                                      margin: EdgeInsets.all(8),
                                      decoration: BoxDecoration(color: Color(0xFFFDFAFF),borderRadius: BorderRadius.circular(15.r),),
                                      child: Container(
                                        decoration: BoxDecoration(color: Color(0xFFFDFAFF),borderRadius: BorderRadius.circular(15.r),),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(15.r),
                                          child: widget.imagefile3.contains("http")?CachedNetworkImage(
                                            imageUrl:widget.imagefile3,
                                            fit: BoxFit.cover,
                                            progressIndicatorBuilder: (context, url, downloadProgress) =>
                                                Container(child: CircularProgressIndicator(value: downloadProgress.progress),alignment: Alignment.center,),
                                            errorWidget: (context, url, error) => Icon(Icons.error),
                                          ):Image.file(
                                            File(widget.imagefile3),
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
                                          child: widget.imagefile3.contains("http")?CachedNetworkImage(
                                            imageUrl:widget.imagefile3,
                                            fit: BoxFit.cover,
                                            progressIndicatorBuilder: (context, url, downloadProgress) =>
                                                Container(child: CircularProgressIndicator(value: downloadProgress.progress),alignment: Alignment.center,),
                                            errorWidget: (context, url, error) => Icon(Icons.error),
                                          ):Image.file(
                                            File(widget.imagefile3),
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
                                                child: widget.imagefile3.contains("http")?CachedNetworkImage(
                                                  imageUrl:widget.imagefile3,
                                                  fit: BoxFit.cover,
                                                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                                                      Container(child: CircularProgressIndicator(value: downloadProgress.progress),alignment: Alignment.center,),
                                                  errorWidget: (context, url, error) => Icon(Icons.error),
                                                ):Image.file(
                                                  File(widget.imagefile3),
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
                                              if(widget.imagefile3.contains("http"))
                                              {
                                                bool isImageDelete=await ProfileRepository.imageDelete(preferences!.getString("accesstoken")!, widget.imageid3);
                                                if(isImageDelete)
                                                {
                                                  var profileprovider = Provider.of<ProfileProvider>(context, listen: false);
                                                  profileprovider.resetStreams();
                                                  if (preferences!.getString("accesstoken") != null) {
                                                    profileprovider.fetchProfileDetails(
                                                        preferences!.getString("accesstoken").toString());
                                                  }
                                                  setState(() {
                                                    httpImages.remove(widget.imagefile3);
                                                    httpImageIndex.remove("2");
                                                    widget.imagefile3="";
                                                  });
                                                }
                                              }
                                              else{
                                                setState(() {
                                                  images.remove(widget.imagefile3);
                                                  print(images);
                                                  widget.imagefile3="";
                                                  imagesindex.remove("2");
                                                });
                                              }
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
                                if(data.image==widget.imagefile3)
                                {

                                  print("image 1");
                                  print(data);
                                  print("widget.imagefile1");
                                  print(widget.imagefile3);
                                  setState(() {
                                    isImage3=true;
                                  });
                                }
                                else{
                                  setState(() {
                                    print("image 1gdgdfgfg");
                                    print(data);
                                    print("widget.imagefile1fgdfgdfgd");
                                    print(widget.imagefile3);
                                    if(data.index=="1")
                                    {
                                      if(widget.imagefile1.contains('http')) {
                                        httpImages.remove(widget.imagefile1);

                                        httpImageIndex.remove("0");
                                        widget.imagefile1 = widget.imagefile3;
                                        if(widget.imagefile1!="")
                                        {
                                          if(widget.imagefile1.contains('http'))
                                          {
                                            httpImages.add(widget.imagefile1);

                                            httpImageIndex.add("0");
                                          }
                                          else{
                                            images.add(widget.imagefile1);
                                            imagesindex.add("0");
                                            images.remove(widget.imagefile3);
                                            imagesindex.remove("2");
                                          }
                                        }

                                        httpImages.remove(widget.imagefile3);

                                        httpImageIndex.remove("2");
                                      }
                                      else{
                                        images.remove(widget.imagefile1);
                                        imagesindex.remove("0");
                                        widget.imagefile1 = widget.imagefile3;
                                        if(widget.imagefile1!="")
                                        {
                                          if(widget.imagefile1.contains('http'))
                                          {
                                            httpImages.add(widget.imagefile1);

                                            httpImageIndex.add("0");
                                            httpImages.remove(widget.imagefile3);

                                            httpImageIndex.remove("2");
                                          }
                                          else{
                                            images.add(widget.imagefile1);
                                            imagesindex.add("0");
                                          }
                                        }

                                        images.remove(widget.imagefile3);
                                        imagesindex.remove("2");
                                        // imagesindex.remove("0");
                                      }
                                      //imagesindex.add("0");
                                    }
                                    else if(data.index=="2")
                                    {
                                      if(widget.imagefile2.contains('http')) {
                                        httpImages.remove(widget.imagefile2);

                                        httpImageIndex.remove("1");
                                        widget.imagefile2=widget.imagefile3;

                                        if(widget.imagefile2!="")
                                        {
                                          if(widget.imagefile2.contains('http'))
                                          {
                                            httpImages.add(widget.imagefile2);

                                            httpImageIndex.add("1");
                                          }
                                          else{
                                            images.add(widget.imagefile2);
                                            imagesindex.add("1");
                                            images.remove(widget.imagefile3);
                                            imagesindex.remove("2");
                                          }
                                        }

                                        httpImages.remove(widget.imagefile3);

                                        httpImageIndex.remove("2");
                                      }
                                      else{
                                        images.remove(widget.imagefile2);
                                        imagesindex.remove("1");
                                        widget.imagefile2=widget.imagefile3;

                                        if(widget.imagefile2!="")
                                        {
                                          if(widget.imagefile2.contains('http'))
                                          {
                                            httpImages.add(widget.imagefile2);

                                            httpImageIndex.add("1");
                                            httpImages.remove(widget.imagefile3);

                                            httpImageIndex.remove("2");
                                          }
                                          else{
                                            images.add(widget.imagefile2);
                                            imagesindex.add("1");
                                          }
                                        }

                                        images.remove(widget.imagefile3);
                                        imagesindex.remove("2");
                                        //imagesindex.remove("1");
                                      }

                                      // imagesindex.add("1");
                                    }
                                    else if(data.index=="4")
                                    {
                                      if(widget.imagefile4.contains('http')) {
                                        httpImages.remove(widget.imagefile4);

                                        httpImageIndex.remove("3");
                                        widget.imagefile4 = widget.imagefile3;

                                        if(widget.imagefile4!="")
                                        {
                                          if(widget.imagefile4.contains('http'))
                                          {
                                            httpImages.add(widget.imagefile4);

                                            httpImageIndex.add("3");
                                          }
                                          else{
                                            images.add(widget.imagefile4);
                                            imagesindex.add("3");
                                            images.remove(widget.imagefile3);
                                            imagesindex.remove("2");
                                          }
                                        }

                                        httpImages.remove(widget.imagefile3);

                                        httpImageIndex.remove("2");
                                      }
                                      else{
                                        images.remove(widget.imagefile4);
                                        imagesindex.remove("3");
                                        widget.imagefile4 = widget.imagefile3;

                                        if(widget.imagefile4!="")
                                        {
                                          if(widget.imagefile4.contains('http'))
                                          {

                                            httpImages.add(widget.imagefile4);
                                            httpImageIndex.add("3");


                                            httpImages.remove(widget.imagefile3);
                                            httpImageIndex.remove("2");
                                          }
                                          else{
                                            images.add(widget.imagefile4);
                                            imagesindex.add("3");
                                          }
                                        }

                                        images.remove(widget.imagefile3);
                                        imagesindex.remove("2");
                                        //imagesindex.remove("3");
                                      }
                                      //imagesindex.add("3");
                                    }
                                    else if(data.index=="5")
                                    {
                                      if(widget.imagefile5.contains('http')) {
                                        httpImages.remove(widget.imagefile5);

                                        httpImageIndex.remove("4");
                                        widget.imagefile5 = widget.imagefile3;

                                        if(widget.imagefile5!="")
                                        {
                                          if(widget.imagefile5.contains('http'))
                                          {
                                            httpImages.add(widget.imagefile5);

                                            httpImageIndex.add("4");
                                          }
                                          else{
                                            images.add(widget.imagefile5);
                                            imagesindex.add("4");
                                            images.remove(widget.imagefile3);
                                            imagesindex.remove("2");
                                          }
                                        }

                                        httpImages.remove(widget.imagefile3);

                                        httpImageIndex.remove("2");
                                      }
                                      else{
                                        images.remove(widget.imagefile5);
                                        imagesindex.remove("4");
                                        widget.imagefile5 = widget.imagefile3;

                                        if(widget.imagefile5!="")
                                        {
                                          if(widget.imagefile5.contains('http'))
                                          {

                                            httpImages.add(widget.imagefile5);
                                            httpImageIndex.add("4");
                                            httpImages.remove(widget.imagefile3);

                                            httpImageIndex.remove("2");
                                          }
                                          else{
                                            images.add(widget.imagefile5);
                                            imagesindex.add("4");
                                          }
                                        }

                                        images.remove(widget.imagefile3);
                                        imagesindex.remove("2");
                                        // imagesindex.remove("4");
                                      }
                                      //imagesindex.add("4");
                                    }
                                    else if(data.index=="6")
                                    {
                                      if(widget.imagefile6.contains('http')) {
                                        httpImages.remove(widget.imagefile6);

                                        httpImageIndex.remove("5");
                                        widget.imagefile6 = widget.imagefile3;
                                        if(widget.imagefile6!="")
                                        {
                                          if(widget.imagefile6.contains('http'))
                                          {
                                            httpImages.add(widget.imagefile6);

                                            httpImageIndex.add("5");
                                          }
                                          else{
                                            images.add(widget.imagefile6);
                                            imagesindex.add("5");
                                            images.remove(widget.imagefile3);
                                            imagesindex.remove("2");
                                          }
                                        }
                                        httpImages.remove(widget.imagefile3);

                                        httpImageIndex.remove("2");
                                      }
                                      else{
                                        images.remove(widget.imagefile6);
                                        imagesindex.remove("5");
                                        widget.imagefile6 = widget.imagefile3;

                                        if(widget.imagefile6!="")
                                        {
                                          if(widget.imagefile6.contains('http'))
                                          {
                                            httpImages.add(widget.imagefile6);

                                            httpImageIndex.add("5");
                                            httpImages.remove(widget.imagefile3);

                                            httpImageIndex.remove("2");
                                          }
                                          else{
                                            images.add(widget.imagefile6);
                                            imagesindex.add("5");
                                          }
                                        }

                                        images.remove(widget.imagefile3);
                                        imagesindex.remove("2");
                                        //imagesindex.remove("5");
                                      }
                                      //imagesindex.add("5");
                                    }
                                    widget.imagefile3=data.image;
                                    print(widget.imagefile3);
                                    isImage1=false;
                                    isImage2=false;
                                    isImage3=false;
                                    isImage4=false;
                                    isImage5=false;
                                    isImage6=false;
                                    if(widget.imagefile3 != "")
                                    {
                                      if(widget.imagefile3.contains('http'))
                                      {
                                        httpImageIndex.add("2");
                                        print("abcdefgh");
                                        httpImages.add(widget.imagefile3);

                                      }
                                      else{
                                        imagesindex.add("2");
                                        print("abcdefgh");
                                        images.add(widget.imagefile3);
                                      }
                                    }
                                  });
                                }
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
                      child: DragTarget<ImagesIndex>(
                        builder: (context,data,rejecteddata){
                          return InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: ()async{
                              if(widget.imagefile4.contains('http'))
                              {
                                httpImages.remove(widget.imagefile4);
                                httpImageIndex.remove("3");
                              }
                              else{
                                images.remove(widget.imagefile4);
                                imagesindex.remove("3");
                              }

                              widget.imagefile4=await _showImagePicker(context,widget.imagefile4);
                              if(widget.imagefile4!="")
                              {
                                imagesindex.add("3");
                                images.add(widget.imagefile4);
                              }
                            },
                            child: widget.imagefile4!=""?Draggable<ImagesIndex>(
                              data: ImagesIndex(index: "4",image: widget.imagefile4),
                              onDragCompleted: (){
                                if(isImage4)
                                {
                                  print("in this not drag completed");

                                }
                                else{
                                  // print(widget.imagefile4);
                                  // images.remove(widget.imagefile4);
                                  // imagesindex.remove("3");
                                  // print(images);
                                  // widget.imagefile4="";
                                  // print("widget.imagefile1");
                                  // print(widget.imagefile4);
                                }

                              },
                              childWhenDragging: Container(
                                height: 129,
                                margin: EdgeInsets.all(8),
                                decoration: BoxDecoration(color: Color(0xFFFDFAFF),borderRadius: BorderRadius.circular(15.r),),
                                child: Container(
                                  decoration: BoxDecoration(color: Color(0xFFFDFAFF),borderRadius: BorderRadius.circular(15.r),),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15.r),
                                    child: widget.imagefile4.contains("http")?CachedNetworkImage(
                                      imageUrl:widget.imagefile4,
                                      fit: BoxFit.cover,
                                      progressIndicatorBuilder: (context, url, downloadProgress) =>
                                          Container(child: CircularProgressIndicator(value: downloadProgress.progress),alignment: Alignment.center,),
                                      errorWidget: (context, url, error) => Icon(Icons.error),
                                    ):Image.file(
                                      File(widget.imagefile4),
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
                                    child: widget.imagefile4.contains("http")?CachedNetworkImage(
                                      imageUrl:widget.imagefile4,
                                      fit: BoxFit.cover,
                                      progressIndicatorBuilder: (context, url, downloadProgress) =>
                                          Container(child: CircularProgressIndicator(value: downloadProgress.progress),alignment: Alignment.center,),
                                      errorWidget: (context, url, error) => Icon(Icons.error),
                                    ):Image.file(
                                      File(widget.imagefile4),
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
                                          child: widget.imagefile4.contains("http")?CachedNetworkImage(
                                            imageUrl:widget.imagefile4,
                                            fit: BoxFit.cover,
                                            progressIndicatorBuilder: (context, url, downloadProgress) =>
                                                Container(child: CircularProgressIndicator(value: downloadProgress.progress),alignment: Alignment.center,),
                                            errorWidget: (context, url, error) => Icon(Icons.error),
                                          ):Image.file(
                                            File(widget.imagefile4),
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
                                        if(widget.imagefile4.contains("http"))
                                        {
                                          bool isImageDelete=await ProfileRepository.imageDelete(preferences!.getString("accesstoken")!, widget.imageid4);
                                          if(isImageDelete)
                                          {
                                            var profileprovider = Provider.of<ProfileProvider>(context, listen: false);
                                            profileprovider.resetStreams();
                                            if (preferences!.getString("accesstoken") != null) {
                                              profileprovider.fetchProfileDetails(
                                                  preferences!.getString("accesstoken").toString());
                                            }
                                            setState(() {
                                              httpImages.remove(widget.imagefile4);
                                              httpImageIndex.remove("3");
                                              widget.imagefile4="";
                                            });
                                          }


                                        }
                                        else{
                                          setState(() {
                                            images.remove(widget.imagefile4);
                                            print(images);
                                            widget.imagefile4="";
                                            imagesindex.remove("3");
                                          });
                                        }
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
                          if(data.image==widget.imagefile4)
                          {
                            print("image 1");
                            print(data);
                            print("widget.imagefile1");
                            print(widget.imagefile4);
                            setState(() {
                              isImage4=true;
                            });
                          }
                          else{
                            setState(() {
                              print("image 1gdgdfgfg");
                              print(data);
                              print("widget.imagefile1fgdfgdfgd");
                              print(widget.imagefile4);
                              if(data.index=="1")
                              {
                                if(widget.imagefile1.contains('http')) {
                                  httpImages.remove(widget.imagefile1);

                                  httpImageIndex.remove("0");
                                  widget.imagefile1 = widget.imagefile4;
                                  if(widget.imagefile1!="")
                                  {
                                    if(widget.imagefile1.contains('http'))
                                    {

                                      httpImages.add(widget.imagefile1);
                                      httpImageIndex.add("0");
                                    }
                                    else{
                                      images.add(widget.imagefile1);
                                      imagesindex.add("0");
                                      images.remove(widget.imagefile4);
                                      imagesindex.remove("3");
                                    }
                                  }

                                  httpImages.remove(widget.imagefile4);
                                  httpImageIndex.remove("3");
                                }
                                else{
                                  images.remove(widget.imagefile1);
                                  imagesindex.remove("0");
                                  widget.imagefile1 = widget.imagefile4;

                                  if(widget.imagefile1!="")
                                  {
                                    if(widget.imagefile1.contains('http'))
                                    {

                                      httpImages.add(widget.imagefile1);
                                      httpImageIndex.add("0");

                                      httpImages.remove(widget.imagefile4);
                                      httpImageIndex.remove("3");
                                    }
                                    else{
                                      images.add(widget.imagefile1);
                                      imagesindex.add("0");
                                    }
                                  }

                                  images.remove(widget.imagefile4);
                                  imagesindex.remove("3");
                                  // imagesindex.remove("0");
                                }
                                //imagesindex.add("0");
                              }
                              else if(data.index=="2")
                              {
                                if(widget.imagefile2.contains('http')) {
                                  httpImages.remove(widget.imagefile2);

                                  httpImageIndex.remove("1");
                                  widget.imagefile2 = widget.imagefile4;
                                  if(widget.imagefile2!="")
                                  {
                                    if(widget.imagefile2.contains('http'))
                                    {
                                      httpImages.add(widget.imagefile2);

                                      httpImageIndex.add("1");
                                    }
                                    else{
                                      images.add(widget.imagefile2);
                                      imagesindex.add("1");
                                      images.remove(widget.imagefile4);
                                      imagesindex.remove("3");
                                    }
                                  }

                                  httpImages.remove(widget.imagefile4);
                                  httpImageIndex.remove("3");
                                }
                                else{
                                  images.remove(widget.imagefile2);
                                  imagesindex.remove("1");
                                  widget.imagefile2 = widget.imagefile4;

                                  if(widget.imagefile2!="")
                                  {
                                    if(widget.imagefile2.contains('http'))
                                    {

                                      httpImages.add(widget.imagefile2);
                                      httpImageIndex.add("1");

                                      httpImages.remove(widget.imagefile4);
                                      httpImageIndex.remove("3");
                                    }
                                    else{
                                      images.add(widget.imagefile2);
                                      imagesindex.add("1");
                                    }
                                  }

                                  images.remove(widget.imagefile4);
                                  imagesindex.remove("3");
                                  //imagesindex.remove("1");
                                }
                                //imagesindex.add("1");
                              }
                              else if(data.index=="3")
                              {
                                if(widget.imagefile3.contains('http')) {
                                  httpImages.remove(widget.imagefile3);

                                  httpImageIndex.remove("2");
                                  widget.imagefile3 = widget.imagefile4;

                                  if(widget.imagefile3!="")
                                  {
                                    if(widget.imagefile3.contains('http'))
                                    {

                                      httpImages.add(widget.imagefile3);
                                      httpImageIndex.add("2");
                                    }
                                    else{
                                      images.add(widget.imagefile3);
                                      imagesindex.add("2");
                                      images.remove(widget.imagefile4);
                                      imagesindex.remove("3");
                                    }
                                  }


                                  httpImages.remove(widget.imagefile4);
                                  httpImageIndex.remove("3");
                                }
                                else{
                                  images.remove(widget.imagefile3);
                                  imagesindex.remove("2");
                                  widget.imagefile3 = widget.imagefile4;

                                  if(widget.imagefile3!="")
                                  {
                                    if(widget.imagefile3.contains('http'))
                                    {

                                      httpImages.add(widget.imagefile3);
                                      httpImageIndex.add("2");

                                      httpImages.remove(widget.imagefile4);
                                      httpImageIndex.remove("3");
                                    }
                                    else{
                                      images.add(widget.imagefile3);
                                      imagesindex.add("2");
                                    }
                                  }

                                  images.remove(widget.imagefile4);
                                  imagesindex.remove("3");
                                  // imagesindex.remove("2");
                                }
                                //imagesindex.add("2");
                              }
                              else if(data.index=="5")
                              {
                                if(widget.imagefile5.contains('http')) {

                                  httpImages.remove(widget.imagefile5);
                                  httpImageIndex.remove("4");
                                  widget.imagefile5 = widget.imagefile4;

                                  if(widget.imagefile5!="")
                                  {
                                    if(widget.imagefile5.contains('http'))
                                    {

                                      httpImages.add(widget.imagefile5);
                                      httpImageIndex.add("4");
                                    }
                                    else{
                                      images.add(widget.imagefile5);
                                      imagesindex.add("4");
                                      images.remove(widget.imagefile4);
                                      imagesindex.remove("3");
                                    }
                                  }

                                  httpImages.remove(widget.imagefile4);
                                  httpImageIndex.remove("3");
                                }
                                else{
                                  images.remove(widget.imagefile5);
                                  imagesindex.remove("4");
                                  widget.imagefile5 = widget.imagefile4;

                                  if(widget.imagefile5!="")
                                  {
                                    if(widget.imagefile5.contains('http'))
                                    {

                                      httpImages.add(widget.imagefile5);
                                      httpImageIndex.add("4");

                                      httpImages.remove(widget.imagefile4);
                                      httpImageIndex.remove("3");
                                    }
                                    else{
                                      images.add(widget.imagefile5);
                                      imagesindex.add("4");
                                    }
                                  }

                                  images.remove(widget.imagefile4);
                                  imagesindex.remove("3");
                                  //imagesindex.remove("4");
                                }
                                //imagesindex.add("4");
                              }
                              else if(data.index=="6")
                              {
                                if(widget.imagefile6.contains('http')) {

                                  httpImages.remove(widget.imagefile6);
                                  httpImageIndex.remove("5");
                                  widget.imagefile6 = widget.imagefile4;

                                  if(widget.imagefile6!="")
                                  {
                                    if(widget.imagefile6.contains('http'))
                                    {

                                      httpImages.add(widget.imagefile6);
                                      httpImageIndex.add("5");
                                    }
                                    else{
                                      images.add(widget.imagefile6);
                                      imagesindex.add("5");
                                      images.remove(widget.imagefile4);
                                      imagesindex.remove("3");
                                    }
                                  }


                                  httpImages.remove(widget.imagefile4);
                                  httpImageIndex.remove("3");
                                }
                                else{
                                  images.remove(widget.imagefile6);
                                  imagesindex.remove("5");
                                  widget.imagefile6 = widget.imagefile4;

                                  if(widget.imagefile6!="")
                                  {
                                    if(widget.imagefile6.contains('http'))
                                    {

                                      httpImages.add(widget.imagefile6);
                                      httpImageIndex.add("5");

                                      httpImages.remove(widget.imagefile4);
                                      httpImageIndex.remove("3");
                                    }
                                    else{
                                      images.add(widget.imagefile6);
                                      imagesindex.add("5");
                                    }
                                  }

                                  images.remove(widget.imagefile4);
                                  imagesindex.remove("3");
                                  // imagesindex.remove("5");
                                }
                                //imagesindex.add("5");
                              }
                              widget.imagefile4=data.image;
                              print(widget.imagefile4);
                              isImage1=false;
                              isImage2=false;
                              isImage3=false;
                              isImage4=false;
                              isImage5=false;
                              isImage6=false;
                              if(widget.imagefile4 != "")
                              {
                                if(widget.imagefile4.contains('http'))
                                {
                                  httpImageIndex.add("3");
                                  print("abcdefgh");

                                  httpImages.add(widget.imagefile4);
                                }
                                else{
                                  imagesindex.add("3");
                                  print("abcdefgh");
                                  images.add(widget.imagefile4);
                                }
                              }
                            });
                          }
                        },
                      ),),
                    Expanded(
                      flex: 1,
                      child: DragTarget<ImagesIndex>(
                        builder: (context,data,rejecteddata){
                          return InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: ()async{
                              if(widget.imagefile5.contains('http'))
                              {
                                httpImages.remove(widget.imagefile5);
                                httpImageIndex.remove("4");
                              }
                              else{
                                images.remove(widget.imagefile5);
                                imagesindex.remove("4");
                              }

                              widget.imagefile5=await _showImagePicker(context,widget.imagefile5);
                              if(widget.imagefile5!="")
                              {
                                imagesindex.add("4");
                                images.add(widget.imagefile5);
                              }
                            },
                            child: widget.imagefile5!=""?Draggable<ImagesIndex>(
                              data: ImagesIndex(index: "5",image: widget.imagefile5),
                              onDragCompleted: (){
                                if(isImage5)
                                {
                                  print("in this not drag completed");

                                }
                                else{
                                  // print(widget.imagefile5);
                                  // images.remove(widget.imagefile5);
                                  // // print(images);
                                  // imagesindex.remove("4");
                                  // widget.imagefile5="";
                                  // print("widget.imagefile1");
                                  // print(widget.imagefile5);
                                }

                              },
                              childWhenDragging: Container(
                                height: 129,
                                margin: EdgeInsets.all(8),
                                decoration: BoxDecoration(color: Color(0xFFFDFAFF),borderRadius: BorderRadius.circular(15.r),),
                                child: Container(
                                  decoration: BoxDecoration(color: Color(0xFFFDFAFF),borderRadius: BorderRadius.circular(15.r),),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15.r),
                                    child: widget.imagefile5.contains("http")?CachedNetworkImage(
                                      imageUrl:widget.imagefile5,
                                      fit: BoxFit.cover,
                                      progressIndicatorBuilder: (context, url, downloadProgress) =>
                                          Container(child: CircularProgressIndicator(value: downloadProgress.progress),alignment: Alignment.center,),
                                      errorWidget: (context, url, error) => Icon(Icons.error),
                                    ):Image.file(
                                      File(widget.imagefile5),
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
                                    child: widget.imagefile5.contains("http")?CachedNetworkImage(
                                      imageUrl:widget.imagefile5,
                                      fit: BoxFit.cover,
                                      progressIndicatorBuilder: (context, url, downloadProgress) =>
                                          Container(child: CircularProgressIndicator(value: downloadProgress.progress),alignment: Alignment.center,),
                                      errorWidget: (context, url, error) => Icon(Icons.error),
                                    ):Image.file(
                                      File(widget.imagefile5),
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
                                          child: widget.imagefile5.contains("http")?CachedNetworkImage(
                                            imageUrl:widget.imagefile5,
                                            fit: BoxFit.cover,
                                            progressIndicatorBuilder: (context, url, downloadProgress) =>
                                                Container(child: CircularProgressIndicator(value: downloadProgress.progress),alignment: Alignment.center,),
                                            errorWidget: (context, url, error) => Icon(Icons.error),
                                          ):Image.file(
                                            File(widget.imagefile5),
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
                                        if(widget.imagefile5.contains("http"))
                                        {
                                          bool isImageDelete=await ProfileRepository.imageDelete(preferences!.getString("accesstoken")!, widget.imageid5);
                                          if(isImageDelete)
                                          {
                                            var profileprovider = Provider.of<ProfileProvider>(context, listen: false);
                                            profileprovider.resetStreams();
                                            if (preferences!.getString("accesstoken") != null) {
                                              profileprovider.fetchProfileDetails(
                                                  preferences!.getString("accesstoken").toString());
                                            }
                                            setState(() {

                                              httpImages.remove(widget.imagefile5);
                                              httpImageIndex.remove("4");
                                              widget.imagefile5="";
                                            });
                                          }


                                        }
                                        else{
                                          setState(() {
                                            images.remove(widget.imagefile5);
                                            print(images);
                                            imagesindex.remove("4");
                                            widget.imagefile5="";
                                          });
                                        }
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
                          if(data.image==widget.imagefile5)
                          {

                            print("image 1");
                            print(data);
                            print("widget.imagefile1");
                            print(widget.imagefile5);
                            setState(() {
                              isImage5=true;
                            });
                          }
                          else{
                            setState(() {
                              print("image 1gdgdfgfg");
                              print(data);
                              print("widget.imagefile1fgdfgdfgd");
                              print(widget.imagefile5);
                              if(data.index=="1")
                              {
                                if(widget.imagefile1.contains('http')) {

                                  httpImages.remove(widget.imagefile1);
                                  httpImageIndex.remove("0");
                                  widget.imagefile1 = widget.imagefile5;

                                  if(widget.imagefile1!="")
                                  {
                                    if(widget.imagefile1.contains('http'))
                                    {

                                      httpImages.add(widget.imagefile1);
                                      httpImageIndex.add("0");
                                    }
                                    else{
                                      images.add(widget.imagefile1);
                                      imagesindex.add("0");
                                      images.remove(widget.imagefile5);
                                      imagesindex.remove("4");
                                    }
                                  }

                                  httpImages.remove(widget.imagefile5);
                                  httpImageIndex.remove("4");
                                }
                                else{
                                  images.remove(widget.imagefile1);
                                  imagesindex.remove("0");
                                  widget.imagefile1 = widget.imagefile5;

                                  if(widget.imagefile1!="")
                                  {
                                    if(widget.imagefile1.contains('http'))
                                    {

                                      httpImages.add(widget.imagefile1);
                                      httpImageIndex.add("0");

                                      httpImages.remove(widget.imagefile5);
                                      httpImageIndex.remove("4");
                                    }
                                    else{
                                      images.add(widget.imagefile1);
                                      imagesindex.add("0");
                                    }
                                  }

                                  images.remove(widget.imagefile5);
                                  imagesindex.remove("4");
                                  //imagesindex.remove("0");
                                }
                                //imagesindex.add("0");
                              }
                              else if(data.index=="2")
                              {
                                if(widget.imagefile2.contains('http')) {

                                  httpImages.remove(widget.imagefile2);
                                  httpImageIndex.remove("1");
                                  widget.imagefile2 = widget.imagefile5;

                                  if(widget.imagefile2!="")
                                  {
                                    if(widget.imagefile2.contains('http'))
                                    {

                                      httpImages.add(widget.imagefile2);
                                      httpImageIndex.add("1");
                                    }
                                    else{
                                      images.add(widget.imagefile2);
                                      imagesindex.add("1");
                                      images.remove(widget.imagefile5);
                                      imagesindex.remove("4");
                                    }
                                  }

                                  httpImages.remove(widget.imagefile5);
                                  httpImageIndex.remove("4");
                                }
                                else{
                                  images.remove(widget.imagefile2);
                                  imagesindex.remove("1");
                                  widget.imagefile2 = widget.imagefile5;

                                  if(widget.imagefile2!="")
                                  {
                                    if(widget.imagefile2.contains('http'))
                                    {

                                      httpImages.add(widget.imagefile2);
                                      httpImageIndex.add("1");

                                      httpImages.remove(widget.imagefile5);
                                      httpImageIndex.remove("4");
                                    }
                                    else{
                                      images.add(widget.imagefile2);
                                      imagesindex.add("1");
                                    }
                                  }

                                  images.remove(widget.imagefile5);
                                  imagesindex.remove("4");
                                  //imagesindex.remove("1");
                                }
                                //imagesindex.add("1");
                              }
                              else if(data.index=="3")
                              {
                                if(widget.imagefile3.contains('http')) {

                                  httpImages.remove(widget.imagefile3);
                                  httpImageIndex.remove("2");
                                  widget.imagefile3 = widget.imagefile5;

                                  if(widget.imagefile3!="")
                                  {
                                    if(widget.imagefile3.contains('http'))
                                    {

                                      httpImages.add(widget.imagefile3);
                                      httpImageIndex.add("2");
                                    }
                                    else{
                                      images.add(widget.imagefile3);
                                      imagesindex.add("2");
                                      images.remove(widget.imagefile5);
                                      imagesindex.remove("4");
                                    }
                                  }

                                  httpImages.remove(widget.imagefile5);
                                  httpImageIndex.remove("4");
                                }
                                else{
                                  images.remove(widget.imagefile3);
                                  imagesindex.remove("2");
                                  widget.imagefile3 = widget.imagefile5;

                                  if(widget.imagefile3!="")
                                  {
                                    if(widget.imagefile3.contains('http'))
                                    {

                                      httpImages.add(widget.imagefile3);
                                      httpImageIndex.add("2");

                                      httpImages.remove(widget.imagefile5);
                                      httpImageIndex.remove("4");
                                    }
                                    else{
                                      images.add(widget.imagefile3);
                                      imagesindex.add("2");
                                    }
                                  }

                                  images.remove(widget.imagefile5);
                                  imagesindex.remove("4");
                                  // imagesindex.remove("2");
                                }
                                //imagesindex.add("2");

                              }
                              else if(data.index=="4")
                              {
                                if(widget.imagefile4.contains('http')) {
                                  httpImages.remove(widget.imagefile4);

                                  httpImageIndex.remove("3");
                                  widget.imagefile4 = widget.imagefile5;

                                  if(widget.imagefile4!="")
                                  {
                                    if(widget.imagefile4.contains('http'))
                                    {

                                      httpImages.add(widget.imagefile4);
                                      httpImageIndex.add("3");
                                    }
                                    else{
                                      images.add(widget.imagefile4);
                                      imagesindex.add("3");
                                      images.remove(widget.imagefile5);
                                      imagesindex.remove("4");
                                    }
                                  }

                                  httpImages.remove(widget.imagefile5);
                                  httpImageIndex.remove("4");
                                }
                                else{
                                  images.remove(widget.imagefile4);
                                  imagesindex.remove("3");
                                  widget.imagefile4 = widget.imagefile5;

                                  if(widget.imagefile4!="")
                                  {
                                    if(widget.imagefile4.contains('http'))
                                    {

                                      httpImages.add(widget.imagefile4);
                                      httpImageIndex.add("3");

                                      httpImages.remove(widget.imagefile5);
                                      httpImageIndex.remove("4");
                                    }
                                    else{
                                      images.add(widget.imagefile4);
                                      imagesindex.add("3");
                                    }
                                  }

                                  images.remove(widget.imagefile5);
                                  imagesindex.remove("4");
                                  //imagesindex.remove("3");
                                }
                                // imagesindex.add("3");
                              }
                              else if(data.index=="6")
                              {
                                if(widget.imagefile6.contains('http')) {

                                  httpImages.remove(widget.imagefile6);
                                  httpImageIndex.remove("5");
                                  widget.imagefile6 = widget.imagefile5;

                                  if(widget.imagefile6!="")
                                  {
                                    if(widget.imagefile6.contains('http'))
                                    {

                                      httpImages.add(widget.imagefile6);
                                      httpImageIndex.add("5");
                                    }
                                    else{
                                      images.add(widget.imagefile6);
                                      imagesindex.add("5");
                                      images.remove(widget.imagefile5);
                                      imagesindex.remove("4");
                                    }
                                  }

                                  httpImages.remove(widget.imagefile5);
                                  httpImageIndex.remove("4");
                                }
                                else{
                                  images.remove(widget.imagefile6);
                                  imagesindex.remove("5");
                                  widget.imagefile6 = widget.imagefile5;

                                  if(widget.imagefile6!="")
                                  {
                                    if(widget.imagefile6.contains('http'))
                                    {

                                      httpImages.add(widget.imagefile6);
                                      httpImageIndex.add("5");

                                      httpImages.remove(widget.imagefile5);
                                      httpImageIndex.remove("4");
                                    }
                                    else{
                                      images.add(widget.imagefile6);
                                      imagesindex.add("5");
                                    }
                                  }

                                  images.remove(widget.imagefile5);
                                  imagesindex.remove("4");
                                  // imagesindex.remove("5");
                                }
                                //imagesindex.add("5");
                              }
                              widget.imagefile5=data.image;
                              print(widget.imagefile5);
                              isImage1=false;
                              isImage2=false;
                              isImage3=false;
                              isImage4=false;
                              isImage5=false;
                              isImage6=false;
                              if(widget.imagefile5 != "")
                              {
                                if(widget.imagefile5.contains('http'))
                                {
                                  httpImageIndex.add("4");
                                  print("abcdefgh");

                                  httpImages.add(widget.imagefile5);
                                }
                                else{
                                  imagesindex.add("4");
                                  print("abcdefgh");
                                  images.add(widget.imagefile5);
                                }
                              }
                            });
                          }
                        },
                      ),),
                    Expanded(
                      flex: 1,
                      child: DragTarget<ImagesIndex>(
                        builder: (context,data,rejecteddata){
                          return InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: ()async{
                              if(widget.imagefile6.contains('http'))
                              {
                                httpImages.remove(widget.imagefile6);
                                httpImageIndex.remove("5");
                              }
                              else{
                                images.remove(widget.imagefile6);
                                imagesindex.remove("5");
                              }

                              widget.imagefile6=await _showImagePicker(context,widget.imagefile6);
                              if(widget.imagefile6!="")
                              {
                                imagesindex.add("5");
                                images.add(widget.imagefile6);
                              }
                            },
                            child: widget.imagefile6!=""?Draggable<ImagesIndex>(
                              data: ImagesIndex(index: "6",image: widget.imagefile6),
                              onDragCompleted: (){
                                if(isImage6)
                                {
                                  print("in this not drag completed");
                                }
                                else{
                                  // print(widget.imagefile6);
                                  // images.remove(widget.imagefile6);
                                  // imagesindex.remove("5");
                                  // print(images);
                                  // widget.imagefile6="";
                                  // print("widget.imagefile1");
                                  // print(widget.imagefile6);
                                }

                              },
                              childWhenDragging: Container(
                                height: 129,
                                margin: EdgeInsets.all(8),
                                decoration: BoxDecoration(color: Color(0xFFFDFAFF),borderRadius: BorderRadius.circular(15.r),),
                                child: Container(
                                  decoration: BoxDecoration(color: Color(0xFFFDFAFF),borderRadius: BorderRadius.circular(15.r),),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15.r),
                                    child: widget.imagefile6.contains("http")?CachedNetworkImage(
                                      imageUrl:widget.imagefile6,
                                      fit: BoxFit.cover,
                                      progressIndicatorBuilder: (context, url, downloadProgress) =>
                                          Container(child: CircularProgressIndicator(value: downloadProgress.progress),alignment: Alignment.center,),
                                      errorWidget: (context, url, error) => Icon(Icons.error),
                                    ):Image.file(
                                      File(widget.imagefile6),
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
                                    child: widget.imagefile6.contains("http")?CachedNetworkImage(
                                      imageUrl:widget.imagefile6,
                                      fit: BoxFit.cover,
                                      progressIndicatorBuilder: (context, url, downloadProgress) =>
                                          Container(child: CircularProgressIndicator(value: downloadProgress.progress),alignment: Alignment.center,),
                                      errorWidget: (context, url, error) => Icon(Icons.error),
                                    ):Image.file(
                                      File(widget.imagefile6),
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
                                          child: widget.imagefile6.contains("http")?CachedNetworkImage(
                                            imageUrl:widget.imagefile6,
                                            fit: BoxFit.cover,
                                            progressIndicatorBuilder: (context, url, downloadProgress) =>
                                                Container(child: CircularProgressIndicator(value: downloadProgress.progress),alignment: Alignment.center,),
                                            errorWidget: (context, url, error) => Icon(Icons.error),
                                          ):Image.file(
                                            File(widget.imagefile6),
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
                                        if(widget.imagefile6.contains("http"))
                                        {
                                          bool isImageDelete=await ProfileRepository.imageDelete(preferences!.getString("accesstoken")!, widget.imageid6);
                                          if(isImageDelete)
                                          {
                                            var profileprovider = Provider.of<ProfileProvider>(context, listen: false);
                                            profileprovider.resetStreams();
                                            if (preferences!.getString("accesstoken") != null) {
                                              profileprovider.fetchProfileDetails(
                                                  preferences!.getString("accesstoken").toString());
                                            }
                                            setState(() {
                                              httpImages.remove(widget.imagefile6);
                                              httpImageIndex.remove("5");
                                              widget.imagefile6="";
                                            });
                                          }
                                        }
                                        else{
                                          setState(() {
                                            images.remove(widget.imagefile6);
                                            print(images);
                                            widget.imagefile6="";
                                            imagesindex.remove("5");
                                          });
                                        }
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
                          if(data.image==widget.imagefile6)
                          {

                            print("image 1");
                            print(data);
                            print("widget.imagefile1");
                            print(widget.imagefile6);
                            setState(() {
                              isImage6=true;
                            });
                          }
                          else{
                            setState(() {
                              print("image 1gdgdfgfg");
                              print(data);
                              print("widget.imagefile1fgdfgdfgd");
                              print(widget.imagefile6);
                              if(data.index=="1")
                              {
                                if(widget.imagefile1.contains('http')) {

                                  httpImages.remove(widget.imagefile1);
                                  httpImageIndex.remove("0");
                                  widget.imagefile1 = widget.imagefile6;

                                  if(widget.imagefile1!="")
                                  {
                                    if(widget.imagefile1.contains('http'))
                                    {

                                      httpImages.add(widget.imagefile1);
                                      httpImageIndex.add("0");
                                    }
                                    else{
                                      images.add(widget.imagefile1);
                                      imagesindex.add("0");
                                      images.remove(widget.imagefile6);
                                      imagesindex.remove("5");
                                    }

                                  }

                                  httpImages.remove(widget.imagefile6);
                                  httpImageIndex.remove("5");
                                }
                                else{
                                  images.remove(widget.imagefile1);
                                  imagesindex.remove("0");
                                  widget.imagefile1 = widget.imagefile6;

                                  if(widget.imagefile1!="")
                                  {
                                    if(widget.imagefile1.contains('http'))
                                    {

                                      httpImages.add(widget.imagefile1);
                                      httpImageIndex.add("0");
                                      httpImages.remove(widget.imagefile6);

                                      httpImageIndex.remove("5");
                                    }
                                    else{
                                      images.add(widget.imagefile1);
                                      imagesindex.add("0");
                                    }

                                  }

                                  images.remove(widget.imagefile6);
                                  imagesindex.remove("5");
                                  // imagesindex.remove("0");
                                }
                                //imagesindex.add("0");
                              }
                              else if(data.index=="2")
                              {
                                if(widget.imagefile2.contains('http')) {
                                  httpImages.remove(widget.imagefile2);

                                  httpImageIndex.remove("1");
                                  widget.imagefile2 = widget.imagefile6;

                                  if(widget.imagefile2!="")
                                  {
                                    if(widget.imagefile2.contains('http'))
                                    {
                                      httpImageIndex.add("1");
                                      httpImages.add(widget.imagefile2);

                                    }
                                    else{
                                      images.add(widget.imagefile2);
                                      imagesindex.add("1");
                                      images.remove(widget.imagefile6);
                                      imagesindex.remove("5");
                                    }
                                  }

                                  httpImages.remove(widget.imagefile6);
                                  httpImageIndex.remove("5");
                                }
                                else{
                                  images.remove(widget.imagefile2);
                                  imagesindex.remove("1");
                                  widget.imagefile2 = widget.imagefile6;

                                  if(widget.imagefile2!="")
                                  {
                                    if(widget.imagefile2.contains('http'))
                                    {
                                      httpImageIndex.add("1");

                                      httpImages.add(widget.imagefile2);


                                      httpImages.remove(widget.imagefile6);
                                      httpImageIndex.remove("5");
                                    }
                                    else{
                                      images.add(widget.imagefile2);
                                      imagesindex.add("1");
                                    }

                                  }

                                  images.remove(widget.imagefile6);
                                  imagesindex.remove("5");
                                  //imagesindex.remove("1");
                                }
                                //imagesindex.add("1");
                              }
                              else if(data.index=="3")
                              {
                                if(widget.imagefile3.contains('http')) {

                                  httpImages.remove(widget.imagefile3);

                                  httpImageIndex.remove("2");

                                  widget.imagefile3 = widget.imagefile6;
                                  if(widget.imagefile3!="")
                                  {
                                    if(widget.imagefile3.contains('http'))
                                    {
                                      httpImageIndex.add("2");

                                      httpImages.add(widget.imagefile3);
                                    }
                                    else{
                                      imagesindex.add("2");
                                      images.add(widget.imagefile3);
                                      images.remove(widget.imagefile6);
                                      imagesindex.remove("5");
                                    }
                                  }

                                  httpImages.remove(widget.imagefile6);
                                  httpImageIndex.remove("5");
                                }
                                else{
                                  images.remove(widget.imagefile3);
                                  imagesindex.remove("2");

                                  widget.imagefile3 = widget.imagefile6;
                                  if(widget.imagefile3!="")
                                  {
                                    if(widget.imagefile3.contains('http'))
                                    {
                                      httpImageIndex.add("2");

                                      httpImages.add(widget.imagefile3);


                                      httpImages.remove(widget.imagefile6);
                                      httpImageIndex.remove("5");
                                    }
                                    else{
                                      imagesindex.add("2");
                                      images.add(widget.imagefile3);
                                    }

                                  }

                                  images.remove(widget.imagefile6);
                                  imagesindex.remove("5");
                                  //imagesindex.remove("5");
                                }
                                //imagesindex.add("2");
                              }
                              else if(data.index=="4")
                              {
                                print("ashvjhsavxasindex4");
                                if(widget.imagefile4.contains('http')) {
                                  httpImages.remove(widget.imagefile4);

                                  httpImageIndex.remove("3");

                                  widget.imagefile4 = widget.imagefile6;
                                  if(widget.imagefile4!="")
                                  {
                                    if(widget.imagefile4.contains('http'))
                                    {
                                      httpImages.add(widget.imagefile4);

                                      httpImageIndex.add("3");
                                    }
                                    else{
                                      images.add(widget.imagefile4);
                                      imagesindex.add("3");
                                      images.remove(widget.imagefile6);
                                      imagesindex.remove("5");
                                    }
                                  }


                                  httpImages.remove(widget.imagefile6);
                                  httpImageIndex.remove("5");
                                }
                                else{
                                  images.remove(widget.imagefile4);
                                  imagesindex.remove("3");

                                  widget.imagefile4 = widget.imagefile6;
                                  if(widget.imagefile4!="")
                                  {
                                    if(widget.imagefile4.contains('http'))
                                    {
                                      httpImages.add(widget.imagefile4);

                                      httpImageIndex.add("3");

                                      httpImages.remove(widget.imagefile6);
                                      httpImageIndex.remove("5");
                                    }
                                    else{
                                      images.add(widget.imagefile4);
                                      imagesindex.add("3");
                                    }
                                  }


                                  images.remove(widget.imagefile6);
                                  imagesindex.remove("5");

                                  // imagesindex.remove("3");
                                  //imagesindex.remove("5");
                                }
                                //imagesindex.add("3");
                              }
                              else if(data.index=="5")
                              {
                                print("dataindex5");
                                if(widget.imagefile5.contains('http')) {

                                  httpImages.remove(widget.imagefile5);
                                  httpImageIndex.remove("4");
                                  print("dataindex5http");
                                  widget.imagefile5 = widget.imagefile6;
                                  if(widget.imagefile5!="")
                                  {
                                    print("dataindex5http=");
                                    if(widget.imagefile5.contains('http'))
                                    {
                                      print("dataindex5http==");
                                      httpImages.add(widget.imagefile5);

                                      httpImageIndex.add("4");
                                    }
                                    else{
                                      print("dataindex5http===");
                                      images.add(widget.imagefile5);
                                      imagesindex.add("4");
                                      images.remove(widget.imagefile6);
                                      imagesindex.remove("5");

                                    }
                                  }


                                  httpImages.remove(widget.imagefile6);
                                  httpImageIndex.remove("5");
                                }
                                else{
                                  print("dataindex5images");
                                  images.remove(widget.imagefile5);
                                  imagesindex.remove("4");
                                  widget.imagefile5 = widget.imagefile6;
                                  if(widget.imagefile5!="")
                                  {
                                    print("dataindex5images==");
                                    if(widget.imagefile5.contains('http'))
                                    {
                                      print("dataindex5images====");

                                      httpImages.add(widget.imagefile5);
                                      httpImageIndex.add("4");

                                      httpImages.remove(widget.imagefile6);
                                      httpImageIndex.remove("5");
                                    }
                                    else{
                                      print("dataindex5images=====");
                                      images.add(widget.imagefile5);
                                      imagesindex.add("4");
                                    }
                                  }
                                  images.remove(widget.imagefile6);
                                  imagesindex.remove("5");
                                  //imagesindex.remove("4");
                                }
                                //imagesindex.add("4");
                              }
                              widget.imagefile6=data.image;
                              print("data.index");
                              print(data.index);
                              print("widget.imagefile6");
                              print(widget.imagefile6);
                              isImage1=false;
                              isImage2=false;
                              isImage3=false;
                              isImage4=false;
                              isImage5=false;
                              isImage6=false;
                              if(widget.imagefile6 != "")
                              {
                                print("abcdefgh======");
                                if(widget.imagefile6.contains('http'))
                                {
                                  httpImageIndex.add("5");
                                  print("abcdefgh");

                                  httpImages.add(widget.imagefile6);
                                }
                                else{
                                  imagesindex.add("5");
                                  print("abcdefghimages");
                                  images.add(widget.imagefile6);
                                }

                              }
                            });
                          }
                        },
                      ),),
                  ],
                ),
              ],
            ),
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
class ImagesIndex{
  String index="";
  String image="";
  ImagesIndex({required this.index,required this.image});
}
Future<File> compress({
  required File image,
  int quality = 60,
  int percentage = 60,
}) async {
  var path = await FlutterNativeImage.compressImage(image.absolute.path,
      quality: quality, percentage: percentage);
  return path;
}
