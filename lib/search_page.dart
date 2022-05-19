import 'package:flutter/material.dart';
import 'package:noobies/restaurant.dart';
import 'package:noobies/restaurant_widget.dart';

class SearchPage extends StatelessWidget {
  final List<Restaurant> restaurants;

  const SearchPage({Key? key, required this.restaurants}) : super(key: key);

  void restaurantSearch(String query) {
    List<Restaurant> filteredRestaurant = [];
    List<Restaurant> temporary = restaurants;

    if (query.isNotEmpty) {
      print(query);
      filteredRestaurant = restaurants
          .where((restaurant) => restaurant.name.contains(query))
          .toList();

      restaurants.clear();
      restaurants.addAll(filteredRestaurant);
    } else {
      restaurants.clear();
      restaurants.addAll(temporary);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // The search area here
          title: Container(
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
        child: Center(
          child: TextField(
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    /* Clear the search field */
                  },
                ),
                hintText: 'Search...',
                border: InputBorder.none),
            onChanged: (value) => restaurantSearch(value),
          ),
        ),
      )),
      body: ListView.builder(
          itemCount: restaurants.length,
          itemBuilder: (context, index) {
            return RestaurantWidget(restaurant: restaurants[index]);
          }),
    );
  }
}
