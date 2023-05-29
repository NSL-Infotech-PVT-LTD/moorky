import 'package:flutter/services.dart';


class TokenPlugin {
  static const MethodChannel _channel = MethodChannel("token_plugin");

  static Future<String> makeToken(String userID) async {
    print("this is call method channel");
    print("this is call method channel #$userID");
    Map resultMap = await _channel.invokeMethod('makeToken', {
      "appID": 2092916647,
      "userID":userID,
      "secret":'',
    });
    print("resultMap");
    print(resultMap);
    return resultMap['token'];
  }
}
