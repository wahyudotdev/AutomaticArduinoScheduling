import 'package:get/get.dart';

class RelayController extends GetxController {
  var relay1 = 0;
  var relay2 = 0;
  var relay3 = 0;
  var relay4 = 0;
  updateState(int relayId, int state) {
    switch (relayId) {
      case 1:
        relay1 = state;
        break;
      case 2:
        relay2 = state;
        break;
      case 3:
        relay3 = state;
        break;
      case 4:
        relay4 = state;
        break;
      default:
    }
    update();
  }
}
