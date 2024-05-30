import 'package:flutter/material.dart';
import 'package:uni_loot/models/order_model.dart';
import 'package:uni_loot/utils/app_constant.dart';

class SingleOrderScreen extends StatelessWidget {
  String docId;
  OrderModel orderModel;
  SingleOrderScreen({
    super.key,
    required this.docId,
    required this.orderModel
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        title: Text('Order', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    orderModel.productName,
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                Text(
                  orderModel.productTotalPrice.toString(),
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 8.0), // Add spacing between sections
            Row(
              children: [
                Text(
                  'Quantity: ' + orderModel.productQuantity.toString(),
                  style: TextStyle(fontSize: 14.0, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Text(
              orderModel.productDescription,
              style: TextStyle(fontSize: 14.0),
            ),
            const SizedBox(height: 16.0), // More spacing after description
            // Image
            Center(
              child: Container(
                width: 150.0,
                height: 200.0, // Adjust image height as needed
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    image: NetworkImage(orderModel.productImages[0]),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16.0), // More spacing after image
            // Customer details
            Text(
              'Customer Information',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text(
              orderModel.customerName,
              style: TextStyle(fontSize: 14.0),
            ),
            const SizedBox(height: 4.0),
            Text(
              orderModel.customerPhone,
              style: TextStyle(fontSize: 14.0),
            ),
            const SizedBox(height: 4.0),
            Text(
              orderModel.customerAddress,
              style: TextStyle(fontSize: 14.0),
            ),
            const SizedBox(height: 4.0),
            Text(
              'Customer ID: ' + orderModel.customerId,
              style: TextStyle(fontSize: 14.0, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}