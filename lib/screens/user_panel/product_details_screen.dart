import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_loot/models/cart_model.dart';
import 'package:uni_loot/models/product_model.dart';
import 'package:uni_loot/screens/user_panel/cart_screen.dart';
import 'package:uni_loot/utils/app_constant.dart';

class ProductDetailsScreen extends StatefulWidget {
  ProductModel productModel;
   ProductDetailsScreen({super.key, required this.productModel});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {

  User? user=FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: AppConstant.appMainColor,
        title: Text("Item Details"),
        actions: [
          GestureDetector(
            onTap: () => Get.to(() => CartScreen()),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.shopping_cart,
              ),
            ),
          )
        ],
      ),
      body: Container(
        child: Column(
          children: [
            //product images

            SizedBox(height:Get.height / 60,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: CachedNetworkImage(
                imageUrl: widget.productModel.productImages[0], // Use the first image
                fit: BoxFit.cover,
                width: Get.width, // Set width to match screen width
                height: Get.height / 2, // Adjust height as needed
                placeholder: (context, url) => ColoredBox(
                  color: Colors.white,
                  child: Center(
                    child: CupertinoActivityIndicator(),
                  ),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            Padding(padding: EdgeInsets.all(8.0),
            child: Card(
              elevation: 5.0,
              shape:RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
            ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      alignment: Alignment.topLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.productModel.productName,
                          ),
                          
                          Icon(Icons.favorite_outline)
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      alignment: Alignment.topLeft,
                      child: Row(
                        children: [

                          widget.productModel.isSale == true &&
                              widget.productModel.salePrice != ''?
                          Text(
                            "RM: " + widget.productModel.salePrice,
                          ): Text("RM: " + widget.productModel.fullPrice,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Category: " + widget.productModel.categoryName,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Description : " + widget.productModel.productDescription,
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Material(
                          child: Container(
                            width: Get.width/3.0,
                            height: Get.height/16,
                            decoration: BoxDecoration(
                                color: AppConstant.appSecondaryColor,
                                borderRadius:BorderRadius.circular((20.0),)
                            ),
                            child: TextButton(
                              child: Text(
                                "Chat",
                                style: TextStyle(color: AppConstant.appTextColor),
                              ),
                              onPressed: (){
                                // sendMessageonWhatsApp(
                                //   productModel: widget.productModel,
                                // );
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5.0,),
                        Material(
                          child: Container(
                            width: Get.width/3.0,
                            height: Get.height/16,
                            decoration: BoxDecoration(
                                color: AppConstant.appSecondaryColor,
                                borderRadius:BorderRadius.circular((20.0),)
                            ),
                            child: TextButton(
                              child: Text(
                                "Add to cart",
                                style: TextStyle(color: AppConstant.appTextColor),
                              ),
                              onPressed: () async {
                                //Get.to(() => SignInScreen());
                                await checkProductExistence(uId: user!.uid );
                              },
                            ),
                          ),
                        ),
                    ],)
                  ),
                ],
              ),
            ),
            )
          ],
        ),
      ),
    );
  }

  // static Future<void> sendMessageonWhatsApp({
  //   required ProductModel productModel,
  // }) async {
  //   final number = "+01156290036";
  //   final message = "Hello UniLoot \n I want to know about this product \n ${productModel.productName} \n ${productModel.productId}";
  //
  //   final url = ('https:/wa.me/$number?text=${Uri.encodeComponent(message)}');
  //
  //   if(await canLaunch(url)){
  //     await launchUrl(url as Uri );
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

  //check items exist or not
  Future<void> checkProductExistence({
    required String uId,
    int quantityIncrement = 1,
  }) async {
    final DocumentReference documentReference
    = FirebaseFirestore.instance
        .collection('cart')
        .doc(uId)
        .collection('cartOrders')
        .doc(widget.productModel.productId.toString());

    DocumentSnapshot snapshot = await documentReference.get();

    if(snapshot.exists){
      int currentQuantity = snapshot['productQuantity'];
      int updatedQuantity = currentQuantity + quantityIncrement;
      double totalPrice = double.parse(widget.productModel.isSale ? widget.productModel.salePrice : widget.productModel.fullPrice) * updatedQuantity;

      await documentReference.update({
        'productQuantity': updatedQuantity,
        'productTotalPrice': totalPrice
      });
      
        print("Items exists");

    }else{
      await FirebaseFirestore.instance.collection('cart').doc(uId).set(
          {
            'uId': uId,
            'createdAt': DateTime.now(),
          },
      );
      CartModel cartModel = CartModel(
          productId: widget.productModel.productId,
          categoryId: widget.productModel.categoryId,
          productName: widget.productModel.productName,
          categoryName: widget.productModel.categoryName,
          salePrice: widget.productModel.salePrice,
          fullPrice: widget.productModel.fullPrice,
          productImages: widget.productModel.productImages,
          deliveryTime: widget.productModel.deliveryTime,
          isSale: widget.productModel.isSale,
          productDescription: widget.productModel.productDescription,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          productQuantity: 1,
          productTotalPrice: double.parse(widget.productModel.fullPrice),
      );
      
      await documentReference.set(cartModel.toMap());

      print("Items added");
    }
  }
}
