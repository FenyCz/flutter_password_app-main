import 'package:hive/hive.dart';

part 'item.g.dart';

@HiveType(typeId: 1)
class Item {
  Item({
    required this.id,
    required this.name,
    required this.user,
    required this.pwd,
  });
  @HiveField(0)
  int id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String user;

  @HiveField(3)
  String pwd;
}
