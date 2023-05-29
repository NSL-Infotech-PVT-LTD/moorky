import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moorky/commanWidget/commanwidget.dart';
import 'package:moorky/dashboardscreen/repository/dashboardrepository.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../provider/dashboardprovider.dart';

class CampignDetailScreen extends StatefulWidget {
  int? id;
  CampignDetailScreen({required this.id});
  @override
  State<CampignDetailScreen> createState() => _CampignDetailScreenState();
}

class _CampignDetailScreenState extends State<CampignDetailScreen> {
  SharedPreferences? preferences;
  @override
  void initState() {
    Init();
    super.initState();
  }
  bool _obscureText = false;
  void Init() async {
    preferences = await SharedPreferences.getInstance();
    var dashboardprovider=Provider.of<DashboardProvider>(context,listen: false);
    dashboardprovider.resetStreams();
    print("sdgfahs====");
    if(preferences!.getString("accesstoken")!=null)
    {
      print(widget.id);
      print(preferences!.getString("accesstoken"));
      dashboardprovider.fetchCampaignDetails(preferences!.getString("accesstoken").toString(),widget.id!);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent,elevation: 0,leading:
      InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: (){
            Navigator.of(context).pop();
          },
          child: SvgPicture.asset("assets/images/arrowback.svg",fit: BoxFit.scaleDown,)),),
      body: SafeArea(
        child: SingleChildScrollView(
          child:  Consumer<DashboardProvider>(
              builder: (context, dashboardprovider, child) => dashboardprovider.campaigndetails?.data != null?
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(dashboardprovider.campaigndetails!.data!.banner.toString(),height: MediaQuery.of(context).size.width,
                      width: MediaQuery.of(context).size.width,fit: BoxFit.fill,),
                    Padding(
                      padding: EdgeInsets.all(15.0.r),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          addLightText(dashboardprovider.campaigndetails!.data!.description.toString(), 12, Color(0xFF15294B)),
                          SizedBox(height: 20.h,),
                          Container(
                            height: 54.h,
                            decoration: BoxDecoration(
                                color: Color(0xFF6601A7),
                                borderRadius: BorderRadius.circular(20.r)),
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                GestureDetector(
                                    onTap: () async{
                                      setState(() {
                                        _obscureText = !_obscureText;
                                      });
                                      if(_obscureText)
                                      {
                                        bool isView=await DashboardRepository.updateview(preferences!.getString("accesstoken")!);
                                        if(isView)
                                        {
                                          print("hello");
                                        }
                                      }
                                    },
                                    child:
                                !_obscureText?addRegularText(AppLocalizations.of(context)!.viewcode, 15, Colors.white):GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                    child: addRegularText("${dashboardprovider.campaigndetails!.data!.couponCode}", 15, Colors.white))),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5.0.h),
                                  child: VerticalDivider(thickness: 1.w,color: Color(0xFFF2E7FA),),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    addRegularText("%${dashboardprovider.campaigndetails!.data!.discount} ${AppLocalizations.of(context)!.discount}", 16,  Color(0xFFF2E7FA))
                                  ],
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 30.h,),
                          addMediumText(AppLocalizations.of(context)!.similaroffer, 14, Colors.black),
                          Container(
                            height: 150.h,
                            margin: EdgeInsets.only(top: 10.h),
                            child: ListView.builder(
                              itemCount: dashboardprovider.campaigndetails!.suggestedCampaigns!.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              physics: ScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: ()async{
                                    print("on tap");

                                    await Navigator.pushReplacement(context,
                                        MaterialPageRoute(builder:
                                            (context) =>
                                            CampignDetailScreen(id:dashboardprovider.campaigndetails!.suggestedCampaigns!.elementAt(index).id!)
                                        )
                                    );
                                  },
                                  child: Container(
                                    width: 150.w,
                                    padding: EdgeInsets.symmetric(horizontal: 2.w),
                                    child:Image.network(dashboardprovider.campaigndetails!.suggestedCampaigns!.elementAt(index).banner!,fit: BoxFit.fill,),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ):Center(child: CircularProgressIndicator(),)
          ),
        ),
      ),
    );
  }
}
