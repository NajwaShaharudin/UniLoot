import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:uni_loot/controllers/admin_edit_category_controller.dart';
import 'package:uni_loot/models/categories_model.dart';
import 'package:uni_loot/utils/app_constant.dart';

import 'all_categories_screen.dart';

class EditCategoryScreen extends StatefulWidget {
  CategoriesModel categoriesModel;
  EditCategoryScreen({super.key, required this.categoriesModel});

  @override
  State<EditCategoryScreen> createState() => _EditCategoryScreenState();
}

class _EditCategoryScreenState extends State<EditCategoryScreen> {

  TextEditingController categoryNameController = TextEditingController();

  @override
  void initState(){
    super.initState();
    categoryNameController.text = widget.categoriesModel.categoryName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        title: Text(widget.categoriesModel.categoryName),
      ),
      body: Container(
        child: Column(
          children: [
            GetBuilder(
              init: EditCategoryController(categoriesModel: widget.categoriesModel),
                builder: (editCategory) {
                return
                  editCategory.categoryImg.value != ''?
                  Stack(
                  children: [
                    CachedNetworkImage(
                      imageUrl: editCategory.categoryImg.value.toString(),
                      fit: BoxFit.contain,
                      height: Get.height / 5.5,
                      width: Get.width / 2,
                      placeholder: (context, url) => const Center(
                        child: CupertinoActivityIndicator(),
                      ),
                      errorWidget: (context, url, error) =>
                      const Icon(Icons.error),
                    ),
                    Positioned(
                      right: 10,
                      top: 0,
                      child: InkWell(
                        onTap: () async {
                          EasyLoading.show();
                          await editCategory.deleteImagesFromStorage(
                              editCategory.categoryImg.value.toString());
                          await editCategory.deleteImageFromFireStore(
                              editCategory.categoryImg.value.toString(),
                              widget.categoriesModel.categoryId);
                          EasyLoading.dismiss();
                        },
                        child: const CircleAvatar(
                          backgroundColor:
                          AppConstant.appSecondaryColor,
                          child: Icon(
                            Icons.close,
                            color: AppConstant.appTextColor,
                          ),
                        ),
                      ),
                    )
                  ],
                )
                      : const SizedBox.shrink();
              },
            ),

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
                  hintText: "Product Name",
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
                  CategoriesModel categoriesModel = CategoriesModel(
                      categoryId: widget.categoriesModel.categoryId,
                      categoryImg: widget.categoriesModel.categoryImg,
                      categoryName: categoryNameController.text.trim(),
                      createdAt: widget.categoriesModel.createdAt,
                      updatedAt: DateTime.now(),
                  );

                  await FirebaseFirestore.instance
                      .collection('categories')
                      .doc(categoriesModel.categoryId)
                      .update(categoriesModel.toJson());

                  EasyLoading.showSuccess('Edit success');

                },
                child: const Text("Update")
            )
          ],
        ),
      ),
    );
  }
}
