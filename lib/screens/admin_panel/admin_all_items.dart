import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_loot/models/product_model.dart';
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
          title: Text("All Item"),
          centerTitle: true,
          backgroundColor: AppConstant.appMainColor,
        ),
        body: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection('products')
              .orderBy('createdAt', descending: true)
              .get(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(snapshot.hasError) {
              return Container(
                child: Center(
                  child: Text("Error"),
                ),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting){
              return Container(
                child: Center(
                  child: CupertinoActivityIndicator(),
                ),
              );
            }
            if(snapshot.data!.docs.isEmpty){
              return Container(
                child: Center(
                  child: Text("No items found!"),
                ),
              );
            }

            if(snapshot.data != null) {
              return ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
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
                        updatedAt: data['updatedAt']
                    );


                    return Card(
                      elevation: 5,
                      child: ListTile(
                        onTap: () {
                          Get.to(() => ItemDetailsScreen(
                              productModel: productModel));
                        },

                        leading: CircleAvatar(
                          backgroundColor: AppConstant.appSecondaryColor,
                          backgroundImage: CachedNetworkImageProvider(
                            productModel.productImages[0],
                            errorListener: (err) {
                              print('Error loading image');
                              Icon(Icons.error);
                            },
                          ),
                        ),
                        title: Text(productModel.productName),
                        subtitle: Text(productModel.productId),
                        trailing: Icon(Icons.arrow_forward_ios),

                      ),
                    );
                  }
              );
            }
            return Container();
          },
        )
    );
  }
}
