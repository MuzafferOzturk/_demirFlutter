import 'package:flutter/material.dart';
import 'package:demir/Utils/commonUtils.dart';
import 'package:demir/Utils/SharedPreferences.dart';
import 'package:demir/Utils/color.dart';
import 'package:flutter/services.dart';
import 'package:demir/controller/controllerLogin.dart';


class loginPage extends StatefulWidget{

  @override
  State createState() {
    return new loginPageState();
  }
}


class loginPageState extends State<loginPage>{
  ControllerLogin controller;
  final _nameText = TextEditingController();
  final _mailText = TextEditingController();
  final _companyText = TextEditingController();
  String phoneNumber = '';

  @override
  void initState(){
    super.initState();
    SharedPref pref = new SharedPref();
    print("<><>>>>Pref ${pref.readBool("LogIn")}");
    pref.readBool("LogIn").then((value){
      if(value!= null && value){
        setState(() {
          print("<><>>>Val $value");
          Navigator.of(context).pushReplacementNamed('/homepage');
        });
      }
    });

  }
  bool _validateAndSave() {
    var form = appCommon.formKey.currentState;
    print('$form');
    if (form.validate()) {
      form.save();
      return true;
    }
    else
      return false;
  }
  _validateAndSubmit() {
    if (_validateAndSave()) {
      controller.verifyPhone(phoneNumber, _companyText.text, _mailText.text, _nameText.text);
//      SharedPref pref = SharedPref();
//      pref.writeBool("LogIn", true);
//      Navigator.of(context).pushNamed('/homepage');
    }
  }
  @override
  Widget build(BuildContext context) {
    controller = ControllerLogin(context);

    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: new AppBar(
        title: new Image.asset("assets/logo.png"),
      ),
      body: new Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top:50, right: 16, left: 16, bottom: 16),
            child: new Form(
              key: appCommon.formKey,
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  new TextFormField(
                    controller: _nameText,
                    decoration: InputDecoration(labelText: 'Ad - Soyad'),
                    validator: (value) =>
                    value.isEmpty
                        ? 'Ad - Soyad Alanı Boş Bırakılamaz.'
                        : null,
                  ),
                  new TextFormField(
                    controller: _companyText,
                    decoration: InputDecoration(labelText: 'Firma'),
                    validator: (value) =>
                    value.isEmpty
                        ? 'Firma Alanı Boş Bırakılamaz.'
                        : null,
                  ),
                  new TextFormField(
                    controller: _mailText,
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
                  new RaisedButton(onPressed: _validateAndSubmit,
                    child: new Text(
                      'Kayıt Ol', style: new TextStyle(fontSize: 20),),),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}