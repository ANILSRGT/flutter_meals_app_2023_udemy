import 'package:flutter/material.dart';

import '../../screens/filters_screen.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  Widget _buildListTile(String title, IconData icon, VoidCallback tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontFamily: 'RobotoCondensed',
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Container(
              height: 120,
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              alignment: Alignment.centerLeft,
              color: Theme.of(context).colorScheme.secondary,
              child: Text(
                'Cooking Up!',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildListTile(
              'Meals',
              Icons.restaurant,
              () => Navigator.of(context).pushReplacementNamed('/'),
            ),
            _buildListTile(
              'Filters',
              Icons.filter_alt,
              () => Navigator.of(context).pushReplacementNamed(FiltersScreen.routeName),
            ),
          ],
        ),
      ),
    );
  }
}
