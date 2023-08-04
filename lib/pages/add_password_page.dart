import 'package:first_app/hive_db/item.dart';
import 'package:first_app/service/secure_db_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:uuid/uuid.dart';

import '../hive_db/adapters.dart';
import '../model/secure_password_item.dart';

class NewPassPage extends StatelessWidget {
  const NewPassPage({super.key, required this.secureStorage});

  final FlutterSecureStorage secureStorage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Password'),
      ),
      body: AddForm(secureStorage),
    );
  }
}

class AddForm extends StatefulWidget {
  const AddForm(this.secureStorage, {super.key});

  final FlutterSecureStorage secureStorage;

  @override
  State<StatefulWidget> createState() {
    return AddFormState();
  }
}

class AddFormState extends State<AddForm> {
  final _formKey = GlobalKey<FormState>();
  String itemName = "";
  String itemUser = "";
  String itemPwd = "";
  var uuid = const Uuid();
  final _secureService = SecureDbService();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              onChanged: (value) {
                itemName = value;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Zadejte název';
                }
                return null;
              },
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Název (URL nebo název služby)'),
            ),
            TextFormField(
              onChanged: (value) {
                itemUser = value;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Zadejte uživatelské jméno';
                }
                return null;
              },
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Uživatelské jméno'),
            ),
            TextFormField(
              onChanged: (value) {
                itemPwd = value;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Zadejte heslo';
                }
                return null;
              },
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(), labelText: 'Heslo'),
            ),
            SizedBox(
              width: double.infinity,
              height: 55.0,
              child: ElevatedButton(
                onPressed: () async {
                  // if all input text is set
                  if (_formKey.currentState!.validate()) {
                    // we generate random key
                    var generatedKey = uuid.v4();

                    // then save password under the generated key
                    _secureService.writeSecureData(widget.secureStorage,
                        SecurePasswordItem(key: generatedKey, value: itemPwd));

                    // add item into db with key instead of password
                    createItem(Item(
                        name: itemName, user: itemUser, pwd: generatedKey));
                    // get to main page
                    if (!mounted) return;
                    Navigator.pop(context);
                  }
                },
                child: const Text('Uložit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
