import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:uni_loot/models/order_model.dart';
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
            ElevatedButton(onPressed: (){
                String feedback = feedbackController.text.trim();
                print(feedback);
                print(productRating);
            }, child: const Text("Submit"))
          ],
        ),
      ),
    );
  }
}
