import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:demir/Firebase/FirebaseMain.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:demir/Utils/SharedPreferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
class ControllerLogin {
  var context;

  ControllerLogin(BuildContext context){
    this.context = context;
  }
  String phoneNo;
  String smsCode;
  String verificationId;
  Future<void> verifyPhone(String number, String company, String mail, String name_surname) async {
    phoneNo = number;
    print("$phoneNo");
    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId){
      verificationId = verId;
    };

    final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]){
      Navigator.pop(context);
      verificationId = verId;
      smsCodeDialog(context, verificationId, company, mail, name_surname, number);
    };

    final PhoneVerificationCompleted verfiedSuccess = (FirebaseUser){
      print('Kayıt Olundu');
    };
    final PhoneVerificationFailed verfiedFailed = (AuthException ex){
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Bir Hata Oluştu. Tefon Numaranızı ve İnternet Bağlantınızı Kontrol Edin.",
          toastLength: Toast.LENGTH_LONG);
      //Scaffold.of(context).showSnackBar(new SnackBar(content: new Text("Bir Hata Oluştu İnternet Bağlantınızı Kontrol Edin.",textAlign: TextAlign.center,)));
      print('<><>Ex ${ex.message}');
    };
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+90$phoneNo',
        timeout: const Duration(minutes: 1),
        verificationCompleted: verfiedSuccess,
        verificationFailed: verfiedFailed,
        codeSent: smsCodeSent,
        codeAutoRetrievalTimeout: autoRetrieve);

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
Future<bool> smsCodeDialog(BuildContext context, String verificationId, String company, String mail, String name_surname, String phone) {
  final _infoText = TextEditingController();
  final _text = TextEditingController();
  bool _textValidate = false;

  Future<bool> verifyDone() async{
    if(_text.text.isNotEmpty){
      try{
        FirebaseAuth _auth = FirebaseAuth.instance;
        final AuthCredential credential = PhoneAuthProvider.getCredential(
          verificationId: verificationId,
          smsCode: _text.text,
        );
        final FirebaseUser user = await _auth.signInWithCredential(credential);
        final FirebaseUser currentUser = await _auth.currentUser();
        if(user.uid == currentUser.uid){
          Navigator.of(context).pop();
          SharedPref pref = SharedPref();
          pref.writeBool("LogIn", true);
          FirebaseMain.saveUser(company, mail, name_surname, phone);
          Navigator.of(context).pushReplacementNamed('/homepage');
        }
        else{
          Fluttertoast.showToast(msg: "Gelen Onay Kodunu Kontrol Ediniz.",
          toastLength: Toast.LENGTH_LONG);
//          Scaffold.of(context).showSnackBar(new SnackBar(content: new Text("Bir Hata Oluştu.\nTekrar Kod Almayı deneyin.",textAlign: TextAlign.center,)));
        }
      }
      catch(ex){
//        Scaffold.of(context).showSnackBar(new SnackBar(content: new Text("Bir Hata Oluştu.\nDaha Sonra Tekrar Deneyin",textAlign: TextAlign.center,)));
        if(ex.toString().indexOf("ERROR_INVALID_VERIFICATION_CODE")>=0){
          Fluttertoast.showToast(msg: "Gelen Onay Kodunu Kontrol Ediniz.",
              toastLength: Toast.LENGTH_LONG);
        }
        else{
          Navigator.of(context).pop();
          Fluttertoast.showToast(msg: "Bir Hata Oluştu.\nDaha Sonra Tekrar Deneyin.",
              toastLength: Toast.LENGTH_LONG);
        }
      }

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