import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uni_loot/utils/app_constant.dart';
import 'package:uni_loot/widgets/drawer_widget.dart';

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
        title: Text(
            AppConstant.appMainName,
          ),
        centerTitle: true,
      ),
      drawer: DrawerWidget(),
    );
  }
}
