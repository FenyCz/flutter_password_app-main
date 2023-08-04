import 'dart:developer';

import 'package:first_app/hive_db/item.dart';
import 'package:first_app/service/secure_db_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';

void createItem(Item item) {
  final box = Hive.box<Item>('itemBox');
  log("Adding new item.");
  box.add(item);
}

Future<List<Item>> getItems(
    SecureDbService secureService, FlutterSecureStorage secureStorage) async {
  log("Getting all items");
  final box = Hive.box<Item>('itemBox');
  List<Item> newPwdList = [];

  // If there are no items, return empty list
  if (box.isEmpty) {
    return <Item>[];
  } else {
    List<Item> values = box.values.toList(growable: false);

    for (var item in values) {
      var password =
          await secureService.readSecureData(secureStorage, item.pwd);
      password ??= "none";
      newPwdList.add(Item(name: item.name, user: item.user, pwd: password));
    }
    return newPwdList;
  }
}
