import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:web/controller/RelayController.dart';
import 'package:web/controller/ScheduleController.dart';
import 'package:web/controller/SensorController.dart';
import 'package:web/controller/WarningController.dart';

class ApiConnect {
  var _baseUrl = 'http://localhost:3000';
  Future<void> getSensor() async {
    try {
      var request = await http.get('$_baseUrl/sensor');
      var body = request.body;
      int _temp = json.decode(body)[0]['temp'];
      int _hum = json.decode(body)[0]['hum'];
      int _press = json.decode(body)[0]['press'];
      int _air = json.decode(body)[0]['air'];
      Get.find<SensorController>().updateDisplay(_temp, _hum, _press, _air);
    } catch (e) {
      print('gagal refresh data');
    }
  }

  // Schedule
  Future<void> getSchedule() async {
    await http.get('$_baseUrl/jadwal').then((value) {
      List<dynamic> timestamp = json.decode(value.body);
      Get.find<ScheduleController>().updateSchedule(timestamp);
    });
  }

  Future<void> addSchedule(DateTime time, String state) async {
    int timestamp = time.millisecondsSinceEpoch;
    await http.post('$_baseUrl/jadwal?state=$state',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'timestamp': timestamp}));
    await getSchedule();
  }

  Future<void> deleteSchedule(int timestamp) async {
    await http
        .get('$_baseUrl/hapusjadwal?timestamp=$timestamp')
        .then((value) async => await getSchedule());
  }

  Future<void> checkSchedule() async {
    try {
      await http.get('$_baseUrl/cekjadwal').then((value) {
        int timestamp = json.decode(value.body)[0]['timestamp'];
        Get.find<WarningController>().remainTime(timestamp);
      });
    } catch (e) {
      Get.find<WarningController>().remainTime(0);
    }
  }

  Future<void> setRelay(int relayId) async {
    try {
      await http.get('$_baseUrl/startrelay?id=relay$relayId').then((value) =>
          Get.find<RelayController>()
              .updateState(relayId, int.parse(value.body)));
    } catch (e) {
      print('gagal update relay');
    }
  }

  Future<void> getRelay() async {
    try {
      for (int i = 1; i < 5; i++) {
        await http.get('$_baseUrl/relay?id=relay$i').then((value) {
          Get.find<RelayController>().updateState(i, int.parse(value.body));
        });
      }
    } catch (e) {
      print('gagal');
    }
  }

  Future<void> allPowerOff() async {
    await http.get('$_baseUrl/poweroff').then((value) {
      if (value.body.contains('OK')) {
        for (int i = 1; i < 5; i++) {
          Get.find<RelayController>().updateState(i, 0);
        }
      }
    });
  }
}
