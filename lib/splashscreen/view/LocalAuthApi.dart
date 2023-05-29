// import 'package:flutter/services.dart';
// import 'package:local_auth/auth_strings.dart';
// import 'package:local_auth/local_auth.dart';
//
// class LocalAuthApi{
//   static final  _localauth=LocalAuthentication();
//   static bool hasfacelock=false;
//
//   static Future<bool> hasBiometric()async {
//     try {
//       return await _localauth.canCheckBiometrics;
//     } on PlatformException catch (e) {
//       return false;
//     }
//   }
//   static Future<bool> authenticate()async{
//     final isAvailable=await hasBiometric();
//     List<BiometricType> listbiomatirc=await _localauth.getAvailableBiometrics();
//     hasfacelock=listbiomatirc.contains(BiometricType.face);
//     print(listbiomatirc);
//
//     if(!isAvailable) return false;
//     try {
//       if(!hasfacelock) false;
//       return await _localauth.authenticateWithBiometrics(localizedReason: "Scan Face to Authenticate",
//       androidAuthStrings: AndroidAuthMessages(
//         signInTitle: "Face ID Required"
//       ),useErrorDialogs: true,stickyAuth: true
//       );
//     } on PlatformException catch (e) {
//       return false;
//     }
//   }
// }