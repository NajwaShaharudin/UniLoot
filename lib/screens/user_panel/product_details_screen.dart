import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:uni_loot/controllers/rating_controller.dart';
import 'package:uni_loot/models/cart_model.dart';
import 'package:uni_loot/models/product_model.dart';
import 'package:uni_loot/models/reviews_model.dart';
import 'package:uni_loot/screens/user_panel/cart_screen.dart';
import 'package:uni_loot/utils/app_constant.dart';

class ProductDetailsScreen extends StatefulWidget {
  ProductModel productModel;
   ProductDetailsScreen({super.key, required this.productModel});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    CalculateProductRatingController calculateProductRatingController =
    Get.put(CalculateProductRatingController(widget.productModel.productId));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        title: const Text("Item Details"),
        actions: [
          GestureDetector(
            onTap: () => Get.to(() => const CartScreen()),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.shopping_cart,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
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
                  color: Colors.grey.shade200,
                  child: const Center(
                    child: CupertinoActivityIndicator(),
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            Padding(padding: const EdgeInsets.all(8.0),
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
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const Icon(Icons.favorite_outline)
                        ],
                      ),
                    ),
                  ),
                  //review
                    Row(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          child: RatingBar.builder(
                            glow: false,
                            ignoreGestures: true,
                            initialRating: double.parse(
                                calculateProductRatingController.averageRating
                                    .toString()),
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 25,
                            itemPadding:
                                const EdgeInsets.symmetric(horizontal: 2.0),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (value) {},
                          ),
                        ),
                        Text(calculateProductRatingController.averageRating.toString()),
                      ],
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
                        const SizedBox(
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
                              child: const Text(
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
            ),
            //reviews
            FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('products')
                  .doc(widget.productModel.productId)
                  .collection('review')
                  .get(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text("Error"),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting){
                  return Container(
                    height: Get.height / 5,
                    child: const Center(
                      child: CupertinoActivityIndicator(),
                    ),
                  );
                }
                if(snapshot.data!.docs.isEmpty){
                  return const Center(child: Text("No reviews found!"),
                  );
                }

                if(snapshot.data != null) {
                  return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index){
                      var data = snapshot.data!.docs[index];
                      ReviewsModel reviewModel = ReviewsModel(
                          customerName: data['customerName'],
                          customerPhone: data['customerPhone'],
                          customerDeviceToken: data['customerDeviceToken'],
                          customerId: data['customerId'],
                          feedback: data['feedback'],
                          rating: data['rating'],
                          createdAt: data['createdAt'],
                      );
                      return Card(
                        elevation: 5,
                        child: ListTile(
                          leading: CircleAvatar(child: Text(reviewModel.customerName[0]),
                          ),
                          title: Text(reviewModel.customerName),
                          subtitle: Text(reviewModel.feedback),
                          trailing: Text(reviewModel.rating),
                        ),
                      );
                    },
                  );
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }


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
