import 'dart:convert';

import 'package:first_app/hive_db/item.dart';
import 'package:first_app/pages/home_page.dart';
import 'package:first_app/service/secure_db_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  // await dotenv.load(fileName: '.env');
  await Hive.initFlutter();
  Hive.registerAdapter(ItemAdapter());

  // TODO use only one secure storage
  const secureStorage = FlutterSecureStorage();
  var keyExists = await secureStorage.read(key: 'hiveKey');
  if (keyExists == null) {
    final newKey = Hive.generateSecureKey();
    await secureStorage.write(key: 'hiveKey', value: base64UrlEncode(newKey));
  }
  final key = await secureStorage.read(key: 'hiveKey');
  final encryptionKey = base64Url.decode(key!);

  await Hive.openBox<Item>('itemBox',
      encryptionCipher: HiveAesCipher(encryptionKey));

  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // create service and pass through widgets
  final secureService = SecureDbService();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Password App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'Password App', secureService: secureService),
    );
  }
}
