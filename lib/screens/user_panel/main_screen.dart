import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:uni_loot/screens/user_panel/all_categories_screen.dart';
import 'package:uni_loot/screens/user_panel/all_flash_sales_screen.dart';
import 'package:uni_loot/screens/user_panel/all_item_screen.dart';
import 'package:uni_loot/utils/app_constant.dart';
import 'package:uni_loot/widgets/all_item_widgets.dart';
import 'package:uni_loot/widgets/banner_widget.dart';
import 'package:uni_loot/widgets/category_widget.dart';
import 'package:uni_loot/widgets/drawer_widget.dart';
import 'package:uni_loot/widgets/flash_sales_widget.dart';

import '../../widgets/heading_widget.dart';
import 'cart_screen.dart';

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
        actions: [
          GestureDetector(
            onTap: () => Get.to (()=> CartScreen()),
              child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.shopping_cart),
            ),
          ),
        ],
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
                onTap: ()=> Get.to(() => AllCategoriesScreen()),
                buttonText: "See More >",
              ),

              CategoriesWidget(),

              HeadingWidget(
                headingTitle: "Flash Sales",
                headingSubtitle: "Grab now while stock last",
                onTap: () => Get.to(() => AllFlashSalesProductScreen()),
                buttonText: "See More >",
              ),

              FlashSalesWidget(),

              //heading
              HeadingWidget(
                headingTitle: "All items",
                headingSubtitle: "View all items",
                onTap: () => Get.to(() => AllItemScreen()),
                buttonText: "See More >",
              ),

              AllItemsWidget(),


            ],
          ),
        ),
      ),
    );
  }
}
