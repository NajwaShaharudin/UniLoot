

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:uni_loot/screens/auth_ui/signIn_screen.dart';
import 'package:uni_loot/utils/app_constant.dart';

class ForgotPasswordController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  Future<void> ForgotPasswordMethod(
      String userEmail,

      ) async {

    try {
      EasyLoading.show(status: "Please wait..");

      await _auth.sendPasswordResetEmail(email: userEmail);
      Get.snackbar(
        "Request sent successfully",
        "Password reset link sent to $userEmail",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppConstant.appSecondaryColor,
        colorText: AppConstant.appTextColor,
      );

      Get.offAll(() => SignInScreen());
      EasyLoading.dismiss();

    } on FirebaseAuthException catch (e){
      EasyLoading.dismiss();
      Get.snackbar(
        "Error",
        "$e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppConstant.appSecondaryColor,
        colorText: AppConstant.appTextColor,
      );
    }
  }
}