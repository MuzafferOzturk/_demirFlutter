import 'dart:async';
import 'dart:collection';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:demir/Utils/color.dart';
import 'package:demir/Firebase/Price.dart';
import 'dart:convert';
import 'package:demir/Utils/commonUtils.dart';
import 'package:demir/Firebase/FirebaseCommon.dart';
import 'package:demir/Firebase/Price.dart';
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
    return new Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        new Container(
          height: MediaQuery.of(context).size.height/1.8,
          child: new SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: _createColumnAndRows(key),
              ),
            ),
          ),
        ),

        /**
        TODO Tablo altındaki widgetlar burda oluşturuldu kaldırılması gerek.
         */
        new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new Container(
              padding: EdgeInsets.all(8.0),
              child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    new Container(
                      color: color.upCash,
                      child: FlatButton(
                        onPressed: ()=>{},
                        child: new Row(
                          children: <Widget>[
                            Image.asset(
                              "assets/whatsapp_main.png",
                              scale: 1.3,
                            ),
                            Text(
                              'Whatsapp\nİletişim',
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    new Container(
                      color: color.colorPrimaryDark,
                      child: FlatButton(
                        onPressed: ()=>{},
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Image.asset(
                              "assets/call_main.png",
                              scale: 1.3,
                            ),
                            Text(
                              'Nakliye Dahil\nTeklif Al',
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    )
                  ]
              ),
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("USD ALIŞ:${appCommon.currency.usdAlis} USD SATIŞ:${appCommon.currency.usdSatis}\n"
                    "EURO ALIŞ:${appCommon.currency.euroAlis} EURO SATIŞ:${appCommon.currency.euroSatis}",
                maxLines: 2,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold),)
              ],
            )
          ],
        )

      ],
    ) ;



  }

  List<Widget> _createColumnAndRows(String key){
    this.column.clear();
    List<Widget> list = [];
    list.add(_createDataColumn(key));
    var rowList = _createDataRows(key);
    for(var item in rowList){
      list.add(item);
    }
    var kdvStr = "[<'1'>]" == key ? "Fiyatlara KDV Dahildir." : "Fiyatlara KDV Dahil Değildir.";
    list.add(new Center(
      child: Text(kdvStr),
    ));
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
  List<charts.Series<priceChart,String>> _createDataForChart(String key,String city_name){
    List<priceChart> data = new List();
    for(var item in ListForDB.price){
      if("[<'${item.cat_code}'>]" == key){
        if(item.history!=null)
          for(var historyItem in item.history){
            if(appCommon.city[int.parse(historyItem.city_code)-1].compareTo(city_name) == 0){
//              print("<><>>>${historyItem.date}");
              for(var priceItem in historyItem.date){
                data.add(new priceChart(priceItem.rec_date, int.parse(priceItem.price)));
              }
              break;
            }
          }
      }
    }
    return [
      new charts.Series<priceChart, String>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (priceChart sales, _) => sales.date,
        measureFn: (priceChart sales, _) => sales.price,
        data: data,
      )
    ];
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
            (subPrice as Map).forEach((subPriceItem, subPriceValue){
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
            _rowList[rowList] = rowColor;
            this.rows.add(_rowList);
          }
        });
        break;
      }
    };
    for(var j = 0; j<this.rows.length;j++){
      var city_name = "";
      list = new List();
      this.rows[j].forEach((key, value){
        for(var i = 0;i<key.length;i++){
          var text="";
          if(i==0){
            text = key[i];
            city_name = key[i];
          }
          else text = '${key[i]}₺';
          list.add(_createRowWidget(i, text, value[i]));
        }
      });

      Widget row =  new Row(
        key: Key("$j"),
        children: list,
      );
//      Row chartRow = new Row(
//        children: <Widget>[
//          new Container(
//            width: MediaQuery.of(context).size.width,
//            height: MediaQuery.of(context).size.height/5,
//            child: new Text("${row.key}"),
//          ),
//        ],
//      );

      listRows.add(new GestureDetector(
          onTap: (){
//            Navigator.push(
//                context,
//                MaterialPageRoute(builder: (context) => priceDetail(key, city_name)));
//            chartRow.child. = true;
            showDialog(context: context,
            builder: (BuildContext context){
              return AlertDialog(
                title: new Text(city_name),
                content: new charts.BarChart(
                  _createDataForChart(key, city_name),
                  animate: true,
                  behaviors: [new charts.PanAndZoomBehavior()],
                ),
                actions: <Widget>[
                  new FlatButton(onPressed: (){
                        Navigator.of(context).pop();
                      },
                      child: new Text("Kapat"))
                ],
              );
            });
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

  Widget _createRowWidget(int index, String text, Color colorRow){
    var assetText = "";
    if(colorRow == color.upCash)
      assetText = "down_arrow";
    else if(colorRow == color.downCash)
      assetText = "up_arrow";
    else
      assetText = "right_arrow";
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
            _createRowText(text, index, colorRow),
            Image.asset("assets/arrow/${assetText}.png",scale: 4,),
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
class priceChart {
  final String date;
  final int price;

  priceChart(this.date, this.price);
}

class priceDetail extends StatelessWidget {
  var keyStr = "";
  var city_name = "";
  priceDetail(this.keyStr, this.city_name);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(city_name),
        ),
        body: LayoutBuilder(builder:
            (BuildContext context, BoxConstraints viewportConstraints) {
          return new charts.BarChart(
              _createDataForChart(keyStr, city_name),
              animate: false);
        }));
  }
  List<charts.Series<priceChart,String>> _createDataForChart(String key,String city_name){
    List<priceChart> data = new List();
    for(var item in ListForDB.price){
      if("[<'${item.cat_code}'>]" == key){
        if(item.history!=null)
          for(var historyItem in item.history){
            if(appCommon.city[int.parse(historyItem.city_code)-1].compareTo(city_name) == 0){
//              print("<><>>>${historyItem.date}");
              for(var priceItem in historyItem.date){
                data.add(new priceChart(priceItem.rec_date, int.parse(priceItem.price)));
              }
              break;
            }
          }
      }
    }
    print("<><>>Data-> $data");
    return [
      new charts.Series<priceChart, String>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (priceChart sales, _) => sales.date,
        measureFn: (priceChart sales, _) => sales.price,
        data: data,
      )
    ];
  }
}
