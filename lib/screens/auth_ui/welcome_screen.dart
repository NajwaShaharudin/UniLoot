import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_loot/controllers/google_signin_controller.dart';
import 'package:uni_loot/screens/auth_ui/signIn_screen.dart';
import 'package:uni_loot/utils/app_constant.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});

  final GoogleSignInController _googleSignInController = Get.put(GoogleSignInController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppConstant.appMainColor,
        title: const Text("Welcome to UniLoot", style: TextStyle(color: AppConstant.appTextColor)),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width > 600 ? 100.0 : 20.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  'assets/images/shop-logo.jpg',
                  width: MediaQuery.of(context).size.width <= 600 ? 200.0 : null,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20.0),
                child: const Text(
                  "Find affordable essentials for your student life",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: Get.height / 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width <= 600 ? Get.width / 1.2 : null, // Set button width
                    child: Material(
                      child: Container(
                        height: Get.height / 12, // Set button height
                        decoration: BoxDecoration(
                          color: AppConstant.appSecondaryColor,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: TextButton.icon(
                          icon: Image.asset(
                            'assets/images/google-logo.png',
                            width: Get.width / 30,
                            height: Get.height / 30,
                          ),
                          label: const Text(
                            "Sign in with Google",
                            style: TextStyle(color: AppConstant.appTextColor),
                          ),
                          onPressed: () {
                            _googleSignInController.signInWithGoogle();
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: Get.height / 50),
              SizedBox(
                width: MediaQuery.of(context).size.width <= 600 ? Get.width / 1.2 : null, // Set button width
                child: Material(
                  child: Container(
                    height: Get.height / 12, // Set button height
                    decoration: BoxDecoration(
                      color: AppConstant.appSecondaryColor,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: TextButton.icon(
                      icon: const Icon(
                        Icons.email,
                        color: AppConstant.appTextColor,
                      ),
                      label: const Text(
                        "Sign in with email",
                        style: TextStyle(color: AppConstant.appTextColor),
                      ),
                      onPressed: () {
                        Get.to(() => SignInScreen());
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
