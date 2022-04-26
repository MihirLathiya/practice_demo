import 'package:get/get.dart';
import 'package:practice_demo/services/user_services.dart';

import '../model/all_user_model.dart';

class UserController extends GetxController {
  var isLoading = true.obs;
  AllUserModel? userInfo;
  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  void fetchData() async {
    isLoading(true);
    try {
      var info = await UserService.userInfo();
      if (info != null) {
        userInfo = info;
      }
    } finally {
      isLoading(false);
    }
  }
}
