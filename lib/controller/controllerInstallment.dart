import 'package:flutter/material.dart';
import 'package:demir/Utils/commonUtils.dart';
import 'package:demir/controller/enums/enums.dart';

class controllerInstallment {
  var context = null;
  var drawerItems = [];
  controllerInstallment(BuildContext context){
    this.context = context;
    _prepareItem();
  }
  _prepareItem(){
    drawerItems.add(new drawerItem("2-12 TAKSİT", new Image.asset("assets/axess.png", scale: 3,),));
    drawerItems.add(new drawerItem("4 TAKSİT", new Image.asset("assets/bonuscard.png", scale: 1.5,)));
    drawerItems.add(new drawerItem("2-9 TAKSİT",new Image.asset("assets/card_finans.png", scale: 1.5,)));
    drawerItems.add(new drawerItem("2-9 TAKSİT", new Image.asset("assets/maximum.png", scale: 1.5,)));
    drawerItems.add(new drawerItem("15-18 TAKSİT", new Image.asset("assets/world_card.png", scale: 1.5,)));
  }
}

class drawerItem{
  String title;
  Image icon;
  drawerItem(this.title,this.icon);
}
