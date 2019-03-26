import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthPhone{
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static String phoneNo;
  static String smsCode;
  static String verificationId;
  static bool bVerfySuccess = false;
  static bool bCodeSent = false;
  static bool bHandleEx = false;
  static Future<void> verifyPhone(String number) async {
    phoneNo = number;

    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId){
      verificationId = verId;
    };

    final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]){
      verificationId = verId;
      bCodeSent = true;
      print('Kod Gonderildi');
    };

    final PhoneVerificationCompleted verfiedSuccess = (FirebaseUser){
      print('Kayıt Olundu');
      bVerfySuccess = true;
    };
    final PhoneVerificationFailed verfiedFailed = (AuthException ex){
      print('|>|>||>${ex.message}');
      bHandleEx = true;

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