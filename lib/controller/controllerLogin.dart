import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:demir/Utils/commonUtils.dart';
import 'package:demir/Firebase/FirebaseCommon.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:demir/Utils/SharedPreferences.dart';
class ControllerLogin {
  var context;

  ControllerLogin(BuildContext context){
    this.context = context;
  }
  String phoneNo;
  String smsCode;
  String verificationId;
  Future<void> verifyPhone(String number) async {
    phoneNo = number;
    print("$phoneNo");
    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId){
      verificationId = verId;
    };

    final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]){
      verificationId = verId;
      smsCodeDialog(context);
    };

    final PhoneVerificationCompleted verfiedSuccess = (FirebaseUser){
      print('Kayıt Olundu');
    };
    final PhoneVerificationFailed verfiedFailed = (AuthException ex){
      Scaffold.of(context).showSnackBar(new SnackBar(content: new Text("Bir Hata Oluştu İnternet Bağlantınızı Kontrol Edin.",textAlign: TextAlign.center,)));
      print('<><>Ex ${ex.message}');
    };
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+90$phoneNo',
        timeout: const Duration(minutes: 1),
        verificationCompleted: verfiedSuccess,
        verificationFailed: verfiedFailed,
        codeSent: smsCodeSent,
        codeAutoRetrievalTimeout: autoRetrieve);
    print("<><>>>End");

  }
  static Future<bool> verifyDone() async{
    await FirebaseAuth.instance.currentUser().then((user){
      if(user != null)
        return true;
      else
        return false;
    });
  }

}
Future<bool> smsCodeDialog(BuildContext context) {
  final _infoText = TextEditingController();
  final _text = TextEditingController();
  bool _textValidate = false;
  signIn() async{
    await FirebaseAuth.instance.currentUser().then((user){
      if(user != null)
        return true;
      else
        return false;
    });
  }
  Future<bool> verifyDone() async{
    if(_text.text.isNotEmpty){
      await FirebaseAuth.instance.currentUser().then((user){
        Navigator.of(context).pop();
        if(user != null){
          SharedPref pref = SharedPref();
          pref.writeBool("LogIn", true);
          Navigator.of(context).pushNamed('/homepage');
        }
        else{
          Scaffold.of(context).showSnackBar(new SnackBar(content: new Text("Gelen Kodu Kontrol Edin.",textAlign: TextAlign.center,)));

        }
      });
    }
  }
  return showDialog(context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new AlertDialog(
          title: Text('Gelen Onay Kodunu Giriniz.'),
          content: TextFormField(
            keyboardType: TextInputType.number,
            controller: _text,
            decoration:  InputDecoration(
              labelText: 'Kod',
              errorText: _textValidate ? null : 'Kod Alanı Boş Bırakılamaz.'
            ),
            validator: (value) =>
            value.isEmpty
                ? 'Kod Alanı Boş Bırakılamaz.'
                : null,
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