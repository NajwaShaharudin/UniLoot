import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:uni_loot/screens/auth_ui/welcome_screen.dart';
import 'package:uni_loot/screens/user_panel/main_screen.dart';
import 'package:uni_loot/utils/app_constant.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState(){
    super.initState();
    Timer(Duration(seconds: 3), () {
      Get.offAll(() => WelcomeScreen());
    });
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
