import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:get/get.dart';
import 'package:uni_loot/models/categories_model.dart';
import 'package:uni_loot/screens/admin_panel/add_categories_screen.dart';
import 'package:uni_loot/screens/admin_panel/edit_category_screen.dart';
import 'package:uni_loot/utils/app_constant.dart';

class AllCategoriesScreen extends StatelessWidget {
  const AllCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        title: Text("All Categories"),
        actions: [
          InkWell(
            onTap: () => Get.to(() => const AddCategoriesScreen()),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('categories')
            // .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("Error"));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CupertinoActivityIndicator());
          }

          if (snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No category found!"));
          }

          return RefreshIndicator(
            onRefresh: () async {
              // Add code to refresh the data
            },
            child: ListView.separated(
              padding: const EdgeInsets.all(16.0),
              separatorBuilder: (context, index) => const Divider(),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final data = snapshot.data!.docs[index];

                CategoriesModel categoriesModel = CategoriesModel(
                    categoryId: data['categoryId'],
                    categoryImg: data['categoryImg'],
                    categoryName: data['categoryName'],
                    createdAt: data['createdAt'],
                    updatedAt: data['updatedAt'],
                );


                return SwipeActionCell(
                  key: ObjectKey(categoriesModel.categoryId),
                  trailingActions: <SwipeAction>[
                    SwipeAction(
                        title: "Delete",
                        onTap: (CompletionHandler handler) async {
                          await Get.defaultDialog(
                            title: "Delete Item",
                            content: const Text(
                                "Are you sure to delete this items?"),
                            textCancel: "Cancel",
                            textConfirm: "Delete",
                            contentPadding: const EdgeInsets.all(10.0),
                            confirmTextColor: Colors.white,
                            onCancel: (){},
                            onConfirm: () async {
                              Get.back();
                              EasyLoading.show(status: 'Please wait..');

                              // await deleteImagesFromFirebase(
                              //   productModel.productImages,
                              // );
                              //
                              // await FirebaseFirestore.instance
                              //     .collection('products')
                              //     .doc(productModel.productId)
                              //     .delete();

                              EasyLoading.dismiss();
                            },
                            buttonColor: Colors.red,
                            cancelTextColor: Colors.black,
                          );
                        },
                        color: Colors.red),
                  ],
                  child: InkWell(
                    onTap: (){},
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: CachedNetworkImage(
                            imageUrl: categoriesModel.categoryImg,
                            width: 80.0,
                            height: 80.0,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(
                              color: Colors.grey[200],
                              child: const Center(
                                  child: CircularProgressIndicator()),
                            ),
                            errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    categoriesModel.categoryName,
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4.0),
                                ],
                              ),
                              GestureDetector(
                                onTap: () => Get.to(() => EditCategoryScreen(categoriesModel: categoriesModel)),
                                child: const Icon(Icons.edit),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
