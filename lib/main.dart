import 'package:flutter/material.dart';
import 'package:demir/Utils/commonUtils.dart';
import 'package:demir/Utils/color.dart';
import 'package:demir/Pages/homePage.dart';
//import 'package:onesignal/onesignal.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
//    OneSignal.shared.init("1750938b-6f66-4fb1-980b-191073e21f2d",iOSSettings: {
//      OSiOSSettings.autoPrompt: false,
//      OSiOSSettings.inAppLaunchUrl: true
//    });
//    OneSignal.shared.setInFocusDisplayType(OSNotificationDisplayType.notification);
    print("---->>> OneSignal init");
    return MaterialApp(
      title: appCommon.appName,
      theme: new ThemeData(
        primaryColor: color.colorPrimaryDark),
      home: new homePage(),
      routes: <String, WidgetBuilder>{
        '/homepage':(BuildContext context) =>homePage()
    },
    );
  }
}
