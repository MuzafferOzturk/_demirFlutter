import 'package:demir/Firebase/FirebaseCommon.dart';
import 'package:demir/Firebase/FirebaseAbsClass.dart';

class Category extends FirebaseAbsClass{
  int cat_code;
  String cat_name;
  int parent_cat;
  Category();
  Category.init(this.cat_code,this.cat_name,this.parent_cat);
  @override
  fromDb(Map data) {
    data.forEach((key,value){
      int cat_code = 0;
      String cat_name = "";
      int parent_cat = 0;
      (value as Map).forEach((keyItem, valuteItem){
        switch(keyItem.toString()){
          case "cat_code":
            cat_code = int.parse(valuteItem.toString());
            break;
          case "cat_name":
            cat_name = valuteItem.toString();
            break;
          case "parent_cat":
            parent_cat = int.parse(valuteItem.toString());
        }
      });
      ListForDB.category.add(new Category.init(cat_code, cat_name, parent_cat));
    });
  }
}