import 'package:flutter/material.dart';
import 'package:demir/Firebase/FirebaseMain.dart';

class appCommon{
  static final appName = "FKM DEMİR";
  static final landPhone = "0352 321 19 84";
  static final address = "Oymaağaç Mh. Mobilyakent\nSitesi P2 Kocasinan/Kayseri";
  static final mail = "info@fkmmalzeme.com.tr";
  static final fax = "0352 321 1985";
  static final telPhone = '+905534684276';
  static final messageBody = 'Lütfen çap listenizi ve teslim yerini gönderiniz.';
  static final mailSubject = 'Fiyat Teklifi';
  static final mapAdress = 'Oymaağaç Mahallesi+Mobilyakent+Kocasinan/Kayseri';
  static bool bHomePageInit = false;
  static firebaseInit() async{
    FirebaseMain firebase = new FirebaseMain();
    await firebase.initialize();
    bHomePageInit = true;
  }
}
