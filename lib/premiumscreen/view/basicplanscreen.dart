import 'dart:async';
import 'dart:io';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moorky/commanWidget/commanwidget.dart';
import 'package:moorky/constant/color.dart';
import 'package:moorky/dashboardscreen/campignscreen/view/campignscreen.dart';
import 'package:moorky/dashboardscreen/view/dashboardscreen.dart';
import 'package:moorky/profilecreate/provider/profileprovider.dart';
import 'package:moorky/profilecreate/repository/profileRepository.dart';
import 'package:moorky/settingscreen/provider/setting_provider.dart';
import 'package:moorky/settingscreen/repository/setting_repository.dart';
import 'package:moorky/settingscreen/view/privacypolicyscreen.dart';
import 'package:moorky/settingscreen/view/termsofusescreen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constant/app_url.dart';

class BasicPlan_Screen extends StatefulWidget {
  const BasicPlan_Screen({Key? key}) : super(key: key);

  @override
  State<BasicPlan_Screen> createState() => _BasicPlan_ScreenState();
}

class _BasicPlan_ScreenState extends State<BasicPlan_Screen> {
  final CarouselController _controller = CarouselController();
  SharedPreferences? preferences;
  int selectedIndex=0;
  int plan_id=0;
  int count=0;
  String sku="";


  bool subscription=false;


  //inapp
  StreamSubscription? _purchaseUpdatedSubscription;
  StreamSubscription? _purchaseErrorSubscription;
  StreamSubscription? _conectionSubscription;
  List<String>? productLists;
  List<IAPItem> _items = [];


  @override
  void initState() {

    super.initState();
    Init();
  }
  bool isLoad=false;
  @override
  void dispose() {
    if (_conectionSubscription != null) {
      _conectionSubscription!.cancel();
      _conectionSubscription = null;
    }
    super.dispose();
  }

