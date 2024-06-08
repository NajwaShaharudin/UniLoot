

import 'package:uuid/uuid.dart';

class GenerateIds{
  String generateProductId(){
    String formatedProductId;
    String uuid = const Uuid().v4();

    //customize id
    formatedProductId = "uni-loot-${uuid.substring(0, 5)}";

    //return
    return formatedProductId;
  }


}