import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practice_demo/common_widgets/text_field.dart';
import 'package:practice_demo/services/email_auth_services.dart';
import 'package:practice_demo/view/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogInScreen extends StatefulWidget {
  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final _password = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final _email = TextEditingController();

  bool showPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TsField(
              hide: false,
              action: TextInputAction.next,
              controller: _email,
              hintText: 'Email',
              validator: (value) {
                if (value.isEmpty) {
                  return 'Enter Email';
                }
              },
            ),
            const SizedBox(
              height: 8,
            ),
            TsField(
              hide: showPassword,
              action: TextInputAction.done,
              controller: _password,
              hintText: 'Password',
              validator: (value) {
                if (value.isEmpty) {
                  return 'Enter Password';
                }
              },
              icon: showPassword ? Icons.visibility : Icons.visibility_off,
              onPress: () {
                setState(
                  () {
                    showPassword = !showPassword;
                  },
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () async {
                if (_formKey.currentState!.validate()) {
                  bool status = await FireBaseService.logInService(
                      email: _email.text, password: _password.text);
                  if (status == true) {
                    SharedPreferences setData =
                        await SharedPreferences.getInstance();
                    setData.setString('email', _email.text).then(
                          (value) => Get.off(
                            () => HomeScreen(),
                          ),
                        );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Invalid Email & Paaword'),
                      ),
                    );
                  }
                }
              },
              child: Container(
                height: 55,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  gradient: LinearGradient(
                    colors: [
                      Colors.teal.shade300,
                      Colors.teal.shade300,
                      Colors.green.shade300
                    ],
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Submit',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // void getData() async {
  //   SharedPreferences userData = await SharedPreferences.getInstance();
  //
  //   bool status = await FireBaseService.logInService(
  //     email: _email.text,
  //     password: _password.toString(),
  //   );
  //   if (status == true) {
  //     userData.setString('email', _email.text);
  //     Get.off(() => const HomeScreen());
  //   }
  // }
}
