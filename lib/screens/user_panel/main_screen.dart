import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:uni_loot/utils/app_constant.dart';

import '../auth_ui/welcome_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppConstant.appSecondaryColor,
          statusBarIconBrightness: Brightness.light),
        backgroundColor: AppConstant.appMainColor,
        title: Text(AppConstant.appMainName),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () async {
              GoogleSignIn googleSignIn = GoogleSignIn();

              await googleSignIn.signOut();
              Get.offAll(() => WelcomeScreen());
            },
            child:  const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.logout),
            ),
          )

        ],
      ),
    );
  }
}
