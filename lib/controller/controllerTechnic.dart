import 'package:flutter/material.dart';
import 'package:xml/xml.dart' as xml;
import 'package:flutter/services.dart' show rootBundle;

class ControllerTechnic {
  var context;

  ControllerTechnic(BuildContext context){
    this.context = context;
    _initialize();
  }
  _initialize(){
    _xmlParse();
  }
  Future<String> _getFileDate() async{
    return await rootBundle.loadString("assets/technic.xml");
  }
  _xmlParse() async{
    var strData = await _getFileDate();
    var document = xml.parse(strData);
//    print("<><>Xml $document");
    document.children.elementAt(2).children.elementAt(1).children.elementAt(1).children.forEach((node){
      print("<>Node3$node");
    });
    document.children.forEach((node){

      node.children.forEach((node2){
        print("<>Node2$node2");
      });
    });
  }
}