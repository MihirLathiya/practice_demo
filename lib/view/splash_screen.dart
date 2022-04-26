import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practice_demo/view/bottom_bar.dart';
import 'package:practice_demo/view/home_screen.dart';
import 'package:practice_demo/view/register_screen/registration_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? dataInfo;
  Timer? timer;
  @override
  void initState() {
    getData().whenComplete(
      () => Timer(
        const Duration(seconds: 3),
        () {
          dataInfo == null
              ? Get.off(
                  () => const RegistrationScreen(),
                )
              : Get.off(
                  () => BottomBar(),
                );
        },
      ),
    );
    super.initState();
  }

  Future getData() async {
    SharedPreferences data = await SharedPreferences.getInstance();
    var info1 = data.getString('email');
    setState(
      () {
        dataInfo = info1;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.blue.shade100,
                Colors.white,
                Colors.white,
                Colors.white,
                Colors.tealAccent.shade100
              ],
            ),
          ),
          child: Center(
            child: Image.asset(
              'assets/images/logo.png',
              height: 120,
              width: 120,
            ),
          ),
        ),
      ),
    );
  }
}
