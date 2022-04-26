import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:practice_demo/common_widgets/image_upload.dart';
import 'package:practice_demo/common_widgets/text.dart';
import 'package:practice_demo/common_widgets/text_field.dart';
import 'package:practice_demo/controller/gender_controller.dart';
import 'package:practice_demo/controller/hobbies_controller.dart';
import 'package:practice_demo/services/email_auth_services.dart';
import 'package:practice_demo/view/register_screen/gender_selection.dart';
import 'package:practice_demo/view/register_screen/hobbies_selection.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constant.dart';
import 'home_screen.dart';

class UpadteProfileScreen extends StatefulWidget {
  const UpadteProfileScreen({Key? key}) : super(key: key);

  @override
  State<UpadteProfileScreen> createState() => _UpadteProfileScreenState();
}

class _UpadteProfileScreenState extends State<UpadteProfileScreen> {
  File? image;
  final picker = ImagePicker();
  dynamic selectCity = 'Surat';
  bool showPassword = true;

  List<String> city = ['Surat', 'Ahmedabad', 'Vadodara'];

  TextEditingController? _firstName;
  TextEditingController? _lastName;
  TextEditingController? _email;
  TextEditingController? _mobileNum;
  TextEditingController? _password;

  final _formKey = GlobalKey<FormState>();

  HobbiesController hobbiesController = Get.put(HobbiesController());
  GenderController genderController = Get.put(GenderController());

  /// Show Image

  Future setImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(
        () {
          image = File(pickedFile.path);
        },
      );
    }
  }

  /// Adding Data to FireBase
  Future updateUserData() async {
    String? imageUrl = await uploadFile(image!, "${Random().nextInt(1000)}");

    bool status = await FireBaseService.signUpService(
      email: _email!.text,
      password: _password!.text,
    );
    SharedPreferences userData = await SharedPreferences.getInstance();

    if (status == true) {
      userData.setString('email', _email!.text);
      firebaseFirestore
          .collection('User')
          .doc(firebaseAuth.currentUser!.uid)
          .update(
        {
          'firstName': _firstName!.text,
          'lastName': _lastName!.text,
          'mobileNumber': _mobileNum!.text,
          'passWord': _password!.text,
          'emailId': _email!.text,
          'image': imageUrl,
          'gender': genderController.genderSelect.value == 0 ? 'Men' : 'Female',
          'city': selectCity,
          'hobbies': hobbiesController.hobbiesSelect.value &&
                  hobbiesController.hobbiesSelect1.value == true
              ? 'Singing' 'Dancing'
              : hobbiesController.hobbiesSelect1.value
                  ? 'Dancing'
                  : hobbiesController.hobbiesSelect1.value
                      ? 'Singing'
                      : 'Not interested',
        },
      ).whenComplete(
        () => Get.off(
          () => HomeScreen(),
        ),
      );
    }
  }

  String? userImage;

  void getUserData() async {
    final user = await FirebaseFirestore.instance
        .collection("User")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    Map<String, dynamic>? getUserData = user.data();
    _email?.text = getUserData!['emailId'];
    _firstName?.text = getUserData!['firstName'];
    _lastName?.text = getUserData!['lastName'];
    _mobileNum?.text = getUserData!['mobileNumber'];
    userImage = getUserData!['image'];
    selectCity = getUserData['city'];
    // setState(() {
    //   _character = getUserData['gender'] == 'Female'
    //       ? SingingCharacter.female
    //       : SingingCharacter.male;
    // });
  }

  @override
  void initState() {
    getUserData();
    super.initState();
  }

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
              Colors.grey.shade200,
              Colors.grey.shade200,
              Colors.greenAccent.shade100
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),

                  /// Image   ==============>>>>>>>>>>>>>
                  Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 10, right: 10),
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white, width: 5),
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(1, 5),
                              color: Colors.grey.shade400,
                              blurRadius: 15,
                            )
                          ],
                        ),
                        child: image == null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.network(
                                  userImage!,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.file(
                                  image!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.white,
                          child: GestureDetector(
                            onTap: () {
                              setImage();
                            },
                            child: const CircleAvatar(
                              backgroundColor: Colors.grey,
                              radius: 21.5,
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Ts(
                    text: 'Set up your profile',
                    color: Colors.grey,
                    size: 18,
                    weight: FontWeight.w900,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Ts(
                    text: 'Update your profile to connect your doctor with',
                    color: Colors.grey,
                    size: 16,
                    weight: FontWeight.w500,
                  ),
                  Ts(
                    text: 'better impression',
                    color: Colors.grey,
                    size: 16,
                    height: 1.5,
                    weight: FontWeight.w500,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Registration',
                      style: TextStyle(
                        fontSize: 20,
                        height: 1.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),

                  /// FirstName  &&  LastName    ==============>>>>>>>>>>>>>
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TsField(
                          hide: false,
                          action: TextInputAction.next,
                          controller: _firstName!,
                          hintText: 'First Name',
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter Name';
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: TsField(
                          hide: false,
                          action: TextInputAction.next,
                          controller: _lastName!,
                          hintText: 'Last Name',
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter Name';
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),

                  /// Email   ==============>>>>>>>>>>>>>
                  TsField(
                    hide: false,
                    action: TextInputAction.next,
                    controller: _email!,
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

                  ///    Mobile ==============>>>>>>>>>>>>>
                  TsField(
                    keyboardType: TextInputType.number,
                    hide: false,
                    action: TextInputAction.next,
                    length: 10,
                    controller: _mobileNum!,
                    hintText: 'Mobile Number',
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter Number';
                      } else if (value.length > 10) {
                        return ' Enter Maximum 10 digit Number ';
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  /// Gender Selection  ==============>>>>>>>>>>>>>
                  GenderSelection(),
                  const SizedBox(
                    height: 20,
                  ),

                  /// City Selection  ==============>>>>>>>>>>>>>
                  TextFormField(
                    validator: (value) {},
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        width: double.infinity,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            value: selectCity,
                            onChanged: (value) {
                              setState(
                                () {
                                  selectCity = value;
                                },
                              );
                            },
                            items: city
                                .map(
                                  (e) => DropdownMenuItem(
                                    child: Text(e),
                                    value: e,
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  /// Hobbies   ==============>>>>>>>>>>>>>

                  HobbiesSelection(),

                  const SizedBox(
                    height: 20,
                  ),

                  /// Password   ==============>>>>>>>>>>>>>

                  TsField(
                    hide: showPassword,
                    action: TextInputAction.done,
                    controller: _password!,
                    hintText: 'Password',
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter Password';
                      }
                    },
                    icon:
                        showPassword ? Icons.visibility : Icons.visibility_off,
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
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        //updateUserData();
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
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
