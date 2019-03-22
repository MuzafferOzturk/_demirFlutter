import 'package:flutter/material.dart';
import 'package:demir/Utils/commonUtils.dart';
import 'package:demir/controller/enums/enums.dart';
import 'package:demir/Firebase/FirebaseCommon.dart';
class controllerNews {
  var context = null;
  var drawerItems = [];
  controllerNews(BuildContext context){
    this.context = context;
    _prepareItem();
  }
  _prepareItem(){
    for(var item in ListForDB.news){
      drawerItems.add(new drawerItem(item.title, item.content, new Image.asset("assets/logo.png", scale: 5,)));
    }
//    drawerItems.add(new drawerItem("FKM DEMİR", "Uygulamamız Yayında!.", new Image.asset("assets/logo.png", scale: 5,),));
  }
}

class drawerItem{
  String title;
  String subTitle;
  Image icon;
  drawerItem(this.title,this.subTitle,this.icon);
}
