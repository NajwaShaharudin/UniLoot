

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  RxList<Map<String, dynamic>> categories = <Map<String,dynamic>>[].obs;
  RxString? selectedCategoryId;
  RxString? selectedCategoryName;

  @override
  void onInit(){
    super.onInit();
    fetchCategories();
  }

  Future<void> fetchCategories () async {
    try{
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance.collection('categories').get();

      List<Map<String, dynamic>> categoriesList = [];
      querySnapshot.docs.forEach((DocumentSnapshot<Map<String, dynamic>> document) {
        categoriesList.add({
          'categoryId': document.id,
          'categoryName': document['categoryName'],
          'categoryImg': document['categoryImg'],
        });
      },
      );
      
      categories.value = categoriesList;
      update();
    }catch(e){
      print("error : $e");
    }
  }
  
  //set selected category 
  void setSelectedCategory(String? categoryId){
    selectedCategoryId = categoryId?.obs;
    print("Select category Id $selectedCategoryId");
    update();
  }
  
  //fetch category name
  Future<String?> getCategoryName(String? categoryId) async {
    try{
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('categories')
          .doc(categoryId)
          .get();

        //Fetch category name from snapshot
        if(snapshot.exists){
          return snapshot.data()?['categoryName'];
        }else {
          return null;
        }
    }catch(e){
      print("Error $e");
      return null;
    }
  }
  // set categoryName
  void setSelectedCategoryName(String? categoryName){
    selectedCategoryName = categoryName?.obs;
    print("selected category name $selectedCategoryName");
    update();
  }

  //set old value
  void setOldValue(String? categoryId){
    selectedCategoryId = categoryId?.obs;
    print('selectedCategoryId $selectedCategoryId');
  }
}