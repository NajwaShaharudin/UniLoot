import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_loot/screens/admin_panel/admin_all_items.dart';
import 'package:uni_loot/screens/admin_panel/all_categories_screen.dart';
import 'package:uni_loot/screens/admin_panel/all_orders_screen.dart';
import 'package:uni_loot/screens/admin_panel/all_user_screen.dart';
import 'package:uni_loot/utils/app_constant.dart';

class AdminMenuItem {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  AdminMenuItem({
    required this.title,
    required this.icon,
    required this.onTap,
  });
}

class AdminMainWidget extends StatefulWidget {
  const AdminMainWidget({super.key});

  @override
  State<AdminMainWidget> createState() => _AdminMainWidgetState();
}

class _AdminMainWidgetState extends State<AdminMainWidget> {
  final List<AdminMenuItem> menuItems = [
    AdminMenuItem(
      title: 'User',
      icon: Icons.people,
      onTap: () => Get.to(const AllUserScreen()),
    ),
    AdminMenuItem(
      title: 'Orders',
      icon: Icons.shopping_bag,
      onTap: () => Get.to(const AllOrdersScreen()),
    ),
    AdminMenuItem(
      title: 'Item',
      icon: Icons.trolley,
      onTap: () => Get.to(const AdminAllItems()),
    ),
    AdminMenuItem(
      title: 'Categories',
      icon: Icons.category,
      onTap: () => Get.to(const AllCategoriesScreen()),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(height: 40.0),
            ListView.builder(
              shrinkWrap: true,
              itemCount: menuItems.length,
              itemBuilder: (context, index) {
                final menuItem = menuItems[index];
                return Card(
                  elevation: 2.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ListTile(
                    leading: Icon(menuItem.icon, size: 40.0, color: AppConstant.appSecondaryColor),
                    title: Text(menuItem.title, style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                    onTap: menuItem.onTap,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
