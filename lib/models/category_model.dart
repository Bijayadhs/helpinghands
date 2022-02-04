import 'package:flutter/material.dart';

class Category {
  final String cName;
  Color? cColor = Colors.purple[400]!;
  Category({
    required this.cName,
    this.cColor,
  });
}
