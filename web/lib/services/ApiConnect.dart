import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:web/controller/SensorController.dart';

class ApiConnect {
  var _baseUrl = 'http://localhost:3000';
  Future<void> getSensor() async {
    var request = await http.get('$_baseUrl/sensor');
    try {
      var body = request.body;
      int _temp = json.decode(body)[0]['temp'];
      int _hum = json.decode(body)[0]['hum'];
      int _press = json.decode(body)[0]['press'];
      int _air = json.decode(body)[0]['air'];
      Get.find<SensorController>().updateDisplay(_temp, _hum, _press, _air);
    } catch (e) {
      print('gagal');
    }
  }

  Future<void> addSchedule(DateTime time) async {
    int timestamp = time.millisecondsSinceEpoch;
    await http.post('$_baseUrl/jadwal',
                                    headers: <String, String>{
                                      'Content-Type': 'application/json; charset=UTF-8',
                                    },
                                    body: jsonEncode({'timestamp':timestamp})
    );
  }
}
