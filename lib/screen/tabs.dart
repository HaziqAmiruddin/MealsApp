import 'package:flutter/material.dart';
//import 'package:meals/data/dummy_data.dart';
//import 'package:meals/models/meal.dart';
import 'package:meals/screen/categories.dart';
import 'package:meals/screen/filters.dart';
import 'package:meals/screen/meals.dart';
import 'package:meals/widget/main_drawer.dart';
//import 'package:meals/providers/meals_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/favorite_provider.dart';
import 'package:meals/providers/filters_provider.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;
  //now we are using favorite provider this no longer need
  //final List<Meal> _favoriteMeals = [];
  //using filter provider now
  //Map<Filter, bool> _selectedFilters = kInitialFilters;

  //move to meal_details screen
  // void _showInfoMessage(String message) {
  //   ScaffoldMessenger.of(context).clearSnackBars();
  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //     duration: const Duration(seconds: 2),
  //     content: Text(message),
  //   ));
  // }

  //now we are using favorite provider this no longer need
  // void _toggleMealFavoriteStatus(Meal meal) {
  //   final isExisting = _favoriteMeals.contains(meal);

  //   if (isExisting) {
  //     setState(() {
  //       _favoriteMeals.remove(meal);
  //       _showInfoMessage('You Remove It From Favorite');
  //     });
  //   } else {
  //     setState(() {
  //       _favoriteMeals.add(meal);
  //       _showInfoMessage('Add To Favorite');
  //     });
  //   }
  // }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop;
    if (identifier == 'filters') {
      //we dont need any input from the filter screen anymore
      //final result =
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => const FiltersScreen(
              //using filter provider now
              //currentFilters: _selectedFilters,
              ),
        ),
      );
      //using filter provider/we dont need any input from the filter screen anymore
      // setState(() {
      //   _selectedFilters = result ?? kInitialFilters;
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    //dont need this anymore because all commnicate to filter provider
    // final meals = ref.watch(mealsProvider);
    // final activeFilter = ref.watch(filtersProvider);
    final availableMeals = ref.watch(filteredMealsprovider);
    // move to filter provider
    // meals.where(
    //   (meal) {
    //     if (activeFilter[Filter.glutenFree]! && !meal.isGlutenFree) {
    //       return false;
    //     }
    //     if (activeFilter[Filter.lactoseFree]! && !meal.isLactoseFree) {
    //       return false;
    //     }
    //     if (activeFilter[Filter.vegetarian]! && !meal.isVegetarian) {
    //       return false;
    //     }
    //     if (activeFilter[Filter.vegan]! && !meal.isVegan) {
    //       return false;
    //     }
    //     return true;
    //   },
    // ).toList();

    Widget activePage = CategoriesScreen(
      //now we are using favorite provider this no longer need
      //onToggleFavorite: _toggleMealFavoriteStatus,
      availableMeals: availableMeals,
    );
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      final favoriteMealsFromProvider = ref.watch(favoriteMealsProvider);
      activePage = MealsScreen(
        meals: favoriteMealsFromProvider,
        //now we are using favorite provider this no longer need
        //onToggleFavorite: _toggleMealFavoriteStatus,
      );
      activePageTitle = 'Favorite';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(onSelectScreen: _setScreen),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
        ],
      ),
    );
  }
}
