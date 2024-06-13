import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:uni_loot/controllers/category_controller.dart';
import 'package:uni_loot/controllers/edit_product_controller.dart';
import 'package:uni_loot/controllers/is_sale_controller.dart';
import 'package:uni_loot/models/product_model.dart';
import 'package:uni_loot/utils/app_constant.dart';

class EditItemScreen extends StatefulWidget {
  ProductModel productModel;
  EditItemScreen({super.key, required this.productModel});

  @override
  State<EditItemScreen> createState() => _EditItemScreenState();
}

class _EditItemScreenState extends State<EditItemScreen> {
  IsSaleController isSaleController = Get.put(IsSaleController());

  CategoryController categoryController = Get.put(CategoryController());

  TextEditingController productNameController = TextEditingController();

  TextEditingController salePriceController = TextEditingController();

  TextEditingController fullPriceController = TextEditingController();

  TextEditingController deliveryTimeController = TextEditingController();

  TextEditingController productDescriptionController = TextEditingController();

  @override
  void initState(){
    super.initState();
    productNameController.text = widget.productModel.productName;
    salePriceController.text = widget.productModel.salePrice;
    fullPriceController.text = widget.productModel.fullPrice;
    deliveryTimeController.text = widget.productModel.deliveryTime;
    productDescriptionController.text = widget.productModel.productDescription;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditProductController>(
      init: EditProductController(productModel: widget.productModel),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppConstant.appMainColor,
            title: Text("Edit Item ${widget.productModel.productName}"),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SingleChildScrollView(
                  child: Container(
                    width: MediaQuery.of(context).size.width - 20,
                    height: Get.height / 3.0,
                    child: GridView.builder(
                        itemCount: controller.images.length,
                        physics: const BouncingScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 2,
                          crossAxisSpacing: 2,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return Stack(
                            children: [
                              CachedNetworkImage(
                                imageUrl: controller.images[index],
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
                                    await controller.deleteImagesFromStorage(
                                        controller.images[index].toString());
                                    await controller.deleteImageFromFireStore(
                                        controller.images[index].toString(),
                                        widget.productModel.productId);
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
                          );
                        }),
                  ),
                ),

                //drop down
                GetBuilder<CategoryController>(
                  init: CategoryController(),
                  builder: (categoryController) {
                    return Column(
                      children: [
                        Container(
                          margin:
                              const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Card(
                            elevation: 10,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownButton<String>(
                                value: categoryController
                                    .selectedCategoryId?.value,
                                items: categoryController.categories
                                    .map((category) {
                                  return DropdownMenuItem<String>(
                                    value: category['categoryId'].toString(),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        CircleAvatar(
                                          backgroundImage: NetworkImage(
                                            category['categoryImg']
                                                .toString(),
                                          ),
                                        ),
                                        const SizedBox(width: 20.0),
                                        Expanded(
                                          child: Text(
                                            category['categoryName'],
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                                onChanged: (String? selectedValue) async {
                                  categoryController
                                      .setSelectedCategory(selectedValue);
                                  String? categoryName =
                                      await categoryController
                                          .getCategoryName(selectedValue);
                                  categoryController
                                      .setSelectedCategoryName(categoryName);
                                },
                                hint: const Text('Select Category'),
                                isExpanded: true,
                                elevation: 10,
                                underline: const SizedBox.shrink(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),

                GetBuilder<IsSaleController>(
                  init: IsSaleController(),
                  builder: (isSaleController){
                    return

                      Card(
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

                const SizedBox(height: 10.0),
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

                GetBuilder<IsSaleController>(
                  init: IsSaleController(),
                  builder: (isSaleController){
                    return isSaleController.isSale.value
                        ? Container(
                      height: 65,
                      margin: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: TextFormField(
                        cursorColor: AppConstant.appMainColor,
                        textInputAction: TextInputAction.next,
                        controller: salePriceController,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 10.0
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
                    )
                        : const SizedBox.shrink();
                  },
                ),

                // Obx((){
                //   return saleController.isSale.value ?  Container(
                //     height: 65,
                //     margin: const EdgeInsets.symmetric(horizontal: 10.0),
                //     child: TextFormField(
                //       cursorColor: AppConstant.appMainColor,
                //       textInputAction: TextInputAction.next,
                //       controller: salePriceController..text = productModel.salePrice,
                //       decoration: const InputDecoration(
                //         contentPadding: EdgeInsets.symmetric(
                //           horizontal: 10.0,
                //         ),
                //         hintText: "Sale Price",
                //         hintStyle: TextStyle(fontSize: 12.0),
                //         border: OutlineInputBorder(
                //           borderRadius: BorderRadius.all(
                //             Radius.circular(10.0),
                //           ),
                //         ),
                //       ),
                //     ),
                //   ) : const SizedBox.shrink();
                // }),


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
                    //product model
                    EasyLoading.show(status: 'Updating...');
                    ProductModel newProductModel = ProductModel(
                        productId: widget.productModel.productId,
                        categoryId: categoryController.selectedCategoryId.toString(),
                        productName: productNameController.text.trim(),
                        categoryName: categoryController.selectedCategoryName.toString(),
                        salePrice: salePriceController.text != ''? salePriceController.text.trim():'',
                        fullPrice: fullPriceController.text.trim(),
                        productImages: widget.productModel.productImages,
                        deliveryTime: deliveryTimeController.text.trim(),
                        isSale: isSaleController.isSale.value,
                        productDescription: productDescriptionController.text.trim(),
                        createdAt: widget.productModel.createdAt,
                        updatedAt: DateTime.now(),
                    );

                    await FirebaseFirestore.instance
                        .collection('products')
                        .doc(widget.productModel.productId)
                        .update(newProductModel.toMap());

                    EasyLoading.showSuccess('Item successfully updated');
                  },
                  child: const Text("Update"),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
