import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:demir/Firebase/FirebaseAuth.dart';

class FragmentLogin extends StatelessWidget {
  final formKey = new GlobalKey<FormState>();
  String phoneNumber = '';
  RaisedButton signButton;
  bool validateAndSave() {
    var form = formKey.currentState;
    print('$form');
    if (form.validate()) {
      form.save();
      return true;
    }
    else
      return false;
  }

  validateAndSubmit(BuildContext context) {
    if (validateAndSave()) {
      FirebaseAuthPhone.verifyPhone(phoneNumber);
      while(true){
        if(FirebaseAuthPhone.bCodeSent){
          smsCodeDialog(context).then((value){
            print('val->>>$value');
          });
          //break;
        }
        if(FirebaseAuthPhone.bHandleEx){
          Scaffold.of(context).showSnackBar(new SnackBar(content: new Text("Bir Hata Oluştu Tekrar Deneyin!.",textAlign: TextAlign.center,)));
          break;
        }
        if(FirebaseAuthPhone.bVerfySuccess){
          Navigator.of(context).pushReplacementNamed('/Pages/homePage');
          break;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(16.0),
          child: new Form(
            key: formKey,
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
                new RaisedButton(onPressed: validateAndSubmit(context),
                  child: new Text(
                    'Kayıt Ol', style: new TextStyle(fontSize: 20),),),

              ],
            ),
          ),
        )
      ],
    );
  }

  Future<bool> smsCodeDialog(BuildContext context) {
    bool verify = false;
    verifyDone() {
      verify = FirebaseAuthPhone.verifyDone() as bool;
      if (verify) {
        Navigator.of(context).pop();
      }
    }
    return showDialog(context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: Text('Gelen Onay Kodunu Giriniz.'),
            content: TextField(
              onChanged: (value) {
                FirebaseAuthPhone.smsCode = value;
              },
            ),
            contentPadding: EdgeInsets.all(10.0),
            actions: <Widget>[
              new FlatButton(
                child: Text('Onayla'),
                onPressed: verifyDone,
              )
            ],
          );
        }
    );
  }
}
