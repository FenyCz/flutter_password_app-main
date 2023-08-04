import 'package:first_app/hive_db/item.dart';
import 'package:first_app/pages/detail_password_page.dart';
import 'package:flutter/material.dart';

class ItemWidget extends StatelessWidget {
  final Item item;

  const ItemWidget({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Card(
        color: Colors.white70,
        elevation: 8,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailPasswordPage(item: item)),
            );
          },
          child: Column(
            children: [
              ListTile(
                title: Text(item.name),
                subtitle: Text(item.user),
              )
            ],
          ),
        ),
      ),
    );
  }
}
