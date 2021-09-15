import 'package:flutter/material.dart';
import '../dummy_data.dart';
import '../widgets/category_item.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //#3 first page of app display
    //#4 grids display
    return GridView(
      //#5 padding around grids
      padding: EdgeInsets.all(20),
      //#6 calling dummy_data class which consists of data for gridview to be displayed
      //also forwarding the each attributes to CategoryItem Class
      children: DUMMY_CATEGORIES
          .map((catData) =>
              CategoryItem(catData.id, catData.title, catData.color))
          .toList(),
      //#7 gridview setup
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20),
    );
  }
}
