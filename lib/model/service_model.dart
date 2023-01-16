import 'package:flutter/material.dart';

enum StatusType {
  active,
  inActive,
}

class ServiceList extends ChangeNotifier {
  late MyServiceModel _service;

  final List<int> _itemIds = [];

  MyServiceModel get service => _service;

  set service(MyServiceModel newService) {
    _service = newService;
    notifyListeners();
  }

  List<ServiceItem> get items =>
      _itemIds.map((id) => _service.getById(id)).toList();

  void add(ServiceItem item) {
    _itemIds.add(item.id);
    notifyListeners();
  }

  void remove(ServiceItem item) {
    _itemIds.remove(item.id);
    notifyListeners();
  }
}

class MyServiceModel {
  static List<String> items = [
    'Code Smell',
    'Control Flow',
    'Interpreter',
    'Recursion',
    'Sprint',
    'Heisenbug',
    'Spaghetti',
    'Hydra Code',
    'Off-By-One',
    'Scope',
    'Callback',
    'Closure',
    'Automata',
    'Bit Shift',
    'Currying',
  ];

  ServiceItem getById(int id) => ServiceItem(id, items[id % items.length]);

  ServiceItem getByPosition(int position) {
    return getById(position);
  }
}

@immutable
class ServiceItem {
  final int id;
  final String name;
  final Color color;
  final int price = 42;

  ServiceItem(this.id, this.name)
      : color = Colors.primaries[id % Colors.primaries.length];

  @override
  int get hashCode => id;

  @override
  bool operator ==(Object other) => other is ServiceItem && other.id == id;
}

// @immutable
// class ServiceItem {
//   final int id;
//   final String name;
//   final String? description;
//   final Color color;
//   final StatusType status;
//   final Location location;
//   final DateTime createDate;
//
//   const ServiceItem(
//     this.id,
//     this.name,
//     this.description,
//     this.color,
//     this.status,
//     this.location,
//     this.createDate,
//   );
//
//   @override
//   int get hashCode => id;
//
//   @override
//   bool operator ==(Object other) => other is ServiceItem && other.id == id;
// }
//
// class Location {
//   final double lat;
//   final double long;
//
//   Location(
//     this.lat,
//     this.long,
//   );
// }
