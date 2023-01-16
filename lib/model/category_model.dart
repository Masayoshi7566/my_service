import 'package:flutter/material.dart';

class CategoryModel {
  static List<String> itemNames = [
    'Therapy',
    'Steam',
    'Vitamin Facial',
  ];

  static double price = 0.0;

  CategoryItem getById(int id) => CategoryItem(
        id,
        itemNames[id % itemNames.length],
        price,
      );

  CategoryItem getByPosition(int position) {
    return getById(position);
  }
}

@immutable
class CategoryItem {
  final int id;
  final String name;
  final double price;

  const CategoryItem(
    this.id,
    this.name,
    this.price,
  );

  @override
  int get hashCode => id;

  @override
  bool operator ==(Object other) => other is CategoryItem && other.id == id;
}
