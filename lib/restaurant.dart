import 'dart:math';
import 'dart:async';
import 'dart:convert';
import 'package:noobies/menu.dart';
import 'package:noobies/location.dart';
import 'package:noobies/item.dart';
import 'package:http/http.dart' as http;
import 'package:faker/faker.dart';

class Restaurant {
  String id;
  String name;
  num rating;
  String description;
  String image;
  Location location;
  Menu menus;

  Restaurant({
    required this.id,
    required this.name,
    required this.rating,
    required this.description,
    required this.image,
    required this.location,
    required this.menus,
  });

  String get fullAddress {
    return '${this.location.address}, ${this.location.city}';
  }

  String get fullCityPrefix {
    return '${this.location.city}, ${this.location.country}';
  }

  factory Restaurant.fromJson(Map<String, dynamic> restaurant) {
      final fakerFoodKeyword= [
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
          'water',
          'coke',
          'juice',
      ];

      return Restaurant(
          id: restaurant['id'],
          name: restaurant['name'],
          rating: restaurant['rating'],
          description: restaurant['description'],
          image: restaurant['pictureId'],
          location: Location(
              address: faker.address.streetName(),
              city: restaurant['city'],
              country: faker.address.country(),
          ),
          menus: Menu(
              foods: (restaurant['menus']['foods'] as List<dynamic>).map((food) => Item( 
                      name: food['name'],
                      price: (10000 + Random().nextInt(50000 - 10000)).toString(),
                      image: faker.image.image(
                          width: 1200,
                          height: 600,
                          keywords: fakerFoodKeyword,
                          random: true,
                      )
              )).toList(),
              drinks: (restaurant['menus']['drinks'] as List<dynamic>).map((drink) => Item( 
                      name: drink['name'],
                      price: (10000 + Random().nextInt(50000 - 10000)).toString(),
                      image: faker.image.image(
                          width: 1200,
                          height: 600,
                          keywords: fakerFoodKeyword,
                          random: true,
                      )

              )).toList(),
          )
      );
  }
}

Future <List<Restaurant>> fetchRestaurant() async {
    final url = 'https://gist.githubusercontent.com/LittleFireflies/e8c08f316217b5018b76b3e5463da34d/raw/bf145725d1d9af2635b71bd6d5d9dc0b79712157/local_restaurant.json';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
        return [
            for (final restaurant in jsonDecode(response.body)['restaurants']) Restaurant.fromJson(restaurant)
        ];
    } else {
        throw Exception('Failed to load');
    }
}
