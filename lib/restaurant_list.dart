import 'dart:math';
import 'package:faker/faker.dart';
import 'package:noobies/menu.dart';
import 'package:noobies/item.dart';
import 'package:noobies/location.dart';
import 'package:flutter/material.dart';
import 'package:noobies/restaurant.dart';
import 'package:noobies/restaurant_detail.dart';
import 'package:noobies/restaurant_widget.dart';

class RestaurantList extends StatefulWidget {
  const RestaurantList({Key? key}) : super(key: key);

  @override
  _RestaurantListState createState() => _RestaurantListState();
}

class _RestaurantListState extends State<RestaurantList> {
  final List<Restaurant> _restaurantList = [];
  final _biggerFont = const TextStyle(fontSize: 12);
  final splitPascalCase = RegExp(r"(?=(?!^)[A-Z])");

  @override
  Widget build(BuildContext context) {

      void filterRestaurant(String query) {
          List<Restaurant> temporaryRestaurant = [];

          temporaryRestaurant.addAll(_restaurantList);

          if (query.isNotEmpty) {
              List<Restaurant> restaurantData = [];
              temporaryRestaurant.forEach((restaurant) {
                  if (restaurant.name.contains(query)) {
                      restaurantData.add(restaurant);
                  }
              });

              setState(() {
                  _restaurantList.clear();
                  _restaurantList.addAll(restaurantData);
              });

              return;
          } else {
              setState(() {
                  _restaurantList.clear();
                  _restaurantList.addAll(temporaryRestaurant);
              });
          }
      }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant List'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return const Divider();

          final index = i ~/ 2;
          final foodCategories = [
            'food',
            'dish',
            'cuisine',
            'burger',
            'fish',
            'potatoes',
            'brunch',
            'lunch',
            'dinner',
            'meat',
            'beverages',
            'beer',
            'wine',
            'eegs',
            'sausages',
            'brocoli',
            'coffee',
            'tea',
            'soda',
            'takeout',
          ];

          if (index >= _restaurantList.length) {
            _restaurantList.add(Restaurant(
              id: faker.guid.guid(),
              name: faker.food.restaurant(),
              rating: (Random().nextDouble() * 5),
              description: faker.lorem.sentences(10).join(' '),
              image: faker.image.image(
                  width: 1200,
                  height: 600,
                  keywords: ['restaurant', 'place', 'building', 'store'],
                  random: true),
              location: Location(
                address: faker.address.streetAddress(),
                city: faker.address.city(),
                country: faker.address.country(),
              ),
              menus: Menu(
                  foods: [
                      Item(
                          name: random.boolean()
                          ? faker.food.dish()
                          : faker.food.cuisine(),
                          price: (10000 + Random().nextInt(50000 - 10000)).toString(),
                      ),
                      Item(
                          name: random.boolean()
                          ? faker.food.dish()
                          : faker.food.cuisine(),
                          price: (10000 + Random().nextInt(50000 - 10000)).toString(),
                      ),
                      Item(
                          name: random.boolean()
                          ? faker.food.dish()
                          : faker.food.cuisine(),
                          price: (10000 + Random().nextInt(50000 - 10000)).toString(),
                      ),
                  ],
                  drinks: [
                      Item(
                          name: random.boolean()
                          ? faker.food.dish()
                          : faker.food.cuisine(),
                          price: (10000 + Random().nextInt(50000 - 10000)).toString(),
                      ),
                  ]
              ),
            ));
          }

          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          DetailScreen(restaurant: _restaurantList[index])));
            },
            child: RestaurantWidget(restaurant: _restaurantList[index]),
          );
        },
      ),
    );
  }
}


                // Menu(
                //   price: (10000 + Random().nextInt(50000 - 10000)).toString(),
                //   foodImage: faker.image.image(
                //       width: 1200,
                //       height: 600,
                //       keywords: foodCategories,
                //       random: true),
                //   type: 'food',
                // ),
                // Menu(
                //   name: random.boolean()
                //       ? faker.food.dish()
                //       : faker.food.cuisine(),
                //   price: (10000 + Random().nextInt(50000 - 10000)).toString(),
                //   foodImage: faker.image.image(
                //       width: 1200,
                //       height: 600,
                //       keywords: foodCategories,
                //       random: true),
                //   type: 'food',
                // ),
                // Menu(
                //   name: random.boolean()
                //       ? faker.food.dish()
                //       : faker.food.cuisine(),
                //   price: (10000 + Random().nextInt(50000 - 10000)).toString(),
                //   foodImage: faker.image.image(
                //       width: 1200,
                //       height: 600,
                //       keywords: foodCategories,
                //       random: true),
                //   type: 'food',
                // )

