import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:demir/controller/controllerLogin.dart';
import 'package:demir/Utils/commonUtils.dart';
import 'package:demir/Utils/SharedPreferences.dart';
class FragmentLogin extends StatelessWidget {
  var context;
  ControllerLogin controller;
  String phoneNumber = '';
  RaisedButton signButton;
  bool validateAndSave() {
    var form = appCommon.formKey.currentState;
    print('$form');
    if (form.validate()) {
      form.save();
      return true;
    }
    else
      return false;
  }
  validateAndSubmit() {
    if (validateAndSave()) {
      controller.verifyPhone(phoneNumber);
//      SharedPref pref = SharedPref();
//      pref.writeBool("LogIn", true);
//      Navigator.of(context).pushNamed('/homepage');
    }
  }
  @override
  Widget build(BuildContext context) {
    this.context = context;
    controller = new ControllerLogin(context);
    // TODO: implement build
    return new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(16.0),
              child: new Form(
                key: appCommon.formKey,
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    new TextFormField(
                      decoration: InputDecoration(labelText: 'Ad - Soyad'),
                      validator: (value) =>
                      value.isEmpty
                          ? 'Ad - Soyad Alanı Boş Bırakılamaz.'
                          : null,
                    ),
                    new TextFormField(
                      decoration: InputDecoration(labelText: 'Firma'),
                      validator: (value) =>
                      value.isEmpty
                          ? 'Firma Alanı Boş Bırakılamaz.'
                          : null,
                    ),
                    new TextFormField(
                      decoration: InputDecoration(labelText: 'Mail'),
                      validator: (value) =>
                      value.isEmpty
                          ? 'Mail Alanı Boş Bırakılamaz.'
                          : null,
                    ),
                    new TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: 'Telefon ( Numaranızı 10 Hane Olarak Giriniz.)'),
                      validator: (value) =>
                      value.isEmpty
                          ? 'Telefon Alanı Boş Bırakılamaz.'
                          : null,
                      onSaved: (value)=> phoneNumber = value,
                      inputFormatters: <TextInputFormatter>[
                        LengthLimitingTextInputFormatter(10),
                        WhitelistingTextInputFormatter.digitsOnly,
                      ],
                    ),
                    new RaisedButton(onPressed: validateAndSubmit,
                      child: new Text(
                        'Kayıt Ol', style: new TextStyle(fontSize: 20),),),
                  ],
                ),
              ),
            )
          ],
    );
  }
}
