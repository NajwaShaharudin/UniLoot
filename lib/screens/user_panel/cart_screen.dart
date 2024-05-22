import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_loot/utils/app_constant.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        title: Text('Your Cart'),
      ),
      body: Container(
        child: ListView.builder(
            itemCount: 20,
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index){
              return Card(
                elevation: 5,
                color: AppConstant.appTextColor,
                child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: AppConstant.appMainColor,
                      child: Text("N"),
                    ),
                    title: Text("New Dress for womens"),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("2200"),
                      SizedBox(width: Get.width / 20.0,
                      ),
                      CircleAvatar(
                        radius: 18.0,
                        backgroundColor: AppConstant.appMainColor,
                        child: Text('-'),
                      ),
                      SizedBox(width: Get.width / 20.0,
                      ),
                      CircleAvatar(
                        radius: 18.0,
                        backgroundColor: AppConstant.appMainColor,
                        child: Text('+'),
                      )
                    ],
                  ),
                  ),
              );
            },
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Total"),
            SizedBox(
              width: Get.width / 40,
            ),
            Text("RM 50.30", style: TextStyle(fontWeight: FontWeight.bold),),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                child: Container(
                  width: Get.width/2.0,
                  height: Get.height/18,
                  decoration: BoxDecoration(
                      color: AppConstant.appSecondaryColor,
                      borderRadius:BorderRadius.circular((20.0),)
                  ),
                  child: TextButton(
                    child: Text(
                      "Checkout",
                      style: TextStyle(color: AppConstant.appTextColor),
                    ),
                    onPressed: (){},
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
