import 'package:flutter/material.dart';
import './dummy_data.dart';
import './models/meal.dart';
import './screens/fliters_screen.dart';
import './screens/tabs_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/category_meals_screen.dart';
import './screens/categories_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;

      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose'] && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan'] && !meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian'] && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    final existingIndex =
        _favoriteMeals.indexWhere((meal) => meal.id == mealId);
    if (existingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  bool isMealFavorite(String id) {
    return _favoriteMeals.any((meal) => meal.id == id);
  }

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  @override
  Widget build(BuildContext context) {
    //#1 setup of theme and text
    return MaterialApp(
      title: 'Meal App',
      theme: ThemeData(
          primarySwatch: Colors.pink,
          accentColor: Colors.pinkAccent,
          canvasColor: Color.fromRGBO(255, 254, 229, 1),
          fontFamily: 'Raleway',
          textTheme: ThemeData.light().textTheme.copyWith(
                // ignore: deprecated_member_use
                body1: TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                ),
                // ignore: deprecated_member_use
                body2: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
                // ignore: deprecated_member_use
                title: TextStyle(
                  fontSize: 20,
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.bold,
                ),
              )),
      // #2 calling another class
      //home: CategoriesScreen(),
      //#01 routes for navigation, consists of {map} and String '' which identify route, then : is creation function stream
      initialRoute:
          '/', //in case if flutter doesnot recognise the default way to homeScreen
      routes: {
        '/': (ctx) => TabsScreen(_favoriteMeals), //default way for homescreen
        CategoryMealsScreen.routeName: (ctx) =>
            CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (ctx) =>
            MealDetailScreen(_toggleFavorite, isMealFavorite),
        FiltersScreen.routeName: (ctx) => FiltersScreen(_filters, _setFilters),
      },
      // if page has no next page route, then it will display this default route page to avoid blank error
      onGenerateRoute: (settings) {
        print(settings.arguments);
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
    );
  }
}
