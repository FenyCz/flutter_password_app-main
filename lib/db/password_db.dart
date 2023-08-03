import 'dart:async';
import 'dart:io';

import 'package:first_app/model/password_item.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
//TODO
//import 'package:sqflite_sqlcipher/sqflite.dart';

class PasswordDatabase {
  // db constructor
  PasswordDatabase._privateConstructor();
  static final PasswordDatabase instance =
      PasswordDatabase._privateConstructor();
  static Database? _database;

  // use existing db or make instance
  Future<Database> get database async => _database ??= await _initDatabase();

  // db init
  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'passwords.db');
    return await openDatabase(
      path,
      //password: "heslo",
      version: 4,
      onCreate: _onCreate,
    );
  }

// create table in db
  Future _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE passwords(id INTEGER PRIMARY KEY, name STRING, user STRING, pwd STRING)',
    );
  }

  // get items from db
  Future<List<PasswordItem>> getItems(secureService) async {
    Database db = await instance.database;
    var pwds = await db.query('passwords', orderBy: 'name');
    List<PasswordItem> newPwdList = [];

    // db contains an items
    if (pwds.isNotEmpty) {
      List<PasswordItem> pwdList =
          pwds.map((c) => PasswordItem.fromMap(c)).toList();

      // go through all the items and update key for the password
      for (var item in pwdList) {
        var password = await secureService.readSecureData(item.pwd);
        // FIX ME if the password is null set to none
        password ??= "none";
        newPwdList
            .add(PasswordItem(name: item.name, user: item.user, pwd: password));
      }
      return newPwdList;
    } else {
      return [];
    }
  }

  // add item to db
  Future<int> add(PasswordItem item) async {
    Database db = await instance.database;
    return await db.insert('passwords', item.toMap());
  }
}
