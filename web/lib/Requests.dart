import 'dart:html';
import 'dart:io';
// import 'package:http/browser_client.dart' as http;
import 'package:http/http.dart' as http;
// import 'package:sky_engine/_http/http.dart' as http;
class Requests{
  Future<void> get()async{
  http.Response response = await http.get(Uri.encodeFull("http://127.0.0.1:3000/test"),
  headers: {"Accept":"application/json","Access-Control-Request-Headers":"Content-Type"});
  print(response.statusCode);
  // if (response.statusCode == 200) {
  //   print('Number of books about http: ${response.body}.');
  // } else {
  //   print('Request failed with status: ${response.statusCode}.');
  // }
  }
}