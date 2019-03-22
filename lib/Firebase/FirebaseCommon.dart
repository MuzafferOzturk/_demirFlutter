import 'package:demir/Firebase/Price.dart';
import 'package:demir/Firebase/Advertisement.dart';
import 'package:demir/Firebase/Category.dart';
import 'package:demir/Firebase/Installment.dart';
import 'package:demir/Firebase/News.dart';
import 'package:demir/Firebase/Product.dart';
import 'package:demir/Firebase/Shipping.dart';

class Db{
  static List<DbName> dbList = [DbName.Advertisement,DbName.Category,DbName.Installment,DbName.News,DbName.Price,DbName.Product,DbName.Shipping];
//  static List<DbName> dbList = [DbName.Price];
  static String dbNameToString(DbName name){
    switch(name){
      case DbName.Shipping:
        return "Shipping";
      case DbName.Product:
        return "Product";
      case DbName.Price:
        return "Price";
      case DbName.News:
        return "News";
      case DbName.Installment:
        return "Installment";
      case DbName.Category:
        return "Category";
      case DbName.Advertisement:
        return "Advertisement";
    }
  }
  static var dbFactories = <String,Object Function()>{
    "Shipping"        : () => new Shipping(),
    "Product"         : () => new Product(),
    "Price"           : () => new priceExtend(),
    "News"            : () => new News(),
    "Installment"     : () => new Installment(),
    "Category"        : () => new Category(),
    "Advertisement"   : () => new Advertisement(),
  };
}
enum DbName{
  Advertisement,
  Category,
  Installment,
  News,
  Price,
  Product,
  Shipping
}
class ListForDB{
  static List<priceExtend> price = new List();
  static List<Advertisement> advertisement = new List();
  static List<Category> category = new List();
  static List<Installment> installment = new List();
  static List<News> news = new List();
  static List<Product> product = new List();
  static List<Shipping> shipping = new List();
}