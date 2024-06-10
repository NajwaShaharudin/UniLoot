import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_loot/controllers/category_controller.dart';
import 'package:uni_loot/controllers/is_sale_controller.dart';
import 'package:uni_loot/models/product_model.dart';
import 'package:uni_loot/screens/admin_panel/add_products_screen.dart';
import 'package:uni_loot/screens/admin_panel/edit_item_screen.dart';
import 'package:uni_loot/screens/admin_panel/item_details_screen.dart';
import 'package:uni_loot/utils/app_constant.dart';


class AdminAllItems extends StatefulWidget {
  const AdminAllItems({super.key});

  @override
  State<AdminAllItems> createState() => _AdminAllItems();
}

class _AdminAllItems extends State<AdminAllItems> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Items"),
        centerTitle: true,
        backgroundColor: AppConstant.appMainColor,
        actions: [
          GestureDetector(
            onTap: () => Get.to(() => AddItemsScreen()),
            child: const Padding(
              padding: EdgeInsets.all(10.0),
              child: Icon(Icons.add),
            ),
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('products')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("Error"));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CupertinoActivityIndicator());
          }

          if (snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No items found!"));
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

                ProductModel productModel = ProductModel(
                    productId: data['productId'],
                    categoryId: data['categoryId'],
                    productName: data['productName'],
                    categoryName: data['categoryName'],
                    salePrice: data['salePrice'],
                    fullPrice: data['fullPrice'],
                    productImages: data['productImages'],
                    deliveryTime: data['deliveryTime'],
                    isSale: data['isSale'],
                    productDescription: data['productDescription'],
                    createdAt: data['createdAt'],
                    updatedAt: data['updatedAt']);

                return InkWell(
                  onTap: () => Get.to(
                      () => ItemDetailsScreen(productModel: productModel)),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: CachedNetworkImage(
                          imageUrl: productModel.productImages[0],
                          width: 80.0,
                          height: 80.0,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            color: Colors.grey[200],
                            child: const Center(child: CircularProgressIndicator()),
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
                                  productModel.productName,
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4.0),
                                Text(
                                  productModel.productId,
                                  style: const TextStyle(fontSize: 14.0),
                                ),
                              ],
                            ),
                        GestureDetector(
                              onTap: () {
                                final editItemCategory =
                                    Get.put(CategoryController());
                                final isSaleController =
                                Get.put(IsSaleController());
                                editItemCategory
                                    .setOldValue(productModel.categoryId);
                                isSaleController.setIsSaleOldValue(productModel.isSale);
                                Get.to(() =>
                                    EditItemScreen(productModel: productModel));
                              },
                              child: const Icon(Icons.edit),
                            )
                          ],
                        ),
                      ),
                    ],
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
