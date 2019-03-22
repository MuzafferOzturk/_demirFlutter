import 'dart:convert';
import 'package:demir/Firebase/FirebaseCommon.dart';
import 'package:demir/Firebase/FirebaseAbsClass.dart';
class Price{
  int cat_code;
  String price;
  String produc_codes;
  String rec_update;
  List<price_history> history;
}

class priceExtend extends FirebaseAbsClass implements Price{
  @override
  int cat_code;

  @override
  List<price_history> history;

  @override
  String price;

  @override
  String produc_codes;

  @override
  String rec_update;


  priceExtend();

  @override
  fromDb(Map data) async{
    data.forEach((key, value){
      Map valueMap = value as Map;
      ListForDB.price.add(_findValue(valueMap));
    });
  }

  Price _findValue(Map map){
    try{
      Price price = new priceExtend();
      map.forEach((key,value){
        switch(key.toString()){
          case "cat_code":
            price.cat_code = int.parse(value.toString());
            break;
          case "price":
            price.price = value.toString();
            break;
          case "rec_update":
            price.rec_update = value.toString();
            break;
          case "product_codes":
            price.produc_codes = value.toString();
            break;
          case "history":
            var historyMap = value as Map;
            var price_historyList = historyMap["price_history"] as List;
            List<price_history> priceHistoryL = new List();
            price_historyList.forEach((item){
              var city_code="";
              List dateList = new List();
              (item as Map).forEach((itemKey,itemVal){
                if(itemKey.toString().compareTo("city_code") == 0)
                  city_code = itemVal.toString();
                else if(itemKey.toString().compareTo("date") == 0)
                  dateList = itemVal as List;
              });
              priceHistoryL.add(new price_history.toDB(city_code, dateList));
            });
            price.history = priceHistoryL;
//        price_historyMap.forEach((keyHistory,valueHistory){
//          (valueHistory as Map).forEach((itemKey,itemVal){
//            print("Key->> $itemKey Val ->>$itemVal");
//          });
//        });
            break;
        }
      });
      return price;
    }
    catch(e){
      print("-->>Price findValue Ex ${e.toString()}");
      return null;
    }
  }


}


class price_history{
  String city_code;
  List<dateClass> date;
  price_history.toDB(String city_code, List dateList){
    this.city_code = city_code;
    List<dateClass> dateClassList = new List();
    dateList.forEach((item){
      var price = "";
      var rec_date = "";
      (item as Map).forEach((key, value){
        if(key.toString().compareTo("price") == 0)
          price = value.toString();
        else if(key.toString().compareTo("rec_date") == 0)
          rec_date = value.toString();
      });
      dateClassList.add(new dateClass.toDB(price, rec_date));
    });

  }
}

class dateClass{
  String price;
  String rec_date;
  dateClass.toDB(this.price,this.rec_date);
}



//var test = snapshot.value as Map;
//test.forEach((key,value){
//print("Key->>>>$key Val->>>$value");
//var test2 = value as Map;
//test2.forEach((key2,value2){
//print("Key222->$key2 val->>$value2");
//});
//});