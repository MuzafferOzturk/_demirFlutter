import 'package:demir/Fragments/fragmentBid.dart';
import 'package:demir/Fragments/fragmentContact.dart';
import 'package:demir/Fragments/fragmentInstallment.dart';
import 'package:demir/Fragments/fragmentNews.dart';
import 'package:demir/Fragments/fragmentPrice.dart';
import 'package:demir/Fragments/fragmentShipping.dart';
import 'package:demir/Fragments/fragmentTechnic.dart';
import 'package:demir/Utils/color.dart';
import 'package:flutter/material.dart';
import 'package:demir/Firebase/FirebaseMain.dart';
import 'package:demir/Utils/commonUtils.dart';

class drawerItem{
  String title;
  Image icon;
  drawerItem(this.title,this.icon);
}

class homePage extends StatefulWidget{
  final drawerItems = [
    new drawerItem("Ana Menu", new Image.asset("assets/price.png", scale: 10.0,),),
    new drawerItem("Haberler", new Image.asset("assets/news.png", scale: 10.0,)),
    new drawerItem("Teklif Al",new Image.asset("assets/bidImage.png", scale: 10.0,)),
    new drawerItem("Taksit Seçenekleri", new Image.asset("assets/installment.png", scale: 10.0,)),
    new drawerItem("Nakliye Fiyatları", new Image.asset("assets/shipping.png", scale: 10.0,)),
    new drawerItem("Teknik Bilgiler",new Image.asset("assets/technic.png", scale: 10.0,)),
    new drawerItem("İletişim", new Image.asset("assets/contact.png", scale: 10.0,)),
  ];
  @override
  State createState() {
    return new homePageState();
  }
}

class homePageState extends State<homePage>{
  int _selectedDrawerIndex = 99;
  @override
  void initState(){
    super.initState();
    appCommon.firebaseInit().then((result){
      setState(() {
        _selectedDrawerIndex = 0;
      });
    });
  }
  _getDrawerItemWidget(int pos){
    switch(pos){
      case 0:
        return new FragmentPrice();
      case 1:
        return new FragmentNews();
      case 2:
        return new FragmentBid();
      case 3:
        return new FragmentInstallment();
      case 4:
        return new FragmentShipping();
      case 5:
        return new FragmentTechnic();
      case 6:
        return new FragmentContact();
      default:
        return new Center(child: SizedBox(width: MediaQuery.of(context).size.width/2,height: MediaQuery.of(context).size.width/2,child:CircularProgressIndicator(strokeWidth: 15,),),);
    }
  }
  _onSelectedItem(int index){
    setState(()=> _selectedDrawerIndex = index);
    Navigator.of(context).pop();
  }
  _refreshClidk() async{
    await appCommon.firebaseInit();
    setState(() {
      _selectedDrawerIndex = 0;
    });
  }
  ListTile refreshList;
  @override
  Widget build(BuildContext context) {
    var drawerOptions = <Widget>[];
    for(var i = 0; i<widget.drawerItems.length; i++){
      var draw = widget.drawerItems[i];
      drawerOptions.add(
        new ListTile(
          leading: draw.icon,
          title : new Text(draw.title),
          selected : i== _selectedDrawerIndex,
          onTap: ()=>_onSelectedItem(i),
        )
      );
    }
    return new Scaffold(
      appBar: new AppBar(
        title: new Image.asset("assets/logo.png"),
        actions: <Widget>[
          FloatingActionButton(
            child: new Container(
              child: new Image.asset("assets/refresh.png", scale: 1.5),
                decoration: BoxDecoration(
                    color: color.colorPrimaryDark
                )
            ),
            backgroundColor: color.colorPrimaryDark,
            onPressed: _refreshClidk,
          )
        ],
      ),
      drawer: new Drawer(
        child: new Column(
          children: <Widget>[
            new Container(
              height: MediaQuery.of(context).size.height/7,
              width: double.infinity,
              child: new DrawerHeader(child: new Image.asset("assets/logo.png"),
                decoration: BoxDecoration(
                  color: color.colorPrimaryDark
                ),
              )
            ),
            new Column(children: drawerOptions)
          ],
        )
      ),
      body: _getDrawerItemWidget(_selectedDrawerIndex),
    );
  }
}
