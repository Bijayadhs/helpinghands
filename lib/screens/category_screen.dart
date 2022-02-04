import 'package:flutter/material.dart';
import 'package:helpinghands/data/services_data.dart';
import 'package:helpinghands/models/category_model.dart';
import 'package:helpinghands/models/service_model.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key, required this.category}) : super(key: key);
  final Category category;

  @override
  Widget build(BuildContext context) {
    final List<Service> _allServices = allServices;
    final List<Service> _services = _allServices.where((Service service) {
      return service.category == category;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(category.cName),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: category.cColor,
              child: Text(_services[index].sTitle[0]),
            ),
            title: Text(_services[index].sTitle),
            subtitle: Text(_services[index].sDescription),
          );
        },
        itemCount: _services.length,
      ),
    );
  }
}
