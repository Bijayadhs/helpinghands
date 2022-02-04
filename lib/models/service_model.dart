import 'package:helpinghands/models/category_model.dart';

class Service {
  final String sTitle;
  final String sDescription;
  final double price;
  final double? rating;
  final List<String>? images;
  final List<String>? comments;
  final int? likes;
  final Category category;
  Service({
    required this.sTitle,
    required this.sDescription,
    required this.price,
    this.rating,
    this.images,
    this.comments,
    this.likes,
    required this.category,
  });
}
