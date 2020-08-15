import 'package:get/get.dart';

class WarningController extends GetxController {
  var remaining = 'Menghubungkan . .';
  var _remainTime;
  remainTime(int timestamp) {
    if (timestamp > 0) {
      var diff = timestamp - DateTime.now().millisecondsSinceEpoch;
      _remainTime = DateTime.fromMillisecondsSinceEpoch(diff).minute + 1;
      if (_remainTime < 2)
        remaining = 'Kelas akan segera dimulai';
      else
        remaining = 'Kelas selanjutnya dalam ${_remainTime.toString()} menit';
    } else
      remaining = 'Kelas Dimulai';
    update();
  }
}
