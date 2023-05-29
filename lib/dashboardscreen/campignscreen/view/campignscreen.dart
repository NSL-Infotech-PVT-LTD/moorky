import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:moorky/commanWidget/commanwidget.dart';
import 'package:moorky/constant/color.dart';
import 'package:moorky/dashboardscreen/campigndetailsscreen/view/campigndetailscreen.dart';
import 'package:moorky/dashboardscreen/provider/dashboardprovider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class CampignScreen extends StatefulWidget {
  const CampignScreen({Key? key}) : super(key: key);

  @override
  State<CampignScreen> createState() => _CampignScreenState();
}

class _CampignScreenState extends State<CampignScreen> {
  SharedPreferences? preferences;
  @override
  void initState() {
    Init();
    super.initState();
  }

  void Init() async {
    preferences = await SharedPreferences.getInstance();
    var dashboardprovider=Provider.of<DashboardProvider>(context,listen: false);
    dashboardprovider.resetStreams();
    print("sdgfahs====");
    if(preferences!.getString("accesstoken")!=null)
    {
      print("sdgfahs");
      print(preferences!.getString("accesstoken"));
      dashboardprovider.fetchCampaignList(preferences!.getString("accesstoken").toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: addMediumText(AppLocalizations.of(context)!.campaign, 18, Colorss.mainColor),centerTitle: true,backgroundColor: Colors.transparent,elevation: 0,),
      body:SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                Consumer<DashboardProvider>(
                    builder: (context, dashboardprovider, child) => dashboardprovider.campaignList != null?
                    GridView.custom(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverStairedGridDelegate(
                        startCrossAxisDirectionReversed: false,
                        mainAxisSpacing: 0.0,
                        crossAxisSpacing: 4,
                        pattern: [
                          StairedGridTile(0.5, 1.0),
                          StairedGridTile(0.5, 1.0),
                          StairedGridTile(1.0, 1.3),
                        ],
                      ),
                      childrenDelegate: SliverChildBuilderDelegate(
                        // childCount: dashboardprovider.campaignList!.data!.length,
                            (context, index) => InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                            onTap: (){

                              Navigator.push(context,
                                  MaterialPageRoute(builder:
                                      (context) =>
                                      CampignDetailScreen(id:dashboardprovider.campaignList!.data!.elementAt(index).id!)
                                  )
                              );
                            },
                            child: Container(
                              child: Image.network(dashboardprovider.campaignList!.data!.elementAt(index).banner!,fit: BoxFit.fill,),margin: EdgeInsets.only(bottom: 10.0.h,left: 3,right: 3),)),
                        childCount: dashboardprovider.campaignList!.data!.length,
                      ),
                    ):Center(child: CircularProgressIndicator(),)
                ),
                SizedBox(height: 40.h,),
                Image.asset("assets/images/moorky2.png",height: 70.h,width: 180.w,fit: BoxFit.fill,),
              ],
            ),
          ),
        )
      ),
    );
  }
}
