import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:uni_loot/screens/admin_panel/admin_all_items.dart';
import 'package:uni_loot/screens/admin_panel/all_orders_screen.dart';
import 'package:uni_loot/screens/admin_panel/all_user_screen.dart';
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
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
        ),
        child: Wrap(
          runSpacing: 10,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text("Admin Dashboard", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
              ),
            ),
            const Divider(
              indent: 10.0,
              endIndent: 10.0,
              thickness: 1.5,
              color: Colors.black,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListTile(
                onTap: (){
                  Get.to(() => const AllUserScreen());
                },
                titleAlignment: ListTileTitleAlignment.center,
                title: const Text("Users"),
                leading: const Icon(Icons.person),
                trailing: const Icon(Icons.arrow_forward),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: const Text("Orders"),
                leading: const Icon(Icons.shopping_bag),
                trailing: const Icon(Icons.arrow_forward),
                onTap: (){
                  Get.to(const AllOrdersScreen());
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: const Text("Item"),
                leading: const Icon(
                    Icons.shopping_cart),
                trailing: const Icon(
                    Icons.arrow_forward
                ),
                onTap: (){
                  Get.back();
                  Get.to(() => const AdminAllItems());
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: const Text("Categories"),
                leading: const Icon(
                    Icons.category),
                trailing: const Icon(
                    Icons.arrow_forward
                ),
                onTap: (){
                  Get.back();
                  Get.to(() => const AdminAllItems());
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
                title: const Text("Logout"),
                leading: const Icon(Icons.logout),
                trailing: const Icon(Icons.arrow_forward),
              ),
            ),
          ],
        ),
        backgroundColor: AppConstant.appSecondaryColor,
      ),
    );
  }
}
