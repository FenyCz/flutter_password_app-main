import 'package:hive/hive.dart';

part 'item.g.dart';

@HiveType(typeId: 1)
class Item {
  Item({
    required this.name,
    required this.user,
    required this.pwd,
  });

  @HiveField(0)
  String name;

  @HiveField(1)
  String user;

  @HiveField(2)
  String pwd;
}
