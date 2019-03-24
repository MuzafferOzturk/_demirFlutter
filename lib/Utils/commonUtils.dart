import 'dart:io';

import 'package:flutter/material.dart';
import 'package:demir/Firebase/FirebaseMain.dart';
import 'package:demir/http/Currency.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

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
  static final currencyURL = "http://www.tcmb.gov.tr/kurlar/today.xml";
  static final separator = Platform.isIOS ? '&' : '?';
  static Currency currency = new Currency();
  static Future firebaseInit() async{
    FirebaseMain firebase = new FirebaseMain();
    await firebase.initialize();
    await appCommon.getCurrency();
    bHomePageInit = true;
  }
  static Future getCurrency() async{
    var response = await http.get(appCommon.currencyURL);
//    print("<><>Response ${response.body}");
    var document = xml.parse(response.body);
//    print("<><>>> Kod->${document.findAllElements("Currency")}");
    var elements = document.findAllElements("Currency");
    if(elements.length!=0){
      for(var element in elements){
        if(element.getAttribute("Kod") == "USD"){
          currency.usdAlis = element.findElements("ForexBuying").elementAt(0).children.elementAt(0).toString();
          currency.usdSatis = element.findElements("ForexSelling").elementAt(0).children.elementAt(0).toString();
        }
        else if(element.getAttribute("Kod") == "EUR"){
          currency.euroAlis = element.findElements("ForexBuying").elementAt(0).children.elementAt(0).toString();
          currency.euroSatis = element.findElements("ForexSelling").elementAt(0).children.elementAt(0).toString();
        }
        if(currency.usdAlis != "" && currency.usdSatis != "" && currency.euroAlis != "" && currency.euroSatis != "") break;
      };
    }
  }
  static final city = [
    "Adana",
    "Adıyaman",
    "Afyonkarahisar",
    "Ağrı",
    "Amasya",
    "Ankara",
    "Antalya",
    "Artvin",
    "Aydın",
    "Balıkesir",
    "Bilecik",
    "Bingöl",
    "Bitlis",
    "Bolu",
    "Burdur",
    "Bursa",
    "Çanakkale",
    "Çankırı",
    "Çorum",
    "Denizli",
    "Diyarbakır",
    "Edirne",
    "Elâzığ",
    "Erzincan",
    "Erzurum",
    "Eskişehir",
    "Gaziantep",
    "Giresun",
    "Gümüşhane",
    "Hakkari",
    "Hatay",
    "Isparta",
    "Mersin",
    "İstanbul",
    "İzmir",
    "Kars",
    "Kastamonu",
    "Kayseri",
    "Kırklareli",
    "Kırşehir",
    "Kocaeli",
    "Konya",
    "Kütahya",
    "Malatya",
    "Manisa",
    "Kahramanmaraş",
    "Mardin",
    "Muğla",
    "Muş",
    "Nevşehir",
    "Niğde",
    "Ordu",
    "Rize",
    "Sakarya",
    "Samsun",
    "Siirt",
    "Sinop",
    "Sivas",
    "Tekirdağ",
    "Tokat",
    "Trabzon",
    "Tunceli",
    "Şanlıurfa",
    "Uşak",
    "Van",
    "Yozgat",
    "Zonguldak",
    "Aksaray",
    "Bayburt",
    "Karaman",
    "Kırıkkale",
    "Batman",
    "Şırnak",
    "Bartın",
    "Ardahan",
    "Iğdır",
    "Yalova",
    "Karabük",
    "Kilis",
    "Osmaniye",
    "Düzce",
    "Payas",
    "Biga",
    "İstanbulAvp",
    "Gebze",
    "ÇiviPayas",
    "TelPayas",
    "İskenderun",
  ];
}
