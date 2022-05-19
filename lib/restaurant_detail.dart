import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:noobies/restaurant.dart';
import 'package:noobies/menu_widget.dart';
import 'package:noobies/item.dart';

class DetailScreen extends StatelessWidget {
  final Restaurant restaurant;
  const DetailScreen({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget titleSection = Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    '${restaurant.fullAddress}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  '${restaurant.fullCityPrefix}',
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.star,
            color: Colors.red[500],
          ),
          Text('${restaurant.rating}')
        ],
      ),
    );

    Column _buildButtonColumn(Color color, IconData icon, String label) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color),
          Container(
            margin: const EdgeInsets.only(top: 8),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: color,
              ),
            ),
          ),
        ],
      );
    }

    Color color = Theme.of(context).primaryColor;

    Widget buttonSection = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildButtonColumn(color, Icons.call, 'CALL'),
        _buildButtonColumn(color, Icons.near_me, 'ROUTE'),
        _buildButtonColumn(color, Icons.share, 'SHARE'),
      ],
    );

    Widget textSection = Padding(
      padding: EdgeInsets.all(32),
      child: RichText(
        text: TextSpan(
          text: faker.lorem.sentences(10).join(' '),
        ),
        softWrap: true,
        textAlign: TextAlign.justify,
      ),
    );

    Widget foodSection = Container(
        width: 640,
        height: 640,
        child: GridView.builder(
            itemCount: restaurant.menus.foods.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
            ),
            itemBuilder: (context, index) => MenuWidget(
                menu: restaurant.menus.foods[index])
            ),
        );

    Widget drinkSection = Container(
        width: 640,
        height: 640,
        child: GridView.builder(
            itemCount: restaurant.menus.foods.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
            ),
            itemBuilder: (context, index) => MenuWidget(
                menu: restaurant.menus.drinks[index])
            ),
    );

    return Scaffold(
        appBar: AppBar(
          title: Text('${restaurant.name}'),
        ),
        body: ListView(children: [
          Image.network(
            '${restaurant.image}',
            width: 640,
            height: 240,
            fit: BoxFit.cover,
          ),
          titleSection,
          buttonSection,
          textSection,
          foodSection,
          drinkSection,
        ]));
  }
}

