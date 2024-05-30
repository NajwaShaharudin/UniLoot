import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_loot/models/order_model.dart';
import 'package:uni_loot/screens/admin_panel/single_order_screen.dart';
import 'package:uni_loot/utils/app_constant.dart';

class DetailsCustomerOrderScreen extends StatelessWidget {
  String docId;
  String customerName;

  DetailsCustomerOrderScreen({
    super.key,
    required this.docId,
    required this.customerName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        title: Text(customerName, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance
            .collection('orders')
            .doc(docId)
            .collection('confirmOrders')
            .orderBy('createdAt', descending: true)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("Error", style: TextStyle(color: Colors.red)));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CupertinoActivityIndicator());
          }

          if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text("No orders found!", style: TextStyle(color: Colors.grey)),
            );
          }

          return ListView.builder(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final data = snapshot.data!.docs[index];
              String orderDocId = data.id;

                OrderModel orderModel = OrderModel(
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
                updatedAt: data ['updatedAt'],
                productQuantity: data['productQuantity'],
                productTotalPrice: data['productTotalPrice'],
                customerId: data['customerId'],
                status: data['status'],
                customerName: data['customerName'],
                customerPhone: data['customerPhone'],
                customerAddress: data['customerAddress'],
                customerDeviceToken: data['customerDeviceToken'],

              );

              return Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  onTap: () => Get.to(() => SingleOrderScreen(
                    docId: snapshot.data!.docs[index].id,
                    orderModel: orderModel,
                  )),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  leading: CircleAvatar(
                    backgroundColor: AppConstant.appSecondaryColor,
                    child: Text(data['customerName'][0], style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                  title: Text(data['customerName'], style: TextStyle(fontSize: 16)),
                  subtitle: Text(orderModel.productName, style: TextStyle(fontSize: 14)),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextButton.icon(
                        onPressed: () => showBottomSheet(
                          userDocId: docId,
                          orderModel: orderModel,
                          orderDocId: orderDocId,
                        ),
                        icon: Icon(Icons.more_vert, color: Colors.grey),
                        label: Text(''),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

void showBottomSheet({required String userDocId, required OrderModel orderModel, required String orderDocId}) {
  Get.bottomSheet(
      Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: () async {
                        await FirebaseFirestore.instance
                            .collection('orders')
                            .doc(userDocId)
                            .collection('confirmOrders')
                            .doc(orderDocId)
                            .update(
                          {
                            'status': false,
                          },
                        );
                      }, child: Text('Pending')),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: () async {
                        await FirebaseFirestore.instance
                            .collection('orders')
                            .doc(userDocId)
                            .collection('confirmOrders')
                            .doc(orderDocId)
                            .update(
                          {
                            'status': true,
                          },
                        );
                      },
                      child: Text('Delivered')),
                ),
              ],
              )
              ],
          ),
      ),
  );
}
