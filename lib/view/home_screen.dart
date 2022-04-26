import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practice_demo/common_widgets/text.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:practice_demo/controller/user_controller.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue.shade100,
              Colors.grey.shade200,
              Colors.grey.shade200,
              Colors.greenAccent.shade100
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Header(),
            const SizedBox(
              height: 30,
            ),
            ServiceType(),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Ts(
                text: 'Popular Doctor',
                weight: FontWeight.w700,
                size: 18,
              ),
            ),
            const SizedBox(
              height: 18,
            ),
            DoctorData()
          ],
        ),
      ),
    );
  }
}

class DoctorData extends StatelessWidget {
  UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (userController.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: userController.userInfo!.users!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisExtent: 270),
              itemBuilder: (BuildContext context, int index) {
                var info = userController.userInfo!.users![index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      info.avatar == null
                          ? Container(
                              height: 160,
                              width: 162,
                              color: Colors.grey.shade500,
                            )
                          : Image.network(
                              '${info.avatar}',
                              height: 160,
                              width: 162,
                              fit: BoxFit.cover,
                            ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          children: [
                            Ts(
                              text: '${info.firstName}',
                              size: 25,
                              weight: FontWeight.w700,
                            ),
                            Flexible(
                              child: Ts(
                                text: '${info.lastName}',
                                overFlow: TextOverflow.ellipsis,
                                size: 25,
                                weight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Medicine Specialist',
                        style: GoogleFonts.rubik(
                            fontSize: 15, color: Colors.black45),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Wrap(
                        children: List.generate(
                          5,
                          (index) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 22,
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}

class ServiceType extends StatelessWidget {
  List<Map<String, dynamic>> service = [
    {
      'name': 'Dental',
      'image': 'assets/images/teeth.png',
      'color': Color(0xff2753F3),
      'color1': Color(0xff765AFC)
    },
    {
      'name': 'Cardiologist',
      'image': 'assets/images/heart.png',
      'color': Color(0xff0EBE7E),
      'color1': Color(0xff07D9AD)
    },
    {
      'name': 'Eye Specialist',
      'image': 'assets/images/eye.png',
      'color': Color(0xffFE7F44),
      'color1': Color(0xffFFCF68)
    },
    {
      'name': 'Skin Specialist',
      'image': 'assets/images/skin.png',
      'color': Color(0xffFF484C),
      'color1': Color(0xffFF6C60)
    },
  ];

  ServiceType({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          service.length,
          (index) => Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: Column(
              children: [
                Container(
                  height: 90,
                  width: 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        service[index]['color'],
                        service[index]['color1'],
                      ],
                    ),
                  ),
                  child: Image.asset(
                    service[index]['image'],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Ts(
                  text: service[index]['name'],
                  size: 12,
                  weight: FontWeight.w700,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 20),
          height: 200,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff4DC6FD), Color(0xff00CCCB)],
            ),
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
          child: Center(
            child: Ts(
              text: 'Find Your Doctor',
              color: Colors.white,
              weight: FontWeight.w900,
              size: 35,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Material(
              elevation: 10,
              shadowColor: Colors.grey.withOpacity(0.1),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: Icon(Icons.search),
                  fillColor: Colors.white,
                  filled: true,
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
