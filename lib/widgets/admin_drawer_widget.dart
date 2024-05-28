import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:uni_loot/screens/admin_panel/all_user_screen.dart';
import 'package:uni_loot/screens/user_panel/cust_order_screen.dart';
import 'package:uni_loot/utils/app_constant.dart';

import '../screens/auth_ui/welcome_screen.dart';

class AdminDrawerWidget extends StatefulWidget {
  const AdminDrawerWidget({super.key});

  @override
  State<AdminDrawerWidget> createState() => _AdminDrawerWidgetState();
}

class _AdminDrawerWidgetState extends State<AdminDrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Get.height/25),
      child: Drawer(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
        ),
        child: Wrap(
          runSpacing: 10,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text("Admin Dashboard", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
              ),
            ),
            Divider(
              indent: 10.0,
              endIndent: 10.0,
              thickness: 1.5,
              color: Colors.black,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text("Home"),
                leading: Icon(Icons.home),
                trailing: Icon(Icons.arrow_forward),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListTile(
                onTap: (){
                  Get.to(() => AllUserScreen());
                },
                titleAlignment: ListTileTitleAlignment.center,
                title: Text("Users"),
                leading: Icon(Icons.person),
                trailing: Icon(Icons.arrow_forward),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text("Orders"),
                leading: Icon(Icons.shopping_bag),
                trailing: Icon(Icons.arrow_forward),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text("Item"),
                leading: Icon(
                    Icons.shopping_cart),
                trailing: Icon(
                    Icons.arrow_forward
                ),
                onTap: (){
                  Get.back();
                  Get.to(() => CustomerOrderScreen());
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListTile(
                onTap: () async {

                  GoogleSignIn googleSignIn = GoogleSignIn();
                  FirebaseAuth _auth = FirebaseAuth.instance;
                  await _auth.signOut();
                  await googleSignIn.signOut();
                  Get.offAll(() => WelcomeScreen());
                },
                titleAlignment: ListTileTitleAlignment.center,
                title: Text("Logout"),
                leading: Icon(Icons.logout),
                trailing: Icon(Icons.arrow_forward),
              ),
            ),
          ],
        ),
        backgroundColor: AppConstant.appSecondaryColor,
      ),
    );
  }
}
