import 'package:get/get.dart';

class isSaleController extends GetxController {
  RxBool isSale = false.obs;

  void toggleIsSale(bool value){
    isSale.value = value;
    update();
  }
}