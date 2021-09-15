import 'package:flutter/material.dart';
import '../dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  //#16 new Widget for section title
  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        // ignore: deprecated_member_use
        style: Theme.of(context).textTheme.title,
      ),
    );
  }

  //#17 new widget for box of ingredients and steps
  Widget buildContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: 150,
      width: 300,
      child: child,
    );
  }

  final Function toggleFavorite;
  final Function isFavorite;

  MealDetailScreen(this.toggleFavorite, this.isFavorite);

  static const routeName = '/meal-detail';

  @override
  Widget build(BuildContext context) {
    //#16 receiving meal id and then passing
    final mealId = ModalRoute.of(context).settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    //#16 adding appbar title on new page and image using id
    return Scaffold(
      appBar: AppBar(
          title: Text(
        '${selectedMeal.title}',
      )),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                selectedMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            //#17 passing title
            buildSectionTitle(context, 'Ingredients'),
            //#18 to display list of ingredients
            buildContainer(
              ListView.builder(
                  itemBuilder: (ctx, index) => Card(
                        color: Theme.of(context).accentColor,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 10,
                          ),
                          child: Text(selectedMeal.ingredients[index],
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                  itemCount: selectedMeal.ingredients.length),
            ),
            //#17
            buildSectionTitle(context, 'Steps'),
            //#18 to display list of steps
            buildContainer(
              ListView.builder(
                itemBuilder: (ctx, index) => Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        child: Text('# ${(index + 1)}'),
                      ),
                      title: Text(selectedMeal.steps[index]),
                    ),
                    Divider(),
                  ],
                ),
                itemCount: selectedMeal.steps.length,
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child:
            Icon(isFavorite(mealId) ? Icons.favorite : Icons.favorite_border),
        onPressed: () => toggleFavorite(mealId),
      ),
    );
  }
}
