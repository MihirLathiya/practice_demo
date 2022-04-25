import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practice_demo/common_widgets/text.dart';
import 'package:practice_demo/controller/hobbies_controller.dart';

class HobbiesSelection extends StatelessWidget {
  HobbiesController hobbiesController = Get.put(HobbiesController());

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          children: [
            Ts(
              text: 'Hobbies',
              color: Colors.grey.shade600,
              size: 17,
            ),
            const SizedBox(
              width: 30,
            ),
            GestureDetector(
              onTap: () {
                hobbiesController.hobbiesState();
              },
              child: Row(
                children: [
                  Obx(
                    () => Container(
                      height: 16,
                      width: 16,
                      color: Colors.grey,
                      child: Align(
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.done,
                          color: Colors.white,
                          size: hobbiesController.hobbiesSelect.value ? 13 : 0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Ts(
                    text: 'Singing',
                    color: Colors.grey.shade600,
                    size: 17,
                  )
                ],
              ),
            ),
            const SizedBox(
              width: 30,
            ),
            GestureDetector(
              onTap: () {
                hobbiesController.hobbiesState1();
              },
              child: Row(
                children: [
                  Obx(
                    () => Container(
                      height: 16,
                      width: 16,
                      color: Colors.grey,
                      child: Align(
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.done,
                          color: Colors.white,
                          size: hobbiesController.hobbiesSelect1.value ? 13 : 0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Ts(
                    text: 'Dancing',
                    color: Colors.grey.shade600,
                    size: 17,
                  )
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
