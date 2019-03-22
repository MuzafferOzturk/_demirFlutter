import 'package:demir/Firebase/FirebaseAbsClass.dart';
import 'package:demir/Firebase/FirebaseCommon.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseMain{
  initialize() async{
    clearAllDb();
    await _getDB();
//    ListForDB.price.forEach((item){
//      print("->>>${item.cat_code}");
//    });
//  ListForDB.advertisement.forEach((item){
//    print("--->>${item.base64}");
//  });
//    ListForDB.category.forEach((item){
//    print("--->>${item.cat_name}");
//  });
//    ListForDB.installment.forEach((item){
//    print("--->>${item.bank_name}");
//  });
    ListForDB.news.forEach((item){
      print("--->>${item.title}");
    });
//    ListForDB.product.forEach((item){
//      print("--->>${item.pro_name}");
//    });
//    ListForDB.shipping.forEach((item){
//      print("--->>${item.outlet}");
//    });
  }
  clearAllDb(){
    ListForDB.price.clear();
    ListForDB.advertisement.clear();
    ListForDB.category.clear();
    ListForDB.installment.clear();
    ListForDB.news.clear();
    ListForDB.product.clear();
    ListForDB.shipping.clear();
  }
  _getDB() async{
    for(var item in Db.dbList){
      await FirebaseDatabase.instance.reference().child(Db.dbNameToString(item)).once().then((snapshot){
        (Db.dbFactories[Db.dbNameToString(item)]() as FirebaseAbsClass).fromDb(snapshot.value);
        print("-->>DB $item");
      });
    }
//    await Db.dbList.forEach((it) async {
//      await FirebaseDatabase.instance.reference().child(Db.dbNameToString(it)).once().then((snapshot){
//        (Db.dbFactories[Db.dbNameToString(it)]() as FirebaseAbsClass).fromDb(snapshot.value);
//      });
//    });

  }
}

