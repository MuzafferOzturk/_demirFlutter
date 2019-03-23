import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:demir/Utils/color.dart';
import 'package:demir/Firebase/Price.dart';
import 'dart:convert';
import 'package:demir/Utils/commonUtils.dart';
import 'package:demir/Firebase/FirebaseCommon.dart';
class controllerPrice{
  var context = null;
  List<Widget> tabList = [];
  List<String> column = [];
  List<LinkedHashMap<List<String>,List<Color>>> rows = new List();
  controllerPrice(BuildContext context){
    this.context = context;
    initialize();
  }

  initialize() async{
//    for(int i=0;i<15;i++){
//      this.rows[i] = ["Konya","100","200","300"];
//    }
//  this.rows.add(["85","0","0","0"]);
//  this.rows.add(["86","0","0","0"]);
//  this.rows.add(["87","0","0","0"]);
//  this.rows.add(["88","0","0","0"]);
    print("-->List Size-> ${ListForDB.price.length}");
  }
  TabBar createTabBar(){
    var tabBar = new TabBar(
      tabs: _createTab(),
      labelColor: Colors.white,
      indicatorColor: Colors.red,
    );
    return tabBar;
  }

  List<Widget> _createTab(){
    for(var item in ListForDB.category.reversed){
      tabList.add(new Tab(text: item.cat_name.replaceAll(' ', '\n'), key: Key(item.cat_code.toString()),));
    }
    return tabList;
  }

  List<Widget> createTabBarView(){
    List<Widget> list = [];
    for(var item in tabList){
      list.add(_createDataTable(item.key.toString()));
    }
//    list.add(_createDataTable());
//    list.add(Text("ÇELİK HASIR"));
//    list.add(Text("HADDE"));
//    list.add(Text("PROFİL"));
    return list;
  }

