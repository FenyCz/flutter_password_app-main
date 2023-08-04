import 'dart:developer';

import 'package:first_app/hive_db/item.dart';
import 'package:first_app/service/secure_db_service.dart';
import 'package:hive/hive.dart';

void createItem(Item item) {
  final box = Hive.box<Item>('itemBox');
  log("Adding new item.");
  box.add(item);
}

List<Item> getItems(SecureDbService secureService) {
  log("Getting all items");
  final box = Hive.box<Item>('itemBox');

  // If there are no items, return empty list
  if (box.isEmpty) {
    return <Item>[];
  } else {
    List<Item> values = box.values.toList(growable: false);
    return values;
  }
}
