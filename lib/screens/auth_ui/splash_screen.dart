import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:uni_loot/controllers/get_user_data_controller.dart';
import 'package:uni_loot/screens/admin_panel/admin_main_screen.dart';
import 'package:uni_loot/screens/auth_ui/welcome_screen.dart';
import 'package:uni_loot/screens/user_panel/main_screen.dart';
import 'package:uni_loot/utils/app_constant.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState(){
    super.initState();
    Timer(Duration(seconds: 3), () {
      loggedIn(context);
    });
  }

  Future<void> loggedIn(BuildContext context) async {
    if(user !=null){
      final GetUserDataController getUserDataController =
      Get.put(GetUserDataController());
      var userData = await getUserDataController.getUserData(user!.uid);

      if(userData[0]['isAdmin'] == true){
        Get.offAll(() => AdminMainScreen());
      } else {
        Get.offAll(() => MainScreen());
      }
    } else {
      Get.to(() => WelcomeScreen());
    }
  }


  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppConstant.appSecondaryColor,
      appBar: AppBar(
        backgroundColor: AppConstant.appSecondaryColor,
        elevation: 0,
      ),
      body: Container(
        width: Get.width,
        alignment: Alignment.center,
        child: Column(
          children: [
            Expanded(
              child: Container(child: Lottie.asset('assets/images/Animation - 1714632341819.json'),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20.0),
              width: Get.width,
              alignment: Alignment.center,
              child: Text(
                AppConstant.appPoweredBy,
                style: const TextStyle(
                    color: AppConstant.appTextColor,
                        fontSize:16.0,
                  fontWeight: FontWeight.bold),
                ),
              )
          ],
        ),
      ),
    );
  }
}
