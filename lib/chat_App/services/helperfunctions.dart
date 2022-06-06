import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions{

static String sharedPreferenceUserLogin = "ISLoggedIN";
static String sharedPreferenceUserNameKey = "usernameKey";
static String sharedPreferenceUserEmailKey = "userEmailKey";
//setters
static Future<bool> savinguserLoggedInToSharedPreference(bool isLoggedin) async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return await prefs.setBool( sharedPreferenceUserLogin , isLoggedin);
}

static Future<bool> savinguserUserNameInToSharedPreference(String username) async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return await prefs.setString( sharedPreferenceUserNameKey , username);
}
static Future<bool> savinguserEmailInToSharedPreference(String email) async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return await prefs.setString( sharedPreferenceUserEmailKey , email );
}

//getters

static Future<bool?> getuserLoggedInToSharedPreference() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return await prefs.getBool(sharedPreferenceUserLogin);
}
static Future<String?> getuserUserNameInToSharedPreference() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return await prefs.getString( sharedPreferenceUserNameKey);
}
static Future<String?> getuserUserEmailInToSharedPreference() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return await prefs.getString( sharedPreferenceUserEmailKey);
}

}