  void Init() async {
    preferences = await SharedPreferences.getInstance();
    var profileprovider = Provider.of<SettingProvider>(context, listen: false);
    profileprovider.resetPriumiumPlans();
    if (preferences!.getString("accesstoken") != null) {
      profileprovider.fetchPremiumPlans(
          preferences!.getString("accesstoken").toString(),"basic");
      profileprovider.fetchPremiumList(
          preferences!.getString("accesstoken").toString(),"basic");
    }
  }
  int _current=0;
  @override
  Widget build(BuildContext context) {
    List<dynamic> planSlider=[
      {
        "icon":"${AppUrl.baseUrl}storage/plan/icons/Qh0WFWRYSwyKFx3tnB3z3QwI8x90YitbM8L1mHNs.svg",
        "title":AppLocalizations.of(context)!.basiconet,
        "description":AppLocalizations.of(context)!.basiconed,
      },
      {
        "icon":"${AppUrl.baseUrl}storage/plan/icons/3mQIh6iAHS5qIkXHELQZnoQBIvdaojBy3XPhSBLD.svg",
        "title":AppLocalizations.of(context)!.basictwot,
        "description":AppLocalizations.of(context)!.basictwod,
      },
      {
        "icon":"${AppUrl.baseUrl}storage/plan/icons/19hT3EtiGo35vhK4WKtLgOu0ler1FIoQjRxcj6a1.svg",
        "title":AppLocalizations.of(context)!.basicthreet,
        "description":AppLocalizations.of(context)!.basicthreed,
      },
      {
        "icon":"${AppUrl.baseUrl}storage/plan/icons/kI3b3R3vLzz7JUzCtfR4YxG5NMy5GxlLf4GyQv00.svg",
        "title":AppLocalizations.of(context)!.basicfourt,
        "description":AppLocalizations.of(context)!.basicfourd,
      },
    ];
    return Scaffold(
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
      backgroundColor: Colors.white,
      // bottomNavigationBar: Container(
      //   height: 40,
      //   color: Colors.transparent,
      //   alignment: Alignment.center,
      //   child: Container(
      //     height: 8.h,width: 160.w,decoration: BoxDecoration(color: Color(0xFF6B18C3),borderRadius: BorderRadius.circular(25.r)),),
      // ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(height: 20,),
              Column(
                children: [
                  CarouselSlider(
                    items: planSlider.map((images) {
                      return Column(
                        children: [
                          SvgPicture.network(
                            images['icon'],
                            height: 82,
                            width: 82,
                            fit: BoxFit.fill,
                          ),
                          SizedBox(height: 15,),
                          addMediumText(images['title'], 16, Colorss.mainColor),
                          SizedBox(height: 15,),
                          SizedBox(
                              width:MediaQuery.of(context).size.width*0.70,
                              child: addCenterRegularText(images['description'], 12, Colors.black))
                        ],
                      );
                    }).toList(),
                    carouselController: _controller,
                    options: CarouselOptions(
                        autoPlay: false,
                        disableCenter: true,
                        aspectRatio: 12 / 6,
                        viewportFraction: 1,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        }),
                  ),
                  SizedBox(

                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: planSlider.asMap().entries.map((entry) {
                      return GestureDetector(
                        onTap: () => _controller.animateToPage(entry.key),
                        child: _current == entry.key
                            ? Container(
                          width: 8.0.w,
                          height: 8.0.h,
                          margin:
                          EdgeInsets.symmetric(horizontal: 4.0.w),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(5.r)),
                              color: _current == entry.key
                                  ? Colorss.mainColor
                                  : Color(0xFFD9D9D9)),
                        )
                            : Container(
                          width: 8.0.w,
                          height: 8.0.h,
                          margin:
                          EdgeInsets.symmetric(horizontal: 4.0.w),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _current == entry.key
                                  ? Colorss.mainColor
                                  : Color(0xFFD9D9D9)),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
              SizedBox(height: 30,),
              Image.asset("assets/images/moorky2.png",height: 70.h,width: 170.w,),
              SizedBox(
                height: 50.h,
              ),
              Container(
                  height: 200,
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.all(8.h),
                  child:Consumer<SettingProvider>(
                      builder: (context, settingprovider, child){
                        if(settingprovider.premiumPlansModel?.data != null){
                          plan_id = settingprovider.planid;
                          sku=settingprovider.sku;
                          if(productLists==null)
                          {
                            productLists = settingprovider.skulist;
                          }
                          subscription=settingprovider.premiumPlansModel!.subscription!;
                          if(!subscription)
                          {
                            count++;
                            if(count==1)
                            {
                              initPlatformState();
                            }

                          }

                        }
                        return settingprovider.premiumPlansModel?.data != null?
                        settingprovider.premiumPlansModel!.data!.length>0?ListView.builder(
                          itemCount: settingprovider.premiumPlansModel!.data!.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          physics: ScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return selectedIndex==index ? Container(
                              width: 150,
                              child: Stack(
                                children: [
                                  Container(
                                    width: 150,
                                    margin: EdgeInsets.only(left: 10,top: 9),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colorss.mainColor,width: 1.5),
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    padding: EdgeInsets.symmetric(horizontal: 2.w,vertical: 5),
                                    child:Column(
                                      children: [
                                        addSemiBoldText(settingprovider.premiumPlansModel!.data!.elementAt(index).invoicePeriod.toString(),59,Colorss.mainColor),
                                        addMediumText(AppLocalizations.of(context)!.month,20,Colorss.mainColor),
                                        Text("${settingprovider.premiumPlansModel!.data!.elementAt(index).expectedPrice.toString()} ${settingprovider.premiumPlansModel!.data!.elementAt(index).currencySymbol.toString()}",textScaleFactor: 1,
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xFF7E7E7E),
                                              fontSize: 9,
                                              decoration: TextDecoration.lineThrough

                                          ),),
                                        addSemiBoldText("${settingprovider.premiumPlansModel!.data!.elementAt(index).price.toString()} ${settingprovider.premiumPlansModel!.data!.elementAt(index).currencySymbol.toString()}",14,Colorss.mainColor),
                                        addMediumText("${settingprovider.premiumPlansModel!.data!.elementAt(index).per_month_price.toString()} ${settingprovider.premiumPlansModel!.data!.elementAt(index).currencySymbol.toString()}",11,Color(0xFFCCCCCC)),

                                      ],
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topCenter,
                                    child: Container(
                                      alignment: Alignment.topCenter,
                                      height:18,
                                      child: addRegularText(AppLocalizations.of(context)!.popular, 12, Colors.white),
                                      width: 80,
                                      decoration: BoxDecoration(
                                          color: Colorss.mainColor,
                                          borderRadius: BorderRadius.circular(5)
                                      ),),
                                  )
                                ],
                              ),
                            ):GestureDetector(
                              onTap: (){
                                setState(() {
                                  selectedIndex = index;
                                  settingprovider.planid=settingprovider.premiumPlansModel!.data!
                                      .elementAt(index).id;
                                  plan_id =
                                      settingprovider.planid;
                                  if(Platform.isIOS)
                                  {
                                    settingprovider.sku=settingprovider.premiumPlansModel!.data!
                                        .elementAt(index).ios_sku;
                                    sku =
                                        settingprovider.sku;
                                    print("sku skuupdate");
                                    print(sku);
                                  }
                                  else{
                                    settingprovider.sku=settingprovider.premiumPlansModel!.data!
                                        .elementAt(index).android_sku;
                                    sku =
                                        settingprovider.sku;
                                  }
                                  print(index);
                                });
                              },
                              child: Container(
                                width: 150,
                                child: Stack(
                                  children: [
                                    Container(
                                      width: 150,
                                      margin: EdgeInsets.only(left: 10,top: 9),
                                      decoration: BoxDecoration(
                                          border: Border.all(color: Color(0xFF000000).withOpacity(0.20)),
                                          borderRadius: BorderRadius.circular(20)
                                      ),
                                      padding: EdgeInsets.symmetric(horizontal: 2.w,vertical: 5),
                                      child:Column(
                                        children: [
                                          addSemiBoldText(settingprovider.premiumPlansModel!.data!.elementAt(index).invoicePeriod.toString(),59,Colorss.mainColor),
                                          addMediumText(AppLocalizations.of(context)!.month,20,Colorss.mainColor),
                                          Text("${settingprovider.premiumPlansModel!.data!.elementAt(index).expectedPrice.toString()} ${settingprovider.premiumPlansModel!.data!.elementAt(index).currencySymbol.toString()}",textScaleFactor: 1,
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xFF7E7E7E),
                                                fontSize: 9,
                                                decoration: TextDecoration.lineThrough

                                            ),),
                                          addSemiBoldText("${settingprovider.premiumPlansModel!.data!.elementAt(index).price.toString()} ${settingprovider.premiumPlansModel!.data!.elementAt(index).currencySymbol.toString()}",14,Colorss.mainColor),
                                          addMediumText("${settingprovider.premiumPlansModel!.data!.elementAt(index).per_month_price.toString()} ${settingprovider.premiumPlansModel!.data!.elementAt(index).currencySymbol.toString()}",11,Color(0xFFCCCCCC)),

                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ):Center(child: Text(AppLocalizations.of(context)!.noplans),):
                       shimmerLoadingWidget(context);
                      }
                  )

              ),
              SizedBox(
                height: 30.h,
              ),
              addCenterRegularText(AppLocalizations.of(context)!.recurringbill, 11, Colors.black.withOpacity(0.51)),
              SizedBox(
                height: 3.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (){
                      Get.to(TermsofUseScreen());
                    },
                    child: Text("https://moorky.com/terms/ ",
                        textScaleFactor: 1.0,style: GoogleFonts.poppins(textStyle: TextStyle(
                            color: Colorss.mainColor.withOpacity(0.51),fontWeight: FontWeight.normal,
                            fontSize: 9
                        ))),
                  ),
                  addRegularText(" & ", 9, Colors.black.withOpacity(0.51)),
                  GestureDetector(
                    onTap: (){
                      Get.to(PrivacyPolicyScreen());
                    },
                    child: Text(" https://moorky.com/privacy/",textScaleFactor: 1.0,style: GoogleFonts.poppins(textStyle: TextStyle(
                        color: Colorss.mainColor.withOpacity(0.51),
                        fontWeight: FontWeight.normal,
                        fontSize: 9
                    ))),
                  ),
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              !isLoad?InkWell(
                onTap: ()async{
                  print("subscription");
                  print(subscription);
                  print("sku");
                  print(sku);
                  // _requestPurchase(sku);
                  if(!subscription)
                  {
                    setState(() {
                      isLoad=true;
                    });
                    _requestPurchase(sku);
                  }
                  else{
                    setState(() {
                      isLoad=false;
                    });
                    showSnakbar("You have already activated plan", context);
                  }


                },
                child: Container(
                    height: 50.h,
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
                        boxShadow: [new BoxShadow(
                          color: Color(0xFFFEEBF5),
                          blurRadius: 20.0,
                        ),],
                        borderRadius: BorderRadius.circular(50.r)),
                    alignment: Alignment.center,
                    child: addMediumText(AppLocalizations.of(context)!.buybasic, 14,Color(0xFFFFFFFF) )
                ),
              ):Container(child: CircularProgressIndicator(),alignment: Alignment.bottomCenter,),

            ],
          ),
        ),
      ),
    );
  }
}
extension InAPPPurchaseMethods on _BasicPlan_ScreenState {

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    Future.delayed(Duration.zero, () {

      // showLoaderDialog(context);
    });

    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      // platformVersion = (await FlutterInappPurchase.instance.pl)!;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // prepare
    var result = await FlutterInappPurchase.instance.initialize();
    print('result: $result');

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      // _platformVersion = platformVersion;
    });

    // refresh items for android
    try {
      String msg = await FlutterInappPurchase.instance.consumeAll();
      print('consumeAllItems: $msg');
    } catch (err) {
      print('consumeAllItems error: $err');
    }

    _conectionSubscription =
        FlutterInappPurchase.connectionUpdated.listen((connected) {
          print('connected: $connected');
        });

    _purchaseUpdatedSubscription =
        FlutterInappPurchase.purchaseUpdated.listen((productItem) async {
          print('purchase-updated: ${productItem?.productId}');
          print('purchase-updated: ${productItem?.transactionId}');
          print('purchase-updated: ${productItem?.productId}');
          print('purchase-updated: ${productItem?.productId}');
          print('purchase-updated: ${productItem?.productId}');
          print('purchase-updated: ${productItem?.productId}');
          // setState(() {
          //   isLoad=true;
          // });
          var paymentsucess=await SettingRepository.getPaymentResponse(preferences!.getString("accesstoken")!, plan_id.toString(),productItem!.productId.toString(),productItem.transactionId.toString(),productItem.transactionDate.toString(),productItem.transactionReceipt.toString());
          if(paymentsucess.statusCode==200)
          {
            var model=await ProfileRepository.updateProfile("basic", "user_plan", preferences!.getString("accesstoken")!);
            if(model.statusCode==200) {

              var model = await ProfileRepository.updateProfile(
                  "basic", "user_plan",
                  preferences!.getString("accesstoken")!);
              setState(() {
                isLoad = false;
              });
              preferences!.setString("usertype", "basic");
              var provider = await Provider.of<ProfileProvider>(
                  context, listen: false);
              provider.resetStreams();
              provider.user_type = "basic";
              provider.adddetails(model);
              showSnakbar(paymentsucess.message!, context);
              Get.off(DashBoardScreen(pageIndex: 1,isNotification: false,));
            }
            else if (model.statusCode == 422) {
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
          else if (paymentsucess.statusCode == 422) {
            setState(() {
              isLoad=false;
            });
            showSnakbar(paymentsucess.message!, context);
          }
          else {
            setState(() {
              isLoad=false;
            });
            showSnakbar(paymentsucess.message!, context);
          }
          // callPlanPurchasedApi('1',"${_items[0].price} ${_items[0].currency}");
          /*Map<String, dynamic> prams = {
            'deviceId': await SharedPreferenceHelper.getInstance().DeviceToken,
            'platform': Platform.isAndroid ? 'Android' : 'iOS',
            'paymentId': productItem?.productId,
            'amount': amount,
            'planId': planId,
            'paymentType': "membership"
          };
          print("paymentparams : $prams");
          createPaymentHistory(prams);*/
        });

    _purchaseErrorSubscription =
        FlutterInappPurchase.purchaseError.listen((purchaseError) {
          print('purchase-error: $purchaseError');
          setState(() {
            isLoad=false;
          });
        });
    //Navigator.pop(context);
    _getProduct();

  }

  Future _getProduct() async {
    Future.delayed(Duration.zero, () {
      //  showLoaderDialog(context);
    });

    List<IAPItem> items = [];
    if(Platform.isIOS){
      items = await FlutterInappPurchase.instance.getProducts(productLists!);
    } else{
      items =
      await FlutterInappPurchase.instance.getSubscriptions(productLists!);
    }
    print(productLists);
    items = await FlutterInappPurchase.instance.getProducts(productLists!);
    print('${items.length}');
    print('vishaolijsdlkcjaslkdjlkasjdlkjals');
    for (var item in items) {
      print('${item.toString()}');
      _items.add(item);
    }
    //Navigator.pop(context);
    setState(() {
      _items = items;
      // _purchases = [];
    });
  }

  void _requestPurchase(String apple_id) {
    FlutterInappPurchase.instance.requestPurchase(apple_id);
  }
}
