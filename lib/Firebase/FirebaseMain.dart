import 'package:demir/Firebase/FirebaseAbsClass.dart';
import 'package:demir/Firebase/FirebaseCommon.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseMain{
  static saveUser(String company, String mail, String name_surname, String phone) async{
    final users = FirebaseDatabase.instance.reference().child('Users');
    await users.child(new DateTime.now().millisecondsSinceEpoch.toString()).set({
      'company': company,
      'mail'   : mail,
      'name_surname' : name_surname,
      'phone' : phone
    }).then((_){

    });
  }
  initialize() async{
    clearAllDb();
    await _getDB();
    ListForDB.news.forEach((item){
      print("--->>${item.title}");
    });
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

