import 'package:flutter/material.dart';

import '../dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static const String routeName = '/meal-detail';
  final void Function(String mealId) toggleFavorite;
  final bool Function(String id) isMealFavorite;
  const MealDetailScreen(this.toggleFavorite, this.isMealFavorite, {super.key});

  Widget _buildSectionTile(BuildContext ctx, String text) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        'Ingredients',
        style: Theme.of(ctx).textTheme.titleMedium,
      ),
    );
  }

  Widget _buildContainer({required Widget child}) {
    return Container(
      height: 150,
      width: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)!.settings.arguments as String;
    final selectedMeal = dummyMeals.firstWhere((m) => m.id == mealId);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedMeal.title),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => toggleFavorite(mealId),
        child: Icon(isMealFavorite(mealId) ? Icons.star : Icons.star_border),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.network(
                selectedMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            _buildSectionTile(context, 'Ingredients'),
            _buildContainer(
              child: ListView.separated(
                itemCount: selectedMeal.ingredients.length,
                separatorBuilder: (ctx, index) => const Divider(),
                itemBuilder: (BuildContext ctx, int index) {
                  return Card(
                    color: Theme.of(context).colorScheme.secondary,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                      child: Text(selectedMeal.ingredients[index]),
                    ),
                  );
                },
              ),
            ),
            _buildSectionTile(context, 'Steps'),
            _buildContainer(
              child: ListView.builder(
                itemCount: selectedMeal.steps.length,
                itemBuilder: (BuildContext ctx, int index) {
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text('# ${index + 1}'),
                    ),
                    title: Text(selectedMeal.steps[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
