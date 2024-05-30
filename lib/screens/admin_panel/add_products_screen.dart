import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_loot/controllers/admin_product_img_controller.dart';
import 'package:uni_loot/utils/app_constant.dart';

class AddItemsScreen extends StatelessWidget {
   AddItemsScreen({super.key});

  AddProductImagesController addProductImagesController =
      Get.put(AddProductImagesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Items'),
        backgroundColor: AppConstant.appMainColor,
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Select Images"),
                  ElevatedButton(
                      onPressed: (){
                        addProductImagesController.showImagesPickerDialog();
                      },
                      child: const Text("Select Images"))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
