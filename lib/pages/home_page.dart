import 'package:first_app/hive_db/adapters.dart';
import 'package:first_app/pages/add_password_page.dart';
import 'package:first_app/service/secure_db_service.dart';
import 'package:first_app/widgets/home_page_item.dart';
import 'package:flutter/material.dart';

import '../hive_db/item.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title, required this.secureService})
      : super(key: key);

  final String title;
  final SecureDbService secureService;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: getItems(widget.secureService).map((password) {
          return ItemWidget(
            item: Item(
              name: password.name,
              user: password.user,
              pwd: password.pwd,
            ),
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        // push to new page and afterwards setState to refresh the home page
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NewPassPage()),
          ).then((_) => setState(() {}));
        },
        child: const Icon(Icons.add),
      ),
    ); // This trailing comma makes auto-formatting nicer for build methods.
  }
}
