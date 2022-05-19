import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:noobies/menu.dart';
import 'package:noobies/item.dart';
import 'package:faker/faker.dart';

class MenuWidget extends StatelessWidget {
  final Item menu;

  const MenuWidget({Key? key, required this.menu}) : super(key: key);

  Widget build(BuildContext context) {
    final menuPrice =
        new NumberFormat.currency(locale: 'id_ID', symbol: 'Rp. ');

    return Card(
      margin: const EdgeInsets.only(
        left: 32,
        right: 16,
        top: 32,
        bottom: 32,
      ),
      child: Column(
        children: [
          Image.network(
            '${menu.image}',
            width: 300,
            height: 100,
            fit: BoxFit.cover,
          ),
          ListTile(
            title: Text('${menu.name}',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                )),
            subtitle: Text(
              menuPrice.format(int.parse(menu.price)),
              style: TextStyle(
                fontSize: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
