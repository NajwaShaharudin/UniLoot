

import 'package:cloud_firestore/cloud_firestore.dart';

class CategoriesModel {
  final String categoryId;
  final String categoryImg;
  final String categoryName;
  final Timestamp createdAt;
  final Timestamp updatedAt;

  CategoriesModel({
    required this.categoryId,
    required this.categoryImg,
    required this.categoryName,
    required this.createdAt,
    required this.updatedAt
  });
  
  //Serialize the UserModel instance to a JSON map
  Map<String, dynamic> toMap() {
    return {
      'categoryId': categoryId,
      'categoryImg': categoryImg,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
  
  //Create a UserModel instance from a JSON map
factory CategoriesModel.fromMap(Map<String, dynamic> json){
    return CategoriesModel(
        categoryId: json['categoryId'],
        categoryImg: json['categoryImg'],
        categoryName: json['categoryName'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt']
    );
}
  
  }

