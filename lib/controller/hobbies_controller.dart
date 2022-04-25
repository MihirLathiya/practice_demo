import 'package:get/get.dart';

class HobbiesController extends GetxController {
  var hobbiesSelect = true.obs;
  var hobbiesSelect1 = true.obs;

  hobbiesState() {
    hobbiesSelect.value = !hobbiesSelect.value;
  }

  hobbiesState1() {
    hobbiesSelect1.value = !hobbiesSelect1.value;
  }
}
