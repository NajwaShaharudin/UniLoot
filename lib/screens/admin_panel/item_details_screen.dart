import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_loot/models/product_model.dart';
import 'package:uni_loot/utils/app_constant.dart';

class ItemDetailsScreen extends StatelessWidget {
  ProductModel productModel;
  ItemDetailsScreen({
    super.key,
    required this.productModel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        title: Text(productModel.productName),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hero image for the product
              Hero(
                tag: productModel.productId, // Unique tag for animation
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    productModel.productImages[0],
                    width: Get.width,
                    height: Get.height * 0.5, // Adjust height as needed
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 16.0), // Spacing between image and details

              // Product details section
              Text(
                productModel.productName,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                productModel.productDescription,
                style: const TextStyle(fontSize: 16.0),
              ),
              const SizedBox(height: 16.0),

              // Info Row with icons (consider using Iconly or similar package)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildInfoRow(Icons.monetization_on, productModel.fullPrice),
                  _buildInfoRow(Icons.delivery_dining, productModel.deliveryTime),
                ],
              ),
              const SizedBox(height: 16.0),

              // Sale badge (if applicable)
              if (productModel.isSale)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(
                    "Sale!",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build info row with icon and text
  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey),
        const SizedBox(width: 8.0),
        Text(text, style: const TextStyle(fontSize: 16.0)),
      ],
    );
  }
}
