import 'package:flutter/material.dart';
import 'package:helpinghands/data/category.dart';
import 'package:helpinghands/models/category_model.dart';
import 'package:helpinghands/screens/category_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Category> _categories = categories;

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: _categories.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        return CategoryTile(category: _categories[index]);
      },
    );
  }
}

class CategoryTile extends StatelessWidget {
  const CategoryTile({
    Key? key,
    required this.category,
  }) : super(key: key);
  final Category category;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: category.cColor,
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return CategoryScreen(category: category);
          }));
        },
        child: Center(
          child: Text(
            category.cName,
            style: const TextStyle(
              fontSize: 24,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
