import 'package:flutter/material.dart';
import 'package:demir/controller/controllerTechnic.dart';

class FragmentTechnic extends StatelessWidget {
  ControllerTechnic controller;
  @override
  Widget build(BuildContext context) {
    controller = new ControllerTechnic(context);
    // TODO: implement build
    return new Center(
      child: new Text("fragmentTechnic"),
    );
  }
}