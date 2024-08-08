import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:uni_loot/models/order_model.dart';
import 'package:uni_loot/models/reviews_model.dart';
import 'package:uni_loot/utils/app_constant.dart';

class UserReviewScreen extends StatefulWidget {
  final OrderModel orderModel;
  const UserReviewScreen({super.key, required this.orderModel});

  @override
  State<UserReviewScreen> createState() => _UserReviewScreenState();
}

class _UserReviewScreenState extends State<UserReviewScreen> {
  TextEditingController feedbackController = TextEditingController();
  double productRating = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        title: const Text("Add Reviews"),
      ),
      body: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Add your rating and review"),
          const SizedBox(
            height: 20.0,
          ),
          RatingBar.builder(
          initialRating: 0,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) =>
          const Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            productRating = rating;
            print(productRating);
            setState(() {});
          },
        ),
            const Text("Feedback"),
            TextFormField(
              controller: feedbackController,
              decoration: const InputDecoration(label: Text("Share your feedback")),
            ),
            const SizedBox(
              height: 20.0,
            ),
            ElevatedButton(onPressed: () async {
              EasyLoading.show(status: "Please wait..");
              String feedback = feedbackController.text.trim();
              User? user = FirebaseAuth.instance.currentUser;
                // print(feedback);
                // print(productRating);

              ReviewsModel reviewModel = ReviewsModel(
                  customerName: widget.orderModel.customerName,
                  customerPhone: widget.orderModel.customerPhone,
                  customerDeviceToken: widget.orderModel.customerDeviceToken,
                  customerId: widget.orderModel.customerId,
                  feedback: feedback,
                  rating: productRating.toString(),
                    createdAt: DateTime.now(),
                  );

                  await FirebaseFirestore.instance
                      .collection('products')
                      .doc(widget.orderModel.productId)
                      .collection('review')
                      .doc(user!.uid)
                      .set(reviewModel.toMap());

                  EasyLoading.dismiss();
                },
                child: const Text("Submit"))
          ],
        ),
      ),
    );
  }
}
