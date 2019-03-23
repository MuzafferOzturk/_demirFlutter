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
  static Future firebaseInit() async{
    FirebaseMain firebase = new FirebaseMain();
    await firebase.initialize();
    bHomePageInit = true;
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
