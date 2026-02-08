import 'package:flutter/cupertino.dart';
import 'package:gaushala/router.router.dart';
import 'package:shared_preferences/shared_preferences.dart';

getHeight(context) => (MediaQuery.of(context).size.height);

getWidth(context) => (MediaQuery.of(context).size.width);
String baseurl = 'https://goshala.erpkey.in';

String apiUploadFilePost = '$baseurl/api/method/upload_file';

const String apiurl =
    'https://api.openrouteservice.org/v2/directions/driving-car';
const String apiKey =
    '5b3ce3597851110001cf6248f55d7a31499e40848c6848d7de8fa624';
int? invoiceStatus = 0;
int? orderStatus = 0;
int? quotationStatus = 0;

getRouteUrl(String startPoint, String endPoint) {
  return Uri.parse('$apiurl?api_key=$apiKey&start=$startPoint&end=$endPoint');
}

///functions
Future<String> getToken() async {
  final Future<SharedPreferences> prefs0 = SharedPreferences.getInstance();
  final SharedPreferences prefs = await prefs0;
  String? apiSecret = prefs.getString("api_secret") ?? "";
  String? apiKey = prefs.getString("api_key") ?? "";
  String formattedString = 'token $apiKey:$apiSecret';
  return formattedString;
}

Future<String> getUrl() async {
  final Future<SharedPreferences> prefs0 = SharedPreferences.getInstance();
  final SharedPreferences prefs = await prefs0;
  String? url = prefs.getString("url") ?? "";
  return url;
}

void logout(BuildContext context) async {
  final Future<SharedPreferences> prefs0 = SharedPreferences.getInstance();
  final SharedPreferences prefs = await prefs0;
  prefs.clear();
  if (context.mounted) {
    Navigator.pushNamed(context, Routes.loginViewScreen);
  }
}
