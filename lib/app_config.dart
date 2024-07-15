import 'package:flutter/material.dart';

class AppConfig {

  static GlobalKey<NavigatorState> materialKey = GlobalKey<NavigatorState>();
}

BuildContext get globalBuildContext => AppConfig.materialKey.currentContext!;

bool get globalBuildContextExits =>
    AppConfig.materialKey.currentContext != null;
