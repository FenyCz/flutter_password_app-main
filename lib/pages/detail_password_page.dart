import 'package:first_app/hive_db/item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DetailPasswordPage extends StatefulWidget {
  const DetailPasswordPage({super.key, required this.item});

  final Item item;

  @override
  State<DetailPasswordPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPasswordPage> {
  bool _isObscure = true;

  Future<void> _copyToClipboard(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Zkopírováno'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item.name),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                readOnly: true,
                controller: TextEditingController()..text = widget.item.name,
                decoration: InputDecoration(
                  labelText: 'Název',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.copy),
                    onPressed: () => _copyToClipboard(widget.item.name),
                  ),
                ),
              ),
              TextField(
                readOnly: true,
                controller: TextEditingController()..text = widget.item.user,
                decoration: InputDecoration(
                  labelText: 'Uživatel',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.copy),
                    onPressed: () => _copyToClipboard(widget.item.user),
                  ),
                ),
              ),
              TextField(
                obscureText: _isObscure,
                readOnly: true,
                controller: TextEditingController()..text = widget.item.pwd,
                decoration: InputDecoration(
                  labelText: 'Heslo',
                  // password visible only on click and copy as well
                  suffixIcon: Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween, // added line
                    mainAxisSize: MainAxisSize.min, // added line
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          _isObscure ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.copy),
                        onPressed: () => _copyToClipboard(widget.item.pwd),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
