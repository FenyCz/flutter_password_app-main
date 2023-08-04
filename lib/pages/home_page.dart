import 'package:first_app/hive_db/adapters.dart';
import 'package:first_app/pages/add_password_page.dart';
import 'package:first_app/service/secure_db_service.dart';
import 'package:first_app/widgets/home_page_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../hive_db/item.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage(
      {Key? key,
      required this.title,
      required this.secureService,
      required this.secureStorage})
      : super(key: key);

  final String title;
  final SecureDbService secureService;
  final FlutterSecureStorage secureStorage;

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
      body: FutureBuilder<List<Item>>(
        future: getItems(widget.secureService, widget.secureStorage),
        builder: (BuildContext context, AsyncSnapshot<List<Item>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: Text('Načítám...'));
          }
          return snapshot.data!.isEmpty
              ? const Center(
                  child: Text('Nejsou uložena žádná hesla.'),
                )
              : ListView(
                  children: snapshot.data!.map((password) {
                    return ItemWidget(
                      item: Item(
                        name: password.name,
                        user: password.user,
                        pwd: password.pwd,
                      ),
                    );
                  }).toList(),
                );
        },
      ),
      // body: ListView(
      //   children: getItems(widget.secureService).map((password) {
      //     return ItemWidget(
      //       item: Item(
      //         name: password.name,
      //         user: password.user,
      //         pwd: password.pwd,
      //       ),
      //     );
      //   }).toList(),
      // ),
      floatingActionButton: FloatingActionButton(
        // push to new page and afterwards setState to refresh the home page
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    NewPassPage(secureStorage: widget.secureStorage)),
          ).then((_) => setState(() {}));
        },
        child: const Icon(Icons.add),
      ),
    ); // This trailing comma makes auto-formatting nicer for build methods.
  }
}
