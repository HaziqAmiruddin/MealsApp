import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screen/meals.dart';
import 'package:meals/widget/category_grid_item.dart';
import 'package:meals/models/category.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen(
      {super.key,
      //now we are using favorite provider this no longer need
      //required this.onToggleFavorite,
      required this.availableMeals});

  //now we are using favorite provider this no longer need
  //final void Function(Meal meal) onToggleFavorite;
  final List<Meal> availableMeals;

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = availableMeals
        .where(
          (meal) => meal.categories.contains(category.id),
        )
        .toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filteredMeals,
          //now we are using favorite provider this no longer need
          //onToggleFavorite: onToggleFavorite,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: [
        for (final category in availableCategories)
          CategoryGridItem(
              category: category,
              onSelectCategory: () {
                _selectCategory(context, category);
              })

        // Text('1', style: TextStyle(color: Colors.white)),
        // Text('2', style: TextStyle(color: Colors.white)),
        // Text('3', style: TextStyle(color: Colors.white)),
        // Text('4', style: TextStyle(color: Colors.white)),
        // Text('5', style: TextStyle(color: Colors.white)),
        // Text('6', style: TextStyle(color: Colors.white)),
      ],
    );
  }
}
