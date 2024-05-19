import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:uni_loot/utils/app_constant.dart';
import 'package:uni_loot/widgets/banner_widget.dart';
import 'package:uni_loot/widgets/category_widget.dart';
import 'package:uni_loot/widgets/drawer_widget.dart';
import 'package:uni_loot/widgets/flash_sales_widget.dart';

import '../../widgets/heading_widget.dart';

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
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: Get.height/90.0,
              ),

              //banner
              BannerWidget(),

              //heading
              HeadingWidget(
                headingTitle: "Categories",
                headingSubtitle: "All you need is here",
                onTap: (){},
                buttonText: "See More >",
              ),

              CategoriesWidget(),

              HeadingWidget(
                headingTitle: "Flash Sales",
                headingSubtitle: "Grab now while stock last",
                onTap: (){},
                buttonText: "See More >",
              ),

              FlashSalesWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
