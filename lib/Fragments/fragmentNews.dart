import 'package:flutter/material.dart';
import 'package:demir/controller/controllerNews.dart';
import 'package:demir/Fragments/fragmentPrice.dart';

class FragmentNews extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    controllerNews controller = new controllerNews(context);
    // TODO: implement build
    return new Center(
      child: new ListView.builder(
        padding: EdgeInsets.all(8),
        itemCount: controller.drawerItems.length + 1,
        itemBuilder: (context, position) {
          if (position == 0) {
            return new Text(
              "Haberler",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            );
          }
          position--;
          var draw = controller.drawerItems[position];
          return new ListTile(
              contentPadding:
                  EdgeInsets.only(left: 8, right: 8, top: 15, bottom: 15),
              leading: draw.icon,
              title: new Text(
                draw.title,
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: new Text(
                draw.subTitle,
                textAlign: TextAlign.left,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => newsDetail(draw.title, draw.subTitle))));
        },
      ),
    );
  }
}

class newsDetail extends StatelessWidget {
  var title = "";
  var subTitle = "";
  newsDetail(this.title, this.subTitle);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Haberler"),
        ),
        body: LayoutBuilder(builder:
            (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints:
                  BoxConstraints(minWidth: viewportConstraints.maxHeight),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      this.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width - 20,
                          child: Text(this.subTitle,textAlign: TextAlign.left, style: TextStyle(fontSize: 18),
//                            maxLines: (MediaQuery.of(context).size.height / Theme.of(context).textTheme.body1.fontSize).floor() -3,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }));
  }
}