  Widget _createDataTable(String key){

    return new SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: _createColumnAndRows(key),
        ),
      ),
    );
  }

  List<Widget> _createColumnAndRows(String key){
    this.column.clear();
    List<Widget> list = [];
    list.add(_createDataColumn(key));
    var rowList = _createDataRows(key);
    for(var item in rowList){
      list.add(item);
    }
//    _createDataRows(key).forEach((it){
//      list.add(it);
//    });
    return list;
  }
  String _getProductName(String productCode){
    for(var item in ListForDB.product)
      if(productCode == item.pro_no.toString()){
        return item.pro_name.toString();
        break;
      }
  }
  Widget _createDataColumn(String key){
    List<Widget> list = [];
    for(var item in ListForDB.price){
      if("[<'${item.cat_code}'>]" == key){
        this.column.add("Bölge");
        item.produc_codes.split(',').forEach((product_code){
          this.column.add(_getProductName(product_code));
        });
        break;
      }
    }
    for(var item in this.column){
      list.add(new Container(
        padding:EdgeInsets.all(8.0),
        width: (MediaQuery.of(context).size.width)/this.column.length,
        child: Text(item,
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold),
          overflow: TextOverflow.ellipsis,
          maxLines: 2,),
      )
      );
    }
    return new Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: list,
    );
  }
  Text _createRowText(String text,int index, Color color){
    return new Text(text,
      textAlign: index == 0 ? TextAlign.left : TextAlign.right,
      overflow: TextOverflow.ellipsis,
      style: new TextStyle(color: color),
      maxLines: 2,);
  }

  List<Widget> _createDataRows(String key){
    List<Widget> list = [];
    List<Widget> listRows = [];
    this.rows.clear();
    for(var item in ListForDB.price){
      if("[<'${item.cat_code}'>]" == key){
        (jsonDecode(item.price) as Map).forEach((key, value){
          for(var subPrice in (value as List)){
            String city_code = "";
            String price = "";
            String pre_last = "";
//            print("subPrice->>$subPrice");
            (subPrice as Map).forEach((subPriceItem, subPriceValue){
//              print("<><>subPriceItem -> $subPriceItem val-> $subPriceValue");
              switch(subPriceItem){
                case "city_code":
                  city_code = appCommon.city[int.parse(subPriceValue.toString())-1];
                  break;
                case "price":
                  price = subPriceValue.toString();
                  break;
                case "pre_last":
                  pre_last = subPriceValue.toString();
                  break;
              }
            });
            LinkedHashMap<List<String>,List<Color>> _rowList = new LinkedHashMap();
            List<String> rowList = new List();
            List<Color> rowColor = new List();
            rowColor.add(Colors.black);
            rowList.add(city_code);
            for(int k = 0; k<price.split(',').length;k++){
              var priceText = price.split(',')[k];
              rowList.add(priceText);
              if(int.parse(priceText)>int.parse(pre_last.split(',')[k])){
                rowColor.add(color.downCash);
              }
              else if(int.parse(priceText)<int.parse(pre_last.split(',')[k])){
                rowColor.add(color.upCash);
              }
              else{
                rowColor.add(color.stableCash);
              }
            }
//            for(var splitItem in price.split(",")){
//              rowList.add(splitItem);
//            }
            _rowList[rowList] = rowColor;
            this.rows.add(_rowList);
//            index++;
          }
        });
        break;
      }
    };
    print("<><>${this.rows}");
    for(var j = 0; j<this.rows.length;j++){
      print("<><>${this.rows[j]}");
      list = new List();
      this.rows[j].forEach((key, value){
        for(var i = 0;i<key.length;i++){
          String text = i==0 ? key[i]: '${key[i]}₺';
//        Text textWidget = _createRowText(text, j);
          list.add(_createRowWidget(i, text, value[i]));
        }
      });

      Widget row =  new Row(
        key: Key("$j"),
        children: list,
      );
      listRows.add(new GestureDetector(
          onTap: (){
            print("${row.key}");
          },
          child:row,
        )
      );
      listRows.add(new Row(
        children: <Widget>[
          new Container(
            color: Colors.black,
            height: 1,
            width: MediaQuery.of(context).size.width,
          )
        ],
      ));
    }
    return listRows;
  }

  Widget _createRowWidget(int index, String text, Color color){
    return index == 0 ? new Container(
      padding:EdgeInsets.all(8.0),
      width: (MediaQuery.of(context).size.width-16)/this.column.length,
      child: _createRowText(text, index, Colors.black),
    ):new Container(
        padding:EdgeInsets.all(8.0),
        width: (MediaQuery.of(context).size.width-16)/this.column.length,
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            _createRowText(text, index, color),
            Image.asset("assets/arrow/right_arrow.png",scale: 4,),
          ],
        )
    );
  }
  //region DATA TABLE
//  DataTable _createDataTable(List<String> column, Map<int,List<String>> rows){
//    return DataTable(
//      columns: _createDataColumn(column),
//      rows: _createDataRow(rows),
//    );
//  }
//  List<DataColumn> _createDataColumn(List<String> column){
//    List<DataColumn> listColumn = [];
//    column.forEach((String it){
//      listColumn.add(new DataColumn(
//        label: Container(child: Text(it,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,),),
//      ));
//    });
//    return listColumn;
//  }
//  List<DataRow> _createDataRow(Map<int,List<String>> rows){
//    List<DataRow> listRows = [];
//    rows.forEach((key,value){
//      List<DataCell> cells = [];
//      for(var i=0 ;i<value.length;i++){
//        cells.add(new DataCell(Row(children: <Widget>[
//          Text(i==0 ? value[i]: '${value[i]}₺',textAlign: i==0 ? TextAlign.left : TextAlign.right,),
//          Image.asset("assets/arrow/right_arrow.png",scale: 5.0,)
//        ],)));
//      }
//      listRows.add(new DataRow(cells: cells));
//    });
//    return listRows;
//  }
  //endregion

}