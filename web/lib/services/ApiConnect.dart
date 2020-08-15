import 'dart:async';
import 'package:http/http.dart' as http;

class ApiConnect {
  var _baseUrl = 'http://127.0.0.1';
  Future<void> getSensor() async {
    var request = await http.get('$_baseUrl/sensor');
    try {
      print(request.body);
    } catch (e) {
      print('gagal');
    }
  }
}
