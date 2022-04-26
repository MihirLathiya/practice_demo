import 'package:http/http.dart' as http;

import '../model/all_user_model.dart';

class UserService {
  static Future userInfo() async {
    http.Response response = await http.get(
      Uri.parse('https://codelineinfotech.com/student_api/User/allusers.php'),
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return allUserModelFromJson(jsonString);
    }
  }
}
