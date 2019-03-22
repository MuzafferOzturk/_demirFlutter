import 'package:flutter/material.dart';
import 'package:demir/controller/controllerInstallment.dart';
class FragmentInstallment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    controllerInstallment controller = new controllerInstallment(context);
    return new Center(
      child: new ListView.builder(
        padding: EdgeInsets.all(8),
        itemCount: controller.drawerItems.length+1,
        itemBuilder: (context, position) {
          if(position==0){
            return new Text("Taksit Seçenekleri",textAlign: TextAlign.center,style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),);
          }
          position--;
          var draw = controller.drawerItems[position];
          return new ListTile(
            contentPadding: EdgeInsets.only(left: 8,right: 8,top: 15,bottom: 15),
            leading: draw.icon,
            title: new Text(draw.title, textAlign: TextAlign.right,style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          );
        },
      ),
    );
  }
}