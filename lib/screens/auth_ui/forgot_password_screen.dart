import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import 'package:uni_loot/controllers/forgot_password_controller.dart';
import 'package:uni_loot/screens/auth_ui/signup_screen.dart';
import '../../utils/app_constant.dart';


class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  final ForgotPasswordController forgotPasswordController = Get.put(ForgotPasswordController());
  TextEditingController userEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (context , isKeyboardVisible) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppConstant.appSecondaryColor,
            centerTitle: true,
            title: Text("FORGOT PASSWORD",
              style: TextStyle(color: AppConstant.appTextColor),
            ),
          ),

          body: Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  isKeyboardVisible? Text("Welcome to my App"):
                  Column(
                    children: [
                      Lottie.asset('assets/images/Animation - 1714632341819.json')
                    ],
                  ),

                  SizedBox(height: Get.height/20),

                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    width: Get.width,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: userEmail,
                        cursorColor: AppConstant.appSecondaryColor,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: "Email",
                          prefixIcon: Icon(Icons.email),
                          contentPadding: EdgeInsets.only(top: 2.0, left: 8.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                  ),


                  SizedBox(height: Get.height/20,),

                  Material(
                    child: Container(
                      width: Get.width/ 2,
                      height: Get.height/18,
                      decoration: BoxDecoration(
                          color: AppConstant.appSecondaryColor,
                          borderRadius:BorderRadius.circular((20.0),)
                      ),
                      child: TextButton(
                        child: Text("Sent Email",
                          style: TextStyle(color: AppConstant.appTextColor),
                        ),
                        onPressed: () async {
                          String email = userEmail.text.trim();


                          if(email.isEmpty){
                            Get.snackbar("Error", "Please fill in the details",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: AppConstant.appSecondaryColor,
                              colorText: AppConstant.appTextColor,
                            );
                          } else {
                            String email = userEmail.text.trim();
                            forgotPasswordController.ForgotPasswordMethod(email);

                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },

    );
  }
}
