import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/screen/meals.dart';
import 'package:meals/widget/category_grid_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  void _selectCategory(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => const MealsScreen(
          title: 'Some Title',
          meals: [],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick your category'),
      ),
      body: GridView(
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
                  _selectCategory(context);
                })

          // Text('1', style: TextStyle(color: Colors.white)),
          // Text('2', style: TextStyle(color: Colors.white)),
          // Text('3', style: TextStyle(color: Colors.white)),
          // Text('4', style: TextStyle(color: Colors.white)),
          // Text('5', style: TextStyle(color: Colors.white)),
          // Text('6', style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
