import 'package:flutter/material.dart';
import '../screens/category_meals_screen.dart';

class CategoryItem extends StatelessWidget {
  //#8 attributes for receiving this data from CategoriesScreen Class
  final String id;
  final String title;
  final Color color;

  CategoryItem(this.id, this.title, this.color);

  //#10 push to next page when the grid is clicked
  void selectCategory(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(CategoryMealsScreen.routeName,
        arguments: {'id': id, 'title': title}); //#02 sending to route address
  }

  @override
  Widget build(BuildContext context) {
    //#9 InkWell is for clickable grid with animation with further setups
    return InkWell(
      onTap: () => selectCategory(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(15),
        // ignore: deprecated_member_use
        child: Text(
          title,
          // ignore: deprecated_member_use
          style: Theme.of(context).textTheme.title,
        ),
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color.withOpacity(0.7), color],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(15)),
      ),
    );
  }
}
