import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/main_drawer.dart';
import '../screens/favorites_screen.dart';
import '../screens/categories_screen.dart';

// #18 creating a stateful widget for Tabs
class TabsScreen extends StatefulWidget {
  final List<Meal> favoriteMeals;

  TabsScreen(this.favoriteMeals);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  //#21 Map consists of two pages with key and titles
  List<Map<String, Object>> _pages;
  //#22 store the page number
  int _selectedPageIndex = 0;

  @override
  void initState() {
    _pages = [
      {'page': CategoriesScreen(), 'title': 'Categories'},
      {
        'page': FavoritesScreen(widget.favoriteMeals),
        'title': 'Your Favorites'
      },
    ];
    super.initState();
  }

  //#23 storing the page number after taking it from the body
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    //#19 AppBar, bottomnavigationBar and body
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title']),
      ),
      //#26 Menu option on AppBar
      drawer: MainDrawer(),
      //#25 body will display from the Map after receiving the page Index and key
      body: _pages[_selectedPageIndex]['page'],
      //#20 creating a bottomNavigationBar
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        //#24 will count the current page number
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            // ignore: deprecated_member_use
            title: Text('Categories'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              // ignore: deprecated_member_use
              title: Text('Favorites')),
        ],
      ),
    );
  }
}
