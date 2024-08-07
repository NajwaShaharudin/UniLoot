import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:uni_loot/controllers/cart_price_controller.dart';
import 'package:uni_loot/models/order_model.dart';
import 'package:uni_loot/utils/app_constant.dart';


class CustomerOrderScreen extends StatefulWidget {
  const CustomerOrderScreen({super.key});

  @override
  State<CustomerOrderScreen> createState() => _CustomerOrderScreen();
}

class _CustomerOrderScreen extends State<CustomerOrderScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  final ItemPriceController itemPriceController = Get.put(ItemPriceController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        title: const Text('Your Orders'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('orders')
            .doc(user!.uid)
            .collection('confirmOrders')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(snapshot.hasError) {
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
            return const Center(child: Text("No item added!"),
            );
          }

          if(snapshot.data != null) {
            return  Container(
              child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index){
                  final productData = snapshot.data!.docs[index];
                  OrderModel orderModel = OrderModel(
                    productId: productData['productId'],
                    categoryId: productData['categoryId'],
                    productName: productData['productName'],
                    categoryName: productData['categoryName'],
                    salePrice: productData['salePrice'],
                    fullPrice: productData['fullPrice'],
                    productImages: productData['productImages'],
                    deliveryTime: productData['deliveryTime'],
                    isSale: productData['isSale'],
                    productDescription: productData['productDescription'],
                    createdAt: productData['createdAt'],
                    updatedAt: productData['updatedAt'],
                    productQuantity: productData['productQuantity'],
                    productTotalPrice: double.parse(productData['productTotalPrice'].toString()),
                    customerId: productData['customerId'],
                    status: productData['status'],
                    customerName: productData['customerName'],
                    customerPhone: productData['customerPhone'],
                    customerAddress: productData['customerAddress'],
                    customerDeviceToken: productData['customerDeviceToken']
                  );

                  //calculate price
                  itemPriceController.fetchItemPrice();
                  return  Card(
                    elevation: 5,
                    color: AppConstant.appTextColor,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: AppConstant.appMainColor,
                        backgroundImage: NetworkImage(orderModel.productImages[0]),
                      ),
                      title: Text(orderModel.productName),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(orderModel.productTotalPrice.toString()),
                          const SizedBox(
                            width: 10.0,
                          ),
                          orderModel.status != true
                              ? const Text("Pending...", style: TextStyle(color: Colors.red),)
                              :const Text("Delivered", style: TextStyle(color: Colors.green),)
                        ],
                      ),
                      trailing: orderModel.status == true
                          ? ElevatedButton(
                        onPressed: (){},
                        child: const Text("Review"),
                      )
                          :const SizedBox.shrink(),
                    ),
                  );
                },
              ),
            );
          }
          return Container();
        },
      ),
      );
  }
}
