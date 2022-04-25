import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practice_demo/common_widgets/text.dart';
import 'package:practice_demo/controller/gender_controller.dart';

class GenderSelection extends StatelessWidget {
  List<String> genderList = ['Men', 'Female'];
  GenderController genderController = Get.put(GenderController());

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Ts(
          text: 'Gender',
          color: Colors.grey.shade600,
          size: 17,
        ),
        Row(
          children: [
            ...List.generate(
              genderList.length,
              (index) => GestureDetector(
                onTap: () {
                  genderController.genderState(index);
                },
                child: SizedBox(
                  height: 20,
                  width: 100,
                  child: Row(
                    children: [
                      Obx(
                        () => Container(
                          height: 15,
                          width: 15,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            shape: BoxShape.circle,
                            border: Border.all(
                              width:
                                  genderController.genderSelect.value == index
                                      ? 3.5
                                      : 0,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Ts(
                        text: genderList[index],
                        color: Colors.grey.shade600,
                        size: 17,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
