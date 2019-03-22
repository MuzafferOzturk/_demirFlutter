import 'package:flutter/material.dart';
import 'package:demir/controller/enums/enums.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:demir/Utils/commonUtils.dart';
import 'dart:io';

class controllerContact{
  final separator = Platform.isIOS ? '&' : '?';
  var context = null;
  controllerContact(this.context);
  LaunchUrl(enumsURL bid) async {
    var _launchURL = setLaunchUrl(bid);
    print('<><>>>>Url ->$_launchURL');
    if (await canLaunch(_launchURL))
      await launch(_launchURL);
    else
      Scaffold.of(context).showSnackBar(new SnackBar(content: new Text("Uygulama Başlatılamadı!.",textAlign: TextAlign.center,)));
  }

  String setLaunchUrl(enumsURL bid) {
    switch (bid) {
      case enumsURL.MAIL:
        return 'mailto:${appCommon.mail}${separator}subject=${Uri.encodeFull('${appCommon.mailSubject}')}&body=${Uri.encodeFull('${appCommon.messageBody}')}';
        break;
      case enumsURL.PHONE:
        return 'tel:${appCommon.landPhone}';
        break;
      case enumsURL.LOCATION:
//        if(Platform.isAndroid)
          return 'https://www.google.com/maps/dir/${separator}api=1&origin=&destination=${appCommon.mapAdress}&travelmode=driving';
//        else
//          return '';
        break;
      default:
        return '';
        break;
    }
  }
}