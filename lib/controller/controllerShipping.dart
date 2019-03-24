import 'dart:convert';
import 'package:demir/Utils/color.dart';
import 'package:flutter/material.dart';
import 'package:demir/Utils/commonUtils.dart';
import 'package:demir/controller/enums/enums.dart';
import 'package:demir/Firebase/FirebaseCommon.dart';

class controllerShipping {
  var context = null;
  var columnWidth = 4.0;
  controllerShipping(BuildContext context){
    this.context = context;
    columnWidth = MediaQuery.of(context).size.width/3.6;
    _prepareItem();
  }
  _prepareItem(){

  }
  List<Widget> createDataColumnAndRows(String outlet){
    List<Widget> widgetList = new List();
//    widgetList.add(new Row(
//      children: <Widget>[
//        Text("test"),
//        Text("test"),
//        Text("test"),
//        Text("test"),
//        Text("test"),
//        Text("test"),Text("test"),
//        Text("test"),
//        Text("test"),
//        Text("test"),
//        Text("test"),
//        Text("test"),
//        Text("test"),
//        Text("test"),
//        Text("test"),
//        Text("test"),
//        Text("test"),
//        Text("test"),
//        Text("test"),
//      ],
//    ));
    widgetList.add(_createDataColumn());
//    _createDataRows(outlet);
    for(var item in _createDataRows(outlet)){
      widgetList.add(item);
    }
    return widgetList;
  }
  Widget _createDataColumn(){
    List<Widget> widgetList = new List();
    for(int i = 0 ; i < 6; i++){
      String text = "";
      if(i.isOdd)
        text = "FİYAT";
      else
        text = "ŞEHİR";
      widgetList.add(new Container(
        padding: EdgeInsets.all(8.0),
        width: columnWidth,
        child: Text(text,
          style: TextStyle(fontWeight: FontWeight.bold),
          maxLines: 2,
          overflow:TextOverflow.ellipsis,
          textAlign: TextAlign.center,),
      ));
    }
    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: widgetList,
    );
  }

  List<Widget> _createDataRows(String outlet){
    List<Widget> widgetList = new List();
    List<Widget> _rowList = new List();
    for(var item in ListForDB.shipping){
      if(item.outlet.compareTo(outlet) == 1){
        (jsonDecode(item.shipping) as Map).forEach((key, value){
//          print("->>>>$key $value");
          int shipIndex = 0;
          for(var shipping in (value as List)){
//            print("Shipping $shipping");
            if(shipIndex>=3){
              widgetList.add(
                new Row(
                  children: _rowList,
                )
              );
              _rowList = new List();
              shipIndex = 0;
            }
            shipIndex++;
            _rowList.add(_createTextWidget(appCommon.city[int.parse((shipping as Map)["city_code"])-1], FontWeight.bold, TextAlign.left));
            _rowList.add(_createTextWidget((shipping as Map)["price"], FontWeight.normal, TextAlign.center));
          }
        });
        break;
      }
    }
    return widgetList;
  }
  Widget _createTextWidget(String text, FontWeight fontWeight, TextAlign align){
    return Container(
      padding: EdgeInsets.only(left: 8.0),
      width: columnWidth,
      child: new Text(
        text,
        style: TextStyle(color: Colors.black, fontWeight: fontWeight),
        textAlign: align,
      ),
    );
  }
}