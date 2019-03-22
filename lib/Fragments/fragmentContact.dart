import 'package:flutter/material.dart';
import 'package:demir/controller/controllerContact.dart';
import 'package:demir/Utils/commonUtils.dart';
import 'package:demir/controller/enums/enums.dart';

class FragmentContact extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  final controllerContact controller = new controllerContact(context);
    // TODO: implement build
    return new Center(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width / 5.10,
                  padding:
                      const EdgeInsets.only(right: 16.0, left: 16, top: 30),
                  decoration: new BoxDecoration(
                      image: new DecorationImage(
                          image: AssetImage(
                            "assets/logo.png",
                          ),
                          fit: BoxFit.fitWidth)))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: FlatButton(
                  padding: const EdgeInsets.only(right: 16.0, left: 16, top: 8),
                  textColor: Colors.black,
                  splashColor: Colors.red,
                  color: Colors.transparent,
                  onPressed: () => controller.LaunchUrl(enumsURL.PHONE),
                  child: new Row(
                    children: <Widget>[
                      Image.asset(
                        "assets/callphone.png",
                        scale: 1.2,
                      ),
                      Expanded(
                        child: Text(
                          '${appCommon.landPhone}',
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: FlatButton(
                  padding: const EdgeInsets.only(right: 16.0, left: 16, top: 8),
                  textColor: Colors.black,
                  splashColor: Colors.red,
                  color: Colors.transparent,
                  onPressed: () => controller.LaunchUrl(enumsURL.LOCATION),
                  child: new Row(
                    children: <Widget>[
                      Image.asset(
                        "assets/location.png",
                        scale: 1.2,
                      ),
                      Expanded(
                        child: Text(
                          '${appCommon.address}',
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: FlatButton(
                  padding: const EdgeInsets.only(right: 16.0, left: 16, top: 8),
                  textColor: Colors.black,
                  splashColor: Colors.red,
                  color: Colors.transparent,
                  onPressed: () => controller.LaunchUrl(enumsURL.MAIL),
                  child: new Row(
                    children: <Widget>[
                      Image.asset(
                        "assets/mail.png",
                        scale: 1.2,
                      ),
                      Expanded(
                        child: Text(
                          '${appCommon.mail}',
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: FlatButton(
                  padding: const EdgeInsets.only(right: 16.0, left: 16, top: 8),
                  textColor: Colors.black,
                  splashColor: Colors.red,
                  color: Colors.transparent,
                  onPressed: () => print("fax"),
                  child: new Row(
                    children: <Widget>[
                      Image.asset(
                        "assets/fax.png",
                        scale: 1.2,
                      ),
                      Expanded(
                        child: Text(
                          '${appCommon.fax}',
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

}
