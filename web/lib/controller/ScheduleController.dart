import 'package:get/get.dart';

class ScheduleController extends GetxController {
  List<String> date;
  List<String> time;

  void updateSchedule(int timestamp) {
    date.clear();
    time.clear();
    var _time = DateTime.fromMillisecondsSinceEpoch(timestamp)
        .toLocal()
        .toString()
        .split('.');
    date.add(_time[0]);
    time.add(_time[1]);
    update();
  }
}
