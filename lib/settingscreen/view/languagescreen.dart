import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moorky/commanWidget/commanwidget.dart';
import 'package:moorky/constant/color.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:moorky/lang/provider/locale_provider.dart';
import 'package:moorky/profilecreate/repository/profileRepository.dart';
import 'package:moorky/quizscreens/quizprovider/QuizProvider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../dashboardscreen/provider/dashboardprovider.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({Key? key}) : super(key: key);

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  SharedPreferences? preferences;
  String langcode="";
  @override
  void initState() {
    Init();
    super.initState();
  }

  void Init() async {
    preferences = await SharedPreferences.getInstance();
    var quizprovider=Provider.of<QuizProvider>(context,listen: false);
    quizprovider.resetStreams();
    if(preferences!.getString("accesstoken")!=null)
    {
      quizprovider.fetchappLanguageList(preferences!.getString("accesstoken").toString());
    }
    if(preferences!.getString("lang") != null)
      {
        print("preferences!.getString(""s"").toString()");
        print(preferences!.getString("lang").toString());
        setState(() {
          langcode=preferences!.getString("lang").toString();
        });
      }
    else{
      setState(() {
        langcode="en";
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: addMediumText(AppLocalizations.of(context)!.langugaes, 18, Colorss.mainColor),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              Navigator.of(context).pop();
            },
            child: SvgPicture.asset(
              "assets/images/arrowback.svg",
              fit: BoxFit.scaleDown,
              color: Colorss.mainColor,
            )),
      ),
      bottomNavigationBar: Container(
        alignment: Alignment.center,
        color: Colors.transparent,
        height: 80.h,
        padding: EdgeInsets.only(bottom: 10.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset("assets/images/moorky2.png",height: 45.h,width: 150.w,),
            Container(
              height: 8.h,width: 140.w,decoration: BoxDecoration(color: Color(0xFF751ACD),borderRadius: BorderRadius.circular(25.r)),),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0.r),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             addMediumText(AppLocalizations.of(context)!.applangugaes, 12, Color(0xFFA8A8A8)),
              Consumer<QuizProvider>(
                  builder: (context, quizprovider, child) => quizprovider.applanguageList?.data != null?
                  ListView.builder(
                    itemCount: quizprovider.applanguageList!.data!.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: ScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      print(quizprovider.applanguageList!.data!.elementAt(index).language_code.toString());
                      return GestureDetector(
                        onTap: ()async{
                          setState(() {
                            langcode=quizprovider.applanguageList!.data!.elementAt(index).language_code.toString();
                          });
                          final provider =
                          Provider.of<LocaleProvider>(context, listen: false);
                          provider.setLocale(Locale(quizprovider.applanguageList!.data!.elementAt(index).language_code.toString()));
                          provider.changeLocaleSettings(quizprovider.applanguageList!.data!.elementAt(index).language_code.toString());
                          await ProfileRepository.updateProfile(
                              quizprovider.applanguageList!.data!.elementAt(index).id.toString(),
                              "app_language_id",
                              preferences!
                                  .getString("accesstoken")!);
                          var dashboardprovider =
                          Provider.of<DashboardProvider>(context, listen: false);
                          dashboardprovider
                              .fetchFilterList(preferences!.getString("accesstoken").toString());
                          dashboardprovider.filterUser();
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 25.h,),
                            addMediumText(quizprovider.applanguageList!.data!.elementAt(index).language, 14, langcode!=quizprovider.applanguageList!.data!.elementAt(index).language_code.toString()?Color(0xFFA8A8A8):Colorss.mainColor),
                            SizedBox(height: 8.h,),
                            Divider(thickness: 1.5,color: Color(0xFff3f3f3),height: 3,),
                          ],
                        ),
                      );
                    },
                  ):Center(child: CircularProgressIndicator(),)
              )
            ],
          ),
        ),
      ),
    );
  }
}
