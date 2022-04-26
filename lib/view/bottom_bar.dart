import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practice_demo/controller/bottom_controller.dart';
import 'package:practice_demo/view/home_screen.dart';
import 'package:practice_demo/view/update_profile.dart';

class BottomBar extends StatelessWidget {
  // const BottomBar({Key? key}) : super(key: key);

  BottomController bottomController = Get.put(BottomController());
  List menu = [
    Icons.home,
    Icons.favorite,
    Icons.book_rounded,
    Icons.notifications,
    Icons.person,
  ];
  List screens = [
    HomeScreen(),
    Container(),
    Container(),
    Container(),
    const UpadteProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 90,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, -2),
              color: Colors.grey.shade200,
              blurRadius: 10,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ...List.generate(
                menu.length,
                (index) => Obx(
                  () {
                    return InkWell(
                      onTap: () {
                        bottomController.selectMenu(index);
                      },
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor:
                            bottomController.selectBottomMenu.value == index
                                ? const Color(0xff03CDCD)
                                : Colors.transparent,
                        child: Icon(
                          menu[index],
                          size: 30,
                          color:
                              bottomController.selectBottomMenu.value == index
                                  ? Colors.white
                                  : Colors.grey,
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
      body: Obx(
        () => screens[bottomController.selectBottomMenu.value],
      ),
    );
  }
}
