import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:uni_loot/utils/app_constant.dart';
import 'package:uni_loot/widgets/admin_main_menu.dart';
import '../auth_ui/welcome_screen.dart';


class AdminMainScreen extends StatefulWidget {
  const AdminMainScreen({super.key});

  @override
  State<AdminMainScreen> createState() => _AdminMainScreenState();
}

class _AdminMainScreenState extends State<AdminMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        centerTitle: true,
        title: const Text("UniLoot Admin"),
        actions: [
          GestureDetector(
            onTap: () async {

              GoogleSignIn googleSignIn = GoogleSignIn();
              FirebaseAuth _auth = FirebaseAuth.instance;
              await _auth.signOut();
              await googleSignIn.signOut();
              Get.offAll(() => WelcomeScreen());
            },
            child: const Icon(Icons.logout),
          )
        ],
      ),

      // drawer: const AdminDrawerWidget(),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Positioned(
                child: Image.asset('assets/images/shop-logo.jpg'),
                    height: 100,
              width: 100,
            ),
            SizedBox(
              height: Get.height / 90.0,
            ),

            const AdminMainWidget()
          ],
        ),
      ),
    );
  }
}