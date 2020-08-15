import 'package:get/get.dart';

class SensorController extends GetxController {
  var temp = 0;
  var hum = 0;
  var press = 0;
  var air = 0;
  var remain = 0.obs;
  updateDisplay(int _temp, int _hum, int _press, int _air) {
    temp = _temp;
    hum = _hum;
    press = _press;
    air = _air;
    update();
  }

  void updateTime() {
    remain.update((value) {
      value = 100;
    });
  }
}
