import 'package:get/get.dart';

class WarningController extends GetxController {
  var remaining = 'Tidak ada jadwal';
  var _remainTime;
  remainTime(int timestamp, int state) {
    int now = DateTime.now().millisecondsSinceEpoch;
    int diff = ((timestamp - now) / 1000).round();
    switch (state) {
      case 0:
        if (diff < 5)
          remaining = 'Kelas telah berakhir';
        else if (diff >= 5 && diff < 300)
          remaining = 'Kelas berakhir dalam $diff s';
        break;
      case 1:
        if (diff < 5)
          remaining = 'Kelas dimulai';
        else if (diff >= 5 && diff < 300)
          remaining = 'Kelas dimulai dalam $diff s';
        break;
      default:
        remaining = remaining;
    }
    update();
  }
}
