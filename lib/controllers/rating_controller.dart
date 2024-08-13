
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:get/get.dart';
//
// class CalculateProductRatingController extends GetxController{
//   final String productId;
//   RxDouble averageRating = 0.0.obs;
//
//   CalculateProductRatingController(this.productId);
//
//   @override
//   void onInit(){
//     super.onInit();
//     calculateAverageRating();
//   }
//
//   void calculateAverageRating() {
//     FirebaseFirestore.instance
//         .collection('products')
//         .doc(productId)
//         .collection('review')
//         .snapshots()
//         .listen((snapshot){
//       if (snapshot.docs.isNotEmpty) {
//         double totalRating = 0;
//         int numberOfReviews = 0;
//         snapshot.docs.forEach((doc) {
//           final rating = doc['rating'];
//           if (rating is double) {
//             totalRating += rating;
//             numberOfReviews++;
//           } else if (rating is String) {
//             try {
//               final parsedRating = double.tryParse(rating);
//               if (parsedRating != null) {
//                 totalRating += parsedRating;
//                 numberOfReviews++;
//               } else {
//                 // Handle case where parsing fails (log error, etc.)
//                 print("Error parsing rating: $rating");
//               }
//             } catch (e) {
//               // Handle potential exception during parsing
//               print("Error parsing rating: $rating ($e)");
//             }
//           } else {
//             // Handle unexpected data type for rating
//             print("Unexpected data type for rating: ${doc['rating']}");
//           }
//         });
//         if (numberOfReviews != 0) {
//           averageRating.value = totalRating / numberOfReviews;
//         } else {
//           averageRating.value = 0.0;
//         }
//       } else {
//         averageRating.value = 0.0;
//       }
//     });
//   }
// }