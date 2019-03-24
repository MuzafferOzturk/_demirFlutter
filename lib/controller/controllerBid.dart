import 'dart:io';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:demir/Utils/commonUtils.dart';
import 'package:demir/controller/enums/enums.dart';

class controllerBid {
  var context = null;
  controllerBid(this.context);
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
        return 'mailto:${appCommon.mail}${appCommon.separator}subject=${Uri.encodeFull('${appCommon.mailSubject}')}&body=${Uri.encodeFull('${appCommon.messageBody}')}';
        break;
      case enumsURL.PHONE:
        return 'tel:${appCommon.telPhone}';
        break;
      case enumsURL.SMS:
        return 'sms:${appCommon.telPhone}${appCommon.separator}body=${Uri.encodeFull('${appCommon.messageBody}')}';
        break;
      case enumsURL.WHATSPP:
        return 'whatsapp://send${appCommon.separator}phone=${appCommon.telPhone}&text=${Uri.encodeFull('${appCommon.messageBody}')}';
        break;
      default:
        return '';
        break;
    }
  }
}
