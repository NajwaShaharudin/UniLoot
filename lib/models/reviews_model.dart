

class ReviewsModel {
  final String customerName;
  final String customerPhone;
  final String customerDeviceToken;
  final String customerId;
  final String feedback;
  final String rating;
  final dynamic createdAt;

  ReviewsModel({
    required this.customerName,
    required this.customerPhone,
    required this.customerDeviceToken,
    required this.customerId,
    required this.feedback,
    required this.rating,
    required this.createdAt,
});

  Map<String, dynamic> toMap() {
    return {
      'customerName': customerName,
      'customerPhone': customerPhone,
      'customerDeviceToken' : customerDeviceToken,
      'customerId': customerId,
      'feedback': feedback,
      'rating': rating,
      'createdAt': createdAt,
    };
  }

  factory ReviewsModel.fromMap(Map<String, dynamic> json) {
    return ReviewsModel(
        customerName: json['customerName'],
        customerPhone: json['customerPhone'],
        customerDeviceToken: json ['customerDeviceToken'],
        customerId: json ['customerId'],
        feedback: json ['feedback'],
        rating: json ['rating'],
        createdAt: json ['createdAt'],
    );
  }
}