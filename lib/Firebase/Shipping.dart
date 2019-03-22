import 'package:demir/Firebase/FirebaseCommon.dart';
import 'package:demir/Firebase/FirebaseAbsClass.dart';

class Shipping extends FirebaseAbsClass{
  String outlet;
  String shipping;
  Shipping();
  Shipping.init(this.outlet,this.shipping);
  @override
  fromDb(Map data) {
    data.forEach((key, value){
      String outlet = "";
      String shipping = "";
      (value as Map).forEach((keyItem, valueItem){
        switch(keyItem.toString()){
          case "outlet":
            outlet = valueItem.toString();
            break;
          case "shipping":
            shipping = valueItem.toString();
            break;
        }
      });
      ListForDB.shipping.add(new Shipping.init(outlet, shipping));
    });
  }
}