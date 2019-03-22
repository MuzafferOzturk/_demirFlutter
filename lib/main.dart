import 'package:flutter/material.dart';
import 'package:demir/Utils/commonUtils.dart';
import 'package:demir/Utils/color.dart';
import 'package:demir/Pages/homePage.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appCommon.appName,
      theme: new ThemeData(
        primaryColor: color.colorPrimaryDark),
      home: new homePage(),
    );
  }
}
