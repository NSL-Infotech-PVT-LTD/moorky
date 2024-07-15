import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:moorky/commanWidget/commanwidget.dart';
import 'package:moorky/constant/color.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:moorky/dashboardscreen/provider/dashboardprovider.dart';
import 'package:moorky/dashboardscreen/repository/dashboardrepository.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomizationCalendar_Screen extends StatefulWidget {
  bool isEdit=false;
  String title="";
  String description="";
  String date="";
  String user_id="";
  String event_id="";
  String remainder="";
  String remainderid="";
  String type="";
  CustomizationCalendar_Screen({required this.isEdit,required this.title,required this.description, required this.date,required this.user_id,required this.event_id,required this.remainder,required this.remainderid,required this.type});

  @override
  State<CustomizationCalendar_Screen> createState() => _CustomizationCalendar_ScreenState();
}

class _CustomizationCalendar_ScreenState extends State<CustomizationCalendar_Screen> {
  TextEditingController titlecontroller=new TextEditingController();
  TextEditingController descriptioncontroller=new TextEditingController();
  SharedPreferences? preferences;
  String accesstoken="";
  bool updateevent=false;
  String reminder_id="";
  String? selectedValue;
  var _scaKey = GlobalKey<ScaffoldState>();
  String time="00:00:00";
  @override
  void initState() {
    Init();
    super.initState();
  }
  var _formKey = GlobalKey<FormState>();

