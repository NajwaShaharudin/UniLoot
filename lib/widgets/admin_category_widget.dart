import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_loot/controllers/category_controller.dart';

class AdminCategoryWidget extends StatelessWidget {
  const AdminCategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryController>(
      init: CategoryController(),
        builder: (categoryController){
        return Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Card(
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton<String>(
                  value: categoryController.selectedCategoryId?.value,
                  items: categoryController.categories.map((category){
                        return DropdownMenuItem<String>(
                          value: category['categoryId'].toString(),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                    category['categoryImg'].toString(),
                                ),
                              ),
                              const SizedBox(width: 20.0),
                             Expanded(child: Text(
                                 category['categoryName'],
                                 overflow: TextOverflow.ellipsis,
                             ),
                             ),
                            ],
                          ),
                        );
                  }).toList(),
                  onChanged: (String? selectedValue) async {
                    categoryController
                        .setSelectedCategory(selectedValue);
                    String? categoryName = await categoryController.getCategoryName(selectedValue);
                    categoryController.setCategoryName(categoryName);
                  },
                  hint: const Text('Select Category'),
                  isExpanded: true,
                  elevation: 10,
                  underline: const SizedBox.shrink(),
                ),
              ),
            ),
            ),
          ],
        );
        },);
  }
}
