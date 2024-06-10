import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:uni_loot/controllers/admin_product_img_controller.dart';
import 'package:uni_loot/controllers/category_controller.dart';
import 'package:uni_loot/models/product_model.dart';
import 'package:uni_loot/utils/app_constant.dart';
import 'package:uni_loot/widgets/admin_category_widget.dart';
import '../../controllers/is_sale_controller.dart';
import '../../services/generate_ids_services.dart';

class AddItemsScreen extends StatelessWidget {
   AddItemsScreen({super.key});

  AddProductImagesController addProductImagesController =
      Get.put(AddProductImagesController());

   CategoryController categoryController =
     Get.put(CategoryController());

   IsSaleController isSaleController = Get.put(IsSaleController());

   TextEditingController productNameController = TextEditingController();
   TextEditingController salePriceController = TextEditingController();
   TextEditingController fullPriceController = TextEditingController();
   TextEditingController deliveryTimeController = TextEditingController();
   TextEditingController productDescriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Items'),
        backgroundColor: AppConstant.appMainColor,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
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

            //display category widget
            const AdminCategoryWidget(),

            //isSale
            GetBuilder<IsSaleController>(
              init: IsSaleController(),
                builder: (isSaleController){
                return Card(
                  child: Padding(
                  padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("On Sale"),
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
            ),

            //form
            const SizedBox(height: 5.0),
            Container(
              height: 65,
              margin: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextFormField(
                cursorColor: AppConstant.appMainColor,
                textInputAction: TextInputAction.next,
                controller: productNameController,
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
            const SizedBox(height: 5.0),

            Obx((){
              return isSaleController.isSale.value ?  Container(
                height: 65,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                child: TextFormField(
                  cursorColor: AppConstant.appMainColor,
                  textInputAction: TextInputAction.next,
                  controller: salePriceController,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 10.0,
                    ),
                    hintText: "Sale Price",
                    hintStyle: TextStyle(fontSize: 12.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ) : const SizedBox.shrink();
            }),


            const SizedBox(height: 5.0),
            Container(
              height: 65,
              margin: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextFormField(
                cursorColor: AppConstant.appMainColor,
                textInputAction: TextInputAction.next,
                controller: fullPriceController,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 10.0,
                  ),
                  hintText: "Full Price",
                  hintStyle: TextStyle(fontSize: 12.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5.0),
            Container(
              height: 65,
              margin: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextFormField(
                cursorColor: AppConstant.appMainColor,
                textInputAction: TextInputAction.next,
                controller: deliveryTimeController,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 10.0,
                  ),
                  hintText: "Delivery Time",
                  hintStyle: TextStyle(fontSize: 12.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5.0),
            Container(
              height: 65,
              margin: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextFormField(
                cursorColor: AppConstant.appMainColor,
                textInputAction: TextInputAction.next,
                controller: productDescriptionController,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 10.0,
                  ),
                  hintText: "Product Description",
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

                  // print(productId);
                  try {
                    EasyLoading.show();
                    await addProductImagesController.uploadFunction(addProductImagesController.selectedImages);
                    print(addProductImagesController.arrImagesUrl);
                    String productId = await GenerateIds().generateProductId();

                    ProductModel productModel = ProductModel(
                        productId: productId,
                        categoryId: categoryController.selectedCategoryId.toString(),
                        productName: productNameController.text.trim(),
                        categoryName: categoryController.selectedCategoryName.toString(),
                        salePrice: salePriceController.text != ''? salePriceController.text.trim(): '',
                        fullPrice: fullPriceController.text.trim(),
                        productImages: addProductImagesController.arrImagesUrl,
                        deliveryTime: deliveryTimeController.text.trim(),
                        isSale:  isSaleController.isSale.value,
                        productDescription: productDescriptionController.text.trim(),
                        createdAt: DateTime.now(),
                        updatedAt: DateTime.now(),
                    );

                    await FirebaseFirestore.instance.collection('products').doc(productId).set(productModel.toMap());
                    EasyLoading.dismiss();
                  }catch (e){
                    print("Error: $e");
                  }
                },
                child: const Text("Upload"),
            )
          ],
        ),
      ),
    );
  }
}
