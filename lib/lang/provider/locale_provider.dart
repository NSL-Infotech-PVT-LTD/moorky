import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import '../../l10n/l10n.dart';


class LocaleProvider extends ChangeNotifier {

  Locale? _locale;
  LocaleProvider(){
    getLocaleFromSettings();
  }
  Locale? get locale => _locale;

  void setLocale(Locale locale) {
    print(locale);
    if (!L10n.all.contains(locale)) return;
    _locale = locale;
    notifyListeners();
  }

  void clearLocale() {
    _locale = null;
    notifyListeners();
  }
  void changeLocaleSettings(String code) async {
    String? localname=Platform.localeName;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(code=="")
      {
        if(localname.contains("en")){
          code="en";
        }else if(localname.contains("tr")){
          code="tr";
        }else if(localname.contains("ar")){
          code="ar";
        }else if(localname.contains("fr")){
          code="fr";
        }else if(localname.contains("ru")){
          code="ru";
        }else{
          code="en";
        }
      }
    print("efwef");
    print(code);
    Locale newLocale=Locale(code.toString());
    if(code == 'en') {
      _locale = Locale('en');

    } else if(code=='ar'){
      print("this is ar");
      _locale = Locale('ar');
    }else if(code=='ru'){
      print("this is ru");
      _locale = Locale('ru');
    }else if(code=='fr'){
      print("this is fr");
      _locale = Locale('fr');
    }
    else if(code=='tr'){
      print("this is tr");
      _locale = Locale('tr');
    }
    print("sdadas");
    print(_locale!.countryCode);

    await prefs.setString("lang", code);
    notifyListeners();
  }

  Future getLocaleFromSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? localname=Platform.localeName;
    String code = "";

    if(prefs.getString("lang") == null)
      {
        if(localname.contains("en")){
          code="en";
          prefs.setString("lang", code);
        }else if(localname.contains("tr")){
          code="tr";
          prefs.setString("lang", code);
        }else if(localname.contains("ar")){
          code="ar";
          prefs.setString("lang", code);
        }else if(localname.contains("fr")){
          code="fr";
          prefs.setString("lang", code);
        }else if(localname.contains("ru")){
          code="ru";
          prefs.setString("lang", code);
        }else{
          code="en";
          prefs.setString("lang", code);
        }
      }
    else{
      code = prefs.getString("lang").toString();
    }
    Locale newLocale = Locale(code);
    if(newLocale == Locale('en')) {
      _locale = Locale('en');
    } else if(newLocale==Locale('fr')){
      _locale = Locale('fr');
    } else if(newLocale==Locale('ru')){
      _locale = Locale('ru');
    }else if(newLocale==Locale('tr')){
      _locale = Locale('tr');
    }
    else if(newLocale==Locale('ar')){
      _locale = Locale('ar');
    }
    notifyListeners();
  }
}
