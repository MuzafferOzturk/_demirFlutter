import 'package:flutter/material.dart';
import 'package:demir/Utils/commonUtils.dart';
import 'package:demir/controller/enums/enums.dart';
import 'package:demir/Firebase/FirebaseCommon.dart';

class controllerInstallment {
  var context = null;
  var drawerItems = [];
  static final String axess = "assets/axess.png";
  static final String bonus = "assets/bonuscard.png";
  static final String cardFinans = "assets/card_finans.png";
  static final String maximum = "assets/maximum.png";
  static final String world = "assets/world_card.png";
  static final Map<String,String> bankList = {"axess":axess, "bonus":bonus, "cardFinans":cardFinans, "maximum":maximum, "world":world};
  controllerInstallment(BuildContext context){
    this.context = context;
    _prepareItem();
  }
  _prepareItem(){
    for(var item in ListForDB.installment){
      if(bankList[item.bank_name] != null)
          drawerItems.add(new drawerItem('${item.install_option} TAKSİT', new Image.asset(bankList[item.bank_name],
            scale: item.bank_name == "axess" ? 3 : 1.5,)));
    }
  }
}

class drawerItem{
  String title;
  Image icon;
  drawerItem(this.title,this.icon);
}
