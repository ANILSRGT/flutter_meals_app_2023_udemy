import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../widgets/items/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-meals';
  final List<Meal> availableMeals;
  const CategoryMealsScreen(this.availableMeals, {super.key});

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  late final String _categoryTitle;
  late List<Meal> _displayedMeals;
  var _loadedInitData = false;

  @override
  void didChangeDependencies() {
    if (!_loadedInitData) {
      final routeArgs = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
      final categoryId = routeArgs['id']!;
      _categoryTitle = routeArgs['title']!;
      _displayedMeals = widget.availableMeals.where((m) => m.categories.contains(categoryId)).toList();
      _loadedInitData = true;
    }
    super.didChangeDependencies();
  }

  void _removeMeal(String mealId) {
    setState(() {
      _displayedMeals.removeWhere((m) => m.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_categoryTitle),
      ),
      body: ListView.builder(
        itemCount: _displayedMeals.length,
        itemBuilder: (BuildContext ctx, int index) {
          return MealItem(
            id: _displayedMeals[index].id,
            title: _displayedMeals[index].title,
            imageUrl: _displayedMeals[index].imageUrl,
            duration: _displayedMeals[index].duration,
            complexity: _displayedMeals[index].complexity,
            affordability: _displayedMeals[index].affordability,
          );
        },
      ),
    );
  }
}
