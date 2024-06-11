import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:uni_loot/controllers/admin_product_img_controller.dart';
import 'package:uni_loot/models/categories_model.dart';
import 'package:uni_loot/services/generate_ids_services.dart';
import 'package:uni_loot/utils/app_constant.dart';

class AddCategoriesScreen extends StatefulWidget {
  const AddCategoriesScreen({super.key});

  @override
  State<AddCategoriesScreen> createState() => _AddCategoriesScreenState();
}
class _AddCategoriesScreenState extends State<AddCategoriesScreen> {
  AddProductImagesController addProductImagesController = Get.put(AddProductImagesController());
  TextEditingController categoryNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Categories"),
        backgroundColor: AppConstant.appMainColor,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
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
                        child: const Text("Select Images"),
                    )
                  ],
                ),
              ),

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
                                    child: Icon(
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

              const SizedBox(height: 40.0),
              Container(
                height: 65,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                child: TextFormField(
                  cursorColor: AppConstant.appMainColor,
                  textInputAction: TextInputAction.next,
                  controller: categoryNameController,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 10.0,
                    ),
                    hintText: "Category Name",
                    hintStyle: TextStyle(fontSize: 12.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ),

              ElevatedButton(
                onPressed: () async {
                  EasyLoading.show();
                  await addProductImagesController.uploadFunction(addProductImagesController.selectedImages);
                  String categoryId = await GenerateIds().generateCategoryId();

                  CategoriesModel categoriesModel = CategoriesModel(
                      categoryId: categoryId,
                      categoryImg: addProductImagesController.arrImagesUrl[0].toString(),
                      categoryName: categoryNameController.text.trim(),
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now(),
                  );
                  print (categoryId);

                  FirebaseFirestore.instance
                      .collection('categories')
                      .doc(categoryId)
                      .set(categoriesModel.toJson());

                  EasyLoading.dismiss();
                },
                child: const Text("Save"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
