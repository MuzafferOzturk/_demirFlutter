import 'package:demir/Firebase/FirebaseCommon.dart';
import 'package:demir/Firebase/FirebaseAbsClass.dart';

class Advertisement extends FirebaseAbsClass{
  String base64;
  Advertisement();
  Advertisement.init(this.base64);
  @override
  fromDb(Map data) {
    data.forEach((key,value){
      (value as Map).forEach((keyItem, valueItem){
        if(keyItem.toString().compareTo("base64") == 0)
          ListForDB.advertisement.add(new Advertisement.init(valueItem));
      });
    });
  }
}