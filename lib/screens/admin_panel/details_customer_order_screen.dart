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
    super.key, required this.docId, required this.customerName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        title: Text(customerName),
      ),
      body:  FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('orders').doc(docId)
            .collection('confirmOrders')
            .orderBy('createdAt', descending: true)
            .get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(snapshot.hasError) {
            return Container(
              child: const Center(
                child: Text("Error"),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting){
            return Container(
              child: const Center(
                child: CupertinoActivityIndicator(),
              ),
            );
          }
          if(snapshot.data!.docs.isEmpty){
            return Container(
              child: const Center(
                child: Text("No orders found!"),
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
                    elevation: 5,
                    child: ListTile(
                      onTap: () => Get.to(() => SingleOrderScreen(
                        docId: snapshot.data!.docs[index].id,
                        orderModel:orderModel,
                      )),

                      leading: CircleAvatar(
                        backgroundColor: AppConstant.appSecondaryColor,
                        child: Text(data['customerName'][0]),
                      ),
                      title: Text(data['customerName']),
                      subtitle: Text(orderModel.productName),
                      trailing: InkWell(
                        onTap: (){
                          showBottomSheet(
                            userDocId: docId,
                            orderModel: orderModel,
                            orderDocId: orderDocId,
                          );
                        },
                        child: Icon(Icons.more_vert),
                      ),

                    ),
                  );
                }
            );
          }
          return Container();
        },
      ),
    );
  }
}

void showBottomSheet({required String userDocId, required OrderModel orderModel, required String orderDocId}){
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
