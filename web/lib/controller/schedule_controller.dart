import 'package:get/get.dart';

class ScheduleController extends GetxController {
  List<String> date = [];
  List<String> time = [];
  List<int> classStatus = [];
  List<int> isOn = [];
  List<int> waktu = [];
  void updateSchedule(List<dynamic> timestamp) {
    date.clear();
    time.clear();
    var now = DateTime.now().millisecondsSinceEpoch;
    timestamp.forEach((element) {
      if (element['timestamp'] > now) {
        var _time = DateTime.fromMillisecondsSinceEpoch(element['timestamp'])
            .toLocal()
            .toString()
            .split(' ');
        date.add(_time[0]);
        time.add(_time[1].split('.')[0]);
        isOn.add(element['state']);
        waktu.add(element['timestamp']);
      }
    });
    date = date.reversed.toList();
    time = time.reversed.toList();
    isOn = isOn.reversed.toList();
    waktu = waktu.reversed.toList();
    // print(timestamp.runtimeType);
    update();
  }
}
