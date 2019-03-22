import 'package:flutter/material.dart';
import 'package:demir/controller/controllerBid.dart';
import 'package:demir/Utils/commonUtils.dart';
import 'package:demir/controller/enums/enums.dart';


class FragmentBid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  final controllerBid controller = new controllerBid(context);
    return Center(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: FlatButton(
                  padding: const EdgeInsets.only(right: 16.0, left: 50, top: 20, bottom: 20),
                  textColor: Colors.black,
                  splashColor: Colors.red,
                  color: Colors.transparent,
                  onPressed: () => controller.LaunchUrl(enumsURL.WHATSPP),
                  child: new Row(
                    children: <Widget>[
                      Image.asset(
                        "assets/bid/whatsapp.png",
                        scale: 1.2,
                      ),
                      Expanded(
                        child: Text(
                          'WHATSAPP',
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
                  padding: const EdgeInsets.only(right: 16.0, left: 50, top: 20, bottom: 20),
                  textColor: Colors.black,
                  splashColor: Colors.red,
                  color: Colors.transparent,
                  onPressed: () => controller.LaunchUrl(enumsURL.MAIL),
                  child: new Row(
                    children: <Widget>[
                      Image.asset(
                        "assets/bid/mail.png",
                        scale: 1.2,
                      ),
                      Expanded(
                        child: Text(
                          'E-MAİL',
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
                  padding: const EdgeInsets.only(right: 16.0, left: 50, top: 20, bottom: 20),
                  textColor: Colors.black,
                  splashColor: Colors.red,
                  color: Colors.transparent,
                  onPressed: () => controller.LaunchUrl(enumsURL.PHONE),
                  child: new Row(
                    children: <Widget>[
                      Image.asset(
                        "assets/bid/call.png",
                        scale: 1.2,
                      ),
                      Expanded(
                        child: Text(
                          'TELEFON',
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
                  padding: const EdgeInsets.only(right: 16.0, left: 50, top: 20, bottom: 20),
                  textColor: Colors.black,
                  splashColor: Colors.red,
                  color: Colors.transparent,
                  onPressed: () => controller.LaunchUrl(enumsURL.SMS),
                  child: new Row(
                    children: <Widget>[
                      Image.asset(
                        "assets/bid/sms.png",
                        scale: 1.2,
                      ),
                      Expanded(
                        child: Text(
                          'SMS',
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