import 'package:demir/Firebase/FirebaseCommon.dart';
import 'package:demir/Firebase/FirebaseAbsClass.dart';

class Installment extends FirebaseAbsClass{
  String bank_name;
  String install_option;
  Installment();
  Installment.init(this.bank_name,this.install_option);
  @override
  fromDb(Map data) {
    data.forEach((key,value){
      String bank_name = "";
      String install_option = "";
      (value as Map).forEach((keyItem, valueItem){
        switch(keyItem.toString()){
          case "bank_name":
            bank_name = valueItem.toString();
            break;
          case "install_option":
            install_option = valueItem.toString();
        }
      });
      ListForDB.installment.add(new Installment.init(bank_name, install_option));
    });
  }
}