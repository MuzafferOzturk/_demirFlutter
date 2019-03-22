import 'package:demir/Firebase/FirebaseCommon.dart';
import 'package:demir/Firebase/FirebaseAbsClass.dart';

class Product extends FirebaseAbsClass{
  int index;
  String pro_name;
  int pro_no;
  Product();
  Product.init(this.index,this.pro_name,this.pro_no);
  @override
  fromDb(Map data) {
    data.forEach((key,value){
      int index = 0;
      String pro_name = "";
      int pro_no = 0;
      (value as Map).forEach((keyItem, valueItem){
        switch(keyItem.toString()){
          case "index":
            index = int.parse(valueItem.toString());
            break;
          case "pro_name":
            pro_name = valueItem.toString();
            break;
          case "pro_no":
            pro_no = int.parse(valueItem.toString());
        }
      });
      ListForDB.product.add(new Product.init(index, pro_name, pro_no));
    });
  }
}