import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moorky/constant/color.dart';
import 'package:moorky/dashboardscreen/view/dashboardscreen.dart';
import 'package:moorky/profilecreate/provider/profileprovider.dart';
import 'package:moorky/profilecreate/repository/profileRepository.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../commanWidget/commanwidget.dart';

class WriteYourReport_Screen extends StatefulWidget {
  String reasonId="";
  String userId="";

  WriteYourReport_Screen({required this.reasonId,required this.userId});

  @override
  State<WriteYourReport_Screen> createState() => _WriteYourReport_ScreenState();
}

class _WriteYourReport_ScreenState extends State<WriteYourReport_Screen> {
  bool isTrue=false;
  var _formKey = GlobalKey<FormState>();
  var _scaKey = GlobalKey<ScaffoldState>();
  String? selectedValue;
  SharedPreferences? preferences;
  String whatHappedText="";
  String report_reason_id="";
  TextEditingController whatController=new TextEditingController();
  String email="";
  @override
  void initState() {
    report_reason_id=widget.reasonId;
    Init();
    super.initState();
  }

  void Init() async {
    preferences = await SharedPreferences.getInstance();
    var profileprovider = Provider.of<ProfileProvider>(context, listen: false);
    setState(() {
      email=profileprovider.useremail.toString();
      print("email");
      print(email);
    });
    if (preferences!.getString("accesstoken") != null) {
      profileprovider.fetchUserReportReason(
          preferences!.getString("accesstoken").toString());
    }}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
          elevation: 0,
          leading:
          InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: (){
                Navigator.of(context).pop();
              },
              child: SvgPicture.asset("assets/images/arrowback.svg",fit: BoxFit.scaleDown,))
      ),
      bottomNavigationBar: !isTrue?whatHappedText.trim() != ""?
      InkWell(
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: ()async{
          print(whatHappedText);
          print(widget.userId);
          print(report_reason_id);
          print(whatHappedText);
          setState(() {
            isTrue=true;
          });
          var isReport=await ProfileRepository.userReport(preferences!.getString("accesstoken").toString(), widget.userId, report_reason_id, "1", report_reason_id);
          if(isReport)
            {
              setState(() {
                isTrue=false;
              });
              Get.offNamedUntil('/home', (route) => false);
            }
          },
        child: Container(
            height: 70.h,
            margin: EdgeInsets.only(left: 25.w,right: 25.w,bottom: 15.h),
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
            child: addMediumText(AppLocalizations.of(context)!.submitreport, 14, Color(0xFFFFFFFF))
        ),
      ):
      Container(
          height: 70.h,
          margin: EdgeInsets.only(top: 90.h,left: 25.w,right: 25.w,bottom: 15.h),
          decoration: BoxDecoration(
              border: Border.all(color: Color(0xFFC2A3DD),width: 1.0),

              borderRadius: BorderRadius.circular(50.r)),
          alignment: Alignment.center,
          child: addMediumText(AppLocalizations.of(context)!.submitreport, 14, Color(0xFFC2A3DD))
      ):SizedBox(
          width:80,child: CircularProgressIndicator()),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 15.h,),
            Text(AppLocalizations.of(context)!.writeyourreport,
              textAlign: TextAlign.center,
              textScaleFactor: 1,
              style: TextStyle(
                color: Color(0xFF6B00C3),
                fontSize: 20,
                fontFamily: "Avenir Black",
                fontWeight: FontWeight.w900
            ),),
            SizedBox(height: 20.h,),
            SizedBox(
              width: MediaQuery.of(context).size.width*0.65,
                child: addCenterRegularText(
                    "${AppLocalizations.of(context)!.reportmoredetail}",12,Color(0xFF15294B).withOpacity(0.47))),
            SizedBox(height: 40.h,),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 5),
                      height: 40,
                      width: 223,
                      decoration: BoxDecoration(color:Colors.white,borderRadius: BorderRadius.circular(10),border: Border.all(color: Colorss.mainColor,width: 1.w)),
                      child: Consumer<ProfileProvider>(
                          builder: (context, profileprovider, child) => profileprovider.reportReasonListModel?.data != null?
                          DropdownButtonHideUnderline(
                            child: DropdownButton2(
                              isExpanded: true,
                              hint: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                                  child: addMediumText(profileprovider.reportReasonListModel!.data!.elementAt(0).reason.toString(), 10, Color(0xFF15294B))
                              ),
                              items: profileprovider.reportReasonListModel!.data!
                                  .map((item) => DropdownMenuItem<String>(
                                value: item.reason.toString(),
                                child: addMediumText(item.reason.toString(), 10, Color(0xFF7118C5)),
                              ))
                                  .toList(),
                              value: selectedValue,
                              onChanged: (value) {
                                setState(() {
                                  selectedValue = value as String;
                                  for(int i=0;i<profileprovider.reportReasonListModel!.data!.length;i++)
                                    {
                                      if(selectedValue==profileprovider.reportReasonListModel!.data!.elementAt(i).reason)
                                        {
                                          report_reason_id=profileprovider.reportReasonListModel!.data!.elementAt(i).id.toString();
                                        }
                                    }
                                });
                              },
                              icon: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: Icon(Icons.keyboard_arrow_down,size: 16,color: Colorss.mainColor,),
                              ),
                              dropdownMaxHeight: 300,
                              dropdownWidth: 223,
                              dropdownPadding: null,
                              dropdownElevation: 4,
                              scrollbarRadius: const Radius.circular(40),
                              scrollbarThickness: 6,
                              scrollbarAlwaysShow: true,
                              offset: const Offset(-20, 0),
                            ),
                          ):Center(child: Text("No Reasons"),)
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 15),
                      child: TextFormField(
                        maxLines: 7,
                        controller: whatController,
                        textInputAction: TextInputAction.done,
                        onChanged: (value){
                          setState(() {
                            whatHappedText=value;
                          });
                        },
                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16.0.r),
                              borderSide: BorderSide(
                                  color: Color(0xFFC2A3DD),
                                  width: 1.0
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16.0.r),
                              borderSide: BorderSide(
                                  color: Color(0xFFC2A3DD),
                                  width: 1.0
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16.0.r),
                              borderSide: BorderSide(
                                  color: Color(0xFFC2A3DD),
                                  width: 1.0
                              ),
                            ),
                            filled: true,
                            hintStyle: GoogleFonts.poppins(textStyle: TextStyle(color: Color(0xFFC2A3DD))),
                            hintText: AppLocalizations.of(context)!.telluswhat,
                            fillColor: Colors.white70),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width*0.70,
                        child: addRegularText("${AppLocalizations.of(context)!.ifyouneedmoreinfo} $email",9 , Color(0xFF15294B).withOpacity(0.50)))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
