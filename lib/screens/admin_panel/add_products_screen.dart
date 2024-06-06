import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_loot/controllers/admin_product_img_controller.dart';
import 'package:uni_loot/controllers/category_controller.dart';
import 'package:uni_loot/utils/app_constant.dart';
import 'package:uni_loot/widgets/admin_category_widget.dart';

import '../../controllers/is_sale_controller.dart';

class AddItemsScreen extends StatelessWidget {
   AddItemsScreen({super.key});

  AddProductImagesController addProductImagesController =
      Get.put(AddProductImagesController());

   CategoryController categoryController =
     Get.put(CategoryController());

   isSaleController saleController =
   Get.put(isSaleController());

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
            ),
            
            //show images
            GetBuilder<AddProductImagesController>(
              init: AddProductImagesController(),
                builder: (imageController){
                return imageController.selectedImages.length > 0
                    ? Container(
                        width: MediaQuery.of(context).size.width - 20,
                        height: Get.height / 3.0,
                        child: GridView.builder(
                          itemCount: imageController.selectedImages.length,
                          physics: const BouncingScrollPhysics(),
                          gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                              mainAxisSpacing: 20,
                              crossAxisSpacing: 10,
                            ),
                          itemBuilder: (BuildContext context, int index){
                            return Stack(
                              children: [
                                Image.file(
                                  File(addProductImagesController.selectedImages[index].path),
                                  fit: BoxFit.cover,
                                  height: Get.height/4,
                                  width: Get.width/2,
                                ),
                                Positioned(
                                    right: 10,
                                    top: 0,
                                  child: InkWell(
                                    onTap: (){
                                       imageController.removeImages(index);
                                       print(imageController.selectedImages.length);
                                    },
                                    child: const CircleAvatar(
                                      backgroundColor: AppConstant.appSecondaryColor,
                                      child: const Icon(
                                        Icons.close,
                                        color: AppConstant.appTextColor,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            );
                          }
                        ),
                )
                    : const SizedBox.shrink();
                },
            ),

            //display category widget
            AdminCategoryWidget(),
            
            //isSale 
            GetBuilder<isSaleController>(
              init: isSaleController(),
                builder: (isSaleController){
                return Card(
                  child: Padding(
                  padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Is Sale"),
                        Switch(
                            value: isSaleController.isSale.value,
                            activeColor: AppConstant.appMainColor,
                            onChanged: (value){
                              isSaleController.toggleIsSale(value);
                            },
                        )
                      ],
                    ),
                ),
                );
                },
            )
          ],
        ),
      ),
    );
  }
}
