import 'package:flutter/material.dart';
import 'package:helpinghands/data/services_data.dart';
import 'package:helpinghands/models/service_model.dart';

class GetServiceScreen extends StatelessWidget {
  const GetServiceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Service> _allServices = allServices;

    return ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: _allServices[index].category.cColor,
            child: Text(_allServices[index].sTitle[0]),
          ),
          title: Text(_allServices[index].sTitle),
          subtitle: Text(_allServices[index].sDescription),
        );
      },
      itemCount: _allServices.length,
    );
  }
}
