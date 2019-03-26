import 'package:shared_preferences/shared_preferences.dart';

class SharedPref{

  Future<bool>  readBool(String key) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("<><>>>>${prefs.getBool(key)}");
    if(prefs.getBool(key) == null)
      return false;
    else
      return prefs.getBool(key);
  }
  Future<bool> writeBool(String key, bool value) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
    return true;
  }
}