  void Init() async {
    preferences = await SharedPreferences.getInstance();
    var dashprovider = Provider.of<DashboardProvider>(context, listen: false);
    if (preferences!.getString("accesstoken") != null) {
      dashprovider.fetchRemainderList(
          preferences!.getString("accesstoken").toString());
      setState(() {
        accesstoken=preferences!.getString("accesstoken").toString();
        reminder_id=widget.remainderid;
      });
    }
    if(widget.isEdit)
      {
        print("gjahgdjhagdjagdjad");
        widget.date=widget.date+"  "+time;
        setState(() {

        });
      }


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key:_scaKey,
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: Container(
        height: 180.h,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: Column(
            children: [
              !updateevent?!widget.isEdit?
              InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: ()async{
                  var isdeleteevent=await DashboardRepository.eventdelete(accesstoken, widget.event_id);
                  if(isdeleteevent)
                  {
                    var dashprovider = Provider.of<DashboardProvider>(context, listen: false);
                    dashprovider.resetEventList();
                    if (preferences!.getString("accesstoken") != null) {
                      print("hello2");
                      dashprovider.fetchEventList(
                          preferences!.getString("accesstoken").toString(),widget.user_id);
                      Navigator.pop(context);
                      print("hello25");
                    }
                  }
                },
                child: Container(
                    height: 70.h,
                    margin: EdgeInsets.only(left: 25.w,right: 25.w),
                    decoration: BoxDecoration(
                        color: Color(0xFF9342D6),
                        borderRadius: BorderRadius.circular(15.r)),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset("assets/images/deleteevent.svg"),
                        SizedBox(width: 10.w,),
                        addMediumText(AppLocalizations.of(context)!.deleteevent, 14, Color(0xFFffffff)),
                      ],
                    )
                ),
              ):
              InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: ()async{
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    if(widget.remainder.contains("Select Reminder"))
                    {
                      showSnakbar(AppLocalizations.of(context)!.pleaseselectremainder, context);
                      return;
                    }
                    print("ajhsdjashgdjhsadjas ${widget.date}");
                    var inputFormat = DateFormat('d MMMM y  HH:mm:ss');
                    var inputDate = inputFormat.parse(
                        widget.date
                            .toString());
                    print(inputDate);
                    var outputFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
                    var utp = outputFormat.format(inputDate);
                    print("utp");
                    print(utp);

                    var iscreateevent=await DashboardRepository.eventcreate(accesstoken, widget.user_id, widget.title, widget.description, utp.toString(),reminder_id.toString(),widget.type);
                    if(iscreateevent)
                    {
                      var dashprovider = Provider.of<DashboardProvider>(context, listen: false);
                      dashprovider.resetEventList();
                      if (preferences!.getString("accesstoken") != null) {
                        print("hello2");
                        dashprovider.fetchEventList(
                            preferences!.getString("accesstoken").toString(),widget.user_id);
                        Navigator.pop(context);
                        print("hello25");
                      }
                    }

                  }},
                child: Container(
                    height: 70.h,
                    margin: EdgeInsets.only(left: 25.w,right: 25.w),
                    decoration: BoxDecoration(
                        color: Color(0xFF9342D6),
                        borderRadius: BorderRadius.circular(15.r)),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset("assets/images/add.svg",color: Colors.white,fit: BoxFit.scaleDown,height: 14,width: 14,),
                        SizedBox(width: 10.w,),
                        addMediumText(AppLocalizations.of(context)!.addevent, 14, Color(0xFFffffff)),
                      ],
                    )
                ),
              ):
              InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: ()async{
                  var inputFormat = DateFormat('d MMMM y');
                  var inputDate = inputFormat.parse(
                      widget.date
                          .toString());
                  var outputFormat = DateFormat('yyyy-MM-dd');
                  var utp = outputFormat.format(inputDate);
                  print(utp);
                  var isupdateevent=await DashboardRepository.eventupdate(
                      accesstoken,
                      widget.event_id,
                      widget.title,
                      widget.description,
                      utp.toString(),
                      reminder_id.toString(),widget.type);
                  if(isupdateevent)
                  {
                    var dashprovider = Provider.of<DashboardProvider>(context, listen: false);
                    dashprovider.resetEventList();
                    if (preferences!.getString("accesstoken") != null) {
                      print("hello2");
                      dashprovider.fetchEventList(
                          preferences!.getString("accesstoken").toString(),widget.user_id);
                      Navigator.pop(context);
                      print("hello25");
                    }
                  }
                },
                child: Container(
                    height: 70.h,
                    margin: EdgeInsets.only(left: 25.w,right: 25.w),
                    decoration: BoxDecoration(
                        color: Color(0xFF9342D6),
                        borderRadius: BorderRadius.circular(15.r)),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset("assets/images/editicon.svg",color: Colors.white,height: 16,width: 14,),
                        SizedBox(width: 10.w,),
                        addMediumText(AppLocalizations.of(context)!.update, 14, Color(0xFFffffff)),
                      ],
                    )
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                margin: EdgeInsets.only(bottom: 15.h,top: 30.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset("assets/images/moorky2.png",height: 45.h,width: 150.w,),
                    SizedBox(height: 5.h,),
                    // Container(
                    //   height: 8.h,width: 160.w,decoration: BoxDecoration(color: Color(0xFF000000),borderRadius: BorderRadius.circular(25.r)),),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 280.h,
                padding: EdgeInsets.all(28),
                decoration: BoxDecoration(
                    color: Colorss.mainColor,
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25))
                ),
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                              onTap:(){
                                Navigator.of(context).pop();
                              },
                              child: SvgPicture.asset("assets/images/arrowwhitecircle.svg")),
                          !widget.isEdit?GestureDetector(
                            onTap: (){
                              setState(() {
                                updateevent=true;
                                titlecontroller.text=widget.title;
                                descriptioncontroller.text=widget.description;
                              });
                            },
                            child: Row(
                              children: [
                                SvgPicture.asset("assets/images/editicon.svg"),
                                SizedBox(width: 5,),
                                addRegularText(AppLocalizations.of(context)!.edit, 14, Colors.white)
                              ],
                            ),
                          ):Container(),
                        ],
                      ),
                      SizedBox(height: 20.h,),
                      !updateevent? !widget.isEdit?addBoldText(widget.title, 18, Colors.white):
                      TextFormField(
                        controller: titlecontroller,
                        showCursor: true,
                        onChanged: (value){
                          setState(() {
                            widget.title=value;
                          });
                        },
                        validator: (value){
                          if(value!.isEmpty)
                          {
                            return "Please Enter Event Title";
                          }
                          return null;
                        },
                        style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.w300,fontSize: 18),
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!.entereventtitle,
                          labelStyle: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.w300,fontSize: 18),
                          hintStyle: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.w300,fontSize: 18),
                          isDense: true,
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ):TextFormField(
                        controller: titlecontroller,
                        cursorColor: Colors.white,
                        showCursor: true,
                        onChanged: (value){
                          setState(() {
                            widget.title=value;
                            print(widget.title);
                          });
                        },
                        validator: (value){
                          if(value!.isEmpty)
                          {
                            return "Please Enter Event Title";
                          }
                          return null;
                        },
                        style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.w300,fontSize: 18),
                        decoration: InputDecoration(
                            hintText: AppLocalizations.of(context)!.entereventtitle,
                            labelStyle: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.w300,fontSize: 18),
                            hintStyle: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.w300,fontSize: 18),
                            isDense: true,
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.zero
                        ),
                      ),
                      // SizedBox(height: 20.h,),
                      // addRegularText(AppLocalizations.of(context)!.thedayyourstory, 8, Colors.white),
                      SizedBox(height: 30.h,),
                      Row(
                        children: [
                          SvgPicture.asset("assets/images/watchs.svg",fit: BoxFit.scaleDown,),
                          SizedBox(width: 10,),
                          !updateevent?!widget.isEdit?addRegularText(widget.date, 14, Colors.white):
                          GestureDetector(
                              onTap: (){
                                selectDate(context);
                              },
                              child: Container(
                                height: 40.h,
                                  alignment: Alignment.center,
                                  child: addRegularText(widget.date, 14, Colors.white))):GestureDetector(
                              onTap: (){
                                selectDate(context);
                              },
                              child: addRegularText(widget.date, 12, Colors.white))

                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30.h,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 28,vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    addBoldText(AppLocalizations.of(context)!.remainder, 16, Colorss.mainColor),
                    SizedBox(height: 10.h,),
                    !updateevent?!widget.isEdit?Container(
                      height: 40,
                      width: 150,
                      child: Consumer<DashboardProvider>(
                          builder: (context, profileprovider, child) => profileprovider.remainderListModel?.data != null?
                          DropdownButtonHideUnderline(
                            child: DropdownButton2(
                              isExpanded: true,
                              disabledHint: Text(widget.remainder),
                              hint: Container(
                                  child: addMediumText(widget.remainder, 13, Color(0xFF15294B))
                              ),
                              items: profileprovider.remainderListModel!.data!
                                  .map((item) => DropdownMenuItem<String>(
                                value: item.title.toString(),
                                child: addMediumText(item.title.toString(), 13, Color(0xFF7118C5)),
                              ))
                                  .toList(),
                              value: selectedValue,
                              onChanged: null,
                              icon: Icon(Icons.keyboard_arrow_down,size: 18,color: Colorss.mainColor,),
                              dropdownMaxHeight: 300,
                              dropdownWidth: 223,
                              dropdownPadding: null,
                              dropdownElevation: 4,
                              scrollbarRadius: const Radius.circular(40),
                              scrollbarThickness: 6,
                              scrollbarAlwaysShow: true,
                              offset: const Offset(-20, 0),
                            ),
                          ):
                          Center(child: Text(AppLocalizations.of(context)!.noremainderfound),)
                      ),
                    ):
                    Container(
                      height: 40,
                      width: 150,
                      child: Consumer<DashboardProvider>(
                          builder: (context, profileprovider, child) => profileprovider.remainderListModel?.data != null?
                          DropdownButtonHideUnderline(
                            child: DropdownButton2(
                              isExpanded: true,
                              hint: Container(
                                  child: addMediumText(widget.remainder, 13, Color(0xFF15294B))
                              ),
                              items: profileprovider.remainderListModel!.data!
                                  .map((item) => DropdownMenuItem<String>(
                                value: item.title.toString(),
                                child: addMediumText(item.title.toString(), 13, Color(0xFF7118C5)),
                              ))
                                  .toList(),
                              value: selectedValue,
                              onChanged: (value) {
                                setState(() {
                                  selectedValue = value as String;
                                  for(int i=0;i<profileprovider.remainderListModel!.data!.length;i++)
                                  {
                                    if(selectedValue==profileprovider.remainderListModel!.data!.elementAt(i).title)
                                    {
                                      reminder_id=profileprovider.remainderListModel!.data!.elementAt(i).id.toString();
                                      widget.remainder=profileprovider.remainderListModel!.data!.elementAt(i).title.toString();
                                    }
                                  }
                                });
                              },
                              icon: Icon(Icons.keyboard_arrow_down,size: 16,color: Colorss.mainColor,),
                              dropdownMaxHeight: 300,
                              dropdownWidth: 223,
                              dropdownPadding: null,
                              dropdownElevation: 4,
                              scrollbarRadius: const Radius.circular(40),
                              scrollbarThickness: 6,
                              scrollbarAlwaysShow: true,
                              offset: const Offset(-20, 0),
                            ),
                          ):Center(child: Text(AppLocalizations.of(context)!.noremainderfound),)
                      ),
                    ):
                    Container(
                      height: 40,
                      width: 150,
                      child: Consumer<DashboardProvider>(
                          builder: (context, profileprovider, child) => profileprovider.remainderListModel?.data != null?
                          DropdownButtonHideUnderline(
                            child: DropdownButton2(
                              isExpanded: true,
                              hint: Container(
                                  child: addMediumText(widget.remainder, 13, Color(0xFF15294B))
                              ),
                              items: profileprovider.remainderListModel!.data!
                                  .map((item) => DropdownMenuItem<String>(
                                value: item.title.toString(),
                                child: addMediumText(item.title.toString(), 13, Color(0xFF7118C5)),
                              ))
                                  .toList(),
                              value: selectedValue,
                              onChanged: (value) {
                                setState(() {
                                  selectedValue = value as String;
                                  for(int i=0;i<profileprovider.remainderListModel!.data!.length;i++)
                                  {
                                    if(selectedValue==profileprovider.remainderListModel!.data!.elementAt(i).title)
                                    {
                                      reminder_id=profileprovider.remainderListModel!.data!.elementAt(i).id.toString();
                                    }
                                  }
                                });
                              },
                              icon: Icon(Icons.keyboard_arrow_down,size: 16,color: Colorss.mainColor,),
                              dropdownMaxHeight: 300,
                              dropdownWidth: 223,
                              dropdownPadding: null,
                              dropdownElevation: 4,
                              scrollbarRadius: const Radius.circular(40),
                              scrollbarThickness: 6,
                              scrollbarAlwaysShow: true,
                              offset: const Offset(-20, 0),
                            ),
                          ):Center(child: Text(AppLocalizations.of(context)!.noremainderfound),)
                      ),
                    ),
                    // Row(
                    //   children: [
                    //     addMediumText("One day before", 12, Color(0xFF7C7B7B)),
                    //     SizedBox(width: 10.w,),
                    //     Icon(Icons.keyboard_arrow_down,size: 16,color: Color(0xFF7C7B7B),)
                    //   ],
                    // ),
                    SizedBox(height: 40.h,),
                    addSemiBoldText(AppLocalizations.of(context)!.description, 14, Colorss.mainColor),
                    SizedBox(height: 10.h,),
                    !updateevent?!widget.isEdit ? addRegularText(widget.description, 10, Color(0xFF999999)):
                    TextFormField(
                      controller: descriptioncontroller,
                      cursorColor: Colors.black,
                      showCursor: true,
                      style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.w300,fontSize: 16),
                      decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!.entereventdescription,
                          labelStyle: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.w300,fontSize: 16),
                          hintStyle: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.w300,fontSize: 16),
                          isDense: true,
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero
                      ),
                      onChanged: (value){
                        setState(() {
                          widget.description=value;
                        });
                      },
                      validator: (value){
                        if(value!.isEmpty)
                        {
                          return "Please Enter Event Description";
                        }
                        return null;
                      },
                    ):TextFormField(
                      controller: descriptioncontroller,
                      cursorColor: Colors.black,
                      showCursor: true,
                      style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.w300,fontSize: 16),
                      decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!.entereventdescription,
                          labelStyle: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.w300,fontSize: 16),
                          hintStyle: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.w300,fontSize: 16),
                          isDense: true,
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero
                      ),
                      onChanged: (value){
                        setState(() {
                          widget.description=value;
                          print(widget.description);
                        });
                      },
                      validator: (value){
                        if(value!.isEmpty)
                        {
                          return "Please Enter Event Description";
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
  Future<void> selectDate(BuildContext context) async {
    DateTime selectedDate = DateTime.now();
    print(selectedDate);
    print(widget.date);
    DateTime dateti=DateFormat("d MMMM y  HH:mm:ss",AppLocalizations.of(context)!.applang=="ar"?"en":AppLocalizations.of(context)!.applang).parse(widget.date);
    print("${dateti.year}, dateti.month ,dateti.day");
    final DateTime? picked = await showDatePicker(
        context: context,
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        initialDate: DateTime(dateti.year,dateti.month,dateti.day),
        firstDate: DateTime(1900, 1),
        lastDate: DateTime(2200,12,31));
    print("pickeddate");
    print(picked);
    if(picked != null)
    {
      TimeOfDay? pickedTime =  await showTimePicker(
        initialTime: TimeOfDay.now(),
        context: context,
      );

      if(pickedTime != null ){
        DateTime pickedDate=DateTime.now();
        pickedDate=DateTime(pickedDate.year,pickedDate.month,pickedDate.day,pickedTime.hour,pickedTime.minute);
        time =  DateFormat('HH:mm:ss').format(pickedDate);
        // print("finaltime");
        //var t=DateFormat.yMMMEd().format(pickedDate);
        print("tfinaltime");
        print(time);
        setState(() {
          widget.date=DateFormat('d MMMM y').format(picked);
          widget.date=DateFormat('d MMMM y').format(picked);
          widget.date="${widget.date}  $time";
          print(widget.date);
          print(widget.date);
        });
      }else{
        print("Time is not selected");
      }

    }

    // else return selectedDate.toString();
  }
}
