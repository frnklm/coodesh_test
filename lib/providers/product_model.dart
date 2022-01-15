import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String type;
  final String description;
  final String filename;
  final int height;
  final int width;
  final double price;
  final int rating;
  final DateTime createdAt;

  Product({
    this.id,
    this.title,
    this.type,
    this.description,
    this.filename,
    this.height,
    this.width,
    this.price,
    this.rating,
    this.createdAt,
  });
}
