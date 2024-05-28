import 'package:flutter/material.dart';
import 'package:uni_loot/utils/app_constant.dart';
import 'package:uni_loot/widgets/admin_drawer_widget.dart';

import '../../widgets/drawer_widget.dart';

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
        title: Text("Admin Panel"),
      ),

      drawer: AdminDrawerWidget(),
    );
  }
}
