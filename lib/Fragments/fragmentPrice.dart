import 'package:flutter/material.dart';
import 'package:demir/controller/controllerPrice.dart';
import 'package:demir/Utils/color.dart';

class FragmentPrice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    controllerPrice controller = new controllerPrice(context);
    final tabBar = controller.createTabBar();
    final tabBarView = controller.createTabBarView();
    // TODO: implement build
    return new DefaultTabController(
      length: 4,
      child: new Scaffold(
      appBar: new AppBar(
        actions: <Widget>[],
        backgroundColor: Colors.indigo,
        title: tabBar
        ),
        body: new TabBarView(
        children: tabBarView,
        )
      )
    );
  }
}