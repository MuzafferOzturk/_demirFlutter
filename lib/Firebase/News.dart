import 'package:demir/Firebase/FirebaseCommon.dart';
import 'package:demir/Firebase/FirebaseAbsClass.dart';
class News extends FirebaseAbsClass{
  String content;
  String rec_date;
  String title;
  News();
  News.init(this.content,this.rec_date,this.title);
  @override
  fromDb(Map data) {
    data.forEach((key,value){
      String content = "";
      String rec_date = "";
      String title = "";
      (value as Map).forEach((keyItem, valueItem){
        switch(keyItem.toString()){
          case "content":
            content = valueItem.toString();
            break;
          case "rec_date":
            rec_date = valueItem.toString();
            break;
          case "title":
            title = valueItem.toString();
            break;
        }
      });
      ListForDB.news.add(new News.init(content, rec_date, title));
    });
  }
}