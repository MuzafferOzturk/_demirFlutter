import 'package:flutter/material.dart';
import 'package:demir/controller/controllerShipping.dart';

class FragmentShipping extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    controllerShipping controller = controllerShipping(context);
    return new SingleChildScrollView(
      child: new Center(
        child: new Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(5.0),
              child: Text("BİGA ÇIKIŞLI NAKLİYE FİYATLARI",
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
              ),
            ),
            new SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child:new Column(
                  children: controller.createDataColumnAndRows("BİGA")
              ),
            ),
            Container(
              padding: EdgeInsets.all(5.0),
              child: Text("KARABÜK ÇIKIŞLI NAKLİYE FİYATLARI",
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
              ),
            ),
            new SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child:new Column(
                  children: controller.createDataColumnAndRows("BİGA")
              ),
            ),
            Container(
              padding: EdgeInsets.all(5.0),
              child: Text("İZMİR ÇIKIŞLI NAKLİYE FİYATLARI",
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
              ),
            ),
            new SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child:new Column(
                  children: controller.createDataColumnAndRows("BİGA")
              ),
            ),
            Container(
              padding: EdgeInsets.all(5.0),
              child: Text("PAYAS ÇIKIŞLI NAKLİYE FİYATLARI",
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
              ),
            ),
            new SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child:new Column(
                  children: controller.createDataColumnAndRows("BİGA")
              ),
            ),
          ],
        ),
      ),
    );
  }
}