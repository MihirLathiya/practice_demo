import 'package:get/get.dart';

class BottomController extends GetxController {
  var selectBottomMenu = 0.obs;

  selectMenu(int index) {
    selectBottomMenu.value = index;
  }
}
