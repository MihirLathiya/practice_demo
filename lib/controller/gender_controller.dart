import 'package:get/get.dart';

class GenderController extends GetxController {
  var genderSelect = 0.obs;

  genderState(int index) {
    genderSelect.value = index;
  }
}
